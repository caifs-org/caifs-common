# CAIFS Common Collection (v1.0.0)

A collection of CAIFS enabled installers and general purpose configuration that can be enabled via CAIFS
<https://github.com/caifs-org/caifs>

This common library also acts as an awesome-lite list of good development software, with the benefit of being able to
see how the specific software can be installed, in a succinct way rather than trawling through various docs.

The caifs-common library prioritises local user level installs by default, using `uv` and `npm` to manage per-user
installs of software, where appropriate. Where required, system level package managers are used which generally will
prompt for passwords (if required) via sudo/su.

On MacOS, `homebrew` is preferred, with the fall backs to `uv` and `npm` for packages that aren't provided by homebrew,
and direct installs to `~/.local` for everything else.

## Installation

See the readme for instructions on how to install the CAIFS installer at <https://github.com/caifs-org/caifs>

To enable this repository, pick one of the following:

> [!IMPORTANT]
> It is generally advisable to always run `caifs add caifs-bootstrap` as your first task, as this will enable the
> `uv` and `npm` installers which are used throughout this library. It is not required though, but targets that require
> either `npm` or `uv` will throw an error.

### Git Clone method (Recommended for users who contribute to caifs-common)

``` shell
git clone https://github.com/caifs-org/caifs-common.git
ln -s $PWD/caifs-common $HOME/.local/share/caifs-collections/caifs-common

# install a target from this collection
# eg caifs add <target from this collection> 
caifs add fzf
```

### Static Release method (Recommended for general consumers)

``` shell
curl -sL https://raw.githubusercontent.com/caifs-org/caifs-common/refs/heads/main/install.sh | sh

# install a target from this collection
# eg caifs add <target from this collection> 
caifs add fzf
```

### Docker container build method

``` dockerfile
FROM debian:trixie-slim
COPY --from=ghcr.io/caifs-org/caifs:latest /caifs/ /usr/local/
COPY --from=ghcr.io/caifs-org/caifs-common:latest /caifs-common/ /usr/local/share/caifs-collections/caifs-common/

RUN CAIFS_LOCAL_COLLECTIONS=/usr/local/share/caifs-collections caifs --status
```

## Some opinionated notes

### Shell directories

Where possible, `config.d` practices are adopted for including separate config files. This is generally a good practice
everywhere, as it allows your most "top-most" config file, say `~/.bashrc`, `~/.zshrc` or `~/.ssh/config` to not be
manipulated by this library. Often a default is provided by your distro of choice, or you may version control your own
dot file. Either way, this library will avoid touching these files when possible and support the use of `config.d` style
includes, which provide minimal impact to your top-most config files.

CAIFS along with this common collection generally uses the completion directories of `share/zsh/completions`
and `share/bash-completion/completions`.

> [!TIP]
> each group that sets a config file in either `~/.bashrc.d/` or `~/.zshrc.d` will use the practice of using the group
> name of the thing being installed as the config file name.
> E.g. `caifs add starship` will add a `~/.bashrc.d/starship.bash` config file via symlink

### Passwords

I like using a `~/.netrc` file as my single source of truth for credential management. Others might not, but either
way I like to keep the contents of that file within a dedicated password manager

## Supported installs

