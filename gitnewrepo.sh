#!/bin/bash

set -e

# ANSI color codes
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
RED=$(tput setaf 1)
RESET=$(tput sgr0)

# Check if git is installed
if ! command -v git &> /dev/null
then
    printf "${RED}❌ Git is not installed. Please install git and try again.${RESET}\n"
    exit
fi

printf "${GREEN}🌟 Script for Fast Repository Cloning and Pushing to a New Repository...${RESET}\n"

read -p "${YELLOW}📥 Enter source repository URL: ${RESET}" source_repo
read -p "${YELLOW}🚀 Enter destination repository URL: ${RESET}" dest_repo

# Check if the URLs are valid
if [[ ! "$source_repo" =~ ^https?:// ]] && [[ ! "$source_repo" =~ ^git@ ]]; then
    printf "${RED}❌ Invalid source repository URL. Please enter a valid URL and try again.${RESET}\n"
    exit
fi

if [[ ! "$dest_repo" =~ ^https?:// ]] && [[ ! "$dest_repo" =~ ^git@ ]]; then
    printf "${RED}❌ Invalid destination repository URL. Please enter a valid URL and try again.${RESET}\n"
    exit
fi

printf "${GREEN}🔍 Cloning source repository...${RESET}\n"
if ! git clone "$source_repo"; then
    printf "${RED}❌ Failed to clone the source repository. Please check the URL and try again.${RESET}\n"
    exit
fi

cd "$(basename "$source_repo" .git)"

# Check the default branch name
default_branch=$(git symbolic-ref -q HEAD)
default_branch=${default_branch##refs/heads/}
default_branch=${default_branch:-HEAD}

printf "${GREEN}🔄 Updating remote to point to the destination repository...${RESET}\n"
if ! git remote set-url origin "$dest_repo"; then
    printf "${RED}❌ Failed to set the new remote URL. Please check the URL and try again.${RESET}\n"
    exit
fi

printf "${GREEN}🚀 Pushing changes to the destination repository...${RESET}\n"
if ! git push -u origin "$default_branch"; then
    printf "${RED}❌ Failed to push to the destination repository. Please check the URL and try again.${RESET}\n"
    exit
fi

printf "${GREEN}✅ Repository cloned and pushed successfully!${RESET}\n"

