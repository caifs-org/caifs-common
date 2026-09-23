#!/bin/sh

# The NVIDIA Container Toolkit lets Docker give a GPU to a container, with
# `docker run --gpus all`. It needs a working NVIDIA driver on the host. Under
# WSL, that is the Windows driver, and a Linux NVIDIA driver must not be
# installed inside the distribution.

KEYRING=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
REPO_URL=https://nvidia.github.io/libnvidia-container

# The toolkit is only useful with a driver that the host can reach
check_driver() {
    if ! nvidia-smi > /dev/null 2>&1; then
        log_warn "nvidia-smi found no GPU. Install the NVIDIA driver first"
        if is_wsl; then
            log_warn "Under WSL, install the driver on Windows, not inside the distribution"
        fi
    fi
}

# Point Docker at the toolkit runtime, and restart the daemon to load it
configure_docker() {
    has_or_exit docker
    rootdo nvidia-ctk runtime configure --runtime=docker
    rootdo systemctl restart docker
}

apt_repo() {
    rootdo apt update
    rootdo apt install -y ca-certificates curl gnupg
    curl -fsSL "${REPO_URL}/gpgkey" | rootdo gpg --dearmor --yes -o "$KEYRING"
    curl -fsSL "${REPO_URL}/stable/deb/nvidia-container-toolkit.list" \
        | sed "s#deb https://#deb [signed-by=${KEYRING}] https://#g" \
        | rootdo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
    rootdo apt update
    rootdo apt install -y nvidia-container-toolkit
}

arch() {
    check_driver
    yay_install nvidia-container-toolkit
    configure_docker
}

fedora() {
    check_driver
    curl -fsSL "${REPO_URL}/stable/rpm/nvidia-container-toolkit.repo" \
        | rootdo tee /etc/yum.repos.d/nvidia-container-toolkit.repo
    rootdo dnf install -y nvidia-container-toolkit
    configure_docker
}

debian() {
    check_driver
    apt_repo
    configure_docker
}

ubuntu() {
    check_driver
    apt_repo
    configure_docker
}
