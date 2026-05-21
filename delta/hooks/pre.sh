#!/bin/sh


arch() {
    yay_install git-delta
}

#fedora() {
#    rootdo dnf install -y git-delta
#}

debian() {
    rootdo apt-get install -y git-delta
}

ubuntu() {
    debian
}

steamos() {
    arch
}

macos() {
    brew install git-delta
}

linux() {
    # Fallback for Linux distros without package manager support
    LATEST_VERSION=$(github_latest_tag "dandavison/delta")
    VERSION=${DELTA_VERSION:=$LATEST_VERSION}
    FILENAME="delta-${VERSION}-$(uname -m)-unknown-linux-gnu"
    curl -fOL "https://github.com/dandavison/delta/releases/download/${VERSION}/${FILENAME}.tar.gz"
    tar -vxzf "${FILENAME}.tar.gz"
    mv "${FILENAME}"/delta "${CAIFS_INSTALL_DIR}"/bin/
    chmod +x "${CAIFS_INSTALL_DIR}"/bin/delta
    caifs_install
}
