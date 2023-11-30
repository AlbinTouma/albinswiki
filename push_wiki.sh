#!/bin/bash
#

while true; do
    inotifywait -r -e modify, create, delete ~/Documents/vimwiki
    

    echo "Enter commit message"
    read message
    git add .
    git commit -m "Updated content"
    git push origin master
done
