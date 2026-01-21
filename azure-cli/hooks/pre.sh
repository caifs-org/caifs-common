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
    uv_install azure-cli
}
