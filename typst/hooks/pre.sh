#!/bin/sh

# typst - markup based typesetting system
# https://typst.app/
#
# typst is a static binary and needs nothing at runtime. pandoc is the
# companion tool that converts markdown, docx and LaTeX to typst and back.
# Arch and homebrew package typst. Fedora, Debian and Ubuntu do not, so they
# take the upstream binary and get pandoc from the distro.
#
# The upstream release is a tar.xz archive, so the linux hook needs xz.

arch() {
    yay_install typst pandoc
}

fedora() {
    rootdo dnf install -y pandoc xz
    linux
}

debian() {
    rootdo apt-get update
    rootdo apt-get install -y pandoc xz-utils
    linux
}

ubuntu() {
    debian
}

macos() {
    brew install typst pandoc
}

linux() {
    if ! command -v xz > /dev/null 2>&1; then
        log_error "xz is not installed. The typst release is a tar.xz archive."
        exit 1
    fi

    MACHINE_TYPE="$(uname -m)"
    case "$MACHINE_TYPE" in
        amd64 | x86_64 | x64)
            TRIPLE="x86_64-unknown-linux-musl"
            ;;
        aarch64 | arm64)
            TRIPLE="aarch64-unknown-linux-musl"
            ;;
        arm | armv7l)
            TRIPLE="armv7-unknown-linux-musleabi"
            ;;
        riscv64)
            TRIPLE="riscv64gc-unknown-linux-gnu"
            ;;
        *)
            echo "Unknown machine type: $MACHINE_TYPE"
            exit 1
            ;;
    esac

    LATEST_VERSION=$(github_latest_tag "typst/typst")
    VERSION=${TARGET_VERSION:=$LATEST_VERSION}
    FILENAME="typst-${TRIPLE}"
    curl -sfL "https://github.com/typst/typst/releases/download/v${VERSION}/${FILENAME}.tar.xz" | tar xJf -

    install -m 0755 "${FILENAME}/typst" "${CAIFS_INSTALL_DIR}"/bin/typst

    caifs_install
}
