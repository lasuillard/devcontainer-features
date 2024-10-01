#!/bin/bash

set -e

# shellcheck source=/dev/null
source dev-container-features-test-lib

check "verify OpenTofu installation" tofu -version | grep -Eo '^OpenTofu v.+$'
check "verify Terragrunt installation" terragrunt --version | grep -Eo '^terragrunt version v.+$'
check "verify terraform-docs installation" terraform-docs --version | grep -E '^terraform-docs version v.+ .+ linux/.+$'
check "terraform is opentofu" terraform -version | grep -Eo '^OpenTofu v.+$'

reportResults
