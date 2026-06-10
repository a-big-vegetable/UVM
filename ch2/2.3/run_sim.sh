#!/bin/bash
# UVM 仿真脚本 — 2.3.3 my_env 测试
# 用法:
#   ./run_sim.sh         命令行模式 (无GUI)
#   ./run_sim.sh -g      GUI模式
#   ./run_sim.sh -w      波形模式 (命令行 + 记录波形)

set -e

# 清理上一次的库（可选）
if [ "$1" = "clean" ]; then
    rm -rf work transcript vsim.wlf
    echo "Cleaned."
    exit 0
fi

# 创建 work 库
vlib work 2>/dev/null || true

# 编译 DUT + TB
# tb_top.sv 内部已经 include 了所有验证组件
vlog +acc +incdir+../dut ../dut/dut.sv tb_top.sv

# 根据参数选择运行模式
if [ "$1" = "-g" ]; then
    # GUI 模式
    vsim -do "run -all" top_tb
elif [ "$1" = "-w" ]; then
    # 命令行 + 波形
    vsim -c -do "log -r /*; run -all; quit" top_tb
else
    # 纯命令行模式
    vsim -c -do "run -all; quit" top_tb
fi
