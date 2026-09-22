#!/bin/sh

# usermod refuses the whole command when one of the named groups is missing,
# and it then adds none of them. `wheel` exists on Arch and Fedora. Debian and
# Ubuntu use `sudo` instead, so `usermod -a -G docker,wheel` failed there with
# `group 'wheel' does not exist` and left the user out of the `docker` group.
# Add `docker` on its own, and add `wheel` only where that group exists.
add_docker_groups() {
    rootdo usermod -a -G docker "$CAIFS_USER"
    if getent group wheel >/dev/null 2>&1; then
        rootdo usermod -a -G wheel "$CAIFS_USER"
    fi
}


arch() {
    yay_install docker docker-buildx docker-compose docker-model-bin
    rootdo systemctl enable --now docker
    add_docker_groups
}

fedora() {
    rootdo dnf config-manager addrepo --from-repofile https://download.docker.com/linux/"$OS_ID"/docker-ce.repo
    rootdo dnf update
    rootdo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    rootdo systemctl enable --now docker
    add_docker_groups
}

debian() {
    # Add Docker's official GPG key:
    rootdo apt update
    rootdo apt install -y ca-certificates curl
    rootdo install -m 0755 -d /etc/apt/keyrings
    rootdo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
    rootdo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    rootdo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

    rootdo apt update
    rootdo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    rootdo systemctl enable --now docker
    add_docker_groups
}

ubuntu() {
    # Add Docker's official GPG key:
    rootdo apt update
    rootdo apt install ca-certificates curl
    rootdo install -m 0755 -d /etc/apt/keyrings
    rootdo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    rootdo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    rootdo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

    rootdo apt update
    rootdo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    rootdo systemctl enable --now docker
    add_docker_groups
}
