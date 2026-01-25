#!/bin/sh

COLLECTION_NAME="caifs-common"
LOCAL_CAIFS_COLLECTION_DIR="$HOME/.local/share/caifs-collections/"

LATEST_VERSION=$(curl -sL https://api.github.com/repos/caifs-org/caifs-common/releases/latest?per_page=1 \
                     | tr -d '[:space:]' \
                     | sed -E 's/.*"tag_name":"v?([^"]+)".*/\1/')

curl -sL https://github.com/caifs-org/caifs-common/releases/download/v"$LATEST_VERSION"/release.tar.gz \
    | tar vzxf - -C "$LOCAL_CAIFS_COLLECTION_DIR"
