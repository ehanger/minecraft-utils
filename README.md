# minecraft-utils

A collection of utility scripts for managing a minecraft server.

## Backup

Compress a minecraft server directory and upload it to AWS S3

Usage: `./backup.sh <minecraft_dir> <s3_bucket>`
Requires: AWS Credentials

## Update

Download the latest version of minecraft and overwrite the existing server jar.

Usage: `./update.sh [optional <path_to_existing_jar>]`
Argument default: `server.jar`

## Start

Start a minecraft server

Usage: `./start.sh [optional <path_to_jar>]`
Argument default: `server.jar`
