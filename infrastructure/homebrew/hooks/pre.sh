fedora() {
    rootdo dnf group install development-tools
    rootdo dnf install procps-ng curl file

    generic
}

debian() {
    rootdo apt-get install build-essential procps curl file git

    generic
}

ubuntu() {
    debian
}


generic() {
    has bash
    has curl
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

}
