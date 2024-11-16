#!/bin/sh

set -e

ARCH="$(dpkg --print-architecture)"

if ! command -v curl || ! command -v gpg || ! command -v unzip; then
  echo "Installing curl, gnupg2, and unzip"
  apt-get update && apt-get install -y curl gnupg2 unzip
fi

# OpenTofu
# ----------------------------------------------------------------------------
echo "Installing OpenTofu"

curl --proto '=https' --tlsv1.2 -fsSL https://get.opentofu.org/install-opentofu.sh |
  sh -s -- --install-method standalone --opentofu-version "$OPENTOFU_VERSION"

# Terragrunt
# ----------------------------------------------------------------------------
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

# terraform-docs
# ----------------------------------------------------------------------------
if [ "$INSTALL_TERRAFORM_DOCS" != "none" ]; then
  if [ "$INSTALL_TERRAFORM_DOCS" = "latest" ]; then
    tfdocs_dl_url="$(
      curl -s https://api.github.com/repos/terraform-docs/terraform-docs/releases/latest |
        grep -Eo -m 1 "https://.+?terraform-docs-v.+-linux-${ARCH}\.tar\.gz"
    )"
  else
    tfdocs_dl_url="https://github.com/terraform-docs/terraform-docs/releases/download/v${INSTALL_TERRAFORM_DOCS}/terraform-docs-v${INSTALL_TERRAFORM_DOCS}-linux-${ARCH}.tar.gz"
  fi

  echo "Downloading terraform-docs from $tfdocs_dl_url"
  curl -L "$tfdocs_dl_url" --output /tmp/terraform-docs.tar.gz &&
    tar -xzf /tmp/terraform-docs.tar.gz -C /tmp/ terraform-docs &&
    mv /tmp/terraform-docs /usr/bin/ &&
    chmod +x /usr/bin/terraform-docs &&
    rm /tmp/terraform-docs.tar.gz
fi

# Terraform symlink to OpenTofu
# ----------------------------------------------------------------------------
if [ "$TERRAFORM_IS_TOFU" = "true" ]; then
  echo "Creating symlink for terraform to tofu"
  if command -v terraform; then
    echo "Command terraform already exists. Skipping symlink creation"
  else
    ln -s "$(which tofu)" /usr/bin/terraform
  fi
fi
