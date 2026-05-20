linux() {

    LATEST_VERSION=$(github_latest_tag "EdJoPaTo/mqttui")
    VERSION=${MQTTUI_VERSION:-$LATEST_VERSION}

    FILENAME=mqttui-v${VERSION}-x86_64-unknown-linux-gnu.tar.gz
    curl -sL https://github.com/EdJoPaTo/mqttui/releases/download/v${VERSION}/$FILENAME | tar -zvxf -

    chmod 0755 mqttui
    chmod 0755 completions/mqttui.bash

    mkdir -p bin "${CAIFS_INSTALL_DIR}"/share/bash-completion/completions
    mv mqttui "${CAIFS_INSTALL_DIR}"/bin/
    mv completions/mqttui.bash "${CAIFS_INSTALL_DIR}"/share/bash-completion/completions/
}
