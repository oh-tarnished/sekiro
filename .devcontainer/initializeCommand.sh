#!/bin/bash

# This script is designed for initializing certain developer tools and settings.
# It performs operations related to Docker and GitHub configuration.
# More about it, Docs : https://containers.dev/implementors/json_reference

# 'set -e pipefail' enables the script to fail on error and handle errors in pipelines.
set -e pipefail

# Print a header message for the initialization process.
printf "=====< \033[1;34m:: Initializing Developer Tools ::\033[0m >=====\n"

printf "\n :: Getting Host Type :: "
echo $(uname -s) > .devcontainer/host
printf "\n └── Done 🖥️\n"

# Getting Docker group ID:
# This section is executed only if the script is running on a Linux system.
# It retrieves the group ID of the 'docker' group and writes it to a file.
if [[ "$(uname -s)" == "Linux" ]]; then
    printf "\n :: Getting docker group :: "
    echo $(getent group docker | cut -d: -f3) > .devcontainer/docker-host-gid
    printf "\n └── Done 🐳\n"
fi

# Writing GitHub token and user to a file:
# This part of the script fetches GitHub credentials using the GitHub CLI.
# It then writes these credentials to a file for use by postCreateCommand.sh.
printf "\n :: Getting GitHub credentials from GitHub CLI :: "
echo "export GH_TOKEN=$(gh auth token)" > .devcontainer/gh-info
echo "export GH_USER=$(awk '/github.com:/{getline; print $2}' ~/.config/gh/hosts.yml)" >> .devcontainer/gh-info
printf "\n └── Done 🔧\n"


# Writing GCloud token to a file:
# This part fo the script fetchs Google Cloud credentials using gcloud CLI.
# Required for bazel to pull private registries
printf "\n :: Getting Google Cloud credentials from gcloud CLI :: "
GCLOUD_TOKEN="$(gcloud auth print-access-token)"
printf "export GCLOUD_TOKEN=$GCLOUD_TOKEN" > .devcontainer/gcloud-info
printf "\n └── Done ☁️\n"

# Print a footer message indicating the end of the initialization process.
printf "\n\n=====< \033[1;34m:: Exiting ::\033[0m >=====\n"
