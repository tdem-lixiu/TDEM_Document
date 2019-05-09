任务：

- [ ] 学习了解JSON格式的特点
- [ ] 将下面示例文件改写成JSON格式，主要考虑key的设置以及数据信息，~~提示性文字可转为简短的Key~~，**每个key对应值的类型要考虑清楚**

- [ ] 尝试使用Fortran语言读取和输出包含示例内容的JSON格式文件，编写信息提取子程序
   - [x] 参考链接给出的开源库可以用Fortran对json文件内的信息很好地读取，已经测试通过
   - [ ] 下面的示例文件内容转换为json格式作为测试文件，编写对应的满足读取需求的Fortran字程序，封装至动态链接库，并说明调用接口
- [ ] 考虑多发射源，多接收点信息时JSON中的Key设置

```
Layer = 2
Res = 100 10
Thickness = 200
number of source = 1
coordinate of source:
start x | start y | end x | end y
   -50       0       50      0
Amplitude of current = 1
Number of electric dipoles = 10
Number of time = 100
Calculated time range = -5 -2
Number of receiving points = 3
coordinate of receiving points:
|   X   |   Y   |   Z   |
    0      100      0
    0      100     -10
    0      100     -20
File prefix = Model_1
Calculate type = ff
```
参考链接：
- 开源代码：[A Fortran 2008 JSON API](https://github.com/jacobwilliams/json-fortran#json-fortran)
- 示例代码：[Example Usage for json-fortran](https://github.com/jacobwilliams/json-fortran/wiki/Example-Usage)
- 教程（此处只参考Fortran部分，Python部分景旭负责）：[Fortran + JSON + Python](http://degenerateconic.com/fortran-json-python/)