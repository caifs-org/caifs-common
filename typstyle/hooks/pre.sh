#!/bin/sh

# typstyle - code formatter for typst
# https://github.com/typstyle-rs/typstyle
#
# Upstream ships a bare binary and not an archive, so there is no unpack step.
# Arch and homebrew package typstyle. Fedora and Ubuntu take the binary.
# Upstream builds no musl binary for aarch64, so that machine gets the gnu one.

arch() {
    yay_install typstyle
}

fedora() {
    linux
}

ubuntu() {
    linux
}

macos() {
    brew install typstyle
}

linux() {
    MACHINE_TYPE="$(uname -m)"
    case "$MACHINE_TYPE" in
        amd64 | x86_64 | x64)
            TRIPLE="x86_64-unknown-linux-musl"
            ;;
        aarch64 | arm64)
            TRIPLE="aarch64-unknown-linux-gnu"
            ;;
        arm | armv7l)
            TRIPLE="arm-unknown-linux-gnueabihf"
            ;;
        *)
            echo "Unknown machine type: $MACHINE_TYPE"
            exit 1
            ;;
    esac

    LATEST_VERSION=$(github_latest_tag "typstyle-rs/typstyle")
    VERSION=${TARGET_VERSION:=$LATEST_VERSION}
    FILENAME="typstyle-${TRIPLE}"
    curl -sfL "https://github.com/typstyle-rs/typstyle/releases/download/v${VERSION}/${FILENAME}" -o typstyle

    install -m 0755 typstyle "${CAIFS_INSTALL_DIR}"/bin/typstyle

    caifs_install
}
