#!/bin/sh

generic() {
    export UV_INSTALL_DIR=./bin
    export UV_NO_MODIFY_PATH=1
    curl -LsSf https://astral.sh/uv/install.sh | sh

    rm bin/env*
    ls -lah bin
    caifs_install bin
}
