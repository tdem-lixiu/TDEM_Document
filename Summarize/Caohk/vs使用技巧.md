<h2 align=center> VS使用小技巧 </h2>

[返回上一级](./)

----
<h3 align=center > 一.VS调试 </h3>

- 1.监视：可以监控变量的变化情况，当变量处于作用域时，变量是亮的，不在该作用域是是呈灰色。此外输入`&变量`能够查看变量所在的内存地址，便于查看内存。

- 2.`内存`:`调试`-->`窗口`-->`内存`

- 3.`Process Exploer`利用该软件可以迅速定位某个exe文件所需要的动态库文件，并寻找到。

- 4.`exe文件生成`：生成别人也能使用的exe文件步骤为，`项目`-->`属性`-->`Fortran`-->`Libraries`-->`runtime Libraries`-->`Multithreaded(release)`或者`Debug Multithreaded (/libs:static /threads /dbglibs)`。

- 5.`VS上的多线程调试`：`断点调试`-->`调试->窗口->线程`-->`先将所有线程全部冻结`-->`将单个线程解冻并进行调试`

- 6.`数组的赋值`：数组在定义时赋值使用`data a(2) /data1,data2/`或者`(/data1,data2/)`来进行，定义之后的用`[]`来赋值(但是要统一类型，比如实型，就得写成2.0，而不是2)，比如：
```Fortran
    real(kind=8),parameter :: a(5) = (/1,2,3,4,5/) 
    real(kind=8) :: b(5)
    real(kind=8),allocatable,dimension(:,:) :: t
    data b(5)  /1,2,3,4,5/
    allocate(t(2,40))
    t(1,:)=[8.0,9.0,10.0,11.5,13.0,15.0,16.5,19.0,21.5,24.0,27.5,31.0,35.0,39.5,44.5,50.5,57.0,64.5,73.0,82.5,93.0,105.5,119.0,&
            134.5,152.5,172.0,194.5,220.0,249.0,281.5,318.0,359.5,406.5,459.5,519.5,587.5,664.5,751.0,849.0,960.0]
    t(2,:)=[24.0,27.0,31.0,35.0,39.0,44.0,50.0,57.0,64.0,72.0,82.0,93.0,105.0,118.0,134.0,151.0,171.0,193.0,219.0,247.0,280.0,&
            316.0,357.0,404.0,457.0,516.0,584.0,660.0,746.0,844.0,954.0,1079.0,1220.0,1379.0,1559.0,1763.0,1993.0,2253.0,2547.0,2880.0]
    allocate(bz(m,nt))
```

----
<h3 align=center > 二.MKL数学库pardiso使用 </h3>

- 1.F77接口可以不必添加`include或use XXmoduel`和`在input处输入lib`，只需要选择`项目`-->`属性`-->`Fortran`-->`Libraries`-->`Use Intel Math Kernel Library`-->`Parallel(/Qmkl:parallel)`,F90则相反，需要前面步骤，不需要后面的，这里pardiso是f77接口。

