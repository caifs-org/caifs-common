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
    mkdir -p local/bin local/share/trivy/templates/

    install -m "0755" ./trivy local/bin/
    install contrib/*.tpl local/share/trivy/templates/

    caifs_install "local/*"
}
