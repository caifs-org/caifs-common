# tinymist

Language server for typst

```text
tinymist
├── hooks
│   └── pre.sh
└── readme.md

2 directories, 2 files
```

## Supported target systems

- arch
- fedora
- linux
- macos
- ubuntu

## Notes

tinymist is the language server for typst. It replaces typst-lsp. It gives an
editor completion, hover, goto definition, document symbols, inlay hints and
code lens. It also holds the preview server, which absorbed the typst-preview
project.

tinymist formats through typstyle or typstfmt. Add the [typstyle](../typstyle/)
target to get the formatter on the command line as well.

Arch packages tinymist, and homebrew has a formula for it. Fedora and Ubuntu
package neither, so these two systems take the upstream tarball from the
`linux` hook.

tinymist tracks typst releases closely. At the time of writing typst is 0.15.1
and tinymist is 0.15.8. Pin both when you pin one:

```shell
caifs add typst==0.15.1 tinymist==0.15.8
```
