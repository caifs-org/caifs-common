#!/bin/sh

debian() {
    rootdo apt-get install -y git
}

fedora() {
    rootdo dnf install -y git-core
}

arch(){
    yay_install git
}
