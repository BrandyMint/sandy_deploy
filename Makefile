PROJECT_DIR=~/sandy_deploy

DOWNLOAD_DIR="${PROJECT_DIR}/downloads"
CONFIG_DIR="${PROJECT_DIR}/config"
CURRENT_DIR="${PROJECT_DIR}/current"
RELEASES_DIR="${PROJECT_DIR}/releases"
LOG_DIR="${PROJECT_DIR}/log"

LATEST_BUILD="${DOWNLOAD_DIR}/latest.zip"

SERVER="konstantin@office.brandymint.ru"
SERVER_BUILDS_PATH="/home/konstantin/SandyAppBuilds/"
SERVER_LOGS_PATH="/home/konstantin/logs/"

all:
	./bin/pull_latest.sh && ./bin/unpack.sh

report:
	scp -r config/ $(SERVER):$(SERVER_LOGS_PATH)$(hostname)-$(date '+%Y-%m-%d-%H:%M:%S')
