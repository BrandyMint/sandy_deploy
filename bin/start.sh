#!/bin/env bash
source "$(dirname $0)/bin/config.sh"

cd $PROJECT_DIR
./bin/pull_latest.sh && ./bin/unpack.sh && ./current/run.sh
