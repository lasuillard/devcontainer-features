#!/bin/bash

set -e

# shellcheck source=/dev/null
source dev-container-features-test-lib

check "verify kubectl installation" kubectl version --client | grep -E 'Client Version: v.+'
check "verify Krew installation" krew version | grep -E 'GitTag\s+v.+'
check "verify k9s installation" k9s version --short | grep -E 'Version\s+v.+'
check "verify Helm installation" helm version --short | grep 'v.+'

reportResults
