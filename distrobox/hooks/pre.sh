#!/bin/sh

# distrobox runs other Linux distributions in containers that share the home
# directory, display and devices of the host. It needs podman or docker.

# Warn when no container manager is present, distrobox cannot start a box without one
check_container_manager() {
    if ! command -v podman > /dev/null 2>&1 && ! command -v docker > /dev/null 2>&1; then
        log_warn "distrobox needs podman or docker. Install one of them first"
    fi
}

# Under WSL, / and /tmp are private mounts. distrobox mounts /tmp into the box
# as a slave mount, and Docker refuses that on a private mount with
# `path /tmp is mounted on /tmp but it is not a shared or slave mount`.
# A systemd unit makes all mounts shared at each start of the distribution.
wsl_shared_mounts() {
    is_wsl || return 0

    if [ ! -d /run/systemd/system ]; then
        log_warn "WSL runs without systemd, so the mounts become private again after a restart"
        log_warn "Turn on systemd in /etc/wsl.conf, or run 'sudo mount --make-rshared /' after each start"
        rootdo mount --make-rshared /
        return 0
    fi

    MOUNT_BIN="$(command -v mount)"
    rootdo tee /etc/systemd/system/make-rshared.service > /dev/null << EOF
[Unit]
Description=Make all mounts shared, for distrobox
After=local-fs.target tmp.mount

[Service]
Type=oneshot
ExecStart=${MOUNT_BIN} --make-rshared /

[Install]
WantedBy=multi-user.target
EOF
    rootdo systemctl daemon-reload
    rootdo systemctl enable --now make-rshared.service
}

arch() {
    check_container_manager
    yay_install distrobox
    wsl_shared_mounts
}

fedora() {
    check_container_manager
    rootdo dnf install -y distrobox
    wsl_shared_mounts
}

debian() {
    check_container_manager
    rootdo apt update
    rootdo apt install -y distrobox
    wsl_shared_mounts
}

ubuntu() {
    debian
}

linux() {
    # The upstream install script puts distrobox and its helpers in <prefix>/bin
    check_container_manager
    curl -fsSL https://raw.githubusercontent.com/89luca89/distrobox/main/install \
        | sh -s -- --prefix "${CAIFS_INSTALL_DIR}"
    caifs_install
    wsl_shared_mounts
}
