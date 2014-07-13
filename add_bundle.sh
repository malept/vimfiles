#!/bin/bash

URL="$1"
shift

if test -z "$URL"; then
    echo "Usage: $0 URL_TO_GIT_REPO" 1>&2
    exit 1
fi

bundle=$(basename "$URL" .git)
commit_msg="Add the $bundle bundle"

if test -n "$PROFILES"; then
    for p in $PROFILES; do
        (
            cd profiles/$p/bundle/
            ln -s ../../../vim/bundle/$bundle .
            git add $bundle
        )
    done
    commit_msg="$commit_msg to the following profiles: $PROFILES"
fi

git submodule add "$@" -- "$URL" vim/bundle/$bundle
git commit -m "$commit_msg"
