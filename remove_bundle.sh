#!/bin/bash
# Based off of: http://stackoverflow.com/q/1260748

BUNDLE="$1"

if test -z "$BUNDLE"; then
    echo "Usage: $0 BUNDLE_NAME" 1>&2
    exit 1
fi

bundle_path=vim/bundle/$BUNDLE

for f in .git/config .gitmodules; do
    git config -f $f --remove-section submodule.$bundle_path
done
git add .gitmodules
git rm --cached "$bundle_path"
git commit -m "Removed the $BUNDLE bundle"
rm -rf $bundle_path
rm -rf .git/modules/$bundle_path
