set export
set shell := ["/bin/sh", "-c"]

PATH := x"$HOME/.local/bin:$PATH"

[doc('List available recipes')]
help:
    @just --list

[doc('Install the CAIFS framework')]
[script]
install-caifs:
    curl -sL https://raw.githubusercontent.com/caifs-org/caifs/refs/heads/main/install.sh | sh
    ls -l $HOME/.local/bin/

[doc('Install CI runner dependencies (uv, pre-commit, rumdl)')]
[script]
install-caifs-runner-deps:
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
    pre-commit install --install-hooks

[doc('Run pre-commit checks on all files')]
[script]
pre-commit-run:
    pre-commit run --all

[doc('Utility function to do a regex replacement on a string')]
[script]
replace str from to:
    echo {{ replace(str, from, to) }}

[doc('Creates the scafolding for a new target within a given category')]
[arg('pre', long, value="true", help='Create a pre.sh hook script')]
[arg('post', long, value="true", help='Create a post.sh hook script')]
[arg('rm', long, value="true", help='Create a rm.sh hook script')]
[arg('config', long, value="true", help="Create a config directory")]
[script]
generate-new-target category target_name pre="false" post="false" rm="false" config="false":
    if "{{ pre }}" || "{{ post }}" || "{{ rm }}"; then
        mkdir -p {{ category +"/"+ target_name }}/hooks
    fi
    if "{{ config }}"; then
        mkdir -p {{ category +"/"+ target_name }}/config
    fi
    if "{{ pre }}"; then
        printf "linux() {\n"                                                  > {{ category +"/"+ target_name }}/hooks/pre.sh
        printf "    MACHINE_TYPE=\"\$(uname -m)\"\n"                         >> {{ category +"/"+ target_name }}/hooks/pre.sh
        printf "    case \$MACHINE_TYPE in\n"                                >> {{ category +"/"+ target_name }}/hooks/pre.sh
        printf "        i386 | i486 | i586 | i686 | i786 | x86)\n"           >> {{ category +"/"+ target_name }}/hooks/pre.sh
        printf "            ARCH=\"386\"\n"                                  >> {{ category +"/"+ target_name }}/hooks/pre.sh
        printf "            ;;\n"                                            >> {{ category +"/"+ target_name }}/hooks/pre.sh
        printf "        amd64 | x86_64 | x64)\n"                             >> {{ category +"/"+ target_name }}/hooks/pre.sh
        printf "            ARCH=\"amd64\"\n"                                >> {{ category +"/"+ target_name }}/hooks/pre.sh
        printf "            ;;\n"                                            >> {{ category +"/"+ target_name }}/hooks/pre.sh
        printf "        arm | armv7l)\n"                                     >> {{ category +"/"+ target_name }}/hooks/pre.sh
        printf "            ARCH=\"arm\"\n"                                  >> {{ category +"/"+ target_name }}/hooks/pre.sh
        printf "            ;;\n"                                            >> {{ category +"/"+ target_name }}/hooks/pre.sh
        printf "        aarch64)\n"                                          >> {{ category +"/"+ target_name }}/hooks/pre.sh
        printf "            ARCH=\"arm64\"\n"                                >> {{ category +"/"+ target_name }}/hooks/pre.sh
        printf "            ;;\n"                                            >> {{ category +"/"+ target_name }}/hooks/pre.sh
        printf "        s390x)\n"                                            >> {{ category +"/"+ target_name }}/hooks/pre.sh
        printf "            ARCH=\"s390x\"\n"                                >> {{ category +"/"+ target_name }}/hooks/pre.sh
        printf "            ;;\n"                                            >> {{ category +"/"+ target_name }}/hooks/pre.sh
        printf "        ppc64)\n"                                            >> {{ category +"/"+ target_name }}/hooks/pre.sh
        printf "           ARCH=\"ppc64\"\n"                                 >> {{ category +"/"+ target_name }}/hooks/pre.sh
        printf "           ;;\n"                                             >> {{ category +"/"+ target_name }}/hooks/pre.sh
        printf "        ppc64le)\n"                                          >> {{ category +"/"+ target_name }}/hooks/pre.sh
        printf "           ARCH=\"ppc64le\"\n"                               >> {{ category +"/"+ target_name }}/hooks/pre.sh
        printf "           ;;\n"                                             >> {{ category +"/"+ target_name }}/hooks/pre.sh
        printf "        *)\n"                                                >> {{ category +"/"+ target_name }}/hooks/pre.sh
        printf "            echo \"Unknown machine type: \$MACHINE_TYPE\"\n" >> {{ category +"/"+ target_name }}/hooks/pre.sh
        printf "            exit 1\n"                                        >> {{ category +"/"+ target_name }}/hooks/pre.sh
        printf "            ;;\n"                                            >> {{ category +"/"+ target_name }}/hooks/pre.sh
        printf "    esac\n"                                                  >> {{ category +"/"+ target_name }}/hooks/pre.sh
        printf "\n"                                                          >> {{ category +"/"+ target_name }}/hooks/pre.sh
        printf "    LATEST_VERSION=\$(github_latest_tag \"test/test\")\n"    >> {{ category +"/"+ target_name }}/hooks/pre.sh
        printf "    VERSION=\${TARGET_VERSION:=\$LATEST_VERSION}\n"          >> {{ category +"/"+ target_name }}/hooks/pre.sh
        printf "    FILENAME=\"test-\${ARCH}-v\${VERSION}\"\n"               >> {{ category +"/"+ target_name }}/hooks/pre.sh
        printf "}\n"                                                         >> {{ category +"/"+ target_name }}/hooks/pre.sh
    fi
    if "{{ post }}"; then
        touch {{ category +"/"+ target_name }}/hooks/post.sh
    fi
    if "{{ rm }}"; then
        touch {{ category +"/"+ target_name }}/hooks/rm.sh
    fi
    printf "# {{ category +"/"+ target_name }}\n\n## Notes" > {{ category +"/"+ target_name }}/readme.md
