#!/bin/sh

# Build image using https://github.com/raspberrypi/pi-gen-micro
# NOTE: This works only on arm64 hosts

set -e

# Clone the pi-gen-micro repository
git clone https://github.com/raspberrypi/pi-gen-micro.git
cd pi-gen-micro

# Build the package
debuild -uc -us

# Install the built package (adjust version/arch if needed)
DEB_PKG=$(ls ../pi-gen-micro_*_arm64.deb | head -n 1)
# sudo dpkg -i "$DEB_PKG"
sudo dpkg --force-depends -i "$DEB_PKG"

# Create an image using pi-gen-micro (example: fastboot configuration)
WORKDIR=$(mktemp -d)
cd "$WORKDIR"
sudo pi-gen-micro fastboot
cd -

echo "Image build complete! Check the $WORKDIR directory for output."
