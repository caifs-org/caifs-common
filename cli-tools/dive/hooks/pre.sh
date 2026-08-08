#!/bin/sh


arch() {
    yay_install dive
}

fedora() {
    LATEST_VERSION=$(github_latest_tag "wagoodman/dive")
    VERSION=${TARGET_VERSION:=$LATEST_VERSION}
    FILENAME="dive_${VERSION}_linux_amd64.rpm"
    curl -sfOL https://github.com/wagoodman/dive/releases/download/v"${VERSION}"/"${FILENAME}"
    rootdo dnf install -y "${FILENAME}" ncurses
}

debian() {
    LATEST_VERSION=$(github_latest_tag "wagoodman/dive")
    VERSION=${TARGET_VERSION:=$LATEST_VERSION}
    FILENAME="dive_${VERSION}_linux_amd64.deb"
    curl -sfOL https://github.com/wagoodman/dive/releases/download/v"${VERSION}"/"${FILENAME}"
    rootdo apt install ./"${FILENAME}"
}
