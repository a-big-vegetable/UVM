# IC Verification Lab Agent Prompt

你是一名资深全栈架构师 + IC Design Verification Engineer + UVM Mentor。

请继续完善我的网站《IC Verification Lab》。

这是一个专门为我设计的 IC Verification 实习冲刺平台。

## 我的当前情况

- 我是电子/集成电路方向大二学生
- SystemVerilog 基础不错
- Verilog/RTL 阅读能力有一定基础
- 但是 UVM 不太会
- 目标是在 2027 年寒假前达到 IC Verification Intern 水平
- 这个网站最终要能作为我的作品集展示给面试官

请不要把网站做成普通知识库，也不要只做课程页面。

网站核心目标是：

用 5 个月时间，把我训练成能完成以下任务的人：

1. 看懂简单 RTL
2. 写 SystemVerilog testbench
3. 理解 transaction / driver / monitor / scoreboard
4. 从 SV testbench 过渡到 UVM
5. 能搭建最小 UVM verification environment
6. 能写 sequence、sequencer、driver、monitor、agent、env、scoreboard、test
7. 能理解 config_db、factory、phase、TLM port
8. 能做 basic functional coverage
9. 能 debug simulation failure
10. 能把项目讲成简历和面试故事

## 一、网站重新定位

网站名称：

IC Verification Lab

副标题：

From SystemVerilog to UVM Internship Readiness

产品定位：

不是 IC 验证百科网站。
不是公开视频课程网站。

而是：

一个面向本科生的 IC Verification 实战训练平台。

核心路径：

Skill Gap Diagnosis
-> UVM Learning Path
-> Verification Challenge
-> Code Simulation
-> Debug Lab
-> Project Portfolio
-> Interview Preparation

最终输出：

1. 一个完整 FIFO Verification 项目
2. 一个 APB Verification 项目
3. 一个 UVM mini project
4. 一份可以放 GitHub 的 README
5. 一份可以写进简历的项目描述
6. 一套 IC Verification 实习面试题和回答训练

## 二、MVP 优先级调整

因为我 SV 已经不错，UVM 较弱，所以不要把重点放在 SV 入门课程。

优先做：

1. UVM Bridge 模块
   帮我从 SystemVerilog testbench 过渡到 UVM。
2. Verification Challenge
   每个挑战都要能训练一个真实验证能力。
3. Debug Lab
   训练我看 log、定位 bug、解释 bug 原因。
4. Portfolio Generator
   自动把我完成的 challenge 生成项目报告。
5. Interview Coach
   围绕我的项目生成面试题。

不要优先做：

- 大量长篇教程
- 漂亮但无功能的首页
- 复杂社区系统
- 排行榜
- 博客系统
- 完整 LMS 课程后台

## 三、网站核心页面

### 1. Dashboard

显示：

- 当前目标：IC Verification Intern
- 距离寒假实习准备目标剩余时间
- 当前阶段：SV -> UVM Transition
- 本周重点：UVM component structure / transaction flow / scoreboard
- 今日任务：
  - 学习一个 UVM 概念
  - 完成一个 mini challenge
  - debug 一个失败案例
  - 更新一次 portfolio note

显示能力雷达图或进度条：

- SystemVerilog: 80%
- RTL Reading: 65%
- Testbench: 60%
- UVM Basics: 20%
- Scoreboard: 45%
- Coverage: 30%
- Debug: 35%
- Interview: 20%

### 2. UVM Roadmap

这是重点页面。

路线应该是：

SV Testbench
-> Transaction
-> Interface
-> Driver
-> Monitor
-> Scoreboard
-> Functional Coverage
-> UVM Component
-> UVM Phase
-> Sequence / Sequencer
-> Agent
-> Env
-> Test
-> Config DB
-> Factory
-> TLM
-> UVM Project

每个节点包含：

- 5 分钟概念
- SV 版本代码
- UVM 版本代码
- 对比解释
- mini challenge
- debug case
- interview question

尤其要强调：

这个 UVM 概念解决了普通 SV testbench 的什么问题？

### 3. Challenge 页面

Challenge 要像 LeetCode，但内容是 IC Verification。

每个 challenge 包含：

- 难度：Easy / Medium / Hard
- 能力标签：driver / monitor / scoreboard / coverage / assertion / uvm
- 题目背景
- DUT 代码
- 用户需要补全的 testbench 或 UVM component
- Monaco Editor
- Run Simulation 按钮
- Submit 按钮
- compile log
- simulation log
- pass/fail result
- hidden tests
- solution explanation

第一阶段至少内置这些 challenge：

#### A. FIFO SV Testbench

要求：

