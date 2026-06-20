_default:
    just --list

# Install deps and tools
install:

# Update deps and tools
update:
    pre-commit autoupdate

alias up := update

# =============================================================================
# Development
# =============================================================================

# Run all checks (lint and test for A SINGLE FEATURE as a smoke test)
ci: (format "yes") lint (test "opentofu")

# Autoformat code
[arg("check", long="check", value="yes")]
format check="no":
    git ls-files --cached --others --exclude-standard '*.sh' \
        | xargs shfmt {{ if check == "yes" { "--list" } else { "--list --write" } }}

alias fmt := format

# Run all linters
lint:
    git ls-files --cached --others --exclude-standard '*.sh' \
        | tee /dev/tty \
        | xargs shellcheck

# Test a feature
test feature:
    devcontainer features test --features '{{ feature }}'

# =============================================================================
# Utility
# =============================================================================

# Remove temporary files
clean:
    find . -path '*.log*' -delete
