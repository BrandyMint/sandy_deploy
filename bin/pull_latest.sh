#!/bin/env bash
source "$(dirname $0)/config.sh"

NEWEST_FILE=$(ssh $SERVER "ls -c $SERVER_BUILDS_PATH" | head -1)

echo "Asking ${SERVER}${SERVER_BUILDS_PATH} for latest release file name.."
echo "Latest build is '${NEWEST_FILE}'"

echo "Fetching release file into ${DOWNLOAD_DIR}"
# scp "${SERVER}:${SERVER_BUILDS_PATH}${NEWEST_FILE}" $DOWNLOAD_DIR/

echo "Symlink to ${LATEST_BUILD}"
rm -f $LATEST_BUILD
ln -s $DOWNLOAD_DIR/${NEWEST_FILE} $LATEST_BUILD
echo "Done"
