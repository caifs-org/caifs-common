linux() {
    MACHINE_TYPE="$(uname -m)"
    case $MACHINE_TYPE in
        amd64 | x86_64 | x64)
            ARCH="x86_64"
            ;;
        arm | armv7l)
            ARCH="arm"
            ;;
        aarch64)
            ARCH="arm64"
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

    LATEST_VERSION=$(github_latest_tag "typst/typst")
    VERSION=${TARGET_VERSION:=$LATEST_VERSION}
    FILENAME="typst-${ARCH}-unknown-linux-musl"
    curl -L https://github.com/typst/typst/releases/download/v"${VERSION}"/"${FILENAME}.tar.xz" | tar xJvf -

    install -m 0755 ${FILENAME}/typst "${CAIFS_INSTALL_DIR}"/bin/typst

    caifs_install

}
