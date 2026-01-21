set export

# List available recipes
help:
    just --list

[script]
[arg("patch", long="patch", value="patch")]
[arg("minor", long="minor", value="minor")]
[arg("major", long="major", value="major")]
bump-version $patch="" $minor="" $major="" *args:
    bump-my-version bump $patch $minor $major {{ args }}

# release.tar.gz
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
