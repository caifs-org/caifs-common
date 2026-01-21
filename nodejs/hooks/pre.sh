#!/bin/sh


arch() {
    yay_install nodejs npm
    mkdir -p ~/.local/lib/node_modules
    npm config set prefix '~/.local'
}

fedora() {
    rootdo dnf install -y nodejs-npm
    mkdir -p ~/.local/lib/node_modules
    npm config set prefix '~/.local'
}
