# IC验证学习规划

> 重启日期：2026-07-31  
> 目标时间：大二寒假前后  
> 当前工具链：本地写代码，CentOS 使用 VCS 编译仿真，Verdi 查看波形和 debug。  
> 总目标：寒假前具备投递 IC/数字验证实习的基础竞争力。不是“看过 UVM”，而是能拿出一个可运行、可讲解、可写进简历的验证项目。

## 0. 当前判断

从 2026-07-31 起，学习按新的 VCS/Verdi 工具链重启。旧的 6 月、7 月初安排全部作废，不再补旧账。

现在不能再从“每天随便学一点”开始。你已经有 VCS 和 Verdi，学习路线必须直接对齐招聘要求。

当前招聘对 IC 验证的核心要求集中在这些点：

- SystemVerilog、Verilog、UVM。
- VCS/Verdi 等仿真和 debug 工具。
- 验证计划、验证环境搭建、testcase 开发、回归测试。
- 功能覆盖率、代码覆盖率、断言/SVA。
- Python/Shell/Makefile 脚本能力。
- APB/AHB/AXI、SPI、I2C、UART 等协议经验。
- 能根据设计文档分析 DUT，定位 bug，维护验证文档。

参考来源：

- 汇顶科技数字 IC 验证岗位：要求 VCS/Verdi、UVM、SystemVerilog、Python。
- 浙江大学就业平台数字 IC 验证岗位：要求环境搭建、VCS、Verdi、回归、覆盖率、断言。
- BOSS 直聘 IC 验证相关岗位：强调验证计划、验证环境、回归测试、覆盖率提升。
- 牛客验证实习岗位：要求 Verilog/SystemVerilog、UVM 基础，了解总线协议和低速外设。

结论：后续不再泛泛学语法。**所有学习都围绕“能独立搭一个模块级验证环境”展开。**

## 1. 寒假前验收目标

寒假前至少交出这些成果：

1. **一个主项目：FIFO UVM 验证**
   - 支持定向测试、随机测试、满/空/边界测试。
   - 有 driver、monitor、sequencer、sequence、agent、env、scoreboard。
   - 有 functional coverage。
   - 有 basic SVA。
   - 能用 VCS 跑仿真，用 Verdi 看波形。
   - README 能说明验证目标、环境结构、运行方式、测试点、覆盖率结果。

2. **一个协议项目：APB slave UVM 验证**
   - 支持 APB read/write。
   - 支持寄存器读写检查。
   - 支持错误场景或非法访问场景。
   - 有验证计划 `verification_plan.md`。

3. **一套工具流**
   - 会写 `run_vcs.sh`。
   - 会用 VCS 编译、仿真、生成 `fsdb/vcd`。
   - 会用 Verdi 打开波形，定位 driver/monitor/DUT 信号关系。
   - 会保存仿真 log。

4. **一套求职材料**
   - 简历一版。
   - 项目讲解稿。
   - CSDN 博客 6 篇以上。
   - 面试题复盘文档。

## 2. 总路线

### 阶段 1：2026-07-31 到 2026-08-18，SV 验证语法补齐

目标：把 SV 验证语法补到能写非 UVM testbench。

必须学会的知识点：

- `class` 和 `module` 的区别：class 是验证对象模板，module 是硬件结构。
- object handle：句柄只是指向对象的变量，`new()` 后才有真实对象。
- constructor：`new()` 如何传参、默认值、`this.xxx` 的作用。
- randomization：`rand`、`randc`、`randomize()`、随机化返回值。
- constraint：`inside`、范围约束、枚举约束、约束冲突。
- interface：把一组 DUT 信号封装起来，减少端口混乱。
- virtual interface：class 世界访问 interface 的桥。
- clocking block：规范 testbench 采样和驱动时序。
- modport：区分 driver/monitor/DUT 看到的信号方向。
- mailbox：非 UVM 环境里传 transaction。
- event：控制不同进程之间的同步。
- covergroup：统计测试有没有覆盖到目标场景。
- SVA：用断言检查协议规则和时序规则。

阶段项目：

- `sv_practice/class_packet`：packet 随机化练习。
- `sv_practice/valid_ready_tb`：非 UVM valid-ready 验证。
- `sv_practice/fifo_tb`：非 UVM FIFO 验证。

阶段验收：

- 每个练习都能在 CentOS 上用 VCS 跑。
- 每个练习都有运行命令和 log。
- 你能解释 generator、driver、monitor、scoreboard 数据流。
- 至少写 2 篇博客草稿。

