#!/bin/sh

linux() {
    # cli does a lot of absolute symbolic linking, have to replicate this to allow it to be installed locally
    # and at system level
    curl -s "https://awscli.amazonaws.com/awscli-exe-linux-$(uname -m).zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    ./aws/install --bin-dir tmp/bin --install-dir tmp/awscli --update

    current_link=$(readlink tmp/awscli/v2/current)
    version=$(basename "$current_link")
    echo "Current version is: $version"

    mv tmp/awscli/v2/"$version" "${CAIFS_INSTALL_DIR}"/lib/awscli

    cd "${CAIFS_INSTALL_DIR}"/bin
    ln -s ../lib/awscli/bin/aws aws
    ln -s ../lib/awscli/bin/aws_completer aws_completer

}
