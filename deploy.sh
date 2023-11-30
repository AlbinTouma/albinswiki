#!/bin/bash

TOKEN=$(cat ~/githubtoken.txt)
LOG_FILE=deploy_log.txt

fswatch -r .

# Only proceed if there are changes to commit
if [ "$(git status --porcelain)" ]; then
    echo "Changes detected. Committing and pushing..." >> "$LOG_FILE"

    export GIT_ASKPASS=<(echo "$TOKEN")
    git add .
    git commit -m "Auto commit on change"
    git push origin main

    unset GIT_ASKPASS

    echo "Changes committed and pushed successfully." >> "$LOG_FILE"
else
    echo "No changes detected. Exiting." >> "$LOG_FILE"
fi

exit

