#!/bin/sh


steamos() {
    rootdo pacman -S --noconfirm tmux
}

fedora() {
    rootdo dnf install -y tmux
}
