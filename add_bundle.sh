#!/bin/bash

URL="$1"

bundle=$(basename "$URL" .git)

git submodule add "$URL" vim/bundle/$bundle
git commit -m "Added the $bundle bundle"
