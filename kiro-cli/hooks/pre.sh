macos() {
    curl -fsSL https://cli.kiro.dev/install | bash
}

linux() {
    MACHINE_TYPE="$(uname -m)"
    case $MACHINE_TYPE in
        amd64 | x86_64 | x64)
            ARCH="x86_64"
            ;;
        aarch64)
            ARCH="aarch64"
            ;;
        *)
            echo "Unknown machine type: $MACHINE_TYPE"
            exit 1
            ;;
    esac

    echo "Downloading kiro-cli, this may take a while so curl progress is enabled"
    curl --proto '=https' --tlsv1.2 -LSf "https://desktop-release.q.us-east-1.amazonaws.com/latest/kirocli-${ARCH}-linux.zip" -o 'kirocli.zip'

    unzip kirocli.zip

    install -m 755 "kirocli/bin/kiro-cli" "${CAIFS_INSTALL_DIR}/bin/"
    install -m 755 "kirocli/bin/kiro-cli-chat" "${CAIFS_INSTALL_DIR}/bin/"
    install -m 755 "kirocli/bin/kiro-cli-term" "${CAIFS_INSTALL_DIR}/bin/"

    caifs_install
}
