# nix

The purely functional package manager

```text
nix
├── hooks
│   └── pre.sh
└── readme.md

2 directories, 2 files
```

## Supported target systems

- arch
- fedora
- generic
- macos
- ubuntu

## Notes

Arch and Fedora package a current nix. The package brings the systemd units,
the nixbld build users and the profile script. This target uses the distro
package on these two systems.

Ubuntu 24.04 LTS packages nix 2.18. This version is too old, so Ubuntu uses
the upstream installer. macOS has no homebrew formula for nix, so macOS also
uses the upstream installer.

The upstream installer runs in multi-user mode. It creates `/nix`, adds the
build users and starts the daemon. The `generic` hook holds this install path.
Any other Linux distribution also uses this path.
