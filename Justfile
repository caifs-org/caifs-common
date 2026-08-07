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

[doc('Creates the scafolding for a new target')]
[arg('pre', long, value="true", help='Create a pre.sh hook script')]
[arg('post', long, value="true", help='Create a post.sh hook script')]
[arg('rm', long, value="true", help='Create a rm.sh hook script')]
[script]
generate-new-target target_name pre="false" post="false" rm="false":
    mkdir -p {{ target_name }}/config {{ target_name }}/hooks
    if "{{ pre }}"; then
        printf "linux() {\n"                                                 > {{ target_name }}/hooks/pre.sh
        printf "    MACHINE_TYPE=\"\$(uname -m)\"\n"                         >> {{ target_name }}/hooks/pre.sh
        printf "    case \$MACHINE_TYPE in\n"                                >> {{ target_name }}/hooks/pre.sh
        printf "        i386 | i486 | i586 | i686 | i786 | x86)\n"           >> {{ target_name }}/hooks/pre.sh
        printf "            ARCH=\"386\"\n"                                  >> {{ target_name }}/hooks/pre.sh
        printf "            ;;\n"                                            >> {{ target_name }}/hooks/pre.sh
        printf "        amd64 | x86_64 | x64)\n"                             >> {{ target_name }}/hooks/pre.sh
        printf "            ARCH=\"amd64\"\n"                                >> {{ target_name }}/hooks/pre.sh
        printf "            ;;\n"                                            >> {{ target_name }}/hooks/pre.sh
        printf "        arm | armv7l)\n"                                     >> {{ target_name }}/hooks/pre.sh
        printf "            ARCH=\"arm\"\n"                                  >> {{ target_name }}/hooks/pre.sh
        printf "            ;;\n"                                            >> {{ target_name }}/hooks/pre.sh
        printf "        aarch64)\n"                                          >> {{ target_name }}/hooks/pre.sh
        printf "            ARCH=\"arm64\"\n"                                >> {{ target_name }}/hooks/pre.sh
        printf "            ;;\n"                                            >> {{ target_name }}/hooks/pre.sh
        printf "        s390x)\n"                                            >> {{ target_name }}/hooks/pre.sh
        printf "            ARCH=\"s390x\"\n"                                >> {{ target_name }}/hooks/pre.sh
        printf "            ;;\n"                                            >> {{ target_name }}/hooks/pre.sh
        printf "        ppc64)\n"                                            >> {{ target_name }}/hooks/pre.sh
        printf "           ARCH=\"ppc64\"\n"                                 >> {{ target_name }}/hooks/pre.sh
        printf "           ;;\n"                                             >> {{ target_name }}/hooks/pre.sh
        printf "        ppc64le)\n"                                          >> {{ target_name }}/hooks/pre.sh
        printf "           ARCH=\"ppc64le\"\n"                               >> {{ target_name }}/hooks/pre.sh
        printf "           ;;\n"                                             >> {{ target_name }}/hooks/pre.sh
        printf "        *)\n"                                                >> {{ target_name }}/hooks/pre.sh
        printf "            echo \"Unknown machine type: \$MACHINE_TYPE\"\n" >> {{ target_name }}/hooks/pre.sh
        printf "            exit 1\n"                                        >> {{ target_name }}/hooks/pre.sh
        printf "            ;;\n"                                            >> {{ target_name }}/hooks/pre.sh
        printf "    esac\n"                                                  >> {{ target_name }}/hooks/pre.sh
        printf "\n"                                                          >> {{ target_name }}/hooks/pre.sh
        printf "    LATEST_VERSION=\$(github_latest_tag \"test/test\")\n"    >> {{ target_name }}/hooks/pre.sh
        printf "    VERSION=\${TARGET_VERSION:=\$LATEST_VERSION}\n"          >> {{ target_name }}/hooks/pre.sh
        printf "    FILENAME=\"test-\${ARCH}-v\${VERSION}\"\n"               >> {{ target_name }}/hooks/pre.sh
        printf "}\n"                                                         >> {{ target_name }}/hooks/pre.sh
    fi
    if "{{ post }}"; then
        touch {{ target_name }}/hooks/post.sh
    fi
    if "{{ rm }}"; then
        touch {{ target_name }}/hooks/rm.sh
    fi
    printf "# {{ target_name }}\n\n## Notes" > {{ target_name }}/readme.md
