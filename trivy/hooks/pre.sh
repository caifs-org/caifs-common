#!/bin/sh


arch() {
    yay_install trivy
}

macos() {
    brew install trivy
}

linux() {
    LATEST_VERSION=$(github_latest_tag "aquasecurity/trivy")
    VERSION=${TRIVY_VERSION:=$LATEST_VERSION}
    FILENAME="trivy_${VERSION}_Linux-64bit.tar.gz"
    curl -sL "https://github.com/aquasecurity/trivy/releases/download/v${VERSION}/${FILENAME}" | tar -xz

    install -m "0755" ./trivy "${CAIFS_INSTALL_DIR}"/bin/
    install -d "${CAIFS_INSTALL_DIR}"/share/trivy/templates/
    install contrib/*.tpl "${CAIFS_INSTALL_DIR}"/share/trivy/templates/

    caifs_install
}
