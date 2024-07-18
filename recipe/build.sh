#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

go build -buildmode=pie -trimpath -o=${PREFIX}/bin/${PKG_NAME} -ldflags="-s -w" ./cmd/buildx

mkdir -p ${PREFIX}/etc/bash_completion.d
mkdir -p ${PREFIX}/share/zsh/site-functions
mkdir -p ${PREFIX}/share/fish/vendor_completions.d

if [[ ${build_platform} == ${target_platform} ]]; then
docker-buildx completion bash > ${PREFIX}/etc/bash_completion.d/docker-buildx
docker-buildx completion zsh > ${PREFIX}/share/zsh/site-functions/_docker-buildx
docker-buildx completion fish > ${PREFIX}/share/fish/vendor_completions.d/docker-buildx.fish
fi

go-licenses save ./cmd/buildx --save_path=license-files
