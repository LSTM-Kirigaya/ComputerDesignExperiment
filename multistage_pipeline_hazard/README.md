# 五级流水线（带冒险和异常处理）

### 项目结构

```
multistage_pipeline
	|-> Controller:  控制器
	|-> DataPath:    数据通路
	|-> data:		 IM和DM读入的地方
	|-> figure:      设计图纸
	|-> test_bench:  调教子模块的小黑屋
	|-> mips_code:   用来测试的mips汇编源代码
	|-> Python:		 一些加速生产的脚本，我高兴时可能会写写使用说明
	|-> mips.v:      最终的CPU
	|-> testBench:   测试mips.v的激励文件
	|-> README.md:   你知道的
	|-> .gitignore
```

### 设计图纸(2021.5.15更新)







---

## 日志

### 2021.5.15

