
macos() {
    brew install terror/tap/just-lsp
}

bazzite() {
    brew install terror/tap/just-lsp
}

arch() {
    yay_install just-lsp
}

linux() {

    MACHINE_TYPE="$(uname -m)"
    case $MACHINE_TYPE in
        i386 | i486 | i586 | i686 | i786 | x86)
            ARCH="386"
            ;;
        amd64 | x86_64 | x64)
            ARCH="x86_64"
            ;;
        arm | armv7l)
            ARCH="arm"
            ;;
        aarch64)
            ARCH="aarch64"
            ;;
        s390x)
            ARCH="s390x"
            ;;
        ppc64)
           ARCH="ppc64"
           ;;
        ppc64le)
           ARCH="ppc64le"
           ;;
        *)
            echo "Unknown machine type: $MACHINE_TYPE"
            exit 1
            ;;
    esac

    LATEST_VERSION=$(github_latest_tag "terror/just-lsp")
    VERSION=${JUST_LSP_VERSION:=$LATEST_VERSION}

    FILENAME="just-lsp-${VERSION}-${ARCH}-unknown-linux-gnu.tar.gz"
    curl -sLO https://github.com/terror/just-lsp/releases/download/${VERSION}/${FILENAME}
    tar -xzf ${FILENAME}
    mv just-lsp "${CAIFS_INSTALL_DIR}"/bin/
    chmod +x "${CAIFS_INSTALL_DIR}"/bin/just-lsp
    caifs_install
}
