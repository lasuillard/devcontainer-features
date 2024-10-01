#!/bin/bash

set -e

# shellcheck source=/dev/null
source dev-container-features-test-lib

check "verify session manager plugin installation" session-manager-plugin --version | grep -E '[0-9\.]+'

reportResults
