#!/bin/sh

set -euo pipefail

if [ $# -ne 2 ]; then
    echo "usage: ./setup.sh <owner-name> <repo-name>"
    exit 0
fi

OWNER=$1
REPO_NAME=$2

REPO_DIR=$(dirname $0)

cd "$REPO_DIR"

for file in $(grep -rl @@REPO_NAME@@ --exclude-dir .git); do
    sed -i "s/@@REPO_NAME@@/$REPO_NAME/g" "$file"
done

for file in $(grep -rl @@OWNER@@ --exclude-dir .git); do
    sed -i "s/@@OWNER@@/$OWNER/g" "$file"
done

mv cmd/main/main.go "cmd/main/$REPO_NAME.go"
mv cmd/main "cmd/$REPO_NAME"

rm setup.sh
