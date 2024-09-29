#!/bin/bash

set -e

# shellcheck source=/dev/null
source dev-container-features-test-lib

check "verify OpenTofu installation" tofu -version | grep -o 'OpenTofu v1.7.3'
check "verify Terragrunt installation" terragrunt --version | grep -o 'terragrunt version v0.67.13'

reportResults
