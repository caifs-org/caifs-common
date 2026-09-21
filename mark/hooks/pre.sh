#!/bin/sh

# mark - sync markdown to Atlassian Confluence
# https://github.com/kovetskiy/mark
#
# Upstream ships tarballs only, so the linux function serves every distro.

linux() {
    LATEST_VERSION=$(github_latest_tag "kovetskiy/mark")
    VERSION=${TARGET_VERSION:=$LATEST_VERSION}

    MACHINE_TYPE="$(uname -m)"
    case "$MACHINE_TYPE" in
        amd64 | x86_64 | x64)
            ARCH="x86_64"
            ;;
        aarch64 | arm64)
            ARCH="arm64"
            ;;
        *)
            echo "Unknown machine type: $MACHINE_TYPE"
            exit 1
            ;;
    esac

    FILENAME="mark_Linux_${ARCH}.tar.gz"
    curl -sfOL "https://github.com/kovetskiy/mark/releases/download/v${VERSION}/${FILENAME}"
    tar -xzf "${FILENAME}" -C "${CAIFS_INSTALL_DIR}"/bin mark
    chmod +x "${CAIFS_INSTALL_DIR}"/bin/mark
    caifs_install
}

arch() {
    linux
}

fedora() {
    linux
}

ubuntu() {
    linux
}

macos() {
    brew install mark
}
