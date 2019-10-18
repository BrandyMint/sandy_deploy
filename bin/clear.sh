#!/bin/env bash
source "$(dirname $0)/config.sh"

BACKUP_DIR=${CONFIG_DIR}/backup
echo "Backup current config into ${BACKUP_DIR}"
rm -fr ${BACKUP_DIR}
mkdir ${BACKUP_DIR}
cp -vr ${CONFIG_DIR}/*.json ${BACKUP_DIR}

echo "Remove files in ${CONFIG_DIR}"
rm -f ${CONFIG_DIR}/*
