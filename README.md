# Sekiro CLI Documentation

## Overview

Sekiro CLI is a powerful tool designed to streamline project setup, configuration, and secret management. This document outlines the available commands and their functionalities.

## Table of Contents

- [Sekiro CLI Documentation](#sekiro-cli-documentation)
  * [Overview](#overview)
  * [Table of Contents](#table-of-contents)
  * [Commands](#commands)
    + [`init`](#-init-)
    + [`configure`](#-configure-)
    + [`secrets`](#-secrets-)

## Commands

### `init`

The `init` command sets up a new project with Bazel, providing templates for various programming languages and necessary build configurations.

**Usage:**

- `sekiro init`: Initializes a new project with a Text-based User Interface (TUI) for template selection.
- `sekiro init <language>`: Directly creates a project in the specified language, bypassing the TUI.
- `sekiro init --no-bazel`: Initializes a project without Bazel integration. This option is not recommended as it skips essential build setup.
- `sekiro init --no-buildkite`: Initializes a project without integrating Buildkite. This option is not recommended as it omits continuous integration setup.

### `configure`

The `configure` command ensures that all necessary dependencies are installed, allowing projects to run smoothly.

**Usage:**

- `sekiro configure`: Checks and installs all required dependencies for the project.
- `sekiro configure --tools=aws,gcloud`: Installs only the specified tools (e.g., AWS CLI, Google Cloud CLI).
- `sekiro configure validate`: Validates the existing environment setup, identifying any missing dependencies and recommending solutions for any detected issues.

### `secrets`

The `secrets` command manages environment secrets for projects, including retrieval, creation, updating, and deletion.

**Usage:**

- `secrets init`: Sets up a `.env` file for the current project based on the `sekiro.config.toml` file or project context.
- `secrets get <project_name> <secret1> <secret2> ...`: Retrieves specified secrets from AWS for the given project. If `<project_name>` is omitted, the command refers to the `sekiro.config.toml` file for project details.
- `secrets create <project_name> secret1=value1 secret2=value2`: Creates secrets with the specified data for the given project. This command requires appropriate permissions.
- `secrets update <project_name> secret1=value1 secret2=value2`: Updates existing secrets for the given project with the provided data.
- `secrets delete <project_name> <secret1> <secret2> ...`: Deletes the specified secrets from the given project.

---

> **Note**: It is essential to have the necessary permissions and configurations in place when using the Sekiro CLI, particularly for operations that interact with external services like AWS. Ensure that your `sekiro.config.toml` is correctly set up and updated for seamless operation of these commands.


