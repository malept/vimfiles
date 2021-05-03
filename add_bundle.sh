#!/bin/bash

if [[ -z "$1" ]]; then
  echo "Usage: $0 URL_TO_GIT_REPO […]" 1>&2
  exit 1
fi

# From: https://stackoverflow.com/a/17841619
function join_by { local IFS="$1"; shift; echo "$*"; }

bundles=()

for URL in "$@"; do
  bundle="$(basename "$URL" .git)"

  if ! grep -qF "s:plugify('$bundle'" vimrc.d/001-plug.vim; then
    echo "Add the new bundle to vimrc.d/001-plug.vim before calling this script" 1>&2
    exit 1
  fi

  bundles+=("$bundle")
  git submodule add -- "$URL" vim/bundle/$bundle
done

commit_msg="feat: add bundles ($(join_by , "${bundles[@]}"))"

git add vimrc.d/001-plug.vim
git commit -m "$commit_msg"
