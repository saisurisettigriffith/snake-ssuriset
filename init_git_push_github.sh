#!/bin/bash

# Check if we're already in a git repository
if [ -d ".git" ]; then
    echo "Git repository already exists."
    # Remove existing remote 'origin' if it exists
    if git remote | grep -q origin; then
        echo "Removing existing remote 'origin'"
        git remote remove origin
    fi
else
    # Initialize a new git repository if not already initialized
    git init
fi

# Append files to .gitignore (using >> so we don't overwrite previous entries)
echo "init_git_push_github.sh" >> .gitignore
echo "ssuriset-twitter-clone-961e2fdf5a9a.json" >> .gitignore

# Add all files to staging
git add .

# Commit the files
git commit -m "Initial commit"

# Get the name of the current directory for the repository name
REPO_NAME="${PWD##*/}"

# Create a new repository on GitHub, set it as the origin, and push the initial commit
gh repo create "$REPO_NAME" --public --source=. --remote=origin --push
