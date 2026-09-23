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

## WSL

Under WSL, `/` and `/tmp` are private mounts. distrobox mounts `/tmp` into the
box as a slave mount, and Docker refuses that on a private mount:

```text
Error response from daemon: path /tmp is mounted on /tmp but it is not a shared or slave mount
```

Under WSL, the target therefore installs and enables the systemd unit
`make-rshared.service`. The unit runs `mount --make-rshared /` at each start
of the distribution. If WSL runs without systemd, the target makes the mounts
shared one time, and gives a warning. Then run `sudo mount --make-rshared /`
after each start, or turn on systemd in `/etc/wsl.conf`.

Do a test after the install:

```sh
distrobox create --name test --image ubuntu:latest
distrobox enter test
```
