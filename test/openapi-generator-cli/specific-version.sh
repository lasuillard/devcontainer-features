#!/bin/bash

set -e

# shellcheck source=/dev/null
source dev-container-features-test-lib

check "verify OpenAPI Generator CLI installation" openapi-generator-cli --version | grep -E '^openapi-generator-cli 7\.8\.0$'

reportResults