### 阶段 2：2026-08-19 到 2026-09-25，UVM 入门项目

目标：完成第一个完整 UVM 环境。不要急着高级，先把数据流跑通。

必须学会的知识点：

- `uvm_object`：transaction/sequence 这类动态对象的基类。
- `uvm_component`：test/env/agent/driver/monitor/scoreboard 这类层次组件的基类。
- factory：为什么不用 `new()` 硬创建，如何注册、创建、覆盖类型。
- config_db：如何把 virtual interface 和配置从 test 传到 driver/monitor。
- phase：build/connect/run/report 的职责。
- objection：为什么 run_phase 不会立刻结束。
- sequence/sequencer/driver：transaction 从产生到驱动 DUT 的路径。
- TLM analysis_port：monitor 如何把采样结果广播出去。
- scoreboard：如何比较期望结果和实际结果。
- active/passive agent：输入 agent 和输出 agent 为什么不同。

阶段项目：

- `uvm_practice/fifo_uvm_basic`

阶段验收：

- 至少 3 个 test：`base_test`、`random_test`、`full_empty_test`。
- scoreboard 能自动判断 PASS/FAIL。
- Verdi 能看到 DUT 输入输出和 monitor 采样点。
- README 有 UVM 结构图或数据流说明。
- 博客 2 篇以上。

### 阶段 3：2026-09-26 到 2026-11-15，简历项目

目标：做出能投简历的项目。项目必须完整，不准只有零散代码。

必须学会的知识点：

- verification plan：从 DUT 功能拆测试点。
- testcase list：定向测试、随机测试、边界测试如何组织。
- coverage plan：功能覆盖率点怎么从规格里提取。
- reference model：如何根据输入 transaction 预测期望输出。
- regression：如何一条命令跑多个 test。
- debug flow：如何从 FAIL log 定位到 waveform，再回到代码修 bug。

主项目：

- `projects/fifo_uvm`

主项目必须包含：

- `rtl/`
- `tb/`
- `sim/run_vcs.sh`
- `doc/verification_plan.md`
- `doc/testcase_list.md`
- `doc/coverage_plan.md`
- `README.md`

项目能力要求：

- 定向测试。
- 约束随机测试。
- scoreboard。
- functional coverage。
- basic SVA。
- VCS 回归脚本。
- Verdi debug 记录。

阶段验收：

- 能一条命令跑回归。
- 能说明每个 test 覆盖什么功能点。
- 能说明至少 3 个 debug 过程。
- 能用 5 分钟讲清楚项目。

### 阶段 4：2026-11-16 到寒假前，APB 项目和投递准备

目标：补协议经验，准备投递。

必须学会的知识点：

- APB 基本时序：setup phase、access phase、PSEL、PENABLE、PREADY。
- APB read/write transaction 如何抽象。
- register read/write 检查方法。
- 协议断言：稳定性、握手完成、非法访问。
- 项目表达：面试时如何讲验证目标、环境结构、测试点、覆盖率、bug。

项目：

- `projects/apb_slave_uvm`

必须完成：

- APB 协议基础笔记。
- APB slave RTL 或开源简化 DUT。
- APB transaction、driver、monitor、scoreboard。
- 寄存器读写测试。
- basic coverage。
- 简历和项目讲解稿。

阶段验收：

- 简历能写 1 个主项目和 1 个协议项目。
- 面试能解释 SV/UVM/VCS/Verdi/coverage/SVA。
- 每个项目都有 README、验证计划、运行脚本和 log。

## 3. 每周节奏

每周必须有四类产出。少一类，就不算完整学习周。

- 代码：至少一个可运行提交。
- 仿真：至少一个 VCS 成功 log 或明确报错 log。
- 文档：README、验证计划、笔记、博客草稿至少一个。
- 复述：用自己的话解释一个机制。

每周汇报模板：

```text
本周完成：
代码路径：
VCS/Verdi 结果：
我理解的关键机制：
遇到的问题：
下周计划：
```

## 4. 每天节奏

每天不追求多，追求不断。

1. **20 分钟复盘**
   - 不看笔记，回忆昨天代码。

2. **60 到 90 分钟主任务**
   - 写代码或修 bug。

3. **30 分钟仿真**
   - 传到 CentOS。
   - 用 VCS 跑。
   - 保存 log。

