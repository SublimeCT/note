# 绪论

## 面向的用户
- Operating System Designer *操作系统设计者*: 面向操作系统 **硬件**
- Programmer *程序员*: 面向 **操作系统** 和 **开发框架**
- End User *终端用户*: 面向应用程序

## 对于 OS 的不同视角
- 从外部看
    - 计算机用户: 提供了用户的使用环境
    - 应用程序员: 提供了虚拟机 *虚拟机指虚拟化出了硬件本身没有的功能*
- 从内部看
    - OS 开发者: 资源管理视角
    - OS 开发者: 组织作业视角

## 需求分析

## 软件系统的功能型需求
- 计算机用户使用的 `Interface` **用户接口**
    - 表现形式
        - 字符形式
        - 菜单形式
        - 图形形式
    - 使用方式
        - `on-line`
        - `off-line`
- 应用软件需要的 `System Call` **系统调用**
    - `POSIX.1`
    - `WIN32 API`

## 操作系统的非功能性需求
- `Performance` or `Efficiencey`: 性能或效率
- `Fairness`: 公平性
- `Reliability`: 可靠性
- `Security`: 安全性
- `Scalability`: 可伸缩(配置)性
- `Extensibility`: 可扩展性
- `Portability`: 可移植性

## 操作系统对硬件平台的依赖
- `Timer`: 计数器
- `I/O Interrupts`: 中断机制
- `DMA`: 直接存储器访问, [关于 DMA](https://www.zhihu.com/topic/20097181/intro)
- `Privileged Instructions`: 特权指令
- `Memory Protection Mechanism`: 内存保护机制, ***如地址越界 / 频繁的内存地址转换***

## 基本概念
- `Thread`: 线程是系统调度的最小单位
- `Process`: 进程是系统中拥有资源的最小实体
- `Virtual Memory`: 虚拟存储是系统对 `OS` 多级物理存储体系的高度抽象的结果, ***如将外存空间虚拟为内存***
- `File`: 是系统对多种外设进行高度抽象的结果, ***如将打印机虚拟为文件***

## 发展
> 省略了最初的单一操作员、单一控制端系统, 参考自 ***计算机的心智系统与哲学原理***

### 单道程序设计(简单批处理系统)
![](../../assets/images/UESTC_OS_uniprogramming.png)

- 以上模型只允许一个 `job` 在内存
- `Main Memory` 表示内存
- 内存中的 `job1` 独占所有(剩余)内存
- `monitor` 是操作系统, **常驻内存**, 在当前 `job` 完成后再从外存选择 `job` 进入内存

![](../../assets/images/UESTC_OS_uniprogramming_timeline.png)

`job` 中可能包含**计算** / **通讯** / **I/O** 等任务; `CPU` 运行远快于 `I/O`, 但是又必须等待 `I/O` 的结果, 实际上有很多时间 `CPU` 是处于等待状态, 且 `job1` 依然占用资源



## refer
- [1_2_01绪论](https://www.icourse163.org/learn/UESTC-1205790811?tid=1452082460#/learn/content?type=detail&id=1220309371&sm=1)
- [关于 DMA](https://www.zhihu.com/topic/20097181/intro)