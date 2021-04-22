# iverilog多文件组织

在verilog HDL设计中，模块化设计模式深入人心，因此，在正常的设计中，我们都会倾向于将一个大模块写成若干个小模块，在一个个文件中注意实现小模块，最终将所有的小模块整合到一个大模块中，也就是将若干个小文件中的描述整合到一个大文件中。此时，如何通过`iverilog`指令一次性编译所有的文件就是一个需要考虑的事。

在C\C++中，大家都是通过include宏指令或者CMakeList文件来实现多文件编译的。`iverilog`提供了三种方式进行多文件编译。

假设我们的项目(`multi_file`)的组织结构如下：

```
multi_file
    |->main.v
    |->v1.v
    |->v2.v
    |->v3.v
```

其中main.v为入口文件，其余的三个都是子模块。

---

## 方法一：include宏

`include`宏在`iverilog`中同样支持。在`main.v`中通过inlclude(注意include的前面有`符号，由于markdown渲染的问题，所以我就不在前面写了)

```verilog
`include "v1.v"
`include "v2.v"
`include "v3.v"

module main;
    v1 u_v1();
    v2 u_v2();
    v3 u_v3();
endmodule
```

我们来试着编译一把：

```latex
$ iverilog -o main main.v
$ vvp main 
I am v1
I am v2
I am v3
```

这说明我们成功了。

---


## 方法二：编译文件

除了使用include，我们可以直接将具有引用关系的文件一股脑全部编译：

> 此时我们的`main.v`中没有include宏了。

尝试编译：

```latex
$ iverilog -o main main.v v1.v v2.v v3.v
$ vvp main
I am v1
I am v2
I am v3
```

效果相同。

---

## 方法三：使用编译参数-c

如果你的文件比较多，那么方法二就会显得非常不优雅，此时，我们可以使用`-c`编译参数，该参数的输入是一个txt文件，这个文件里有我们所有需要编译的文件。

> 此时我们的`main.v`中没有include宏了。

我们先创建一个文件`commandfile.txt`。内容如下：
```
main.v
v1.v
v2.v
v3.v

```

> 这里有个坑，由于使用了C语言的文件流函数读取，所以请确保你的commandfile.txt中一行一个文件名，且最后空出一行当作EOF，也就是文件流读取的终止符，否则，iverilog编译时会报错：`ERROR: File name not terminated.`

编译一把：

```latex
$ iverilog -o main -c commandfile.txt
$ vvp main
I am v1
I am v2
I am v3
```