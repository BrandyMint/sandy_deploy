#!/bin/env bash
source "$(dirname $0)/config.sh"

UNPACK_DIR=${RELEASES_DIR}`date -Iseconds`

file=$1

if [ -z "$file"]; then
  echo 'Select release package (.zip) to unpack'
  exit 1
fi

echo "Unpacking $file into $UNPACK_DIR.."

mkdir $UNPACK_DIR

unzip $file -d $UNPACK_DIR

echo "Switch current"
rm -f $CURRENT_DIR
ln -s $UNPACK_DIR $CURRENT_DIR
