#!/bin/sh


arch() {
    yay_install direnv
}

fedora() {
    rootdo dnf install -y direnv
}

debian() {
    rootdo apt update
    rootdo apt install -y direnv
}

ubuntu() {
    debian
}
