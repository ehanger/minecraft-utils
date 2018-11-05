#!/bin/bash

test -n "${1}" && SERVER_JAR="${1}" || SERVER_JAR="server.jar"

remove-existing() {
  echo "Removing existing server: ${1}"
  rm ${1}
}

download-latest() {
  local MANIFEST_URL="https://launchermeta.mojang.com/mc/game/version_manifest.json"
  local MANIFEST=$(curl ${MANIFEST_URL})
  local LATEST_VERSION=$(echo ${MANIFEST} | jq -r '.latest.release')
  local LATEST_PACKAGE_URL=$(echo ${MANIFEST} | jq -r '.versions' | jq -r --arg VERSION ${LATEST_VERSION} '.[] | select(.id==$VERSION).url')
  local LATEST_PACKAGE=$(curl ${LATEST_PACKAGE_URL})
  local SERVER_JAR_URL=$(echo ${LATEST_PACKAGE} | jq -r '.downloads.server.url')
  curl -o ${SERVER_JAR} ${SERVER_JAR_URL}
}

test -f "${SERVER_JAR}" && remove-existing "${SERVER_JAR}" || echo "No existing server found: ${SERVER_JAR}"

download-latest
