#!/bin/sh


arch() {
    yay_install shfmt
}

linux() {
    LATEST_VERSION=$(github_latest_tag "mvdan/sh")
    VERSION=${SHFMT_VERSION:-$LATEST_VERSION}

    FILENAME="shfmt_v${VERSION}_linux_amd64"
    curl -sL --output "${CAIFS_INSTALL_DIR}"/bin/shfmt "https://github.com/mvdan/sh/releases/download/v${VERSION}/${FILENAME}"
    chmod +x "${CAIFS_INSTALL_DIR}"/bin/shfmt
}
