#!/bin/env bash
source "$(dirname $0)/bin/config.sh"

cd $PROJECT_DIR

echo "Start application"
watch -b -n 1 /bin/bash -c $PROJECT_DIR/bin/run.sh
