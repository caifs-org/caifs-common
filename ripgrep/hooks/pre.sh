#!/bin/sh


arch() {
    yay_install ripgrep
}

fedora() {
    rootdo dnf install -y ripgrep
}

ubuntu() {
    debian_install
}

debian() {
    rootdo apt install -y ripgrep
}
