# kiro cli is not supported via homebrew, so everything goes via generic

generic() {
    kiro-cli uninstall

    # the above should take care of it, but this is bezos so lets be sure
    caifs_remove bin/kiro-cli bin/kiro-cli-chat bin/kiro-cli-term
}
