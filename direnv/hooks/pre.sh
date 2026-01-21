#!/bin/sh


arch() {
    yay_install direnv
}

fedora() {
    rootdo dnf install -y direnv
}
