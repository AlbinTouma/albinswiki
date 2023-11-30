#!/bin/bash

TOKEN=$(cat ~/githubtoken.txt)
LOG_FILE=deploy_log.txt

# Update the remote URL with the token
git remote set-url origin "https://AlbinTouma:$TOKEN@github.com/AlbinTouma/albinswiki.git"

fswatch -r .

# Only proceed if there are changes to commit
if [ "$(git status --porcelain)" ]; then
    echo "Changes detected. Committing and pushing..." >> "$LOG_FILE"

    git add .
    git commit -m "Auto commit on change"
    git push origin main

    echo "Changes committed and pushed successfully." >> "$LOG_FILE"
else
    echo "No changes detected. Exiting." >> "$LOG_FILE"
fi

exit

