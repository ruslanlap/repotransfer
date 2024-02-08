#!/bin/bash

set -e

# ANSI color codes
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)

printf "${GREEN}🌟 Script for Fast Repository Cloning and Pushing to a New Repository...${RESET}\n"

read -p "${YELLOW}📥 Enter source repository URL: ${RESET}" source_repo
read -p "${YELLOW}🚀 Enter destination repository URL: ${RESET}" dest_repo

# Validate user input
if [[ ! $source_repo =~ ^https?:// ]]; then
    printf "${YELLOW}⚠️ Invalid source repository URL. Please provide a valid URL.${RESET}\n"
    exit 1
fi

if [[ ! $dest_repo =~ ^https?:// ]]; then
    printf "${YELLOW}⚠️ Invalid destination repository URL. Please provide a valid URL.${RESET}\n"
    exit 1
fi

printf "${GREEN}🔍 Cloning source repository...${RESET}\n"

# Display a spinner while cloning
function display_spinner() {
    local pid=$!
    local delay=0.1
    local spin='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'

    while ps -p $pid >/dev/null; do
        local temp=${spin#?}
        printf " [%c] " "$spin"
        local spin=$temp${spin%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done

    printf "    \b\b\b\b"
}

git clone "$source_repo" &

display_spinner

repo_name=$(basename "$source_repo" .git)
cd "$repo_name"

# Check the default branch name
default_branch=$(git symbolic-ref -q HEAD)
default_branch=${default_branch##refs/heads/}
default_branch=${default_branch:-HEAD}

printf "${GREEN}🔄 Updating remote to point to the destination repository...${RESET}\n"
git remote set-url origin "$dest_repo"

# Prompt the user to select a branch
read -p "${YELLOW}🌟 Select a branch to push to the destination repository (default: $default_branch): ${RESET}" branch
branch=${branch:-$default_branch}

printf "${GREEN}🚀 Pushing changes to the destination repository...${RESET}\n"

# Display a progress bar while pushing
function display_progress_bar() {
    local progress=$1
    local total=$2
    local percentage=$((progress * 100 / total))
    local length=$((progress * 20 / total))
    local bar=$(printf "%-${length}s" "█")
    printf "\r[${bar// /█}${bar:20}] - $percentage%%"
}

git push -u origin "$branch" &

total_commits=$(git rev-list --count HEAD)
current_commit=0

while ps -p $! >/dev/null; do
    current_commit=$(git rev-list --count HEAD)
    display_progress_bar $current_commit $total_commits
    sleep 1
done

if [ $? -eq 0 ]; then
    printf "\n${GREEN}✅ Repository cloned and pushed successfully!${RESET}\n"
else
    printf "\n${YELLOW}⚠️ Failed to push changes to the destination repository. Please check the setup.${RESET}\n"
    exit 1
fi

# Log the actions performed
log_file="repository_setup.log"
echo "$(date '+%Y-%m-%d %H:%M:%S') - Repository cloned and pushed successfully!" >> "$log_file"

# Thank the user at the end
printf "${GREEN}🎉 Repository cloned and pushed successfully! Thank you!${RESET}\n"

