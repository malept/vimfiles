#!/bin/bash

git submodule foreach 'git fetch --recurse-submodules origin'
git submodule update --recursive
git add vim/bundle
git add special
git commit -m "Update all bundles"
