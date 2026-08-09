macos() {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    has brew
    brew install coreutils
}

fedora() {
    rootdo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm
    rootdo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-"$(rpm -E %fedora)".noarch.rpm
    rootdo dnf install -y curl
}

debian() {
    rootdo apt-get update
    rootdo apt-get install -y curl
}

ubuntu() {
    debian
}

steamos() {
    rootdo steamos-readonly disable
    rootdo pacman-key --init
    rootdo pacman-key --populate archlinux
    rootdo pacman-key --populate holo
}

alpine() {
    rootdo apk add coreutils curl
}

arch() {
    rootdo pacman -S --needed --noconfirm base-devel curl git

    if ! has yay; then
        git clone https://aur.archlinux.org/yay.git yay
        makepkg -si --noconfirm
        yay -S yay
    fi

}
