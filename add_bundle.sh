#!/bin/bash

URL="$1"
shift

if test -z "$URL"; then
    echo "Usage: $0 URL_TO_GIT_REPO" 1>&2
    exit 1
fi

bundle=$(basename "$URL" .git)
commit_msg="Add the $bundle bundle"

if grep -qF "s:plugify('$bundle'" vimrc.d/001-plug.vim; then
    git add vimrc.d/001-plug.vim
else
    echo "Add the new bundle to vimrc.d/001-plug.vim before calling this script" 1>&2
    exit 1
fi

git submodule add "$@" -- "$URL" vim/bundle/$bundle
git commit -m "$commit_msg"
