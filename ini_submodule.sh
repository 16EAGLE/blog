#!/bin/sh
# run once: fist time after pull of full repo and BEFORE ./deploy.sh
git submodule update --init
cd public
git checkout master