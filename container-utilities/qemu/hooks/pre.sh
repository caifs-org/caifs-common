debian() {
    rootdo apt-get install -y qemu-user qemu-user-binfmt
}

fedora() {
    rootdo dnf install -y qemu-user-static
}
