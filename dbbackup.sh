#!/bin/bash

# Set the name of the MongoDB database and S3 bucket
DB_NAME="admin"
BUCKET_NAME="sumans3265bucketapi"

# Set the path to the MongoDB binaries and backup directory
MONGODB_HOME="/usr/bin/mongodb"
BACKUP_DIR="/home/ubuntu/backup"


# Set the timestamp for the backup filename
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)

# Create the backup directory if it doesn't exist


# Use mongodump to create a backup of the database

mongodump --archive="$BACKUP_DIR/$TIMESTAMP" --gzip --db=admin

# Compress the backup directory into a tarball
tar -zcvf "$BACKUP_DIR/$TIMESTAMP.tar.gz" "$BACKUP_DIR/$TIMESTAMP"

# Upload the backup to S3 using the AWS CLI
aws s3 cp "$BACKUP_DIR/$TIMESTAMP.tar.gz" "s3://$BUCKET_NAME/$TIMESTAMP.tar.gz"

# Remove the uncompressed backup directory and tarball
rm -rf "$BACKUP_DIR/$TIMESTAMP"
rm "$BACKUP_DIR/$TIMESTAMP.tar.gz"

