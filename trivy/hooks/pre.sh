#!/bin/sh


arch() {
    yay_install trivy
}

macos() {
    brew install trivy
}

linux() {

    MACHINE_TYPE="$(uname -m)"
    case $MACHINE_TYPE in
        amd64 | x86_64 | x64)
            ARCH="64bit"
            ;;
        arm | armv7l)
            ARCH="ARM"
            ;;
        aarch64)
            ARCH="ARM64"
            ;;
        s390x)
            ARCH="s390x"
            ;;
        ppc64le)
           ARCH="PPC64LE"
           ;;
        *)
            echo "Unknown machine type: $MACHINE_TYPE"
            exit 1
            ;;
    esac

    LATEST_VERSION=$(github_latest_tag "aquasecurity/trivy")
    VERSION=${TRIVY_VERSION:=$LATEST_VERSION}
    FILENAME="trivy_${VERSION}_Linux-${ARCH}.tar.gz"

    echo "Fetching $FILENAME"
    curl -sL "https://github.com/aquasecurity/trivy/releases/download/v${VERSION}/${FILENAME}" | tar -xz

    install -m "0755" ./trivy "${CAIFS_INSTALL_DIR}"/bin/
    install -d "${CAIFS_INSTALL_DIR}"/share/trivy/templates/
    install contrib/*.tpl "${CAIFS_INSTALL_DIR}"/share/trivy/templates/

    caifs_install
}
