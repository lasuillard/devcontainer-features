#!/bin/bash

set -e

# shellcheck source=/dev/null
source dev-container-features-test-lib

check "verify kubectl installation" kubectl version --client | grep 'Client Version: v1.31.1'
check "verify Krew installation" krew version | grep -E 'GitTag\s+v0\.4\.3'
check "verify k9s installation" k9s version --short | grep -E 'Version\s+v0\.32\.4'
check "verify Helm installation" helm version --short | grep 'v3.16.2'

reportResults
