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
- [ ] 一维正演输出结果包含**发射参数信息**作为**道头**，上一条中信息由读入待定义文件获取，待定义全域视电阻率文件文件名作为接口传递
    - [x] 输入文件与正演模块输出文件格式一致，按道头设置参数接口，功能初步实现，尚未修改正演模块。``(2019.05.06)``
    - [ ] 文件格式采用``.json``，便于后续处理，有待制定。``(2019.05.07)``
- [ ] 绘制曲线时要考虑增加文件道头的影响
- [ ] 现有绘图功能的接口分散写在各类中的自定函数，代码冗余
##### 更改说明
- 示例输入文件为``model.par``，文件名由中间文``件fname.temp``传递，标准正演结果数据由``halfspace.dat``传递，待定义数据由``fwd.dat``传递
    - [ ] 考虑更改为数据传递，改写函数接口
- 过程文件统一在Fortran动态库中删除