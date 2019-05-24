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
    !��ʼ��
    call json%initialize()
    !��ȡ�ļ�
    call json%load_file(filename='shiyan.json')
    !���ļ������������console����
    call json%print_file()
    !��ȡ�ļ���������ݸ�����ʹ��json%get
    !��ȡ���������,��integer����,kind����ν
    call json%get('nlayer',i)
    !��ȡ��������飬ֱ����δ����ļ��ɣ�����json%get���Զ�Ϊ�����ã�Ҳ���÷����
    !�������ĸ�����Ҫ�ǵ�����Ҫ��������
    call json%get('res',a)
    !
    call json%get('thickness',h)
    call json%get('nsource',j)
    !��ȡ��ֵ�е��Ӽ��������ô����ȽϺã������ṩ���˵�С������Ϊ�ο�
    allocate(s(j,4))  !��Ϊÿ��Դ��������4�����ǹ̶�����
    do k=1,j,1
        write(str,*) k
        str='source.source'//trim(adjustl(str)) !�õ���ֵ
        call json%get(str,s1)
        s(k,:)=s1
    enddo
    !
    call json%get('current',I0)
    call json%get('ndipole',ndipole)
    call json%get('ntime',ntime)
    call json%get('trange',trange)
    call json%get('nrec',nrec)
    allocate(coordrec(nrec,3),c1(3))  !��Ϊÿ��Դ��������4�����ǹ̶�����
    do k=1,nrec,1
        write(str,*) k
        str='coordrec.rec'//trim(adjustl(str)) !�õ���ֵ
        call json%get(coordrec,c1)
        coordrec(k,:)=c1
    enddo
    !��ȡ���ֲ��֣��ַ�������Ϊ�ɷ����ַ������飬���л�ȡ��ʽ����������
    call json%get('prefix',name1)
    call json%get('caltype',name2)
    pause   
end program jf_test_8

