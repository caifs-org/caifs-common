
generic() {
    curl -sSLO https://raw.githubusercontent.com/devcontainers/cli/main/scripts/install.sh
    chmod +x install.sh
    ./install.sh --prefix "${CAIFS_INSTALL_DIR}"/lib/devcontainers

    # Devcontainers install.sh does not handle relative links for this scenario, so we patch with sed
    # https://github.com/devcontainers/cli/issues/1232
    sed -i \
        's#SCRIPT_PATH="$(readlink "$0" 2>/dev/null || readlink -f "$0" 2>/dev/null || echo "$0")"#SCRIPT_PATH="$(readlink -f "$0" 2>/dev/null || echo "$0")"#' \
        "${CAIFS_INSTALL_DIR}"/lib/devcontainers/bin/devcontainer

    cd "${CAIFS_INSTALL_DIR}"/bin || exit
    ln -s ../lib/devcontainers/bin/devcontainer devcontainer
}
