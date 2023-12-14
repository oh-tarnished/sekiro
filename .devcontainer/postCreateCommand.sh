#!/bin/bash

# This script is designed for setting up developer tools, including configuring access permissions
# and creating a .netrc file for GitHub authentication.
# More about it, Docs : https://containers.dev/implementors/json_reference

# 'set -e pipefail' ensures that the script will stop on any errors and properly handle failed pipelines.
set -e pipefail

# Print a header message to indicate the start of the setup process.
printf "=====< \033[1;34m:: Setting Up Development Setup ::\033[0m >=====\n"

git config --global --add safe.directory /workspaces/testflight

# Adding permissions for the 'developer' user to access the .cache directory.
# This command changes the owner of the ~/.cache directory to the 'developer' user.
printf "\n :: Adding permissions for developer to access .cache :: \n"
sudo chown -R developer:developer ~/.cache
printf "\n └── Done 💿\n"

if [[ "$(cat .devcontainer/host)" == "Darwin" ]]; then
   printf "\n :: Setting Permissions to Docker :: "
   sudo chown -R developer:developer /var/run/docker.sock
   rm -rf ~/.docker/config.json
   printf "\n └── Done 🔌\n"
fi

# If you need more permissions then you can add like this for example:
# `sudo chown -R developer:developer ~/.cache ~/.config`

echo ""
# Creating a .netrc file for storing GitHub credentials.
# If a .netrc file already exists, it is removed to ensure a clean setup.
# The script then sources GitHub credentials from the .devcontainer/gh-info file.
# Finally, it writes the GitHub machine, login, and password information to the .netrc file.
printf " :: Creating .netrc file :: \n"
[ -e ~/.netrc ] && rm ~/.netrc
. ./.devcontainer/gh-info
printf "machine github.com login $GH_USER password $GH_TOKEN\n" >> ~/.netrc
printf "\n └── Done 🚀\n"
printf " :: Setting up pre-commit-hooks file :: \n"
pre-commit install
pip3 install black isort flake8
printf "\n └── Done ⚡️\n"
# Print an empty line at the end for better readability in the console output.
echo ""
