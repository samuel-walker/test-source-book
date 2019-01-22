#!/bin/bash
command -v node >/dev/null 2>&1 || { echo >&2 "node.js is not installed, aborting"; exit 1; }
command -v npm >/dev/null 2>&1 || { echo >&2 "npm is not installed, aborting"; exit 1; }
command -v gitbook >/dev/null 2>&1 || { echo >&2 "gitbook is not installed, aborting"; exit 1; }

gitbook install
gitbook build
gitbook serve
