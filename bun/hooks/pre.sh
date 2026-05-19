#!/bin/sh


arch() {
    yay_install bun
}

linux() {
    has unzip
    has bash

    # Official bun install script
    curl -fsSL https://bun.sh/install | bash
}
