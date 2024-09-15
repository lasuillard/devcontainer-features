#!/bin/bash

set -e

# shellcheck source=/dev/null
source dev-container-features-test-lib

check "verify Java installation" java --version | grep -Eo 'openjdk .+$'
check "verify OpenAPI Generator CLI installation" openapi-generator-cli --version | grep -Eo '^openapi-generator-cli .+$'

reportResults
