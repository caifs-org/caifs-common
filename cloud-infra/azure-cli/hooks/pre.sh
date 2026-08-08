#!/bin/sh


arch() {
    yay_install python-argcomplete
}

steamos() {
    rootdo pacman -S --noconfirm python-argcomplete
}

fedora() {
    rootdo dnf install -y python3-argcomplete
}


generic() {
    # Pip needs to be installed alongside azure-cli in order for
    # installing argcomplete alongside means we don't have to rely on system packages
    uv_install azure-cli --with pip,argcomplete
}
