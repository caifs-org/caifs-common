# pandoc

Markup conversion tool

```text
pandoc
├── config
│   ├── .bashrc.d
│   │   └── pandoc.bash
│   ├── .pandoc
│   │   └── templates
│   │       └── GitHub.html5
│   └── .zshrc.d
│       └── pandoc.zsh
├── hooks
│   └── pre.sh
└── readme.md

7 directories, 5 files
```

## Supported target systems

- arch
- fedora
- macos
- ubuntu

## Notes

The caifs runner sends every macOS release to the `macos` hook, so this target
needs no version test. Homebrew builds pandoc 3.11 for the three most recent
macOS releases.

## LaTeX engine

pandoc needs a LaTeX engine to write PDF files. Each platform installs one:

- arch: `texlive-latexrecommended` and `texlive-fontsrecommended`
- fedora: `texlive-collection-latexrecommended` and
  `texlive-collection-fontsrecommended`
- ubuntu: `texlive-latex-recommended`, `texlive-fonts-recommended` and
  `lmodern`
- macos: the `basictex` cask

The generated LaTeX loads `lmodern` without a guard, so the recommended font
set is required. Debian and Ubuntu package `lmodern` on its own, which is why
that name appears a second time in the Ubuntu list. `basictex` is TeX Live
`scheme-small`, and that scheme includes `lm`.

pandoc guards `upquote`, `microtype`, `parskip` and `xurl` with
`\IfFileExists`, so the larger `latexextra` collection is not needed.

On macOS, `basictex` puts its programs in `/Library/TeX/texbin`. The installer
adds this path through `/etc/paths.d/TeX`. Open a new shell before you run
`pandoc -o out.pdf`.
