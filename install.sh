#!/bin/sh

INSTALL_PREFIX=${INSTALL_PREFIX:=$HOME/.local/share/caifs-collections}
CAIFS_COMMON_VERSION="latest"

mkdir -p "$INSTALL_PREFIX"

if [ "${CAIFS_COMMON_VERSION}" = "latest" ]; then
    DOWNLOAD_URL="https://github.com/caifs-org/caifs-common/releases/${CAIFS_COMMON_VERSION}/download/release.tar.gz"
else
    DOWNLOAD_URL="https://github.com/caifs-org/caifs-common/releases/download/${CAIFS_COMMON_VERSION}/release.tar.gz"
fi

curl -sL "${DOWNLOAD_URL}" | tar zvxf - -C "${INSTALL_PREFIX}"
