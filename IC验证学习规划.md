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

必须完成：

- class、handle、new、copy、compare、print。
- randomize、constraint、inside、dist、rand/randc。
- interface、clocking block、modport、virtual interface。
- mailbox、event。
- covergroup。
- 基础 SVA：即时断言、并发断言、握手协议断言。

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

必须掌握：

- `uvm_component` 和 `uvm_object`。
- factory 注册和创建。
- config_db 传 virtual interface。
- phase 和 objection。
- sequence、sequencer、driver 通信。
- analysis_port、analysis_fifo、scoreboard。
- active/passive agent。

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

### Day 2：2026-08-01，interface 和 virtual interface

任务：

- 写 `sv_practice/valid_ready_tb/valid_ready_if.sv`。
- 包含 `clk`、`rst_n`、`valid`、`ready`、`data`。
- 写一个最小 `tb_top.sv` 实例化 interface。
- 用 VCS 编译。

验收标准：

- 能解释 interface 解决了什么问题。
- 能解释 virtual interface 为什么是 class 和 RTL 的桥。

### Day 3：2026-08-02，非 UVM driver

任务：

- 写 packet class。
- 写 driver class。
- driver 通过 virtual interface 驱动 valid-ready 接口。
- 用 VCS 跑，Verdi 看波形。

验收标准：

- 波形能看到 valid/data 被 driver 驱动。
- 能解释 driver 职责。

### Day 4：2026-08-03，monitor 和 mailbox

任务：

- 写 monitor class。
- monitor 从 interface 采样 transaction。
- 使用 mailbox 把 transaction 送到 scoreboard。

验收标准：

- log 能显示 monitor 采样到的数据。
- 能解释 mailbox 在非 UVM TB 里的作用。

### Day 5：2026-08-04，scoreboard

任务：

- 写一个简单 DUT。
- 写 scoreboard 比较输入和输出。
- 制造一个错误，确认 scoreboard 能报错。

验收标准：

- 有 PASS 场景。
- 有 FAIL 场景。
- 能解释 scoreboard 不是打印器，而是自动检查器。

### Day 6：2026-08-05，coverage 和 SVA 入门

任务：

- 加 covergroup。
- 加 1 到 2 条简单 assertion。
- 用 VCS 跑。

验收标准：

- 能解释功能覆盖率和代码覆盖率区别。
- 能解释 assertion 检查什么。

### Day 7：2026-08-06，复盘和博客草稿

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
