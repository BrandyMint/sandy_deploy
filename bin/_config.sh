#!/bin/env bash

# Так он возвращает путь самого верхнего скрипта из которого был запущен
# PROJECT_DIR=$(pwd $(dirname $(readlink -f $0))/../)

PROJECT_DIR=/home/sandy/SandyApp
echo "Hello! I'm Sandy deployer! I live in ${PROJECT_DIR}"

DOWNLOAD_DIR="${PROJECT_DIR}/downloads"
CONFIG_DIR="${PROJECT_DIR}/config"
CURRENT_DIR="${PROJECT_DIR}/current"
RELEASES_DIR="${PROJECT_DIR}/releases"
LOG_DIR="${PROJECT_DIR}/log"

test -d ${LOG_DIR} || mkdir ${LOG_DIR}

LATEST_BUILD="${DOWNLOAD_DIR}/latest.zip"

SERVER="konstantin@office.brandymint.ru"
SERVER_BUILDS_PATH="/home/konstantin/SandyAppBuilds/"
echo
