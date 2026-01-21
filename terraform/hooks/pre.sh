#!/bin/sh


arch() {
    yay_install terraform
}

fedora() {
    rootdo dnf config-manager addrepo --from-repofile https://rpm.releases.hashicorp.com/$ID/hashicorp.repo
    rootdo dnf update
    rootdo dnf install -y terraform
}
