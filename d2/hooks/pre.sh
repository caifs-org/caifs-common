#!/bin/sh

arch() {
    yay_install d2
}

macos() {
    brew install d2
}

linux() {
    LATEST_VERSION=$(github_latest_tag "terrastruct/d2")
    VERSION=${D2_VERSION:=$LATEST_VERSION}

    ARCH=$(uname -m)
    case "$ARCH" in
        x86_64) ARCH="amd64" ;;
        aarch64) ARCH="arm64" ;;
    esac

    FILENAME="d2-v${VERSION}-linux-${ARCH}.tar.gz"
    curl -fOL "https://github.com/terrastruct/d2/releases/download/v${VERSION}/${FILENAME}"
    tar -xzf "${FILENAME}"
    install -m "0755" "d2-v${VERSION}/bin/d2" ~/.local/bin/
    install -d ~/.local/share/man/man1/
    install -m "0644" "d2-v${VERSION}/man/d2.1" ~/.local/share/man/man1/
}

darwin() {
    LATEST_VERSION=$(github_latest_tag "terrastruct/d2")
    VERSION=${D2_VERSION:=$LATEST_VERSION}

    ARCH=$(uname -m)
    case "$ARCH" in
        x86_64) ARCH="amd64" ;;
        arm64) ARCH="arm64" ;;
    esac

    FILENAME="d2-v${VERSION}-macos-${ARCH}.tar.gz"
    curl -fOL "https://github.com/terrastruct/d2/releases/download/v${VERSION}/${FILENAME}"
    tar -xzf "${FILENAME}"
    install -m "0755" "d2-v${VERSION}/bin/d2" ~/.local/bin/
}
