#!/bin/bash
set -e

# Update package lists
echo "Updating package lists..."
apt-get update

# Upgrade packages
echo "Upgrading packages..."
apt-get upgrade -y

# Clean up
echo "Cleaning up..."
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Execute the command passed to the container
exec "$@"
