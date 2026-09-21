# typstyle

Code formatter for typst

```text
typstyle
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

typstyle formats typst source files. The [tinymist](../tinymist/) language
server calls it to format a document in an editor. This target gives you the
same formatter on the command line, for a script or a pre-commit hook.

Arch packages typstyle, and homebrew has a formula for it. Fedora and Ubuntu
package neither, so these two systems take the upstream binary from the `linux`
hook.

Upstream publishes a bare binary and not an archive, so the `linux` hook has no
unpack step. Upstream also builds no musl binary for aarch64. That machine gets
the gnu binary instead.
