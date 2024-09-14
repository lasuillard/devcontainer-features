#!/bin/bash

set -e

source dev-container-features-test-lib

check "verify session manager plugin installation" session-manager-plugin --version | grep -Eo '[0-9\.]+'

reportResults