4. **10 分钟记录**
   - 写当天做了什么、哪里没懂。

每天汇报必须带证据：

```text
日期：
今天完成：
代码路径：
运行命令：
VCS/Verdi 结果：
我自己的理解：
明天任务：
```

## 5. 第 1 周任务：2026-07-31 到 2026-08-06

### Day 1：2026-07-31，恢复环境和 packet 随机化

今天不许铺大计划。只做一个最小可运行练习。

先学知识点：

- `class`：定义验证对象模板，不是硬件模块。它描述一笔数据有哪些字段、有哪些方法，比如 `addr/data/kind/print()`。
- `handle`：指向对象的变量。`packet p;` 只是声明了一个句柄，还没有对象；`p = new();` 后才真的创建对象。
- `new()`：构造函数。作用是创建对象、初始化字段、把对象交给句柄。以后 UVM 里的 transaction 也靠类似思想创建。
- `this.xxx`：表示当前对象自己的字段。构造函数参数和成员变量重名时，必须用 `this.addr = addr;` 区分。
- `rand`：声明字段可以被随机化。没有 `rand`，`randomize()` 不会改这个字段。
- `constraint`：限制随机结果的合法范围。验证不是乱随机，而是在合法协议范围内随机。
- `inside`：常用约束写法，例如 `addr inside {[8'h00:8'hff]};` 表示地址只能落在这个范围。
- `randomize()`：触发随机化，返回 1 表示成功，返回 0 表示失败。标准写法要检查返回值，不能裸调用。
- VCS 基本流程：`vcs` 编译生成 `simv`，`./simv` 运行仿真，`tee` 保存 log。

任务：

- 整理 `sv_practice/class_packet/packet_test.sv`。
- 使用 `rand`、`constraint`、`randomize()`。
- 在 CentOS 上用 VCS 跑通。
- 保存 log 到 `sv_practice/class_packet/vcs_run.log`。
- 新建 `notes/restart_2026_07_31.md`，写明当前工具链、今天结果、明天任务。

验收标准：

- 能展示 20 条随机 packet。
- 能解释 `rand`、`constraint`、`randomize()`。
- 能说明 VCS 编译和仿真命令。

### Day 2：2026-08-01，最小 DUT + interface

先学知识点：

- interface 是什么：interface 是 SystemVerilog 提供的“信号包”。它把一组相关信号放在一起，例如 `clk/rst_n/valid/ready/data`。
- 为什么需要 interface：如果不用 interface，DUT、driver、monitor、tb_top 都要写一长串端口，容易接错、漏接、方向混乱。
- interface 和 module 的区别：module 描述硬件结构或测试顶层，interface 主要封装连接信号。interface 本身不是 driver，也不是 monitor。
- valid-ready 协议：`valid` 表示发送方有数据，`ready` 表示接收方能收。只有 `valid && ready` 同时为 1，数据才真正传输成功。
- signal direction：同一根信号对不同角色方向不同。driver 负责驱动 `valid/data`，DUT 可能驱动 `ready`，monitor 只观察。
- modport 是什么：modport 给 interface 定义不同视角，限制信号方向。例如 driver modport 可以输出 `valid/data`，monitor modport 只能输入观察。
- 最小 DUT 思路：先写一个极简单模块，把输入 `valid/data` 打一拍输出，验证环境先证明它能工作。
- 今天不学 virtual interface：virtual interface 等 Day 3 写 driver class 时再学。今天只学 interface 如何连接 module。
- 今天掌握标准：你必须能画出 `tb_top -> interface -> pass_through_dut` 的连接关系。

具体任务：

1. **建立目录**
   - 创建 `sv_practice/valid_ready_tb/`。

2. **写 interface 文件**
   - 文件名：`sv_practice/valid_ready_tb/valid_ready_if.sv`。
   - interface 名：`valid_ready_if`。
   - 参数：`DATA_WIDTH = 32`。
   - 信号：`clk`、`rst_n`、`valid`、`ready`、`data`。
   - 暂时只写信号，不强制写 modport。先把最小 DUT 跑通。

3. **写最小 DUT**
   - 文件名：`sv_practice/valid_ready_tb/pass_through_dut.sv`。
   - 功能：复位后 `ready` 恒为 1；当 `valid && ready` 时，把 `data` 锁存到 `data_out`，并拉高 `valid_out` 一个周期。
   - 端口可以直接使用普通端口，不必一开始就用 modport。

