#!/bin/bash

git submodule update --remote --recursive
git add vim/bundle
git add special
git commit -m "Update all bundles"
git submodule update --recursive --init
