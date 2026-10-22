#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")/.."

IMAGE="devops-tool"

echo "Building Docker image..."
docker build -t "$IMAGE" .

echo "Smoke test: help"
docker run --rm "$IMAGE" help

echo "Smoke test: system-info"
docker run --rm "$IMAGE" system-info

echo "Smoke test: invalid command"

if docker run --rm "$IMAGE" invalid-command >/dev/null 2>&1; then
    echo "FAIL: Invalid command was accepted"
    exit 1
else
    echo "PASS: Invalid command was rejected"
fi

echo "Docker build and smoke tests completed!"
