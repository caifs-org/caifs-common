#!/bin/sh

# tinymist - language server for typst
# https://github.com/Myriad-Dreamin/tinymist
#
# Arch and homebrew package tinymist. Fedora and Ubuntu do not, so they take
# the upstream tarball. tinymist tracks typst releases closely, so pin it with
# 'caifs add tinymist==<version>' when you pin typst.

arch() {
    yay_install tinymist
}

fedora() {
    linux
}

ubuntu() {
    linux
}

macos() {
    brew install tinymist
}

linux() {
    MACHINE_TYPE="$(uname -m)"
    case "$MACHINE_TYPE" in
        amd64 | x86_64 | x64)
            TRIPLE="x86_64-unknown-linux-musl"
            ;;
        aarch64 | arm64)
            TRIPLE="aarch64-unknown-linux-musl"
            ;;
        arm | armv7l)
            TRIPLE="armv7-unknown-linux-musleabihf"
            ;;
        riscv64)
            TRIPLE="riscv64gc-unknown-linux-musl"
            ;;
        *)
            echo "Unknown machine type: $MACHINE_TYPE"
            exit 1
            ;;
    esac

    LATEST_VERSION=$(github_latest_tag "Myriad-Dreamin/tinymist")
    VERSION=${TARGET_VERSION:=$LATEST_VERSION}
    FILENAME="tinymist-${TRIPLE}"
    curl -sfL "https://github.com/Myriad-Dreamin/tinymist/releases/download/v${VERSION}/${FILENAME}.tar.gz" | tar xzf -

    install -m 0755 "${FILENAME}/tinymist" "${CAIFS_INSTALL_DIR}"/bin/tinymist

    caifs_install
}
