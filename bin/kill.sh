#!/bin/env bash
source "$(dirname $0)/config.sh"

echo "Kill all sandboxes"
PIDS=$(ps axfww | grep sandbox.x86_64 | grep -v grep | awk '{ print $1 }')

if [ -s "$PIDS" ]; then
  cat $PIDS | xargs kill -9
else
  echo "There are no applications to kill"
fi
