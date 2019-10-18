#!/bin/env bash
source "$(dirname $0)/bin/config.sh"

echo 
./bin/kill.sh
./bin/pull_latest.sh && ./bin/unpack.sh

echo "Run"
./current/run.sh

echo "Exit with status $?"
