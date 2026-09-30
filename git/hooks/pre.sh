#!/bin/sh

debian() {
    rootdo apt-get update
    rootdo apt-get install -y git
}

ubuntu() {
    debian
}

fedora() {
    rootdo dnf install -y git-core
}

arch(){
    yay_install git
}
