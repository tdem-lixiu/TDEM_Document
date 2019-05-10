<h2 align=center> Fortran语法规范 </h2>

#### 一.变量定义 ####

- 1.首先建议通过以下命令取消默认的命名规则：
``Implicit none``
数据类型主要有本质类型和派生类型，其中本质类型有:integer，real，complex，character，logical，这类都能用kind来指定精度，而字符型可以用len指定长度。
- 2.常用格式：类型（kind=...）,形容词,形容词... :: 变量名，例如：
```Fortran
Integer(kind=2) :: a
Real(kind=4) :: b
complex(kind=4) :: c
Integer(kind=2),parameter :: d !对于常数而言，最好加上parameter属性
```
- 3.对于数组：(1) 类型（kind=...）,形容词,形容词...,dimension(...) :: 变量名
   (2) 类型（kind=...），形容词，形容词...,dimension :: 变量名(数组外形)，例如：
```Fortran
real(kind=4),dimension(3) :: a,b
real(kind=4),dimension :: c(3),d(5)
```
- 4.对于字符型：Character(len=...),形容词,形容词... :: 变量名，例如：
```Fortran
Character(len=10) :: str
```
- 5.对于逻辑型：Logical,形容词,形容词... :: 变量名，这里logical比较特殊，通常不指定使用空间大小，由编辑器自行决定。例如：
```Fortran
Logical :: a  !推荐情况
Logical(kind=1) :: a   !也可以写成这种形式
```
- 6.派生类型：定义结构体，
```Fortran
type,形容词 :: 结构体名      !这里很少加形容词
    变量(声明语句)
end type
```
将结构体实体化，也可实体化为数组，
```Fortran
type(结构体名) :: 变量名
```
示例：
```Fortran
!定义部分
type :: student
    character(len=20) :: name
    integer(kind=2) :: age
    real(kind=4) :: score
end type student
!-------------------------------------------------
!实体化部分
type(student) :: a
a%name='xiaoming'   !引用其成员时建议使用:结构体%成员名；不建议用：结构体%成员名
a%age=22
a%score=98
```
- 7.data赋初值(必须放在执行语句之前)：当要给的初值比较多时，程序可能就会显得比较乱，可以使用data进行赋值，格式为：data 变量1,变量2,变量3,... /value1,value2,value3,.../，例如：
```Fortran
real(kind=4) :: a,b
complex(kind=4) :: c
character(len=8) :: str
data a,b,c,str /1.0,2.0,(3.0,4.0),'Hello'/
```
则依顺序由，a=1.0，b=2.0，c=(3.0,4.0)，str='Hello'，当变量赋值较多时，这种方式会显得更容易管理。
此外，它对数组的赋值也比较方便，例如：
```Fortran
real(kind=4),dimension :: a(4)
data a /1.0,2.0,3.0,4.0/
```
除了以上方式外，还可以表示为：
```Fortran
real(kind=4),dimension :: a(4)
integer(kind=2) :: i
data (a(i),i=1,4) /1.0,2.0,3.0,4.0/
```
- 8.moduel里面的参数建议：首先区分moduel中可外部调用、外部不可调用，对于不可调用的变量或者子程序，应该声明为：``private 变量名或者子程序名``；对于可调用部分，应该声明为：``pubulic 变量名或者子程序名``。例如：
```Fortran
module atem
implicit none
private     !将默认改为私有化
public:: transform    !函数名
public:: gauleg     !变量名
integer(kind=2),parameter :: gauleg=100
contains
subroutine transform(...)
...
```
moduel子程序中虚参建议使用Intent声明，对于输入变量，应写成：``类型（kind=...）,形容词,...,Intent(in) :: 变量名``；对于输出变量，应写成：``类型（kind=...）,形容词,...,Intent(out) :: 变量名``；对于既是输入又是输出的变量：``类型（kind=...）,形容词,...,Intent(inout) :: 变量名``，默认类型为：Intent(inout)。示例：
```Fortran
real(kind=4),Intent(in) :: a     !输入变量
real(kind=4),Intent(out) :: b    !输出变量
real(kind=4),Intent(inout) :: c  !既是输入又是输出变量
real(kind=4) :: d                !既是输入又是输出变量
```
----
#### 二.输入格式 ####
- 1.输入文件不宜过多，最好控制到1个或者2个文件之内，文件中不参与读取部分的说明应该在前面加上'!'，提示这是注释说明。
#### 二.输出格式 ####
- 1.通常设计师建议，不要将format集中排列，如此不利于搜寻。最好将format直接放在write之下，或者直接写在write里面。这里建议在非必要情况下，直接写在write里面。
[^1]:正在学习完善中......