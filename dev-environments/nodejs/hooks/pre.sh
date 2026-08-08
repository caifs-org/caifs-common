#!/bin/sh


arch() {
    yay_install nodejs npm
    mkdir -p "$HOME/.local/lib/node_modules"
    npm config set prefix "$HOME/.local"
}

fedora() {
    rootdo dnf install -y nodejs-npm
    mkdir -p "$HOME/.local/lib/node_modules"
    npm config set prefix "$HOME/.local"
}

debian() {
    rootdo apt-get install -y  nodejs npm
    mkdir -p "$HOME/.local/lib/node_modules"
    npm config set prefix "$HOME/.local"
}
