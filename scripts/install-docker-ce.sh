#!/bin/bash
set -e
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Cleanly reinstall docker-ce.
set +e
sudo apt-get purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
set -e
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
set +e
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
set -e
sudo apt autoremove -y
sudo apt autoclean -y
sudo apt install -y docker-ce
set +e
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
set -e
echo "====="
echo "Please logout and log back in again to inherit changes to user's groups.
echo "====="
