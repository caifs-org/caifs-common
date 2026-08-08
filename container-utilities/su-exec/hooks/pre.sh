#!/bin/sh

debian() {
    rootdo apt-get install -y su-exec
}

ubuntu() {
    debian
}
