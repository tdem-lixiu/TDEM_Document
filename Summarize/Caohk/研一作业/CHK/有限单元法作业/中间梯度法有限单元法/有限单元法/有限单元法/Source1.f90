Program main
    implicit none
    character(len=20) :: filename1
    integer(kind=4),parameter :: NX=4,NY=3
    real(kind=8),parameter :: E0=1.0
    real(kind=8) :: x(NX+1),y(NY+1)
    real(kind=8),allocatable,dimension(:) :: ro,ga,p
    integer(kind=4),allocatable,dimension(:) :: id  !ro是区域划分为几块,nro为每个单元的区域号
    real(kind=8),allocatable,dimension(:,:) :: xy
    integer(kind=4) :: Nd,Ne
    integer(kind=4) :: nro(nx,ny)
    integer(kind=4),allocatable,dimension(:,:) :: I4
    integer(kind=4) :: i,j,n_ro
    ND=(NX+1)*(NY+1)
    NE=NX*NY
    allocate(xy(2,ND),I4(4,NE),id(ND),p(ND))
    open(11,file='NE.txt',status='old')
    read(11,*) (x(i),i=1,NX+1)
    read(11,*) (y(i),i=1,NY+1)
    read(11,*) n_ro
    allocate(ro(n_ro))
    do  i=1,n_ro
        read(11,*) ro(i)
    enddo
    
    do  j=1,NY
        read(11,*) (nro(i,j),i=1,NX)
    enddo
    !
    !do  j=1,ND
    !    read(11,*)(XY(I,J),I=1,2)
    !enddo
    !
    !read(11,*)(NB1(i),i=1,ND1)
    !read(11,*)(U1(i),i=1,ND1)
    !close(11)
    call XY14(Nx,Ny,x,y,Nd,Ne,xy,I4)
    call id1(nx,ny,id)

    allocate(ga( id(nd) ))
    !call e2k1(nx,ny,nd,ne,xy,I4,id,ga,nro,ro)
    call p1(E0,nx,ny,nd,ne,xy,I4,nro,ro,p)
 
    deallocate(xy,I4)
!    call LDLT(SK,ND,IW,U,IE)
!    write(*,*) '请输入保存计算后的数据文件名:'
!    read(*,*) filename1
!    open(6,file=filename1,status='unknown')
!    write(6,510) U
!    close(6)
!510 format(/3e15.6)
end program
    
subroutine XY14(Nx,Ny,x,y,Nd,Ne,xy,I4)
implicit none
integer(kind=4) :: NX,NY,ND,NE
integer(kind=4) :: I4(4,*)
real(kind=8) :: x(nx+1),y(ny+1),xy(2,*)
integer(kind=4) :: IX,IY,N,N1
ND=(NX+1)*(NY+1)
NE=NX*NY
do IX=1,NX+1
    do IY=1,NY+1
        N=(IX-1)*(NY+1)+IY
        XY(1,N)=X(IX)
        XY(2,N)=Y(IY)
    enddo
enddo
do IX=1,NX
    do IY=1,NY
        N=(IX-1)*NY+IY
        N1=(IX-1)*(NY+1)+IY
        I4(1,N)=N1
        I4(2,N)=N1+1
        I4(3,N)=N1+NY+2
        I4(4,N)=N1+NY+1
    enddo
enddo
endsubroutine
    
subroutine k44(a,b,sgm,ke)
implicit none
real(kind=8) :: ke(4,4)
real(kind=8) :: a,b,sgm,ab,ba
ba=b/a
ab=a/b
ke(1,1)=sgm*(ba+ab)/3.d0
ke(2,1)=sgm*(ba-2.d0*ab)/6.d0
ke(2,2)=ke(1,1)
ke(3,1)=sgm*(-ba-ab)/6.d0
ke(3,2)=sgm*(-2.d0*ba+ab)/6.d0
ke(3,3)=ke(1,1)
ke(4,1)=ke(3,2)
ke(4,2)=ke(3,1)
ke(4,3)=ke(2,1)
ke(4,4)=ke(1,1)
end subroutine
    
subroutine p1(E0,nx,ny,nd,ne,xy,I4,nro,ro,p)
implicit none
real(kind=8) :: E0
integer(kind=4) :: nx,ny,nd,ne
integer(kind=4) :: I4(4,ne),nro(nx,ny)
real(kind=8) :: xy(2,nd),ro(*),p(nd)
integer(kind=4) :: i,iy,nk,L,nj
real(kind=8) :: B,sgm,pe
do i=1,nd
    p(i)=0.d0
enddo
do iy=1,ny
    sgm=1.d0/ro(nro(1,iy))
    nj=I4(1,iy)
    nk=I4(2,iy)
    B=xy(2,nj)-xy(2,nk)
    pe=5.d-1*sgm*E0*B
    p(nj)=p(nj)+pe
    p(nk)=p(nk)+pe
    sgm=1.d0/ro(nro(nx,iy))
    L=(nx-1)*ny+iy
    nj=I4(3,L)
    nk=I4(4,L)
    B=xy(2,nj)-xy(2,nk)
    pe=5.d-1*sgm*E0*B
    p(nj)=p(nj)+pe
    p(nk)=p(nk)+pe
enddo
end subroutine
    
subroutine e2k1(nx,ny,nd,ne,xy,I4,id,ga,nro,ro)
implicit none
integer(kind=4) :: nx,ny,nd,ne
integer(kind=4) :: I4(4,ne),id(nd),nro(nx,ny)
real(kind=8) :: xy(2,nd),ro(*),ga(*)
real(kind=8) :: ke(4,4),a,b,sgm
integer(kind=4) :: i,ix,iy,L,nj,nk,j,k,M
do i=1,id(nd)
    ga(i)=0.d0
enddo
do ix=1,nx
    do iy=1,ny
        L=(ix-1)*ny+iy
        a=xy(1,I4(4,L))-xy(1,I4(1,L))
        b=xy(2,I4(1,L))-xy(2,I4(2,L))
        sgm=1.d0/ro(nro(ix,iy))
        call k44(a,b,sgm,ke)
        do j=1,4
            nj=I4(j,L)
            do k=1,j
                nk=I4(k,L)
                if (nj .GT. nk) then
                    M=id(nk)-nj+nk
                else
                    M=id(nk)-nk+nj
                endif
                ga(M)=ga(M)+ke(j,k)
            enddo
        enddo
    enddo
enddo
end subroutine
    
subroutine id1(nx,ny,id)
implicit none
integer(kind=4) :: nx,ny
integer(kind=4) :: id(*)
integer(kind=4) :: i,j,n
id(1)=1
do i=2,ny+1
    id(i)=id(i-1)+2
enddo
do i=2,nx+1
    n=(i-1)*(ny+1)+1
    id(n)=id(n-1)+ny+2
    do j=2,ny+1
        n=(i-1)*(ny+1)+j
        id(n)=id(n-1)+ny+3
    enddo
enddo
end subroutine
        