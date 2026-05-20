#!/bin/sh

arch() {
    yay_install gitu
}

linux() {
    LATEST_VERSION=$(github_latest_tag "altsem/gitu")
    VERSION=${GITU_VERSION:=$LATEST_VERSION}
    FILENAME="gitu-v${VERSION}-$(uname -m)-unknown-linux-gnu"
    curl -sLO https://github.com/altsem/gitu/releases/download/v${VERSION}/${FILENAME}.zip
    unzip -o "${FILENAME}".zip
    mv "${FILENAME}"/gitu "${CAIFS_INSTALL_DIR}"/bin/
    chmod +x "${CAIFS_INSTALL_DIR}"/bin/gitu
}
