#!/bin/sh

set -e

ARCH=$(uname -m)

echo "Preparing to download plugin for $ARCH"

case $ARCH in
    x86_64)
        download_url='https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb'
        ;;
    i386 | i686)
        download_url='https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_32bit/session-manager-plugin.deb'
        ;;
    arm64)
        download_url='https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_arm64/session-manager-plugin.deb'
        ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

echo "Downloading plugin from $download_url"

apt-get update && apt-get install -y curl

curl -sL "$download_url" -o /tmp/session-manager-plugin.deb

echo "Installing plugin"

dpkg -i /tmp/session-manager-plugin.deb
rm /tmp/session-manager-plugin.deb
