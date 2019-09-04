program main
    implicit none
    integer,parameter :: ND=20201, NE=40000, ND1=400
    real(kind=8) :: XY(2,ND), U1(ND1), U(ND)
    integer :: I3(3,NE), NB1(ND1)
    integer :: IW
    real(kind=8),allocatable :: SK(:,:)
    integer :: i, j, IE
    
    call get_parameter(NE, ND, ND1, I3, NB1, XY, U1)
    call mbw(NE, I3, IW)
    allocate(SK(ND,IW))
    call uk1(ND, NE, IW, I3, XY, SK)
    !write(*,*) SK
    call UB1(ND1, NB1, U1, ND, IW, SK, U)
    !write(*,*) U
    call LDLT(SK, ND, IW, U, IE)
    !write(*,*) U
    deallocate(SK)
    call output_data(ND, XY, U)
    end program
    
subroutine get_parameter(NE, ND, ND1, I3, NB1, XY, U1)
    implicit none
    integer :: NE, ND, ND1
    integer :: I3(3,NE), NB1(ND1)
    real(kind=8) :: XY(2,ND), U1(ND1)
    integer :: i
    
    open(10,file="I3.txt",status="old")
        do i = 1, NE
            read(10,*) I3(1,i), I3(2,i), I3(3,i)
        end do
    close(10)
    
    open(10,file="XY.txt",status="old")
        do i = 1, ND
            read(10,*) XY(1,i), XY(2,i)
        end do
    close(10)
    
    open(10,file="NB1.txt",status="old")
        do i = 1, ND1
            read(10,*) NB1(i), U1(i)
        end do
    close(10)
    end subroutine get_parameter
    
subroutine uke1(x,y,ke)
    implicit none
    real(kind=8) :: x(3), y(3), a(3), b(3)
    real(kind=8) :: ke(3,3)
    real(kind=8) :: s
    integer i, j
    
    a(1) = y(2) - y(3)
    a(2) = y(3) - y(1)
    a(3) = y(1) - y(2)
    b(1) = x(3) - x(2)
    b(2) = x(1) - x(3)
    b(3) = x(2) - x(1)
    s = 2.d0 * ( a(1) * b(2) - a(2) * b(1) )
    do i = 1, 3
        do j = 1, i
            ke(i, j) = ( a(i) * a(j) + b(i) * b(j) ) /s
        end do
    end do
    end subroutine uke1
    
subroutine mbw(Num_Element, I3, semi_bandwidth)

    integer :: Num_Element
    integer :: I3(3, Num_Element)
    real(kind=8) :: M
    integer :: i
    integer :: semi_bandwidth
    
    semi_bandwidth = 0
    do i = 1, Num_Element
        M = MAX( IABS(I3(1,i)-I3(2,i)), IABS(I3(2,i)-I3(3,i)), IABS(I3(3,i)-I3(1,i)) )
        if (M+1.GT.semi_bandwidth) then
            semi_bandwidth = M+1
        end if 
    end do
    end subroutine mbw
    
subroutine uk1(ND, NE, IW, I3, XY, SK)
    implicit none
    integer :: ND, NE, IW
    integer :: I3(3,NE)
    real(kind=8) :: XY(2,ND), SK(ND,IW)
    real(kind=8) :: X(3), Y(3)
    real(kind=8) :: KE(3,3)
    integer :: i, j, k, II, NJ, NK
    SK = 0.d0
    do i = 1, NE
        do j = 1, 3
            II = I3(j,i)
            X(j) = XY(1,II)
            Y(j) = XY(2,II)
            !write(*,*) X(j),Y(j)
        end do
        call uke1(X, Y, KE)
        !write(*,*) KE
        !write(*,*)
        do j = 1, 3
            NJ = I3(j,i)
            do k = 1, j
                NK = I3(k,i)
                if (NJ<NK) then
                    NJ = NJ - NK + IW
                    !write(*,*) NK,NJ
                    SK(NK,NJ) = SK(NK,NJ) + KE(J,K)
                    NJ = NJ + NK - IW
                else
                    !write(*,*) NJ,NK
                    NK = NK - NJ + IW
                    !write(*,*) NJ,NK
                    SK(NJ,NK) = SK(NJ,NK) + KE(J,K)
                    !write(*,*) KE(J,K)
                end if
            end do
        end do
    end do
    end subroutine uk1
    
subroutine UB1(ND1, NB1, U1, ND, IW, SK, U)
    implicit none
    integer :: ND1, ND, IW
    integer :: NB1(ND1)
    real(kind=8) :: U1(ND1), SK(ND,IW), U(ND)
    integer :: i, j
    
    U = 0.d0
    do i = 1, ND1
        j = NB1(i)
        SK(j,IW) = SK(j,IW) * 1.0d10
        U(j) = SK(j,IW) * U1(i)
    end do
    end subroutine UB1
    
subroutine LDLT(A, N, IW, P, IE)
    implicit none
    integer :: N, IW
    real(kind=8) :: A(N,IW), P(N), B
    integer IE, i, j, l, k, MI, IL, MJ, IJ, JL, IT
    !write(*,*) A
    do i = 1, N
        if (i.LE.IW) then
            IT = 1
        else
            IT = i - IW + 1
        end if
        k = i-1
        if (i.EQ.1.d0) then
            if ( A(i,IW).EQ.0.d0 ) then
                IE = 1
                write(*,*) "ÆæÒì"
                stop
            else
                IE = 0
                !write(*,*) "·ÇÆæÒì"
            end if
        end if
        do l = IT, K
            IL = l + IW - i
            B = A(i,IL)
            A(i,IL) = B/A(l,IW)
            !write(*,*) IL,i,B,A(l,IW)
            P(i) = P(i) - A(i,IL) * P(l)
            MI = l + 1
            do j = MI, i
                IJ = j + IW -i
                JL = l + IW -j
                !write(*,*) i,IJ,JL
                A(i,IJ) = A(i,IJ) - A(j,JL) * B
            end do
        end do
    end do
    
    do j = 1, N
        if (j.LE.IW) then
            IT = N
            I = N - j + 1
        else
            IT = N - j + IW
            I = N - j + 1
        end if 
        P(I) = P(I) /A(I,IW)
        !write(*,*) I,P(I)
        if (j/=1) then
            IE = 0
            !write(*,*) "·ÇÆæÒì"
            K = I + 1
            do MJ = K, IT
                IJ = I - MJ + IW
                !write(*,*) I,MJ,IJ
                P(I) = P(I) - P(MJ) * A(MJ,IJ)
                !write(*,*) P(I)

            end do
        end if
    end do
    end subroutine LDLT
    
subroutine output_data(ND, XY, U)
    implicit none
    integer :: ND
    real(kind=8) :: XY(2,ND), U(ND)
    integer :: i
    
    open(10,file="U.dat",status="unknown")
    do i = 1, ND
        write(10,*) XY(1,i), XY(2,i), U(i)
    end do
    close(10)
    end subroutine output_data