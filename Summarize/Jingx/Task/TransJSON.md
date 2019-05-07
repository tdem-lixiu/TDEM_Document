任务：

- [ ] 学习了解JSON格式的特点
- [ ] 将下面示例文件改写成JSON格式，主要考虑数据信息，提示性文字可转为简短的Key
- [ ] 尝试使用Fortran语言读取和输出包含示例内容的JSON格式文件，编写信息提取子程序
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