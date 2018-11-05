#!/bin/bash

MINECRAFT_DIR=$1
S3_BUCKET=$2

_abort() {
    message=$1
    echo $message
    exit 1
}

test -d "${MINECRAFT_DIR}" || _abort "Error: No minecraft directory found named ${MINECRAFT_DIR}. Exiting..."
test -n "${S3_BUCKET}" || _abort "Error: S3 Bucket name not provided. Exiting..."

TIMESTAMP=$(date +%F_%H_%M_%S.%N)
TAR_FILE="minecraft-server-backup-${TIMESTAMP}.tar.gz"

echo "Compressing ${MINECRAFT_DIR} into /tmp/${TAR_FILE}..."
tar -zcvf /tmp/${TAR_FILE} ${MINECRAFT_DIR}
echo "Done."

echo "Uploading ${TAR_FILE} to s3://${S3_BUCKET}/${TAR_FILE}..."
aws s3 cp /tmp/${TAR_FILE} s3://${S3_BUCKET}/${TAR_FILE}

echo "Upload complete, cleaning up..."
rm /tmp/${TAR_FILE}

echo "Done."
