#!/bin/bash
#

while true; do
    inotifywait -r -e modify, create, delete .
    
    git add .
    git commit -m "Updated content"
    git push origin master
done
