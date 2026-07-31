这里存放的是6.22号的任务，我今天补上
# 已掌握什么
## systerm veriolg
我已经掌握了systerm verilog的使用，包括接口，类，function，task，自认为理解到位了。还有forever，repeat等语法的存在。
## UVM
我对UVM的掌握通过<UVM实战>这本书，已经理解了最基本的框架，从uvm_top（UVM自己搭建的最顶层的树根），到uvm_basic（里面一般包含了uvm_base，(用于连接sequence和sequencer）,和uvm_sequence），再往下就是uvm_env，env下是uvm_agt，uvm_scoreboard和uvm_module，uvm_agt下是uvm_monitor and uvn_driver。这是我没有看书回想的，可能有一些错误。还有第二章说的uvm的一些具体机制。
## verilog
对于verilog的学习起源于ysyx计划，我现在用verilog搭建过一个支持七条指令的minirv_cpu，状态机我知道是什么东西，但是目前还不太会使用，因为感觉没有什么使用场景。我打过竞业达比赛，会一些分支预测部分。
## C
我对C的掌握也不多，现在更是因为没有怎么用到过，现在全忘记了。

# 想找什么实习
不清楚，我不知道IC验证有什么实习，主人你可以推荐一点吗？我只知道IC验证高校干的人少，我好找一点。

# 当前最担心什么
当前最担心的就是自己不好好学习，希望严加看管。
然后就是我马上要期末考试了，不过没关系，我会努力的去努力。

# 希望寒假前的项目能达到什么样的水平
不知道，我也不知道有哪些水平。我希望毕业工作月工资两万起步，所以要多实习，主人你帮我规划吧。

# 修正后 UVM 的理解
UVM 结构大致是：uvm_root/uvm_top -> uvm_test_top -> test -> env -> agent/model/scoreboard/coverage。
test 负责配置环境、启动 sequence、控制测试流程。
env 是验证环境容器，负责创建 agent、model、scoreboard，并在 connect_phase 里连接 TLM 通路。
agent 负责封装 sequencer、driver、monitor。active agent 有 sequencer 和 driver，passive agent 通常只有 monitor。
sequence 负责产生 transaction。
sequencer 负责管理 sequence 和 driver 之间的 transaction 传递。
driver 从 sequencer 获取 transaction，并通过 virtual interface 驱动 DUT。
monitor 从 interface 采样 DUT 输入/输出，并通过 analysis_port 发给 scoreboard、model 或 coverage。
scoreboard 比较期望结果和实际结果，判断 DUT 行为是否正确。
model 根据输入 transaction 产生期望输出。
transaction 是验证环境里流动的数据对象。

# 优先投递实习方向
1. 数字 IC 验证实习：优先。原因是和当前 SV/UVM 学习路线最匹配。
2. SoC 验证实习：次优先。原因是后续 APB、寄存器、总线验证项目可以支撑。
3. FPGA 验证/测试实习：保底。原因是你有 Verilog/FPGA/比赛基础，但目标仍然向 IC 验证靠。