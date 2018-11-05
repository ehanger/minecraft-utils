#!/bin/bash
cd "${0%/*}"

MEMORY="2560M"

_abort() {
    message=$1
    echo $message
    exit 1
}

test -n "${1}" && SERVER_JAR="${1}" || SERVER_JAR="server.jar"
test -f "${SERVER_JAR}" || _abort "Error: ${SERVER_JAR} not found. Exiting..."

java -jar -Xms${MEMORY} -Xmx${MEMORY} ${SERVER_JAR} nogui
