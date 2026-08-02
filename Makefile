SRC_DIR  := /home/bigvegetable/UVM/myself
DST_DIR  := /mnt/d/UVM_study
SHARE_DIR ?= /mnt/hgfs/UVM_study
SIM_DIR   ?= /home/bigvegetable/UVM_study
VCS_DIR   ?= sv_practice/valid_ready_tb

RSYNC_EXCLUDES := \
	--exclude '.git' \
	--exclude '.claude/' \
	--exclude '.vscode/' \
	--exclude 'work/' \
	--exclude 'csrc/' \
	--exclude 'simv' \
	--exclude 'simv.daidir/' \
	--exclude 'simv.vdb/' \
	--exclude 'ucli.key' \
	--exclude 'vcs.key' \
	--exclude 'DVEfiles/' \
	--exclude '*.fsdb' \
	--exclude '*.vcd' \
	--exclude '*.vpd' \
	--exclude 'transcript'

# make d: 把 myself 下所有文件同步到 D 盘 UVM_study
.PHONY: d
d:
	@echo "==> syncing $(SRC_DIR) -> $(DST_DIR)"
	rsync -av --progress \
		$(RSYNC_EXCLUDES) \
		--exclude '*.log' \
		"$(SRC_DIR)/" "$(DST_DIR)/"
	@echo "==> done"

# make d-all: 同步所有文件，包括 log 和仿真产物
.PHONY: d-all
d-all:
	@echo "==> syncing ALL files $(SRC_DIR) -> $(DST_DIR)"
	rsync -av --progress \
		$(RSYNC_EXCLUDES) \
		"$(SRC_DIR)/" "$(DST_DIR)/"
	@echo "==> done"

# make cp: 在 CentOS 中把共享目录同步到本地仿真目录
# 默认源目录是 /mnt/hgfs/UVM_study，默认目标是 /home/bigvegetable/UVM_study。
# 如果你的共享目录路径不同：
#   make cp SHARE_DIR=/path/to/shared/UVM_study
.PHONY: cp
cp:
	@test -d "$(SHARE_DIR)" || (echo "ERROR: SHARE_DIR not found: $(SHARE_DIR)"; exit 1)
	@mkdir -p "$(SIM_DIR)"
	@echo "==> syncing shared repo $(SHARE_DIR) -> sim repo $(SIM_DIR)"
	rsync -av --delete --progress \
		$(RSYNC_EXCLUDES) \
		"$(SHARE_DIR)/" "$(SIM_DIR)/"
	@echo "==> done"

.PHONY: vcs
vcs:
	cd "$(VCS_DIR)" && rm -rf csrc simv simv.daidir ucli.key vcs_run.log
	cd "$(VCS_DIR)" && vcs -full64 -sverilog -debug_access+all tb_top.sv -o simv
	@echo "==> simv generated successfully"
	cd "$(VCS_DIR)" && ./simv | tee vcs_run.log
	@echo "==> simulation finished, wrote vcs_run.log"
	@if [ -d "$(SHARE_DIR)" ]; then \
		$(MAKE) log; \
	else \
		echo "==> SHARE_DIR not found, skip log copy: $(SHARE_DIR)"; \
	fi

# make log: 在 CentOS 中把本地仿真目录生成的 .log 回传到共享目录
.PHONY: log
log:
	@test -d "$(SIM_DIR)/$(VCS_DIR)" || (echo "ERROR: sim dir not found: $(SIM_DIR)/$(VCS_DIR)"; exit 1)
	@mkdir -p "$(SHARE_DIR)/$(VCS_DIR)"
	@echo "==> copying logs $(SIM_DIR)/$(VCS_DIR) -> $(SHARE_DIR)/$(VCS_DIR)"
	cp -v "$(SIM_DIR)/$(VCS_DIR)"/*.log "$(SHARE_DIR)/$(VCS_DIR)/"
	@echo "==> done"

# make log-in: 在 WSL 中把 D 盘共享目录里的 .log 拉回当前仓库
.PHONY: log-in
log-in:
	@test -d "$(DST_DIR)/$(VCS_DIR)" || (echo "ERROR: shared dir not found: $(DST_DIR)/$(VCS_DIR)"; exit 1)
	@mkdir -p "$(SRC_DIR)/$(VCS_DIR)"
	@echo "==> copying logs $(DST_DIR)/$(VCS_DIR) -> $(SRC_DIR)/$(VCS_DIR)"
	cp -v "$(DST_DIR)/$(VCS_DIR)"/*.log "$(SRC_DIR)/$(VCS_DIR)/"
	@echo "==> done"
