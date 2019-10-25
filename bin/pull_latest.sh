#!/bin/env bash
source "$(dirname $0)/_config.sh"

test -d $DOWNLOAD_DIR || mkdir $DOWNLOAD_DIR
NEWEST_FILE=$(ssh $SERVER "ls -c $SERVER_BUILDS_PATH" | head -1)

echo "Asking ${SERVER}${SERVER_BUILDS_PATH} for latest release file name.."
echo "Latest build is '${NEWEST_FILE}'"

echo "Fetching release file into ${DOWNLOAD_DIR}"

FILE=$DOWNLOAD_DIR/${NEWEST_FILE}
if [ -f $FILE ]; then
  echo "File ${FILE} already exists."

  if [ "$1" = "force" ]; then
   echo "Remove and download again"
   rm $FILE
  else
   echo "Cancel.. Restart with argument 'force' to force downloading '> ${0} force'"
   exit 1
  fi
fi

scp "${SERVER}:${SERVER_BUILDS_PATH}${NEWEST_FILE}" $FILE

echo "Symlink to ${LATEST_BUILD}"
rm -f $LATEST_BUILD
ln -s $FILE $LATEST_BUILD
echo "Done"
