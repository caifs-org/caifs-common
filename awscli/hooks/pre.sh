#!/bin/sh



linux() {
    # cli does a lot of absolute symbolic linking, have to replicate this to allow it to be installed locally
    # and at system level
    curl -s "https://awscli.amazonaws.com/awscli-exe-linux-$(uname -m).zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    ./aws/install --bin-dir local/bin --install-dir local/awscli --update

    current_link=$(readlink local/awscli/v2/current)
    version=$(basename "$current_link")
    echo "Current version is: $version"

    unlink local/bin/aws
    unlink local/bin/aws_completer
    unlink local/awscli/v2/current

    mkdir -p local/lib/
    mv local/awscli/v2/"$version" local/lib/awscli

    cd local/bin
    ln -s ../lib/awscli/bin/aws aws
    ln -s ../lib/awscli/bin/aws_completer aws_completer

    cd ../..

    caifs_install "local/*"
}
