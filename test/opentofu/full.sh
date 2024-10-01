#!/bin/bash

set -e

# shellcheck source=/dev/null
source dev-container-features-test-lib

check "verify OpenTofu installation" tofu -version | grep -E '^OpenTofu v.+$'
check "verify Terragrunt installation" terragrunt --version | grep -E '^terragrunt version v.+$'
check "verify terraform-docs installation" terraform-docs --version | grep -E '^terraform-docs version v.+ .+ linux/.+$'
check "terraform is opentofu" terraform -version | grep -E '^OpenTofu v.+$'

reportResults
