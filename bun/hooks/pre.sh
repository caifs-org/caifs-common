#!/bin/sh


arch() {
    yay_install bun
}

linux() {
    # Official bun install script
    curl -fsSL https://bun.sh/install | bash
}
