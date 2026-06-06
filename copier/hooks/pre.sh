macos() {
    brew install copier
}

bazzite() {
    brew install copier
}

generic() {
    uv_install copier

    copier --completions bash > "${CAIFS_INSTALL_DIR}"/share/bash-completion/completions/copier.bash
    caifs_install
}