4. **写最小 tb_top**
   - 文件名：`sv_practice/valid_ready_tb/tb_top.sv`。
   - include `valid_ready_if.sv` 和 `pass_through_dut.sv`。
   - 例化 `valid_ready_if vif();`。
   - 例化 `pass_through_dut dut(...)`，把 `vif.clk/rst_n/valid/ready/data` 连接进去。
   - 产生 100MHz 时钟：`always #5 vif.clk = ~vif.clk;`。
   - 产生复位：开始 `rst_n=0`，20ns 后拉高。
   - 写一个 initial 发送一次数据：复位后驱动 `valid=1`、`data=32'h1234_5678`。
   - 打印输入 `valid/ready/data` 和 DUT 输出 `valid_out/data_out`。
   - 仿真 100ns 后 `$finish`。

5. **用 VCS 编译运行**
   - 在 CentOS 中进入 `sv_practice/valid_ready_tb/`。
   - 执行：
     ```bash
     vcs -full64 -sverilog -debug_access+all tb_top.sv -o simv
     ./simv | tee vcs_run.log
     ```

6. **检查结果**
   - log 里必须能看到复位变化。
   - log 里必须能看到输入 `valid=1`、`ready=1`、`data=12345678`。
   - log 里必须能看到 DUT 输出 `valid_out=1`、`data_out=12345678`。
   - 能说明这次 DUT 为什么算通过。

验收标准：

- 能解释 interface 解决了什么问题。
- 能解释 DUT 的输入输出。
- 能解释 `valid && ready` 代表什么。
- 能提供 `valid_ready_if.sv`、`pass_through_dut.sv`、`tb_top.sv`、`vcs_run.log`。

### Day 3：2026-08-02，非 UVM driver

先学知识点：

- transaction：一次抽象操作。对 valid-ready 来说，可以是一笔 `data` 传输；对 APB 来说，可以是一笔 read/write。
- 为什么要 transaction：验证环境不应该到处传裸信号。sequence/generator 产生 transaction，driver 把 transaction 变成引脚时序。
- driver 的职责：主动驱动 DUT 输入。driver 不是随机数生成器，也不是检查器，它只负责“把抽象激励翻译成时序”。
- virtual interface 在 driver 中的作用：driver 是 class，不能直接写端口，所以必须通过 virtual interface 访问 `valid/data/ready`。
- valid-ready 驱动规则：driver 先给出 data，拉高 valid，等待 ready；等 `valid && ready` 成立后，这笔 transaction 才算发送完成。
- reset 后默认值：复位期间 driver 应把 `valid` 拉低，`data` 给安全默认值，避免 DUT 收到假激励。
- 今天掌握标准：你必须能解释“packet 进入 driver 后，如何变成 valid/data 波形”。

任务：

- 写 packet class。
- 写 driver class。
- driver 通过 virtual interface 驱动 valid-ready 接口。
- 用 VCS 跑，Verdi 看波形。

验收标准：

- 波形能看到 valid/data 被 driver 驱动。
- 能解释 driver 职责。

### Day 4：2026-08-03，monitor 和 mailbox

先学知识点：

- monitor 的职责：被动观察 interface，把真实发生的信号行为重新打包成 transaction。monitor 不允许驱动 DUT。
- 为什么需要 monitor：driver 发了什么不等于 DUT 真的收到了什么。monitor 采的是事实，不是意图。
- 采样点：valid-ready 协议中，通常在时钟边沿检测到 `valid && ready` 时采样 `data`。
- mailbox 是什么：mailbox 是 SV 里的线程通信工具。monitor 可以 `put()` transaction，scoreboard 可以 `get()` transaction。
- blocking put/get：`get()` 没数据时会等待，所以 scoreboard 不需要自己轮询。
- driver 和 monitor 的区别：driver 主动施加激励，monitor 被动采样事实。混淆这两个角色，后面 UVM agent 一定会乱。
- 今天掌握标准：你必须能说清楚“monitor 为什么不能直接相信 driver 的数据”。

任务：

- 写 monitor class。
- monitor 从 interface 采样 transaction。
- 使用 mailbox 把 transaction 送到 scoreboard。

验收标准：

- log 能显示 monitor 采样到的数据。
- 能解释 mailbox 在非 UVM TB 里的作用。

### Day 5：2026-08-04，scoreboard

先学知识点：

