#!/bin/bash

git submodule foreach 'git pull --recurse-submodules origin master'
git add vim/bundle
git add special
git commit -m "Updated all bundles"
