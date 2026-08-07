macos() {
    brew install gitlab-ci-local
}

linux() {
    npm_install gitlab-ci-local
    gitlab-ci-local --completion >> "$CAIFS_INSTALL_DIR/share/bash-completion/completions/gitlab-ci-local.bash"
    caifs_install
}
