#!/bin/bash

set -e

# shellcheck source=/dev/null
source dev-container-features-test-lib

check "verify kubectl installation" kubectl version --client | grep -E 'Client Version: v.+'
check "do not install Krew" command krew 2>&1 | grep 'krew: command not found'
check "do not install k9s" command k9s 2>&1 | grep 'k9s: command not found'
check "do not install Helm" command helm 2>&1 | grep 'helm: command not found'

reportResults
