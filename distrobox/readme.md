# distrobox

Run other Linux distributions in containers that share the host home directory

```text
distrobox
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
- ubuntu

## Requirements

The target needs `podman` or `docker`. The `linux` target uses the upstream
install script, and puts the binaries in `${CAIFS_INSTALL_DIR}/bin`.

Do a test after the install:

```sh
distrobox create --name test --image ubuntu:latest
distrobox enter test
```
