macos() {
    brew install coreutils curl
}

fedora() {
    rootdo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm
    rootdo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-"$(rpm -E %fedora)".noarch.rpm
    rootdo dnf install -y curl
}

debian() {
    rootdo apt install -y curl
}

steamos() {
    rootdo steamos-readonly disable
    rootdo pacman-key --init
    rootdo pacman-key --populate archlinux
    rootdo pacman-key --populate holo

    # run the arch method now to get yay
    arch
}


arch() {
    rootdo pacman -S --needed --noconfirm base-devel curl git

    # yay, to install the good shit
    if ! has yay; then
        git clone https://aur.archlinux.org/yay.git yay
        makepkg -si --noconfirm
        yay -S yay
    fi
}
