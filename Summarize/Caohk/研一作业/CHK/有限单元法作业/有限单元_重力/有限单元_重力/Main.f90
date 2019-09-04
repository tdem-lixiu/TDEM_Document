Program main
    implicit none
    character(len=20) :: filename1
    integer(kind=8),parameter :: ND=15,NE=16,ND1=12
    integer(kind=8) :: IW
    real(kind=8) :: XY(2,15),U1(12),SK(15,15),U(15)
    integer(kind=8) :: I3(3,16),NB1(12)
    integer(kind=4) :: i,j,IE
    open(11,file='NE.txt',status='old')
    do  j=1,NE
        read(11,*) (I3(i,j),i=1,3)
    enddo
    
    do  j=1,ND
        read(11,*)(XY(I,J),I=1,2)
    enddo
    
    read(11,*)(NB1(i),i=1,ND1)
    read(11,*)(U1(i),i=1,ND1)
    close(11)
    call MBW(NE,I3,IW)
    call UK1(ND,NE,IW,I3,XY,SK)
    call UB1(ND1,NB1,U1,ND,IW,SK,U)
    call LDLT(SK,ND,IW,U,IE)
    write(*,*) '请输入保存计算后的数据文件名:'
    read(*,*) filename1
    open(6,file=filename1,status='unknown')
    write(6,510) U
    close(6)
510 format(/3e15.6)
    end program
    
    
    subroutine MBW(NE,I3,IW)
    implicit none
    integer(kind=8) :: NE
    integer(kind=8) :: IW,m
    integer(kind=8) :: I3(3,NE)
    integer(kind=4) :: i
    IW=0
    do i=1,NE
        m=max(iabs(I3(1,i)-I3(2,i)),iabs(I3(2,i)-I3(3,i)),iabs(I3(3,I)-I3(1,I)))
        if (m+1.GT.IW) then
            IW=M+1
        end if
    end do
    return
    end subroutine
    
    subroutine UK1(ND,NE,IW,I3,XY,SK)
    implicit none
    integer(kind=8) :: IW
    integer(kind=8) :: NE,ND
    integer(kind=8) :: I3(3,NE)
    real(kind=8):: XY(2,ND),SK(ND,IW)
    real(kind=8) :: X(3),Y(3)
    real(kind=8) :: Ke(3,3)
    integer(kind=4) :: NJ,NK
    integer(kind=4) :: i,j,l,k
    do i=1,ND
        do j=1,IW
            SK(i,j)=0
        enddo
    enddo
    do L=1,NE
        do j=1,3
            i=I3(j,L)  !取得对应单元中的节点号
            x(j)=XY(1,i)  !取得每个节点的x,y坐标
            y(j)=XY(2,i)
        enddo
        call UKE1(X,Y,KE)
        do j=1,3
            NJ=I3(j,l)
            do k=1,j
                NK=I3(k,l)   !获取Ke的双下标
                if (NJ.LT.NK) then
                    NJ=NJ-NK+IW
                    SK(NK,NJ)=SK(NK,NJ)+KE(j,k)
                    NJ=NJ+NK-IW
                else
                    NK=NK-NJ+IW
                    SK(NJ,NK)=SK(NJ,NK)+KE(J,K)
                endif
            enddo
        enddo
    enddo
    return
    end subroutine

    
    subroutine UKE1(X,Y,KE)
    implicit none
    real(kind=8):: X(3),Y(3),A(3),B(3)
    real(kind=8) :: KE(3,3)
    integer(kind=4) :: i,j
    real(kind=8) :: S
    A(1)=Y(2)-Y(3)
    A(2)=Y(3)-Y(1)
    A(3)=Y(1)-Y(2)
    B(1)=X(3)-X(2)
    B(2)=X(1)-X(3)
    B(3)=X(2)-X(1)
    S=2.*(A(1)*B(2)-A(2)*B(1))
    do i=1,3
        do j=1,i
            Ke(i,j)=( A(i)*A(j)+B(i)*B(j) ) / s
        enddo
    enddo
    return
    end subroutine
    
    
    subroutine UB1(ND1,NB1,U1,ND,IW,SK,U)
    implicit none
    integer(kind=8) :: IW,ND1,ND
    integer(kind=8) :: NB1(ND1)
    real(kind=8):: U1(ND1),SK(ND,IW),U(ND)
    integer(kind=4) :: i,j
    do i=1,ND
        u(i)=0
    enddo
    do i=1,ND1
        j=NB1(i)
        SK(j,IW)=SK(j,IW)*1.e10
        U(j)=SK(j,IW)*U1(i)
    enddo
    return
    end subroutine
    
    subroutine LDLT(A,N,IW,P,IE)
    integer(kind=8) :: N,IW
    integer(kind=4) :: IE
    real(kind=8) :: A(N,IW),P(N)
    do 15 i=1,N
        if(I.LE.IW) goto 20
        IT=I-IW+1
        goto 30
20      IT=1
30      K=I-1
        IF(I.EQ.1)goto 40
        do 25 L=IT,K
            IL=L+IW-I
            B=A(I,IL)
            A(I,IL)=B/A(L,IW)
            P(I)=P(I)-A(I,IL)*P(L)
            MI=L+1
            do 25 j=MI,I
                IJ=J+IW-I
                JL=L+IW-J
25      A(I,IJ)=A(I,IJ)-A(J,JL)*B
40      IF( A(I,IW).EQ.0. ) goto 100
15  continue
    do 45 j=1,n
        if( J.LE.IW ) goto 60
        IT=N-J+IW
        goto 70
60      IT=N
70      I=N-J+1
        P(I)=P(I)/A(I,IW)
        IF(J.EQ.1)goto 45
        K=I+1
        do 65 MJ=K,IT
            IJ=I-MJ+IW
65      P(I)=P(I)-P(MJ)*A(MJ,IJ)
45  continue
    IE=0
    goto 110
100 IE=1
110 return
    end subroutine