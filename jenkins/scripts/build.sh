#!/usr/bin/env sh

npm install
npm install -g gitbook-cli
gitbook install
gitbook build
