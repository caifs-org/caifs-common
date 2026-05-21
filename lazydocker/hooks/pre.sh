#!/bin/sh

arch() {
    yay_install lazydocker
}

linux() {
    # This works for both linux and macos, however some might prefer to install from homebrew
    export DIR="${CAIFS_INSTALL_DIR}/bin"
    curl -sL https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

    caifs_install
}

macos() {
    brew install jesseduffield/lazydocker/lazydocker
}
