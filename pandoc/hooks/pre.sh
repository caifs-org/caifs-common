#!/bin/sh

# pandoc - markup conversion tool
# https://pandoc.org/
#
# Each platform also gets a LaTeX engine. pandoc needs one to write PDF files.
# The generated LaTeX loads lmodern without a guard, so the recommended font
# set is required and not optional.

arch() {
    yay_install pandoc texlive-latexrecommended texlive-fontsrecommended
}

fedora() {
    rootdo dnf install -y pandoc \
        texlive-collection-latexrecommended \
        texlive-collection-fontsrecommended
}

ubuntu() {
    rootdo apt-get update
    rootdo apt-get install -y pandoc \
        texlive-latex-recommended \
        texlive-fonts-recommended \
        lmodern
}

macos() {
    brew install pandoc
    brew install --cask basictex
}
