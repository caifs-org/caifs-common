#!/bin/sh

arch() {
    yay_install just-lsp
}

linux() {
    LATEST_VERSION=$(github_latest_tag "terror/just-lsp")
    VERSION=${JUST_LSP_VERSION:=$LATEST_VERSION}

    FILENAME=just-lsp-${VERSION}-x86_64-unknown-linux-gnu.tar.gz
    curl -sLO https://github.com/terror/just-lsp/releases/download/${VERSION}/${FILENAME}
    tar -xzf ${FILENAME}
    mv just-lsp "${CAIFS_INSTALL_DIR}"/bin/
    chmod +x "${CAIFS_INSTALL_DIR}"/bin/just-lsp
    caifs_install
}
