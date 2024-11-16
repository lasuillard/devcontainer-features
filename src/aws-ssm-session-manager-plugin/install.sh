#!/bin/sh

set -e

ARCH="$(dpkg --print-architecture)"

if ! command -v curl; then
  echo "Installing curl"
  apt-get update && apt-get install -y curl
fi

case $ARCH in
amd64)
  download_url='https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb'
  ;;
arm64)
  download_url='https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_arm64/session-manager-plugin.deb'
  ;;
*)
  echo "Unsupported architecture: $ARCH"
  exit 1
  ;;
esac

echo "Installing plugin from $download_url"

curl -sL "$download_url" -o /tmp/session-manager-plugin.deb &&
  dpkg -i /tmp/session-manager-plugin.deb &&
  rm /tmp/session-manager-plugin.deb
