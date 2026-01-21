set export
set shell := ["/bin/sh", "-c"]

[doc('List available recipes')]
help:
    @just --list

[doc('Install the CAIFS framework')]
[script]
install-caifs:
    curl -sL https://raw.githubusercontent.com/caifs-org/caifs/refs/heads/main/install.sh | sh

[doc('Install CI runner dependencies (uv, pre-commit, rumdl)')]
[script]
install-caifs-runner-deps:
    export PATH="$HOME/.local/bin:$PATH"
    caifs add uv pre-commit rumdl --hooks

[doc('Bump version (use --patch, --minor, or --major)')]
[script]
[arg("patch", long="patch", value="patch")]
[arg("minor", long="minor", value="minor")]
[arg("major", long="major", value="major")]
bump-version $patch="" $minor="" $major="" *args:
    bump-my-version bump --verbose $patch $minor $major {{ args }}

[doc('Create release.tar.gz for distribution')]
[script]
create-release-tar:
    tar --exclude-from .tarignore --transform 's,^,caifs-common/,' -czvf release.tar.gz *

[doc('List contents of release tarball')]
[script]
list-release-tar-files:
    tar -ztf release.tar.gz

[doc('Install pre-commit hooks locally')]
[script]
pre-commit-install:
    export PATH="$HOME/.local/bin:$PATH"
    pre-commit install --install-hooks

[doc('Run pre-commit checks on all files')]
[script]
pre-commit-run:
    export PATH="$HOME/.local/bin:$PATH"
    pre-commit run --all

[doc('Generate readme.md for all targets')]
[script]
generate-target-readmes:
    for target in $(ls -d */hooks 2>/dev/null | sed 's|/hooks||'); do
        echo "Generating $target/readme.md"
        # Extract description from README.md table
        description=$(grep "\[$target\]" README.md | awk -F'|' '{print $3}' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
        # Extract supported systems from pre.sh function definitions
        systems=$(grep -oE '^\s*\w+\s*\(\)|^\w+\(\)' "$target/hooks/pre.sh" 2>/dev/null | sed 's/[[:space:]]*()//g; s/[[:space:]]//g' | sort | while read -r sys; do echo "- $sys"; done)
        cat > "$target/readme.md" << EOF
    # $target

    $description

    \`\`\`text
    $(tree -a "$target")
    \`\`\`

    ## Supported target systems

    $systems
    EOF
    done
    echo "Done generating readmes for all targets"
