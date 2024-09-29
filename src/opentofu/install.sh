#!/bin/sh

set -e

ARCH=$(dpkg --print-architecture)

echo "Preparing to install OpenTofu for $ARCH"

apt-get update && apt-get install -y curl gnupg2 unzip

echo "Installing OpenTofu"

curl --proto '=https' --tlsv1.2 -fsSL https://get.opentofu.org/install-opentofu.sh |
  sh -s -- --install-method standalone --opentofu-version "$OPENTOFU_VERSION"

# Terragrunt
if [ "$INSTALL_TERRAGRUNT" != "none" ]; then
  if [ "$INSTALL_TERRAGRUNT" = "latest" ]; then
    terragrunt_dl_url="$(
      curl -s https://api.github.com/repos/gruntwork-io/terragrunt/releases/latest |
        grep -Eo -m 1 "https://.+?terragrunt_linux_${ARCH}"
    )"
  else
    terragrunt_dl_url="https://github.com/gruntwork-io/terragrunt/releases/download/v${INSTALL_TERRAGRUNT}/terragrunt_linux_${ARCH}"
  fi
  echo "Downloading Terragrunt from $terragrunt_dl_url"
  curl -L "$terragrunt_dl_url" -o /usr/bin/terragrunt && chmod +x /usr/bin/terragrunt
fi

# Terraform symlink to OpenTofu
if [ "$TERRAFORM_IS_TOFU" = "true" ]; then
  echo "Creating symlink for terraform to tofu"
  if command -v terraform; then
    echo "terraform already exists. Skipping symlink creation"
  else
    ln -s "$(which tofu)" /usr/bin/terraform
  fi
fi