| Software target                                                                   | Description                                                                                            |
|:----------------------------------------------------------------------------------|:-------------------------------------------------------------------------------------------------------|
| [ansible](automation-workflow/ansible/)                                           | Configuration automation tool                                                                          |
| [ansible-language-server](editors-ides/ansible-language-server/)                  | Ansible Language server for auto-completion and linting                                                |
| [awscli](cloud-infra/awscli/)                                                     | Official AWS CLI                                                                                       |
| [azure-cli](cloud-infra/azure-cli/)                                               | Official Azure CLI                                                                                     |
| [basedpyright](editors-ides/basedpyright/)                                        | A based version of the pyright lang server with saner defaults                                         |
| [bash-language-server](editors-ides/bash-language-server/)                        | LSP server for bash and sh                                                                             |
| [bump-my-version](automation-workflow/bump-my-version/)                           | CLI for applying semver practices to git repos                                                         |
| [bun](dev-environments/bun/)                                                      | Fast JavaScript runtime and package manager                                                            |
| [caifs-bootstrap](bootstrap/caifs-bootstrap/)                                      | The initial bootstrapping target to install various installers like `uv` and `npm`                     |
| [copier](automation-workflow/copier/)                                             | A library and CLI app for rendering project templates.                                                 |
| [cruft](automation-workflow/cruft/)                                               | CookieCutter template manager                                                                          |
| [d2](documentation/d2/)                                                            | Modern diagram scripting language that turns text into diagrams                                        |
| [delta](cli-tools/delta/)                                                         | Syntax-highlighting pager for git diffs                                                                |
| [devcontainers](dev-environments/devcontainers/)                                  | Docker containers specifically configured to provide a full-featured, isolated development environment |
| [direnv](shell-terminal/direnv/)                                                  | Manage environment variables per directory                                                             |
| [dive](cli-tools/dive/)                                                           | TUI tool for inspecting docker images                                                                  |
| [docker](containerization/docker/)                                                | Docker community edition engine & CLI tooling                                                          |
| [docker-clean](container-utilities/docker-clean/)                                 | Meta group for performing common clean up actions (use last)                                           |
| [docker-cli](containerization/docker-cli/)                                        | Docker CE CLI tooling only, no engine install                                                          |
| [docker-language-server](editors-ides/docker-language-server/)                    | Docker language server for auto-completion in IDEs                                                     |
| [fd](cli-tools/fd/)                                                               | Fast find alternative written in Rust                                                                  |
| [fzf](cli-tools/fzf/)                                                             | Fast fuzzy finder utility                                                                              |
| [git](shell-terminal/git/)                                                        | Some nice configuration specifically for work                                                          |
| [gitlab-ci-local](automation-workflow/gitlab-ci-local/)                           | Run gitlab CICD tasks locally                                                                          |
| [gitu](cli-tools/gitu/)                                                           | TUI for git interaction, based on magit                                                                |
| [glab](system-admin/glab/)                                                        | GitLab CLI tool for interacting with GitLab APIs                                                       |
| [gosu](container-utilities/gosu/)                                                 | Simple Go-based setuid+setgid+setgroups+exec                                                           |
| [hadolint](automation-workflow/hadolint/)                                         | Dockerfile linter that helps you build best practice Docker image                                      |
| [homebrew](infrastructure/homebrew/)                                              | The Missing Package Manager for macOS (or Linux)                                                       |
| [jq](cli-tools/jq/)                                                               | lightweight and flexible command-line JSON processor akin to sed,awk,grep                              |
| [just](automation-workflow/just/)                                                 | A command runner, inspired by make but much better                                                     |
| [just-lsp](editors-ides/just-lsp/)                                                | LSP server for Just                                                                                    |
| [kiro-cli](cli-tools/kiro-cli/)                                                   | Kiro Agentic command-line interface only                                                               |
| [kubectl](containerization/kubectl/)                                              | kubernetes command line interface                                                                      |
| [lazydocker](cli-tools/lazydocker/)                                               | TUI for managing local docker containers                                                               |
| [marksman](editors-ides/marksman/)                                                | LSP server for Markdown                                                                                |
| [minikube](containerization/minikube/)                                            | Kubernetes dev environment                                                                             |
| [netrc](system-admin/netrc/)                                                      | A small go utility to interact with .netrc files                                                       |
| [nodejs](dev-environments/nodejs/)                                                | Javascript runtime (mainly used for managing packages via this tool) see NVM                           |
| [nvm](dev-environments/nvm/)                                                      | Manage multiple node versions                                                                          |
| [oras](cloud-infra/oras/)                                                         | CLI tool for interfacing with OCI objects                                                              |
| [pandoc](documentation/pandoc/)                                                   | Markup conversion tool                                                                                 |
| [poetry](dev-environments/poetry/)                                                | A perfectly fine python project management tool, but deprecated in favour of uv now                    |
| [pre-commit](automation-workflow/pre-commit/)                                     | Run checks and validation before committing to git                                                     |
| [prek](automation-workflow/prek/)                                                 | prek is a reimagined version of pre-commit, built in Rust.                                             |
| [pycharm](misc/pycharm/)                                                          | JetBrains Python IDE                                                                                   |
| [pyrefly](editors-ides/pyrefly/)                                                  | A fast type checker and language server for Python with powerful IDE features                          |
| [pyright](editors-ides/pyright/)                                                  | Microsoft Python language server                                                                       |
| [ripgrep](cli-tools/ripgrep/)                                                     | A faster, enhanced version of grep. Often integrated into editors                                      |
| [ruff](misc/ruff/)                                                                | Extremely fast linter for Python                                                                       |
| [rumdl](documentation/rumdl/)                                                     | A modern Markdown linter and formatter, built for speed with Rust                                      |
| [shellcheck](cli-tools/shellcheck/)                                               | Static analysis tool for shell scripts                                                                 |
| [shfmt](cli-tools/shfmt/)                                                         | Shell script formatter                                                                                 |
| [ssh](shell-terminal/ssh/)                                                        | SSH config.d directory setup                                                                           |
| [starship](shell-terminal/starship/)                                              | A terminal prompt prettier, written in Rust                                                            |
| [su-exec](container-utilities/su-exec/)                                           | switch user and group id, setgroups and exec, smaller alternative to gosu                              |
| [terraform](cloud-infra/terraform/)                                               | Infrastructure as code tool by HashiCorp                                                               |
| [tini](container-utilities/tini/)                                                 | A tiny but valid `init` for containers                                                                 |
| [tmux](shell-terminal/tmux/)                                                      | A terminal multiplexer                                                                                 |
| [trash-cli](cli-tools/trash-cli/)                                                 | Command line interface to the freedesktop.org trashcan.                                                |
| [trivy](cloud-infra/trivy/)                                                       | Container image scanning tool                                                                          |
| [ty](editors-ides/ty/)                                                            | An extremely fast python type checker and language server from Astral                                  |
| [uv](dev-environments/uv/)                                                        | Python dependency management                                                                           |
| [vscode-json-languageserver](editors-ides/vscode-json-languageserver/)             | A JSON LSP server                                                                                      |
| [watchexec](cli-tools/watchexec/)                                                 | Monitor file changes and run commands                                                                  |
| [yaml-language-server](editors-ides/yaml-language-server/)                        | YAML language server, for auto-completion                                                              |

