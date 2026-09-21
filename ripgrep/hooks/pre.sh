#!/bin/sh


arch() {
    yay_install ripgrep
}

fedora() {
    rootdo dnf install -y ripgrep
}

debian() {
    rootdo apt install -y ripgrep
}

ubuntu() {
    debian
}