- 写 transaction
- 写 driver
- 写 monitor
- 写 scoreboard
- 检查 normal / overflow / underflow / reset

#### B. FIFO Scoreboard Debug

要求：

- 找出 scoreboard mismatch 原因
- 修复 compare logic

#### C. Valid-Ready Protocol Checker

要求：

- 检查 valid/ready handshake
- 编写 assertion 或 checker

#### D. APB Write/Read Testbench

要求：

- 根据 APB timing 写 driver
- monitor 采集 transaction
- scoreboard 检查 read data

#### E. UVM Mini Driver

要求：

- 把普通 SV driver 改写成 uvm_driver
- 使用 seq_item_port 获取 transaction

#### F. UVM Monitor + Analysis Port

要求：

- monitor 采集 transaction
- 通过 analysis_port 发给 scoreboard

#### G. UVM Scoreboard

要求：

- 使用 analysis_export / analysis_imp 接收 transaction
- 对 expected / actual 做比较

### 4. Debug Lab

Debug Lab 是差异化核心。

每个 debug case 包含：

- Buggy RTL 或 Buggy Testbench
- failing simulation log
- waveform 文本摘要或截图
- 用户判断 bug 类型：
  - DUT bug
  - driver bug
  - monitor bug
  - scoreboard bug
  - reset bug
  - protocol bug
- 用户填写 bug 原因
- 用户提交修复代码
- 系统运行验证

第一阶段至少做这些 case：

1. FIFO underflow flag bug
2. FIFO scoreboard expected queue bug
3. reset deassert timing bug
4. valid-ready handshake monitor sampling bug
5. APB read data one-cycle latency bug

### 5. Portfolio 页面

这是为找实习服务的核心页面。

每完成一个 challenge 或 debug case，自动生成项目记录。

Portfolio 应包含：

- Project Overview
- Verification Goal
- DUT Description
- Testbench Architecture
- Components:
  - transaction
  - driver
  - monitor
  - scoreboard
  - coverage
  - assertion
- Test Plan
- Test Cases
- Bugs Found
- Debug Method
- Simulation Result
- Coverage Summary
- Lessons Learned
- Interview Talking Points

支持导出 Markdown，适合作为 GitHub README。

输出示例：

```text
FIFO Verification Project

I built a SystemVerilog-based verification environment for a synchronous FIFO.
The environment includes transaction modeling, constrained stimulus generation,
driver, monitor, scoreboard, and directed/random tests. I verified normal
operation, overflow, underflow, and reset behavior. I also debugged a scoreboard
mismatch caused by incorrect expected queue handling.
```

### 6. Interview Coach 页面

围绕我的项目和 UVM 学习情况生成面试训练。

功能：

- 根据已完成项目生成面试题
- 提供参考回答
- 让我输入自己的回答
- AI 从技术完整度、表达清晰度、项目可信度三个角度评分
- 给出改进建议

第一批面试题包括：

- 为什么验证需要 scoreboard？
- driver 和 monitor 的区别是什么？
- transaction 是什么？
- sequence 和 sequencer 的区别是什么？
- UVM agent 里面通常包含什么？
- active agent 和 passive agent 有什么区别？
- analysis_port 是干什么的？
- config_db 解决什么问题？
- factory 机制有什么用？
- 你怎么验证 FIFO？
- 你在项目里 debug 过什么 bug？
- functional coverage 和 code coverage 有什么区别？

## 四、Simulation Runner 要求

第一版不要追求完整 UVM 在线仿真。

必须支持：

- Verilog RTL
- SystemVerilog testbench 子集
- assertion 基础用法
- 简单 coverage 统计或 mock coverage report

工具优先：

- Icarus Verilog
- Verilator

注意：

因为完整 UVM 通常依赖商业仿真器，不要让第一版阻塞在在线运行完整 UVM 上。

设计策略：

1. SV Challenge 可以真实 compile + simulate
2. UVM Challenge 第一版可以采用：
   - 代码结构检查
   - static pattern check
   - mock simulation log
   - AI code review
   - 后续预留 Questa/VCS runner adapter

Simulation Runner 必须有：

- 独立 job id
- compile stdout/stderr
- simulation stdout/stderr
- timeout
- log length limit
- temporary workspace
- basic sandbox isolation
- pass/fail parser
- test summary

## 五、前端设计要求

UI 可以比当前版本更完整，但不要做成花哨官网。

整体风格：

专业、工程化、训练平台、适合每天使用。

不要做大 hero landing page。

首页就是 Dashboard。

前端必须包含：

- 左侧导航栏
- Dashboard
- Skill/UVM Roadmap
- Challenge 列表
- Challenge 详情页
- Monaco Editor
- Run Result 面板
- Debug Lab
- Portfolio
- Interview Coach

