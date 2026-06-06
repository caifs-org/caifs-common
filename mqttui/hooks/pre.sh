macos() {
    brew install mqttui
}

bazzite() {
    brew install mqttui
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

    LATEST_VERSION=$(github_latest_tag "EdJoPaTo/mqttui")
    VERSION=${MQTTUI_VERSION:-$LATEST_VERSION}

    FILENAME="mqttui-v${VERSION}-${ARCH}-unknown-linux-gnu.tar.gz"
    curl -sL "https://github.com/EdJoPaTo/mqttui/releases/download/v${VERSION}/$FILENAME" | tar -zvxf -

    chmod 0755 mqttui
    chmod 0755 completions/mqttui.bash

    mkdir -p bin "${CAIFS_INSTALL_DIR}"/share/bash-completion/completions
    mv mqttui "${CAIFS_INSTALL_DIR}"/bin/
    mv completions/mqttui.bash "${CAIFS_INSTALL_DIR}"/share/bash-completion/completions/

    caifs_install
}
