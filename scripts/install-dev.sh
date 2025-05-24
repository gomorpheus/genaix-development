#!/bin/bash
set -e
sudo apt install -y curl ssh net-tools build-essential libgeos-dev virt-manager ack htop
install-postgres-client16.sh
install-python3.sh
install-firefox.sh
install-docker-ce.sh
