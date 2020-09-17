PROJECT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
INSTALL_DIRS:= ~/Desktop ~/Рабочий\ стол ~/.local/share/applications/

TMP_DIR:=${PROJECT_DIR}/tmp
CONFIG_DIR:=~/.config/unity3d/Darkkon/sandbox
CURRENT_DIR:=${PROJECT_DIR}/current
RELEASES_DIR:=${PROJECT_DIR}/releases
LOG_DIR:=${PROJECT_DIR}/log
UNPACK_LOG:=${LOG_DIR}/unpacking.log
CONFIG_BACKUP_DIR=${LOG_DIR}/config_backup-$(shell date -Iseconds) 

LATEST_DOWNLOADED_PACK:=${TMP_DIR}/latest.zip
CURRENT_VERSION:=$$(cat $(CURRENT_DIR)/version)

SERVER:=sandyapp@sandysunday.ru
SERVER_BUILDS_PATH:=/data/SandyAppBuilds/linux
SERVER_LOGS_PATH:=/home/sandyapp/logs/
NEW_LOG:=$(shell echo $$(hostname)-$$(date '+%Y-%m-%d-%H:%M:%S'))

LATEST_PATH:=$(shell ssh $(SERVER) "ls -c $(SERVER_BUILDS_PATH)/* | head -1")

all: update watch

install:
	@for dir in $(INSTALL_DIRS) ; do \
        cp -vf $(PROJECT_DIR)/*.desktop --target-directory "$$dir" 2>/dev/null; \
    done

watch:
	@watch -b -n 1 "cd $(PROJECT_DIR) && make run"

stop_all:
	@echo 'Убиваю все запущенные приложения'
	@ps axfww | grep sandbox.x86-64 | grep -v grep | awk '{ print $1 }' | xargs -r kill -9

run: stop_all
	@echo "Запускаю версию $(CURRENT_VERSION)"; \
	$(CURRENT_DIR)/run.sh || \
	( \
		EXIT_CODE=$$?; \
	 	echo "Завершен с кодом $$EXIT_CODE"; \
	 	cd $(PROJECT_DIR); \
	 	LOG_MESSAGE=$(TMP_DIR)/message.txt; \
	 	echo "EXIT_CODE=$$EXIT_CODE" > $$LOG_MESSAGE; \
	 	make report LOG_PREFIX=!crash- LOG_MESSAGE=$$LOG_MESSAGE; \
		exit $$EXIT_CODE; \
	)

report:
	@echo "Отправляю лог.."
	$(eval LOG_NAME=$(LOG_PREFIX)$(NEW_LOG))
	scp -r $(CONFIG_DIR)/ $(SERVER):$(SERVER_LOGS_PATH)$(LOG_NAME)
ifneq ($(LOG_MESSAGE), )
	scp -r $(LOG_MESSAGE) $(SERVER):$(SERVER_LOGS_PATH)$(LOG_NAME)
endif
	@echo $(LOG_NAME)

update: download unpack

download:
	@echo "Ищу последний релиз.."
	$(eval LATEST_NAME=$(notdir $(LATEST_PATH)))
#	@scp $(SERVER):$(LATEST_PATH) $(TMP_DIR)/
# with rsync ssh we can see progress and dont redownload if its equals
ifeq ($(LATEST_PATH), )
	@echo "Сервер недоступен, попробуйте еще раз"
else
	@echo "Последний доступный релиз: $(LATEST_NAME), качаю.."
	@(	\
		rsync --progress -e ssh $(SERVER):$(LATEST_PATH) $(TMP_DIR)/ && \
		rm -f $(LATEST_DOWNLOADED_PACK) && \
		ln -s $(TMP_DIR)/$(LATEST_NAME) $(LATEST_DOWNLOADED_PACK) \
	) || echo "Не удалось загрузить новую версию, попробуйте еще раз"
endif

unpack:
	$(eval PACK_NAME=$(shell ls -o $(LATEST_DOWNLOADED_PACK) | grep -oE '[^/]+$$' | sed 's/.zip//' ))
# keep only last 3 unpacks with current version
	@ls -dc ${RELEASES_DIR}/$(PACK_NAME)* | tail -n +3 | tr "\n" "\0" | xargs -0 rm -rf --
	$(eval UNPACK_DIR=${RELEASES_DIR}/${PACK_NAME}-$(shell date -Iseconds))
	@mkdir $(UNPACK_DIR)
	@echo "Распаковываю в $(UNPACK_DIR) и линкую в $(CURRENT_DIR)"
	@unzip $(LATEST_DOWNLOADED_PACK) -d $(UNPACK_DIR) > $(UNPACK_LOG)
	@rm -f $(CURRENT_DIR)
	@ln -s $(UNPACK_DIR) $(CURRENT_DIR)
	@echo "Развернул версию $(CURRENT_VERSION)"

backup_config:
	@mkdir ${CONFIG_BACKUP_DIR}
	@cp -vr ${CONFIG_DIR}/* ${CONFIG_BACKUP_DIR}

clear: backup_config
	@rm -f $(CONFIG_DIR)/*
