## 全域视电阻率定义程序总结
***
[<==](https://github.com/tdem-lixiu/TDEM_Document/blob/master/Summarize/Jingx/README.md) ======================================================================= [==>](https://github.com/tdem-lixiu/TDEM_Document/blob/master/README.md)
### AppResATEMbyBzORdBzShiftAlgorithm程序总结
##### 原始程序功能说明
- 需要**IMSL**数学函数库
    * **CSIEZ**: Computes the cubic spline interpolant with the ‘not-a-knot’ condition and return values of the interpolant at specified points.[Link](https://docs.roguewave.com/en/imsl/fortran/2018.0/html/fnlmath/index.html#page/FNLMath%2Fmch3.06.09.html%23ww1409634)
    * FORTRAN 77 Interface
        Single:	
        ```Fortran
        CALL CSIEZ (NDATA, XDATA, FDATA, N, XVEC, VALUE)
        ```
        Double:	The double precision name is **DCSIEZ**.
- ``halfspace.dat``为相同发射参数下该时间段均匀半空间的响应
- ``fwd.dat``为待定义全域视电阻率的输入数据
##### GATEM 需要做的更改
- [x] ``halfspace.dat``改为在程序内计算得出，需要包含发射参数信息
    - 道头信息层数及各层电阻率和厚度在``ShiftAppRes1D.dll``中并没有使用，**存在问题**：非此程序正演数据并不包含道头，文件数据格式有待讨论。``(2019.05.06)``
- [x] 一维正演输出结果包含**发射参数信息**作为**道头**，上一条中信息由读入待定义文件获取，待定义全域视电阻率文件文件名作为接口传递
    - [x] 输入文件与正演模块输出文件格式一致，按道头设置参数接口，功能初步实现，尚未修改正演模块。``(2019.05.06)``
    - [x] 文件格式采用``.json``，便于后续处理，有待制定。``(2019.05.07)``
    - [x] 改写标准格式，考虑Fortran对于json格式的输入和输出[task]((https://github.com/tdem-lixiu/TDEM_Document/blob/master/Summarize/Jingx/Task/TransJSON.md) )
    ``初步完成，JSON文件key值可最后与整个系统统一命名（2019.05.13）``
- [x] 绘制曲线时要考虑增加文件道头的影响
    ``提取t与field对应的值组成Numpy数组进行绘图（2019.05.13）``
- [ ] ~~现有绘图功能的接口分散写在各类中的自定函数，代码冗余~~
专门设置任务解决此问题，不局限于在AppResShift模块集成任务中
##### 更改说明
- 示例输入文件为``model.par``，文件名由中间文``件fname.temp``传递，~~标准正演结果数据由``halfspace.dat``传递，待定义数据由``fwd.dat``传递~~
    - [x] ~~考虑更改为数据传递，改写函数接口~~
    模块封装成熟，采用json文件传递便于信息提取，在保留装置系统参数的情况下仍然可以直接读取其中的数据
    - [x] 中间传递过程以``AppRes.json``为载体，最终输出文件可以自动匹配输入文件名
- 过程文件统一在Fortran动态库中删除
- 为了适应json文件为接口的全域视电阻率定义程序，相应的一维正演程序也做了调整
    - [ ] json文件中冗余的key
    - [ ] json文件标准格式文档说明``(包括正演和全域视电阻率定义程序输入输出)``
