#!/bin/sh


arch() {
    yay_install tmux
}

steamos() {
    rootdo pacman -S --noconfirm tmux
}

fedora() {
    rootdo dnf install -y tmux
}

debian() {
    rootdo apt update
    rootdo apt install -y tmux
}

ubuntu() {
    debian
}
