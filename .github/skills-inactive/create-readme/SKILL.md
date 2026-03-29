---
name: create-readme
description: 'Create a comprehensive, well-structured README.md for a project. Use this skill whenever the user asks to write, generate, or improve a README — even if they just say "add a readme", "document this project", or "create project documentation". Also trigger when the user wants to make a project more presentable on GitHub.'
---

# Create README.md

Generate an appealing, informative README that helps someone understand and use the project in under 2 minutes.

## Workflow

1. **Analyze the project** — scan the workspace to understand: languages, frameworks, project structure, build tools, entry points, and any existing docs.
2. **Identify a logo/icon** — if there's a project logo or icon in the repo, use it in the header.
3. **Write the README** — use the structure below, tailored to what the project actually contains. Skip sections that don't apply.
4. **Use GFM** — GitHub Flavored Markdown, including [admonitions](https://github.com/orgs/community/discussions/16925) where appropriate (e.g. `> [!NOTE]`, `> [!WARNING]`).

## Structure

Follow this order, omitting sections that aren't relevant:

```md
# Project Name

[One-line description of what it does]

## Overview

[2-3 paragraphs: what the project is, who it's for, why it exists.
Include a screenshot or demo GIF if available.]

## Features

[Bullet list of key capabilities]

## Prerequisites

[What the user needs installed before getting started]

## Getting Started

[Step-by-step: clone, install, configure, run]

## Usage

[Common use cases with code examples]

## Configuration

[Environment variables, config files, options]

## Project Structure

[Brief overview of key directories and files]

## Tech Stack

[Languages, frameworks, tools — as a table or list]
```

## Style guidelines

- Be concise — every sentence should earn its place. No filler paragraphs.
- Use code blocks for commands and file paths.
- Don't overuse emojis — one or two for visual structure is fine, a wall of them is not.
- Don't include LICENSE, CONTRIBUTING, or CHANGELOG sections — those have dedicated files.
- Write for someone who has never seen the project and wants to get productive fast.

## Reference READMEs

Take inspiration from the structure and tone of these:

- <https://raw.githubusercontent.com/Azure-Samples/serverless-chat-langchainjs/refs/heads/main/README.md>
- <https://raw.githubusercontent.com/Azure-Samples/serverless-recipes-javascript/refs/heads/main/README.md>
- <https://raw.githubusercontent.com/sinedied/run-on-output/refs/heads/main/README.md>
- <https://raw.githubusercontent.com/sinedied/smoke/refs/heads/main/README.md>
