#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")/.."

echo "Checking required files..."

required_files=(
    "README.md"
    "app/app.sh"
    "scripts/lint.sh"
    "scripts/build.sh"
    "tests/test.sh"
    ".github/workflows/ci.yml"
    "Dockerfile"
    "compose.yaml"
    ".dockerignore"
    "grade.sh"
)

for file in "${required_files[@]}"; do
    if [[ ! -f "$file" ]]; then
        echo "MISSING: $file"
        exit 1
    fi
done

echo "All required files exist."

echo "Checking Bash syntax..."

for script in app/*.sh scripts/*.sh tests/*.sh; do
    bash -n "$script"
done

echo "All Bash syntax checks passed!"
