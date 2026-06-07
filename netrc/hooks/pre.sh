generic() {
    MACHINE_TYPE="$(uname -m)"
    case $MACHINE_TYPE in
        amd64 | x86_64 | x64)
            ARCH="amd64"
            ;;
        aarch64)
            ARCH="arm64"
            ;;
        *)
            echo "Unknown machine type: $MACHINE_TYPE"
            exit 1
            ;;
    esac

    LOWER_OS_TYPE=$(echo "$OS_TYPE" | tr '[:upper:]' '[:lower:]')

    LATEST_VERSION=$(github_latest_tag "dokku/netrc")
    VERSION=${DIVE_VERSION:=$LATEST_VERSION}
    FILENAME="netrc-${LOWER_OS_TYPE}-${ARCH}"
    curl -sfLo "${CAIFS_INSTALL_DIR}"/bin/netrc "https://github.com/dokku/netrc/releases/download/v${VERSION}/${FILENAME}"
    chmod -v +x "${CAIFS_INSTALL_DIR}"/bin/netrc
    caifs_install
}
