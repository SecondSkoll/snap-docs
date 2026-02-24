#!/bin/bash

# Configuration
REPO="canonical/snapd"
WORKFLOW="build-documentation.yaml"
ARTIFACT_NAME="rest-api-documentation"
TARGET_DIR="${SOURCEDIR}/_html_extra/reference/api"

mkdir -p "${TARGET_DIR}"

echo "Searching for the latest successful run that has artifact '${ARTIFACT_NAME}'..."

RUN_IDS=$(gh run list \
  -R "${REPO}" \
  --workflow "${WORKFLOW}" \
  --status success \
  --limit 100 \
  --json databaseId \
  -q '.[].databaseId')

DOWNLOAD_SUCCESS=false

gh run download "22216785446" -R "${REPO}" -n "${ARTIFACT_NAME}" -D "${TARGET_DIR}"

if [ "$DOWNLOAD_SUCCESS" = false ]; then
  echo "Error: You made a mistake. :( '${ARTIFACT_NAME}'."
  exit 1
fi

echo "OpenAPI docs successfully downloaded to ${TARGET_DIR}"
