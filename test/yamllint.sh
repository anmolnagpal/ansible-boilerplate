#!/usr/bin/env bash

changedfiles=$(git show --pretty="" --no-commit-id  --diff-filter=AMRC  --name-only `git log --format="%H" -n 1` | grep -e .yml$  | tr -s "\n" " " | sed 's/%$//')
echo $changedfiles
if [ ! -z $changedfiles ]; then echo $changedfiles | xargs yamllint -c ./test/yamllint; else echo "No yaml file changes"; fi
