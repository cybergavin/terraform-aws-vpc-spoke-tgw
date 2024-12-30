#!/bin/bash

# Check if terraform-docs is installed
if ! command -v terraform-docs &> /dev/null; then
    echo "Error: terraform-docs is not installed or not in PATH"
    exit 1
fi

# Get the git repository root directory
REPO_ROOT=$(git rev-parse --show-toplevel)

# Generate docs only if .tf files in current directory are staged and README.md exists with markers
if git diff --name-only --cached -- "${REPO_ROOT}/*.tf" &> /dev/null && \
   [ -f "${REPO_ROOT}/README.md" ] && \
   grep -q "<!-- BEGIN_TF_DOCS -->" "${REPO_ROOT}/README.md"; then
    terraform-docs "${REPO_ROOT}"
fi