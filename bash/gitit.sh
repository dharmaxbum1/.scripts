#!/bin/bash

if [[ -z "${1}" ]]; then echo "gitit BRANCH-NAME COMMIT-MESSAGE"; exit 1; fi
if [[ -z "${2}" ]]; then echo "gitit BRANCH-NAME COMMIT-MESSAGE"; exit 1; fi

BRANCH="${1}"
MSG="${2}"

git pull origin "${BRANCH}"
git add *
git commit -am "${MSG}"
git push origin "${BRANCH}"
