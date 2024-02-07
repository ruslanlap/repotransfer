#!/bin/bash

set -e

# ANSI color codes
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)

printf "${GREEN}🌟 Script for Fast Repository Cloning and Pushing to a New Repository...${RESET}\n"

read -p "${YELLOW}📥 Enter source repository URL: ${RESET}" source_repo
read -p "${YELLOW}🚀 Enter destination repository URL: ${RESET}" dest_repo

printf "${GREEN}🔍 Cloning source repository...${RESET}\n"
git clone "$source_repo"

cd "$(basename "$source_repo" .git)"

# Check the default branch name
default_branch=$(git symbolic-ref -q HEAD)
default_branch=${default_branch##refs/heads/}
default_branch=${default_branch:-HEAD}

printf "${GREEN}🔄 Updating remote to point to the destination repository...${RESET}\n"
git remote set-url origin "$dest_repo"

printf "${GREEN}🚀 Pushing changes to the destination repository...${RESET}\n"
git push -u origin "$default_branch"

printf "${GREEN}✅ Repository cloned and pushed successfully!${RESET}\n"

