# Git-dev Target

The git target will ensure the `git` binary is installed, it is handy for unattended installations that require git,
but no extra configuration.

This git-dev target adds nice configuration, intended for a dev workflow

`~/.gitconfig-work`
`~/.gitconfig-private`

## Workflow

After installing, instead of the usual `git clone` method, use the aliases `git clone-work` or `git clone-private` to
clone the repositories into the correct base work directory. eg `$DEFAULT_CODE_DIR/work` or `$DEFAULT_CODE_DIR/private`

## Updating the global ignore file

The currently used script for updating the `~/.config/git/ignore` file is below
It used to be a post-hook script, but it was too dynamic and not idempotent enough. Now it gets managed as config

``` shell
GLOBAL_IGNORES="\
        Global/Ansible.gitignore \
        Global/JetBrains.gitignore \
        Global/Linux.gitignore \
        Global/Emacs.gitignore \
        Global/macOS.gitignore \
        Global/VisualStudioCode.gitignore \
        Global/VirtualEnv.gitignore \
        Global/Windows.gitignore \
        Dotnet.gitignore \
        Python.gitignore \
        Terraform.gitignore \
"

GLOBAL_IGNORE_FILE=config/.config/git/ignore

mkdir -p $(dirname ${GLOBAL_IGNORE_FILE})

# reset the file or create it
> ${GLOBAL_IGNORE_FILE}

echo "Downloading common gitignores from https://github.com/github/gitignore..."
for ignore_file in $GLOBAL_IGNORES; do
    echo "" >> ${GLOBAL_IGNORE_FILE}
    echo "## Start ${ignore_file}" >> ${GLOBAL_IGNORE_FILE}
    curl -sL https://raw.githubusercontent.com/github/gitignore/refs/heads/main/${ignore_file} >> ${GLOBAL_IGNORE_FILE}
    echo "## End ${ignore_file}" >> ${GLOBAL_IGNORE_FILE}
done
```

## Dependencies

You should ensure that you have a `$DEFAULT_CODE_DIR` environment variable set, which by default is generated during
`caifs add bootstrap`
