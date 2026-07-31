SRC_DIR  := /home/bigvegetable/UVM/myself
DST_DIR  := /mnt/d/UVM_study

# make d: 把 myself 下所有文件同步到 D 盘 UVM_study
.PHONY: d
d:
	@echo "==> syncing $(SRC_DIR) -> $(DST_DIR)"
	rsync -av --progress \
		--exclude '.git' \
		--exclude 'work/' \
		--exclude '*.fsdb' \
		--exclude 'simv*' \
		--exclude '*.log' \
		"$(SRC_DIR)/" "$(DST_DIR)/"
	@echo "==> done"

# make d-all: 同步所有文件，包括 log 和仿真产物
.PHONY: d-all
d-all:
	@echo "==> syncing ALL files $(SRC_DIR) -> $(DST_DIR)"
	rsync -av --progress \
		--exclude '.git' \
		--exclude 'work/' \
		"$(SRC_DIR)/" "$(DST_DIR)/"
	@echo "==> done"
