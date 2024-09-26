#!/bin/sh

set -e

ARCH=$(dpkg --print-architecture)

echo "Preparing to download plugin for $ARCH"

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

if ! command -v curl; then
  echo "curl is not installed. Installing curl"
  apt-get update && apt-get install -y curl
fi

echo "Downloading plugin from $download_url"

curl -sL "$download_url" -o /tmp/session-manager-plugin.deb

echo "Installing plugin"

dpkg -i /tmp/session-manager-plugin.deb
rm /tmp/session-manager-plugin.deb
