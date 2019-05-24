program jf_test_8
    use json_module
    implicit none
    type(json_file) :: json
    integer(kind=4) :: i,j,k,ntime,nrec
    character(len=20) :: str
    real(kind=4),allocatable,dimension(:):: a,h
    real(kind=4),allocatable,dimension(:):: s1,c1,trange
    real(kind=4),allocatable,dimension(:,:):: s,coordrec
    real(kind=4) :: I0,ndipole
    character(len=10),allocatable,dimension(:) :: name1,name2
    logical :: found
    !初始化
    call json%initialize()
    !读取文件
    call json%load_file(filename='shiyan.json')
    !将文件的内容输出到console上面
    call json%print_file()
    !提取文件里面的内容给变量使用json%get
    !提取里面的整数,用integer即可,kind无所谓
    call json%get('nlayer',i)
    !提取里面的数组，直接用未分配的即可，利用json%get会自动为你分配好，也可用分配的
    !但不管哪个，都要记得在仍要销毁数组
    call json%get('res',a)
    !
    call json%get('thickness',h)
    call json%get('nsource',j)
    !提取键值中的子集，这个怎么处理比较好，这里提供个人的小技巧作为参考
    allocate(s(j,4))  !因为每个源的坐标是4，这是固定死的
    do k=1,j,1
        write(str,*) k
        str='source.source'//trim(adjustl(str)) !得到键值
        call json%get(str,s1)
        s(k,:)=s1
    enddo
    !
    call json%get('current',I0)
    call json%get('ndipole',ndipole)
    call json%get('ntime',ntime)
    call json%get('trange',trange)
    call json%get('nrec',nrec)
    allocate(coordrec(nrec,3),c1(3))  !因为每个源的坐标是4，这是固定死的
    do k=1,nrec,1
        write(str,*) k
        str='coordrec.rec'//trim(adjustl(str)) !得到键值
        call json%get(coordrec,c1)
        coordrec(k,:)=c1
    enddo
    !提取文字部分，字符串必须为可分配字符串数组，其中获取方式与数组类似
    call json%get('prefix',name1)
    call json%get('caltype',name2)
    pause   
end program jf_test_8

