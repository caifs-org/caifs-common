macos() {
    brew install minikube
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

    LATEST_VERSION=$(github_latest_tag "kubernetes/minikube")
    VERSION=${TARGET_VERSION:=$LATEST_VERSION}

    curl -L \
     --output "${CAIFS_INSTALL_DIR}/bin/minikube" \
     --create-dirs \
     --create-file-mode 0755 \
     "https://github.com/kubernetes/minikube/releases/download/v${VERSION}/minikube-linux-${ARCH}"

    caifs_install
}
