# Bootstrap Target

installs some _generally_ common things for particular operating systems

For instance, fedora users will generally install the non-free `dnf` repositories

SteamOS users will want to unlock their filesystem to install things...

MacOS will want to install homebrew

## Default code dir and localsettings

This bootstrap target also prompts for a variable `$DEFAULT_CODE_DIR`. This directory path
is used for a bunch of other targets, like `git` and `editorconfig` for example. By default,
it defaults to `DEFAULT_CODE_DIR=$HOME/code`

This variable is also placed into a file `$HOME/.localsettings` - which is intended to be sourced
by whatever shell you choose to use.

If you use the `bash` target from this repo, then it will automatically link this in.
