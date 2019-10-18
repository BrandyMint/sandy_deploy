#!/bin/env bash

PROJECT_DIR=$(pwd $(dirname $(readlink -f $0))/../)
echo "Hello! I'm Sandy deployer! I live in ${PROJECT_DIR}"

DOWNLOAD_DIR="${PROJECT_DIR}/downloads/"

SERVER="konstantin@office.brandymint.ru"
SERVER_BUILDS_PATH="/home/konstantin/SandyAppBuilds/"
echo
