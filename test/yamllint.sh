#!/usr/bin/env bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

changedfiles=$(git show --pretty="" --no-commit-id  --diff-filter=AMRC  --name-only `git log --format="%H" -n 1` | grep -e .yml$  | tr -s "\n" " " | sed 's/%$//')
echo $changedfiles
if [ ! -z $changedfiles ]; then echo $changedfiles | xargs yamllint -c ./test/yamllint; else echo "${GREEN}No yaml file changes${NC}"; fi
