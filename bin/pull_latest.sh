#!/bin/env bash
source "$(dirname $0)/config.sh"

LATEST_BUILD=$(ssh $SERVER "ls -c $SERVER_BUILDS_PATH" | head -1)

echo "Asking ${SERVER}${SERVER_BUILDS_PATH} for latest release file name.."
echo "Latest build is '${LATEST_BUILD}'"

echo "Fetching release file into ${DOWNLOAD_DIR}"
scp "${SERVER}:${SERVER_BUILDS_PATH}${LATEST_BUILD}" $DOWNLOAD_DIR
echo "Done"
