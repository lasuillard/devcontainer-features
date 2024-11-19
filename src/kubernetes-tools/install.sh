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
if [ "$KREW_VERSION" != "none" ]; then
  if [ "$KREW_VERSION" = "latest" ]; then
    krew_dl_url="$(
      curl -s https://api.github.com/repos/kubernetes-sigs/krew/releases/latest |
        grep -Eo -m 1 "https://.+krew-linux_${ARCH}\.tar\.gz"
    )"
  else
    krew_dl_url="https://github.com/kubernetes-sigs/krew/releases/download/${KREW_VERSION}/krew-linux_${ARCH}.tar.gz"
  fi

  echo "Installing Krew from $krew_dl_url"
  (
    set -x
    cd "$(mktemp -d)" &&
      KREW="krew-linux_${ARCH}" &&
      curl -fsSLO "$krew_dl_url" &&
      tar zxvf "${KREW}.tar.gz" &&
      mv ./"${KREW}" /usr/local/bin/krew &&
      chmod +x /usr/local/bin/krew &&
      sudo su "$_REMOTE_USER" -c 'krew install krew && echo '\''export PATH="${PATH}:${HOME}/.krew/bin"'\'' >> ~/.bashrc'
  )
fi

# K9s
# ----------------------------------------------------------------------------
if [ "$K9S_VERSION" != "none" ]; then
  if [ "$K9S_VERSION" = "latest" ]; then
    k9s_dl_url="$(
      curl -s https://api.github.com/repos/derailed/k9s/releases/latest |
        grep -Eo -m 1 "https://.+k9s_linux_${ARCH}\.deb"
    )"
  else
    k9s_dl_url="https://github.com/derailed/k9s/releases/download/${K9S_VERSION}/k9s_linux_${ARCH}.deb"
  fi

  echo "Downloading K9s from $k9s_dl_url"
  curl -L --output /tmp/k9s.deb "$k9s_dl_url" &&
    dpkg --install /tmp/k9s.deb &&
    rm -f /tmp/k9s.deb
fi

# Helm
# ----------------------------------------------------------------------------
if [ "$HELM_VERSION" != "none" ]; then
  HELM_VERSION=$([ "$HELM_VERSION" = "latest" ] && echo '' || echo "$HELM_VERSION")

  echo "Installing Helm $HELM_VERSION"
  curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 |
    DESIRED_VERSION="$HELM_VERSION" bash
fi
