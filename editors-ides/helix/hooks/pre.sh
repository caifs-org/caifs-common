macos() {
    brew_install helix
}

fedora() {
    rootdo dnf install -y helix
}

ubuntu() {
    rootdo add-apt-repository ppa:maveonair/helix-editor
    apt_install helix
}

arch() {
    yay_install helix
}

debian() {
    MACHINE_TYPE="$(uname -m)"
    case $MACHINE_TYPE in
        amd64 | x86_64 | x64)
            ARCH="amd64"
            ;;
        *)
            echo "Unknown machine type: $MACHINE_TYPE"
            exit 1
            ;;
    esac

    LATEST_VERSION=$(github_latest_tag "helix-editor/helix")
    VERSION=${TARGET_VERSION:=$LATEST_VERSION}
    FILENAME="helix_${VERSION}-1_${ARCH}.deb"
    curl -OL "https://github.com/helix-editor/helix/releases/download/${VERSION}/${FILENAME}"
    apt_install "${FILENAME}"
}
