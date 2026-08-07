macos() {
    brew install kubectl
}

linux() {

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

    LATEST_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)
    VERSION=${TARGET_VERSION:=$LATEST_VERSION}

    curl -L \
         --output "${CAIFS_INSTALL_DIR}/bin/kubectl" \
         --create-dirs \
         --create-file-mode 0755 \
         "https://dl.k8s.io/release/${VERSION}/bin/linux/${ARCH}/kubectl"

    caifs_install
}
