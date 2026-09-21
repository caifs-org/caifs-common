# typst

Markup based typesetting system

```text
typst
├── hooks
│   └── pre.sh
└── readme.md

2 directories, 2 files
```

## Supported target systems

- arch
- debian
- fedora
- linux
- macos
- ubuntu

## Notes

typst is a static binary. It embeds its default fonts and needs no other
software at runtime.

This target also installs pandoc. pandoc converts markdown, docx and LaTeX
to typst, and typst back to those formats. The typst reader and writer need
pandoc 3.0 or later. Every platform in the table above packages a later
version.

Arch packages typst, and homebrew has a formula for it. Fedora, Debian and
Ubuntu package neither typst nor tinymist, so these systems take the upstream
binary from the `linux` hook. Any other Linux distribution also uses the
`linux` hook, but it gets no pandoc.

The upstream release is a `tar.xz` archive. The `fedora`, `debian` and
`ubuntu` hooks install xz first. On any other Linux distribution, install xz
before you add this target. The `linux` hook stops with an error when xz is
absent.

The tinymist language server and the typstyle formatter have their own
targets, because a version pin applies to one target at a time. Install the
three together:

```shell
caifs add typst tinymist typstyle
```
