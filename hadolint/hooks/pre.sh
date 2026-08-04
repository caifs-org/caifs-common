macos() {
    brew install hadolint
}

linux() {
    MACHINE_TYPE="$(uname -m)"
    case $MACHINE_TYPE in
        amd64 | x86_64 | x64)
            ARCH="x86_64"
            ;;
        aarch64)
            ARCH="arm64"
            ;;
        *)
            echo "Unknown machine type: $MACHINE_TYPE"
            exit 1
            ;;
    esac

    LATEST_VERSION=$(github_latest_tag "hadolint/hadolint")
    VERSION=${TARGET_VERSION:=$LATEST_VERSION}

    # form the github release filename
    FILENAME="hadolint-linux-${ARCH}"
    curl -sfOL https://github.com/hadolint/hadolint/releases/download/v"${VERSION}"/"${FILENAME}"

    install -m 0755 "${FILENAME}" "${CAIFS_INSTALL_DIR}"/bin/hadolint
    caifs_install
}