- scoreboard 的职责：自动判断 DUT 输出是否正确。它不是打印 log 的地方，是验证环境的裁判。
- expected：期望结果，通常由 reference model 根据输入 transaction 算出来。
- actual：实际结果，通常由 output monitor 从 DUT 输出接口采样得到。
- reference model：一个行为模型，不追求和 RTL 写法一样，只追求功能结果正确。
- compare：scoreboard 比较 expected 和 actual；一致则 PASS，不一致则报错。
- 为什么要 FAIL 场景：只跑 PASS 不能证明 scoreboard 有用。必须故意制造错误，看它能不能抓住。
- 今天掌握标准：你必须能解释“为什么人肉看波形不算合格验证”。

任务：

- 写一个简单 DUT。
- 写 scoreboard 比较输入和输出。
- 制造一个错误，确认 scoreboard 能报错。

验收标准：

- 有 PASS 场景。
- 有 FAIL 场景。
- 能解释 scoreboard 不是打印器，而是自动检查器。

### Day 6：2026-08-05，coverage 和 SVA 入门

先学知识点：

- code coverage：工具统计 RTL 代码哪些语句、分支、条件被跑到。它回答“代码有没有被执行”。
- functional coverage：你根据规格定义功能点，统计这些功能点有没有测到。它回答“规格有没有被验证”。
- 两者区别：代码覆盖率高不代表功能覆盖完整；功能覆盖率需要你自己定义 coverpoint。
- covergroup：功能覆盖率容器，里面放 coverpoint 和 bins。
- coverpoint：你要观察的变量或表达式，例如 `kind`、`addr[7:4]`、FIFO depth。
- bins：把 coverpoint 的取值范围分桶，例如 read/write/idle 三类。
- assertion 的作用：仿真过程中实时检查规则，规则一破坏就报错。
- immediate assertion：在过程块里立刻检查一个条件。
- concurrent assertion：跨时钟周期检查时序关系，适合协议规则。
- valid-ready 断言例子：valid 拉高但 ready 没来时，data 应保持稳定。
- 今天掌握标准：你必须能说清楚“coverage 统计测没测到，assertion 检查有没有违规”。

任务：

- 加 covergroup。
- 加 1 到 2 条简单 assertion。
- 用 VCS 跑。

验收标准：

- 能解释功能覆盖率和代码覆盖率区别。
- 能解释 assertion 检查什么。

### Day 7：2026-08-06，复盘和博客草稿

先学知识点：

- 技术复盘不是流水账。结构必须是：目标、知识点、代码结构、运行结果、问题、修正、下一步。
- 博客不能只贴代码。每段代码都要说明它解决什么问题，为什么这样写。
- log 是证据。博客里要保留关键 VCS 命令和关键输出，不要只说“跑通了”。
- 踩坑要写清楚。比如少加 `-sverilog`，VCS 会把 SV 当 Verilog 编译，遇到 `class` 就报错。
- 面试表达要升级：不要说“我写了 driver”，要说“我把 transaction 翻译成 valid-ready 时序，并通过 monitor/scoreboard 验证结果”。
- 今天掌握标准：你能把本周内容讲成一个完整故事，而不是散装语法。

任务：

- 整理本周代码。
- 写一篇博客草稿：《从 SV class 到非 UVM 验证平台：我的第一周恢复训练》。
- 写周报。

验收标准：

- 博客草稿不少于 1200 字。
- 包含代码、log、踩坑。
- 周报必须写出 3 个薄弱点。

## 6. VCS/Verdi 基础命令

最小 VCS 命令：

```bash
vcs -full64 -sverilog -debug_access+all packet_test.sv -o simv
./simv
```

生成 Verdi 可看波形时，testbench 里先加：

```systemverilog
initial begin
    $fsdbDumpfile("wave.fsdb");
    $fsdbDumpvars(0, packet_test);
end
```

编译时通常需要加 Verdi PLI，具体路径以你的 CentOS 环境为准。先能跑 VCS，再处理 FSDB。

打开 Verdi：

```bash
verdi -sv packet_test.sv -ssf wave.fsdb
```

## 7. 学习规则

1. **没 log 不算跑过**。
2. **没 README 不算项目**。
3. **没 scoreboard 不算验证环境**。
4. **没 coverage 不算完整验证**。
5. **没复述不算学会**。
6. **落后后不补幻想计划，只补最小可运行任务**。

我按这四个标准验收你：

- 代码能不能跑。
- log 是否可信。
- 解释是否准确。
- 是否能转化成简历项目。
