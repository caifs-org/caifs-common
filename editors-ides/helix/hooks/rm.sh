macos() {
    brew_uninstall helix
}

fedora() {
    rootdo dnf uninstall -y helix
}

ubuntu() {
    apt_uninstall helix
}

debian() {
    apt_uninstall helix
}

arch() {
    yay_uninstall helix
}
