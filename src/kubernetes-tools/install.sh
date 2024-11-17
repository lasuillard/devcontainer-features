#!/bin/sh

set -e

ARCH=$(dpkg --print-architecture)

if ! command -v curl || ! command -v git; then
  echo "Installing curl, and git"
  apt-get update && apt-get install -y curl git
fi

# kubectl
# ----------------------------------------------------------------------------
echo "Installing kubectl"

if [ "$KUBECTL_VERSION" = "latest" ]; then
  KUBECTL_VERSION="$(curl -L -s https://dl.k8s.io/release/stable.txt)"
fi

curl -L --output /usr/bin/kubectl "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${ARCH}/kubectl" &&
  chmod +x /usr/bin/kubectl

# Krew
# ----------------------------------------------------------------------------
if [ "$INSTALL_KREW" != "none" ]; then
  if [ "$INSTALL_KREW" = "latest" ]; then
    krew_dl_url="$(
      curl -s https://api.github.com/repos/kubernetes-sigs/krew/releases/latest |
        grep -Eo -m 1 "https://.+krew-linux_${ARCH}\.tar\.gz"
    )"
  else
    krew_dl_url="https://github.com/kubernetes-sigs/krew/releases/download/${INSTALL_KREW}/krew-linux_${ARCH}.tar.gz"
  fi

  echo "Installing Krew from $krew_dl_url"
  (
    set -x
    cd "$(mktemp -d)" &&
      KREW="krew-linux_${ARCH}" &&
      curl -fsSLO "$krew_dl_url" &&
      tar zxvf "${KREW}.tar.gz" &&
      mv ./"${KREW}" /usr/local/bin/krew
  )
fi

# K9s
# ----------------------------------------------------------------------------
if [ "$INSTALL_K9S" != "none" ]; then
  if [ "$INSTALL_K9S" = "latest" ]; then
    k9s_dl_url="$(
      curl -s https://api.github.com/repos/derailed/k9s/releases/latest |
        grep -Eo -m 1 "https://.+k9s_linux_${ARCH}\.deb"
    )"
  else
    k9s_dl_url="https://github.com/derailed/k9s/releases/download/${INSTALL_K9S}/k9s_linux_${ARCH}.deb"
  fi

  echo "Downloading K9s from $k9s_dl_url"
  curl -L --output /tmp/k9s.deb "$k9s_dl_url" &&
    dpkg --install /tmp/k9s.deb &&
    rm -f /tmp/k9s.deb
fi

# Helm
# ----------------------------------------------------------------------------
if [ "$INSTALL_HELM" != "none" ]; then
  helm_version=$([ "$INSTALL_HELM" = "latest" ] && echo '' || echo "$INSTALL_HELM")

  echo "Installing Helm $helm_version"
  curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 |
    DESIRED_VERSION="$helm_version" bash
fi
