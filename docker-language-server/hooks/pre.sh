linux () {
    LATEST_VERSION=$(github_latest_tag "docker/docker-language-server")
    VERSION=${DOCKER_LANGUAGE_SERVER_VERSION:=$LATEST_VERSION}
    FILENAME=docker-language-server-linux-amd64-v${VERSION}
    curl -sL \
         --output bin/docker-language-server \
         --create-dirs \
         --create-file-mode 0755 \
         https://github.com/docker/docker-language-server/releases/download/v"${VERSION}"/"${FILENAME}"

    caifs_install bin
}