> [!TIP]
> All can be installed and configured via `caifs add <name of target>`

## Notes on Install

Some of the installs might prompt or include some extras that you did not know about. Anything of note
is detailed below.

### Installing specific versions

While the most common use case for these dots if or bootstrapping a local dev machine, there is a potential use case for
using these dot installers within a container build.

For local dev, it is usually perfectly fine to install the latest of whatever software you are installing, and that is
why it is the default. For those odd times where you require a specific version of a piece of software, then _most_ of
the installs support installing a specific version via supplying an env var of the form `$<PACKAGE NAME>_VERSION`

For example, the following will attempt to install `poetry` version 1.8.2, in this case via `uv`

`POETRY_VERSION=1.8.2 caifs add poetry`

### Writing hooks for custom machine types

When required to write generic wrappers such as for `linux` or `generic` hooks, consider using the following to derive
the appropriate architecture and form subsequent download links

``` shell
linux() {
    MACHINE_TYPE="$(uname -m)"
    case $MACHINE_TYPE in
        i386 | i486 | i586 | i686 | i786 | x86)
            ARCH="386"
            ;;
        amd64 | x86_64 | x64)
            ARCH="amd64"
            ;;
        arm | armv7l)
            ARCH="arm"
            ;;
        aarch64)
            ARCH="arm64"
            ;;
        s390x)
            ARCH="s390x"
            ;;
        ppc64)
           ARCH="ppc64"
           ;;
        ppc64le)
           ARCH="ppc64le"
           ;;
        *)
            echo "Unknown machine type: $MACHINE_TYPE"
            exit 1
            ;;
    esac

    # form the github release filename
    filename="some-cool-binary-linux-${ARCH}.tar.gz"
}
```

