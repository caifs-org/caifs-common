#!/bin/sh

linux() {
    LATEST_VERSION=$(github_latest_tag "mvdan/sh")
    VERSION=${SHFMT_VERSION:-$LATEST_VERSION}

    FILENAME="shfmt_v${VERSION}_linux_amd64"
    mkdir bin
    curl -sL --output bin/shfmt "https://github.com/mvdan/sh/releases/download/v${VERSION}/${FILENAME}"
    chmod +x bin/shfmt

    # If the link root starts with a / then privileges will be escalated
    # resulting install will respect $LINK_ROOT completely, therefore LINK_ROOT=/usr/, will result in /usr/bin/shfmt
    # If the LINK_ROOT is the default $HOME - then it will be installed to $HOME/.local/bin/shfmt
    caifs_install "bin"
}
