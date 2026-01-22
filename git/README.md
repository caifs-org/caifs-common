# Git Target

The git target will ensure the `git` binary is installed, but also generate some nice configuration,
centered around separating work and private repositories.

This results in two scaffolding files, which aren't linked like a typical CAIFS config file.

After running this target, you will need to populate these files with details - otherwise git will complain.

`~/.gitconfig-work`
`~/.gitconfig-private`

## Workflow

After installing, instead of the usual `git clone` method, use the aliases `git clone-work` or `git clone-private` to
clone the repositories into the correct base work directory. eg `$DEFAULT_CODE_DIR/work` or `$DEFAULT_CODE_DIR/private`

## Dependencies

You should ensure that you have a `$DEFAULT_CODE_DIR` environment variable set, which by default is generated during
`caifs add bootstrap`
