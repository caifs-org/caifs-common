#!/bin/sh
macos() {
    brew install glab
}

bazzite() {
    brew install glab
}

arch() {
    yay_install glab
}

linux() {
    MACHINE_TYPE="$(uname -m)"
    case $MACHINE_TYPE in
        i386 | i486 | i586 | i686 | i786 | x86)
            ARCH="386"
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
           ARCH="ppc64le"
           ;;
        *)
            echo "Unknown machine type: $MACHINE_TYPE"
            exit 1
            ;;
    esac
    VERSION=$(gitlab_latest_tag "gitlab-org%2Fcli")
    FILENAME="glab_${VERSION}_linux_${ARCH}.tar.gz"

    curl -Ls "https://gitlab.com/gitlab-org/cli/-/releases/v${VERSION}/downloads/${FILENAME}" | tar xvzf -
    mv bin/glab "${CAIFS_INSTALL_DIR}"/bin/
    chmod +x "${CAIFS_INSTALL_DIR}"/bin/glab
    caifs_install
}
