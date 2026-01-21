set export
set shell := [ "/bin/sh" ]

# List available recipes
help:
    just --list

[script]
install-caifs:
    curl -sL curl -sL https://github.com/caifs-org/caifs/install.sh | sh

[script]
install-caifs-runner-deps:
    export PATH="$HOME/.local/bin:$PATH"
    caifs add uv pre-commit rumdl --hooks

[script]
[arg("patch", long="patch", value="patch")]
[arg("minor", long="minor", value="minor")]
[arg("major", long="major", value="major")]
bump-version $patch="" $minor="" $major="" *args:
    bump-my-version bump --verbose $patch $minor $major {{ args }}


create-release-tar:
    tar --exclude-from .tarignore --transform 's,^,caifs-common/,' -czvf release.tar.gz *

list-release-tar-files:
    tar -ztf release.tar.gz

# Install pre-commit hooks
pre-commit-install:
    pre-commit install --install-hooks

# Run pre-commit checks on all files
pre-commit-run:
    pre-commit run --all
