#!/bin/bash

# A script that auto updates my blog site

# I do not know how to make this script work through cron :(

# Add all my path just to make sure it will work
PATH=/home/$USER/gems/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
GEM_HOME=/home/$USER/gems           # Add gem home path 
gitdir="/home/$USER/nobodys-blog"

# Go to the blog's git directory and check if there is any changes
cd $gitdir
git remote update
count=$(git rev-list HEAD...@{u} --count)

if [[ $count == '0' ]]; then
    # If there are 0 changes do nothing
    printf "[$(date +"%Y-%m-%d-%T")] No changes detected. Nothing to do.\n----------------------\n"
else
    # If there are any changes then pull them and execute the rest only on success of the previous command
    git pull
    bundle exec jekyll build && cp -r $gitdir/_site/* /var/www/html/ && printf "Everything DONE!\n-------------------------\n"
fi

