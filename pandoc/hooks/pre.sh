#!/bin/sh


arch() {
    yay_install pandoc
}

fedora() {
    rootdo dnf install -y pandoc
}
