# ComputerDesignExperiment
计算机组成原理的实验，包括单周期CPU和五级流水线CPU的verilog实现。对本项目的大致结构稍作说明：

```
ComputerDesignExperiment
	|-> doc : 						实验文档
	|-> learning_verilog:			一些有关verilog的基础语法的demo
	|-> single_cycle:				单周期CPU，支持14条指令
	|-> multistage_pipeline:		五级流水线CPU，支持34条指令，不支持冒险，转发和异常
	|-> multistage_pipeline_final:  五级流水线CPU，支持57条指令，支持冒险，转发，不支持冒险
```

每个verilog项目都是用iverilog编译器进行多文件组织，不熟悉的同学可以参考我的知乎博客：https://zhuanlan.zhihu.com/p/367612172。

其次，每个子项目都有自己的README，可以自行参考，了解项目结构。

