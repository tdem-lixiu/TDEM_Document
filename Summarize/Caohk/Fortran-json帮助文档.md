<h2 align=center> Fortran-json帮助文档 </h2>

#### 一.json的书写 ####

[json书写参考网址](https://www.cnblogs.com/tech-bird/p/3588430.html)

- 1.`键值：值`：其中键值是字符串，使用双引号表示。值可以是：数字（整数或浮点数），字符串（在双引号中）,数组（在方括号中）,对象（在花括号中）；
- 2.数据由逗号隔开；
- 3.花括号里面保存着对象，对象可以包含各种数据，包括数组；
- 4.方括号保存在数组，数组里面的元素可以是字符串，例如：

```json
{
   "Byname":[
       "男",
       "女"
       ],
    "years":[
        12,
        20,
        50
        ],
  ...
  ...
}
```

可以看出Byname和years就是键值，而[]里面代表是数组，其中的元素可以是数字也可以是字符串。用{}括起来的部分就是一个对象。

- 5.对象在json里面的数据结构为{key:value,key:value....}，key代表键值，value代表值，一个json文件里面至少有一个对象，并且对象里面可以包含对象，例如：

```json
{
    "University":{
        "Name":"长安",
        "Grade":["一年级","二年级","三年级"]
    },
    "Name":"CHK"
}
```

其中，"University"就是外面大对象里面中一个子对象的键值。

- 6.数组里面的元素可以包含对象，例如：

```json
{
    "Education":[
        {
            "长沙":["一中","二中","三中"],
            "水平":["低","中","高"]
        },
        {
            "西安":["一中","二中","三中"],
            "水平":["低","中","高"]
        },
        {
            "北京":["一中","二中","三中"],
            "水平":["低","中","高"]
        }
    ]
}
```

----

#### 二.json的文件读取 ####

- 1.首先从[下载地址](https://github.com/jacobwilliams/json-fortran/releases)上下载相应的json和Fortran的库；
- 2.将文件夹中的lib复制拷贝到相应的工程的文件夹内；（这样就不用添加相应的moduel和lib路径）
- 3.添加调用所使用的相应moduel名字，use ......（为了方便，直接use json_module即可）；添加相应使用的lib到link中，在项目---属性---Fortran---link---input---libjsonfortrand.lib。
- 4.调用相应的函数即可使用。主要函数有：

#####
`json%initialize()`：初始化，在使用json的子函数前，需要先初始化；

`json%load_file(filename='json文件名')`：读取json的文件，将文件内容存储在内部函数；

`json%print_file()`：将读取的文件内容输出到屏幕上；

`json%get()`：从文件提取信息(数，数组，字符串)；

`json%get('键值名',变量)` ：当提取的量为数组型时，变量应该为可分配数组型(Allocatable)，可以不进行分配直接json%get；当提取的量为字符串时，(注意json文件字符串在[]中)，变量为可分配的字符串：`character(len=?),allocatable,dimension(:) :: 字符串变量名`。
#####

- 5.示例：

```fortran
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
    allocate(coordrec(nrec,3))  !因为每个源的坐标是4，这是固定死的
    do k=1,nrec,1
        write(str,*) k
        str='coordrec.rec'//trim(adjustl(str)) !得到键值
        call json%get(str,c1)
        coordrec(k,:)=c1
    enddo
    !提取文字部分，字符串必须为可分配字符串数组，其中获取方式与数组类似
    call json%get('prefix',name1)
    call json%get('caltype',name2)
    pause
end program jf_test_8
```

json文件内容如下:

```json
{
    "nlayer": 2,
    "res":[100,10],
    "thickness":[200],
    "nsource":2,
    "source":{
        "source1":[-50,50,50,50],
        "source2":[50,-50,-50,-50]
    },
    "current":1,
    "ndipole":10,
    "ntime":100,
    "trange":[-5,-2],
    "nrec":3,
    "coordrec":{
        "rec1":[0,100,0],
        "rec2":[0,100,-10],
        "rec3":[0,100,-20]
    },
    "prefix":["Model_1"],
    "caltype":["ff"]
}
```

----

#### 三.json的文件输出 ####

----

[^1]:正在学习完善中......