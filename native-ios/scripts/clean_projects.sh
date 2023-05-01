#!/bin/zsh

set -euo pipefail

projects=(`find . -name project.pbxproj`)

for project in $projects
do
    python3 ./scripts/xUnique.py -sp $project > /dev/null
done
