#!/bin/sh


fedora() {
    rootdo dnf install -y ripgrep
}

ubuntu() {
    debian_install
}

debian() {
    rootdo apt install -y ripgrep
}
