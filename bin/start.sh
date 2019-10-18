#!/bin/env bash
source "$(dirname $0)/bin/config.sh"

cd $PROJECT_DIR

./bin/pull_latest.sh && ./bin/unpack.sh

echo "Start application"
watch -b -n 1 ./current/run.sh
