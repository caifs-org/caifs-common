#!/bin/sh

arch() {
    arch_install glab
}

linux() {
    VERSION=$(gitlab_latest_tag "gitlab-org%2Fcli")
    FILENAME="glab_${VERSION}_linux_amd64"

    curl -Ls https://gitlab.com/gitlab-org/cli/-/releases/v${VERSION}/downloads/${FILENAME}.tar.gz | tar xvzf -
    mv bin/glab "${CAIFS_INSTALL_DIR}"/bin/
    chmod +x "${CAIFS_INSTALL_DIR}"/bin/glab
    caifs_install
}
