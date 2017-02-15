#!/bin/bash

BRANCH="${1}"
MSG="${2}"

if [[ -z "${BRANCH}" ]]; then echo "gitit BRANCH-NAME COMMIT-MESSAGE"; exit 1; fi
if [[ -z "${MSG}" ]]; then echo "gitit BRANCH-NAME COMMIT-MESSAGE"; exit 1; fi
if [[ "${MSG}" = "RANDOM" ]]; then MSG=$(echo "$(curl -s http://whatthecommit.com/index.txt)"); fi

git pull origin "${BRANCH}"
git add *
git commit -am "${MSG}"
git push origin "${BRANCH}"
