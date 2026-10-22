#!/usr/bin/env bash

set -uo pipefail

cd "$(dirname "$0")/.."

passed=0
failed=0

run_test() {
    local name="$1"
    local expected="$2"
    shift 2

    local actual=0
    "$@" >/dev/null 2>&1 || actual=$?

    if [[ "$actual" -eq "$expected" ]]; then
        echo "PASS: $name"
        ((passed+=1))
    else
        echo "FAIL: $name (expected $expected, got $actual)"
        ((failed+=1))
    fi
}

run_test "Help command" 0 ./app/app.sh help
run_test "System information" 0 ./app/app.sh system-info
run_test "Invalid command" 2 ./app/app.sh unknown
run_test "Missing hostname" 2 ./app/app.sh check-host
run_test "Valid hostname" 0 ./app/app.sh check-host localhost
run_test "Missing port" 2 ./app/app.sh check-port localhost
run_test "Non-numeric port" 2 ./app/app.sh check-port localhost abc
run_test "Out-of-range port" 2 ./app/app.sh check-port localhost 70000

echo
echo "Results: $passed passed, $failed failed"

if (( failed > 0 )); then
    exit 1
fi

exit 0
