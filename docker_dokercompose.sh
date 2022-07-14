#!/bin/bash
sudo apt update && sudo apt upgrade -y && sudo apt install curl vim wget gnupg apt-transport-https lsb-release ca-certificates socat unzip -y
sudo apt autoremove -y
sudo curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh
sudo curl -L "https://github.com/docker/compose/releases/download/v2.6.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
systemctl enable docker
