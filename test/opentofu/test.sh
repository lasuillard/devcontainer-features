#!/bin/bash

set -e

# shellcheck source=/dev/null
source dev-container-features-test-lib

check "verify OpenTofu installation" tofu -version | grep -Eo '^OpenTofu v.+$'
check "do not install Terragrunt" command terragrunt 2>&1 | grep 'terragrunt: command not found'
check "do not install terraform-docs" command terraform-docs 2>&1 | grep 'terraform-docs: command not found'
check "terraform is terraform" command terraform 2>&1 | grep 'terraform: command not found'

reportResults