### Docker community edition

Installs docker engine, cli and all the bits and pieces required for docker development.

The docker install occurs via the recommended way via <https://docs.docker.com/engine/install/>

`caifs add docker`

If you want just the CLI tooling for docker, minus the engine - particularly useful in docker pipeline builds,
then the docker-cli target is an alternative.

### Install uv

Installing uv is a requirement for other tools, such as `pre-commit`, `ruff`, `poetry` and `just`.

The install occurs via the currently recommended way on <https://docs.astral.sh/uv/getting-started/installation/>

`caifs add uv`

### Various UV tools

Tools like pre-commit, just, ruff, ansible etc which can be installed via the `uv tool install`, which is provided by
CAIFS as a wrapper, `uv_install`. This ensures ownership and custom link roots are respected

This is considered best practice for non system wide installs and hence is the preferred method when available

> [!Note]
> Once tools are installed this way, be sure to periodically update them via_ `uv tool update`
> or by running the _set_ hook again for that group.

### Shells BASH and ZSH

Other tools that require bash or zsh integration manage their own configuration for the shells, for instance
`starship`. In order to keep this consistent, the generally well accepted practice of organsing your custom
import shell scripts under a specifc directory is adopted and setup during the first run

For bash, custom scripts should be placed in `~/.bashrc.d/` while for zsh, it is `~/.zshrc.d/`

Some distributions already adopt this practice, in which case nothing else needs to be done. For those that don't,
the addition is contained with a `.bashrc-custom` or `.zshrc-custom` file and the source line is automatically appended
to `.bashrc` or `.zshrc`.

### Pandoc

Gitlab and Github both use extensions to markdown that are not 100% compatible.

Unless you want to jump back and forth between the online Gitlab markdown editor, you can also get a decent
representation via using `pandoc`

Installing `pandoc` will also install the github html rendering template, which is much better than stock standard.

For a "good enough" local verification of a readme file that will render in Gitlab, you can run the following.

```shell
pandoc \
    --metadata=title=markdown \
    --template=GitHub.html5 \
    --from gfm \
    --to html5 \
    --mathjax \
    --highlight-style=pygments \
    --standalone \
    -o preview.html 
    readme.md
```

which is also provided as an alias, provided you have installed the bash or zsh group previously:

```shell
pandoc-preview readme.md
```

For bonus points, you can also run `watchexec` and have the preview.html auto-reload in your browser

```shell
watchexec readme.md pandoc-preview readme.md
```

### Ruff

A global `ruff.toml` file is provided within `~/.config/ruff/ruff.toml` which contains some commonly accepted standards.

Consider extending the global file when developing in order to not have to duplicate the same settings across projects.

An example project level `pyproject.toml`

``` toml
[tool.ruff]
# Extend the `pyproject.toml` file in the user config directory...
extend = "~/.config/ruff/pyproject.toml"
```

OR

An example project level `ruff.toml`

``` toml
# Extend the `ruff.toml` file in the user config directory...
extend = "~/.config/ruff/ruff.toml"

# ...but use a different line length.
line-length = 100
```

See here for more information on the limits of how this config file discovery works

<https://docs.astral.sh/ruff/configuration/#config-file-discovery>

### Rumdl

Rumdl is a fast markdown linter and LSP server. It is backwards compatible with `markdownlint`, aka `mdl`.

A global `rumdl.toml` is provided as part of the install. Unlike ruff, it cannot be extended in a per-project basis, so
it might not be as useful.

A potential pattern for using `rumdl` within `pre-commit` checks in a pipeline for instance, is to install the `rumdl`
config during the pipeline
