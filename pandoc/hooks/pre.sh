#!/bin/sh

# pandoc - markup conversion tool
# https://pandoc.org/
#
# Each packaged platform also gets a LaTeX engine. pandoc needs one to write
# PDF files. The generated LaTeX loads lmodern without a guard, so the
# recommended font set is required and not optional.
#
# Every other Linux distribution takes the upstream binary from the linux
# hook. That hook installs no LaTeX engine, so PDF output needs one more
# install by hand.

arch() {
    yay_install pandoc texlive-latexrecommended texlive-fontsrecommended
}

fedora() {
    rootdo dnf install -y pandoc \
        texlive-collection-latexrecommended \
        texlive-collection-fontsrecommended
}

debian() {
    rootdo apt-get update
    rootdo apt-get install -y pandoc \
        texlive-latex-recommended \
        texlive-fonts-recommended \
        lmodern
}

ubuntu() {
    debian
}

macos() {
    brew install pandoc
    brew install --cask basictex
}

linux() {
    MACHINE_TYPE="$(uname -m)"
    case "$MACHINE_TYPE" in
        amd64 | x86_64 | x64)
            ARCH="amd64"
            ;;
        aarch64 | arm64)
            ARCH="arm64"
            ;;
        *)
            echo "Unknown machine type: $MACHINE_TYPE"
            exit 1
            ;;
    esac

    LATEST_VERSION=$(github_latest_tag "jgm/pandoc")
    VERSION=${TARGET_VERSION:=$LATEST_VERSION}
    FILENAME="pandoc-${VERSION}-linux-${ARCH}"
    curl -sfL "https://github.com/jgm/pandoc/releases/download/${VERSION}/${FILENAME}.tar.gz" | tar xzf -

    install -m 0755 "pandoc-${VERSION}/bin/pandoc" "${CAIFS_INSTALL_DIR}"/bin/pandoc

    caifs_install
}
