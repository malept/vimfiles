#!/bin/bash

URL="$1"

if test -z "$URL"; then
    echo "Usage: $0 URL_TO_GIT_REPO" 1>&2
    exit 1
fi

bundle=$(basename "$URL" .git)

git submodule add "$URL" vim/bundle/$bundle
git commit -m "Added the $bundle bundle"
