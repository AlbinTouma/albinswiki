#!/bin/bash


fswatch -r .

    # Only proceed if there are changes to commit
if [ "$(git status --porcelain)" ]; then
    git add .
    git commit -m "Auto commit on change"
    git push
    break
fi

exit
