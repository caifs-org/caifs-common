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
- debian
- fedora
- linux
- macos
- ubuntu

## Notes

The `ubuntu` hook calls the `debian` hook. The caifs runner matches a hook to
the OS id, and it has no fallback from `debian` to `ubuntu`. Without a
`debian` hook, this target does nothing on Debian.

The caifs runner sends every macOS release to the `macos` hook, so this target
needs no version test. Homebrew builds pandoc 3.11 for the three most recent
macOS releases.

Arch, Debian, Fedora and Ubuntu package pandoc, so these systems take the
distribution package. Any other Linux distribution uses the `linux` hook,
which installs the upstream binary from GitHub. Upstream builds this binary
for amd64 and arm64 only.

## LaTeX engine

pandoc needs a LaTeX engine to write PDF files. Each packaged platform
installs one:

- arch: `texlive-latexrecommended` and `texlive-fontsrecommended`
- fedora: `texlive-collection-latexrecommended` and
  `texlive-collection-fontsrecommended`
- debian and ubuntu: `texlive-latex-recommended`, `texlive-fonts-recommended`
  and `lmodern`
- macos: the `basictex` cask

The `linux` hook installs no LaTeX engine, because it cannot know the package
manager of the distribution. On these systems, install TeX Live by hand before
you write a PDF file.

The generated LaTeX loads `lmodern` without a guard, so the recommended font
set is required. Debian and Ubuntu package `lmodern` on its own, which is why
that name appears a second time in the Debian list. `basictex` is TeX Live
`scheme-small`, and that scheme includes `lm`.

pandoc guards `upquote`, `microtype`, `parskip` and `xurl` with
`\IfFileExists`, so the larger `latexextra` collection is not needed.

On macOS, `basictex` puts its programs in `/Library/TeX/texbin`. The installer
adds this path through `/etc/paths.d/TeX`. Open a new shell before you run
`pandoc -o out.pdf`.
