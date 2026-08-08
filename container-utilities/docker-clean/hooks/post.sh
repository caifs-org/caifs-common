#!/bin/sh

debian() {
    rootdo apt-get -y clean
    rootdo rm -rf /var/lib/apt/lists/*
    linux
}

linux() {
    rootdo rm -rf /tmp/* /var/tmp/*
}