- 2.函数调用：`call pardiso (pt, maxfct, mnum, mtype, phase, n, a, ia, ja, perm, nrhs, iparm, msglvl, b, x, error)` ：
```Fortran
integer(kind=8)  :: pt(64)   !// kind=8:x64; kind=4:win32
!pt(64):指向求解器内部数据地址的指针。这些地址被传递到求解器和所有相关的内部内存，他们都通过这个指针进行组织管理，一般不需要动它；
integer(kind=4)  :: maxfct
!maxfct:具有相同非零稀疏结构且必须同时保存在内存中的最大因子数。在大多数应用中，该值等于1。在求解器的内部数据管理中，可以同时存储多个具有相同非零结构的不同分解。
integer(kind=4) :: mnum
!mnum:指示实际需要求解的矩阵，与maxfct捆绑使用，使用这个标量，您可以定义要分解的矩阵。值必须为：1≤mnum≤maxfct。在大多数应用程序中，此值为1，值得注意的是，不同的mnum需要指定不同的pt进行求解，所以如果使用maxfct，则需要将maxfct、mnum和pt捆绑一起使用来达到存储多个LU分解目的。
!此外值得注意的是，pardiso里面的LU分解不能覆盖，它只会保存第一次分解的结果
integer(kind=4) :: mtype
!mtype:定义求解的矩阵类型；
!1:实对称与结构对称矩阵；2:实对称正定矩阵；-2:实对称矩阵；3:复数对称与结构对称矩阵；4:复数埃尔米特正定矩阵；-4:复数埃尔米特矩阵；6:复数对称矩阵；11:实数不对称矩阵；13:复数不对称矩阵
integer(kind=4) :: phase
!phase:控制求解器的执行。通常是两到三位数字。整数i和j（正常执行模式为10i+j，1≤i≤3，i≤j≤3）。i数字表示执行的开始阶段，j表示结束阶段。PARDISO有以下执行阶段：
!阶段1：填充还原分析和符号分解
!阶段2：数值因式分解
!阶段3：包含迭代细化的前向和回代求解
!整个阶段可以分为两个或三个独立的过程：向前、回代和对角线求解
!phase:11:分析;     12:分析，因式分解;      13:分析，因式分解，求解和迭代细化
!22:因式分解;  23:因式分解，求解和迭代细化;   33:求解和迭代细化;
!331:和33一样，但只进行前向替换;   332:同33，但只进行对角替换;   333:同33，但只进行回代
!0:释放mnum个L和U矩阵的内存；   -1：释放所有内存
integer(kind=4) :: n
!n:矩阵的大小，即为求解n*n的矩阵
real(kind=8)    :: a
!a为双精度类型时，矩阵为实数类型，即mtype=1，2，-2，11，且有双精度的iparm(28)=0；
!a为单精度类型时，矩阵为实数类型，即mtype=1，2，-2，11，且有单精度的iparm(28)=1；
!a为双精度复数时，矩阵为复数类型，即mtype=3，6，13，14，-4，且有双精度的iparm(28)=0；
!a为单精度复数时，矩阵为复数类型，即mtype=3，6，13，14，-4，且有单精度的iparm(28)=1；
!a为矩阵，存储着非零元素
integer(kind=4):: ia(n+1)
!ia(i)代表第i行，ia(i+1)代表等于A中所有非零元素，ia和ja具体看CSR存储格式
integer(kind=4):: ja(n+1)
!CSR保存格式，分为两种情况，当为对称矩阵时，只保存上三角的信息，当为非对称矩阵时，保存所有非零元素的信息。其中a记录每一个非零元素，ia(1)=1，ia(n+1)-ia(n)=第n行的元素；ja是每一个非零元素在列号，如果需要保存的非零元素有k个和该矩阵方程为h*h，则ja(k)，a(k)，ia(h+1).
integer(kind=4):: perm(n)
!直接perm=0，暂时不知道干嘛的
integer(kind=4):: nrhs
!nrhs为方程组右边向量b的列数，这里一般是1.
integer(kind=4):: iparm(64)
!iparm(3)是并行的线程 数，一般令其iparm(3) = mkl_get_max_threads()，需要先定义integer(kind=4), external:: mkl_get_max_threads
integer(kind=4):: msglvl
!msglvl=0时不显示信息，msglvl=1时将信息显示在屏幕上。
real(kind=8) :: b
!b为右手边向量
real(kind=8) :: x
!x是方程组最终的结果值
integer(kind=4):: error
!对于以及进行LU分解的，哪些变量是可以进行回收的呢？
!a、ia、ja、perm，其中perm一般用不上，但是pt、iparm在分解的时候值会变化
```

----
<h3 align=center > 三.MPI的使用 </h3>

- 1.去MPI的官网下载MPI，在集群服务器上进行安装，具体安装说明后面补充。

- 2.安装好好，登上系里的服务器集群，`218.195.54.104`，账号，这里是老师的账号：`003472`，密码:`580725`。

- 3.首先打开MPI的文件，`source MPI的文件位置`，系里的就是`source /public/software/profile.d/mpi_intelmpi-5.0.2.044.sh`，然后打开程序`main`修改程序MPI的进程个数`ind`和`numpro`，ind是从0到n-1，numpro=n，再然后打开参数文件，修改openMP的进程个数。再然后输入`mpdboot`，这个指令具体作用暂时未知，此外，这里不是直接运行exe文件，而是用MPI的指令运行exe文件，输入`make clean`-->`make`-->`mpiexec -np 线程数 ./a.out`，指令例子如下：
```shell
make clean
source /public/software/profile.d/mpi_intelmpi-5.0.2.044.sh
make
mpiexec -np 4 ./a.out
```