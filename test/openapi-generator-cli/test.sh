#!/bin/bash

set -e

# shellcheck source=/dev/null
source dev-container-features-test-lib

check "can be installed even java not installed" openapi-generator-cli --version 2>&1 | grep 'java: not found'

reportResults
