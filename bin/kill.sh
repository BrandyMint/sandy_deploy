#!/bin/env bash
source "$(dirname $0)/config.sh"

echo "Kill all sandboxes"
ps axfww | grep sandbox.x86_64 | grep -v grep | awk '{ print $1 }' | xargs kill -9
