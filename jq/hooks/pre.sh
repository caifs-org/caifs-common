debian() {
    rootdo apt-get install -y jq
}

macos() {
    brew install jq
}

bazzite() {
    brew install jq
}

fedora() {
    rootdo dnf install -y jq
}

linux() {
    MACHINE_TYPE="$(uname -m)"
    case $MACHINE_TYPE in
        i386 | i486 | i586 | i686 | i786 | x86)
            ARCH="i386"
            ;;
        amd64 | x86_64 | x64)
            ARCH="amd64"
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
           ARCH="ppc64el"
           ;;
        *)
            echo "Unknown machine type: $MACHINE_TYPE"
            exit 1
            ;;
    esac

    VERSION=$(github_latest_tag "jqlang/jq")
    FILENAME="jq-linux-${ARCH}"
    curl -sLo "${CAIFS_INSTALL_DIR}/bin/jq" "https://github.com/jqlang/jq/releases/download/${VERSION}/${FILENAME}"

    caifs_install

}
