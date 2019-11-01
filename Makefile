PROJECT_DIR:=~/sandy_deploy

TMP_DIR:=${PROJECT_DIR}/tmp
CONFIG_DIR:=~/.config/unity3d/Darkkon/sandbox
CURRENT_DIR:=${PROJECT_DIR}/current
RELEASES_DIR:=${PROJECT_DIR}/releases
LOG_DIR:=${PROJECT_DIR}/log
UNPACK_LOG:=${LOG_DIR}/unpacking.log
CONFIG_BACKUP_DIR=${LOG_DIR}/config_backup-$(shell date -Iseconds) 

LATEST_DOWNLOADED_PACK:=${TMP_DIR}/latest.zip
CURRENT_VERSION:=$(shell cat $(CURRENT_DIR)/version)

SERVER:=konstantin@office.brandymint.ru
SERVER_BUILDS_PATH:=/home/konstantin/SandyAppBuilds/
SERVER_LOGS_PATH:=/home/konstantin/logs/

NEWEST_FILE:=`ssh $(SERVER) "ls -c $(SERVER_BUILDS_PATH)" | head -1`
GET_LATEST_NAME:=ssh $(SERVER) "ls -c $(SERVER_BUILDS_PATH)" | head -1

all: update watch

watch: stop_all
	@echo "Запускаю версию $(CURRENT_VERSION)"
	watch -b -n 1 /bin/bash -c ./current/run.sh

stop_all:
	@echo 'Убиваю все запущенные приложения'
	@ps axfww | grep sandbox.x86_64 | grep -v grep | awk '{ print $1 }' | xargs -r kill -9

run: stop_all
	@echo "Запускаю версию $(CURRENT_VERSION)"
	./current/run.sh

report:
	scp -r config/ $(SERVER):$(SERVER_LOGS_PATH)$(hostname)-$(date '+%Y-%m-%d-%H:%M:%S')

update: download unpack

download:
	@echo "Ищу последний релиз.."
	$(eval LATEST=$(shell $(GET_LATEST_NAME)))
	@echo "Последний доступный релиз: $(LATEST), качаю.."
	@scp $(SERVER):$(SERVER_BUILDS_PATH)$(LATEST) $(TMP_DIR)/
	@rm -f $(LATEST_DOWNLOADED_PACK)
	@ln -s $(TMP_DIR)/$(LATEST) $(LATEST_DOWNLOADED_PACK)

unpack:
	$(eval PACK_NAME=$(shell ls -o $(LATEST_DOWNLOADED_PACK) | grep -oE '[^/]+$$'))
	$(eval UNPACK_DIR=${RELEASES_DIR}/${PACK_NAME}-$(shell date -Iseconds))
	@mkdir $(UNPACK_DIR)
	@echo "Распаковываю в $(UNPACK_DIR) и линкую в $(CURRENT_DIR)"
	@unzip $(LATEST_DOWNLOADED_PACK) -d $(UNPACK_DIR) > $(UNPACK_LOG)
	@rm -f $(CURRENT_DIR)
	@ln -s $(UNPACK_DIR) $(CURRENT_DIR)
	@echo 'Развернул версию $(CURRENT_VERSION)'

backup_config:
	@mkdir ${CONFIG_BACKUP_DIR}
	@cp -vr ${CONFIG_DIR}/* ${CONFIG_BACKUP_DIR}

clear: backup_config
	@rm -f $(CONFIG_DIR)/*
