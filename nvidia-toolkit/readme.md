# nvidia-toolkit

NVIDIA Container Toolkit, gives a GPU to Docker containers

```text
nvidia-toolkit
├── hooks
│   └── pre.sh
└── readme.md

2 directories, 2 files
```

## Supported target systems

- arch
- debian
- fedora
- ubuntu

## Requirements

The target needs `docker`, and a working NVIDIA driver on the host. Under WSL,
the driver is the Windows driver. Do not install a Linux NVIDIA driver inside
the distribution.

Do a test after the install:

```sh
docker run --rm --gpus all ubuntu nvidia-smi
```
