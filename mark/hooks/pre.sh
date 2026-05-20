#!/bin/sh

# mark - sync markdown to Atlassian Confluence
# https://github.com/kovetskiy/mark

linux() {
    LATEST_VERSION=$(github_latest_tag "kovetskiy/mark")
    VERSION=${MARK_VERSION:=$LATEST_VERSION}

    ARCH=$(uname -m)
    case "$ARCH" in
        x86_64) ARCH="x86_64" ;;
        aarch64) ARCH="arm64" ;;
    esac

    FILENAME="mark_Linux_${ARCH}.tar.gz"
    curl -sfOL "https://github.com/kovetskiy/mark/releases/download/v${VERSION}/${FILENAME}"
    tar -xzf "${FILENAME}" -C "${CAIFS_INSTALL_DIR}"/bin
    chmod +x "${CAIFS_INSTALL_DIR}"/bin/mark
}

darwin() {
    LATEST_VERSION=$(github_latest_tag "kovetskiy/mark")
    VERSION=${MARK_VERSION:=$LATEST_VERSION}

    ARCH=$(uname -m)
    case "$ARCH" in
        x86_64) ARCH="x86_64" ;;
        arm64) ARCH="arm64" ;;
    esac

    FILENAME="mark_Darwin_${ARCH}.tar.gz"
    curl -sfOL "https://github.com/kovetskiy/mark/releases/download/v${VERSION}/${FILENAME}"
    tar -xzf "${FILENAME}" -C "${CAIFS_INSTALL_DIR}"/bin
    chmod +x "${CAIFS_INSTALL_DIR}"/bin/mark
}
