#!/bin/bash

git submodule update --remote
git submodule update --recursive --init
git add vim/bundle
git add special
git commit -m "Update all bundles"
