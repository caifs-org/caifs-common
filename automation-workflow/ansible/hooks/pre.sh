#!/bin/sh


arch() {
    yay_install sshpass
}

fedora() {
    rootdo dnf install -y sshpass
}

linux() {
    has uv
    uv tool install --with-executables-from ansible-core,ansible-lint \
       --with requests \
       ansible
}
