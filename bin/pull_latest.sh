#!/bin/env bash

DOWNLOAD_PATH="./downloads/"
SERVER="konstantin@office.brandymint.ru"
SERVER_BUILDS_PATH="/home/konstantin/SandyAppBuilds/"

LATEST_BUILD=$(ssh $SERVER "ls -c $SERVER_BUILDS_PATH" | head -1)

echo "Asking ${SERVER}${SERVER_BUILDS_PATH} for latest release file name.."
echo "Latest build is '${LATEST_BUILD}'"

echo "Fetching release file to ${DOWNLOAD_PATH}"
scp "${SERVER}:${SERVER_BUILDS_PATH}${LATEST_BUILD}" $DOWNLOAD_PATH
echo "Done"
