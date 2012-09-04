#!/bin/bash

git submodule foreach 'git pull'
git add vim/bundle
git commit -m "Updated all bundles"