Challenge 详情页布局：

左侧：

- 题目描述
- DUT 代码
- test requirement
- hints
- related UVM concept

右侧：

- Monaco Editor
- Run button
- Submit button
- Result tabs:
  - Compile Log
  - Simulation Log
  - Test Result
  - AI Review

Debug Lab 布局：

左侧：

- bug scenario
- code
- log
- waveform summary

右侧：

- bug classification
- fix editor
- submit fix
- result
- explanation

Portfolio 布局：

- 项目卡片列表
- 每个项目有完成度
- coverage
- bugs fixed
- challenges completed
- export README button

## 六、数据库设计要求

请设计数据库表，至少包含：

- users
- skills
- user_skill_progress
- courses
- challenges
- challenge_files
- test_cases
- submissions
- simulation_jobs
- debug_cases
- debug_submissions
- portfolio_projects
- portfolio_entries
- interview_questions
- interview_attempts
- ai_reviews

每个 submission 需要记录：

- user_id
- challenge_id
- submitted_code
- status
- compile_log
- simulation_log
- test_result_json
- score
- created_at

每个 portfolio entry 需要能追踪来源：

- challenge submission
- debug case
- manual note
- AI generated summary

## 七、后端 API 要求

请设计并实现 FastAPI API routes：

Challenge:

- GET /api/challenges
- GET /api/challenges/{id}
- POST /api/challenges/{id}/run
- POST /api/challenges/{id}/submit
- GET /api/submissions/{id}

Debug:

- GET /api/debug-cases
- GET /api/debug-cases/{id}
- POST /api/debug-cases/{id}/submit

Portfolio:

- GET /api/portfolio
- POST /api/portfolio/generate
- GET /api/portfolio/{id}/markdown

AI:

- POST /api/ai/code-review
- POST /api/ai/debug-assist
- POST /api/ai/interview-question
- POST /api/ai/interview-score

Progress:

- GET /api/progress
- POST /api/progress/update

## 八、AI 功能要求

AI 不要只是聊天框。

AI 必须绑定具体学习任务。

第一版实现：

### 1. AI Code Review

输入：

- user code
- challenge requirement
- simulation log

输出：

- coding issue
- verification architecture issue
- possible bug
- improvement suggestion
- interview explanation suggestion

### 2. AI Debug Assistant

输入：

- failing log
- code
- waveform summary

输出：

- likely bug location
- reasoning
- next debug step
- suggested fix direction

### 3. AI Interview Coach

输入：

- portfolio project
- user answer

输出：

- score
- missing technical points
- better answer
- follow-up questions

如果没有 OpenAI/DeepSeek API key：

- 使用 mock AI response
- 不影响主流程

## 九、内容重点

因为我 SV 掌握较好，请减少：

- Verilog 基础教程
- SV 基础语法教程
- 数字电路基础长文

重点增加：

- 从 SV testbench 到 UVM 的迁移
- UVM component 之间的数据流
- sequence / sequencer / driver 关系
- monitor 如何采集 transaction
- scoreboard 如何比较 expected/actual
- analysis_port / analysis_imp 使用
- config_db 的实际使用场景
- factory override 为什么有用
- UVM phase 执行顺序
- 如何讲清楚一个 verification project

## 十、第一版验收标准

完成后，网站必须至少做到：

1. 我能打开 Dashboard，看见寒假实习目标和 UVM 学习进度
2. 我能进入 UVM Roadmap，看到从 SV 到 UVM 的学习路线
3. 我能打开 FIFO Challenge
4. 我能在 Monaco Editor 里编辑 testbench
5. 我能点击 Run Simulation
6. 后端返回 compile log 和 simulation log
7. 系统能判断 PASS / FAIL
8. 我能完成一个 Debug Lab case
9. 我能生成 FIFO Verification Project README
10. 我能进入 Interview Coach，练习关于 FIFO/UVM 的面试题

## 十一、开发方式

请先不要直接大规模写代码。

先输出：

1. 当前项目结构分析
2. 现有功能缺口
3. 新版产品结构
4. 数据库 schema
5. API routes
6. 前端页面结构
7. Simulation Runner 方案
8. 第一阶段任务拆分

然后再开始实现。

实现时优先打通一个完整 vertical slice：

FIFO Challenge
-> Run Simulation
-> PASS/FAIL
-> Debug Case
-> Portfolio README
-> Interview Questions

不要平均开发所有模块。

## 十二、最终判断标准

请把这个网站当成我申请 IC Verification 实习的作品来做。

每个页面、每个功能都要服务于一个问题：

面试官看到后，会不会相信我真的做过验证、会写 testbench、会 debug、能学习 UVM？
