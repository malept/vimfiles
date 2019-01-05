#!/bin/bash
# Based off of: http://stackoverflow.com/q/1260748

BUNDLE="$1"

if test -z "$BUNDLE"; then
    echo "Usage: $0 BUNDLE_NAME" 1>&2
    exit 1
fi

bundle_path=vim/bundle/$BUNDLE

if grep -qF "s:plugify('$BUNDLE'" vimrc.d/001-plug.vim; then
    echo "Remove the new bundle from vimrc.d/001-plug.vim before calling this script" 1>&2
    exit 1
else
    git add vimrc.d/001-plug.vim
fi

for f in .git/config .gitmodules; do
    git config -f $f --remove-section submodule.$bundle_path
done
git add .gitmodules
git rm --cached "$bundle_path"
git commit -m "Remove the $BUNDLE bundle"
rm -rf $bundle_path
rm -rf .git/modules/$bundle_path
