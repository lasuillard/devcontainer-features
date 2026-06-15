#!/bin/bash

set -o errexit

# shellcheck source=/dev/null
source dev-container-features-test-lib

check "verify Java installation" java --version | grep -E 'openjdk .+$'
check "verify OpenAPI Generator CLI installation" openapi-generator-cli --version | grep -E '^openapi-generator-cli .+$'

reportResults
