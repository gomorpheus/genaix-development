#!/bin/bash
sudo snap remove firefox
sudo apt remove -y firefox
sudo add-apt-repository -y ppa:mozillateam/ppa

FILE="/etc/apt/preferences.d/mozillateamppa"
set -e
/bin/cat <<EOM >/tmp/mozillateamppa
Package: firefox*
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
EOM

sudo mv /tmp/mozillateamppa $FILE

sudo apt update
sudo apt install -y firefox


