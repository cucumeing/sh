#!/bin/bash
sudo apt update && sudo apt upgrade -y && sudo apt install curl vim wget gnupg apt-transport-https lsb-release ca-certificates socat unzip -y
sudo apt autoremove -y
sudo curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh
sudo curl -L "https://github.com/docker/compose/releases/download/v2.6.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
systemctl enable docker
mkdir -p data/docker_data/uptimekuma && cd data/docker_data/uptimekuma && touch docker-compose.yml
cat >> ~/data/docker_data/uptimekuma/docker-compose.yml << EOF
version: '3.3'

services:
  uptime-kuma:
    image: louislam/uptime-kuma:1
    container_name: uptime-kuma
    volumes:
      - ./uptime-kuma-data:/app/data
    ports:
      - 3001:3001  # <Host Port>:<Container Port>
    restart: always
EOF
docker-compose up -d
mkdir -p ~/data/docker_data/nginxproxymanager && cd ~/data/docker_data/nginxproxymanager && touch docker-compose.yml
cat >> ~/data/docker_data/nginxproxymanager/docker-compose.yml << EOF
version: "3"
services:
  app:
    image: 'jc21/nginx-proxy-manager:latest'
    restart: unless-stopped
    ports:
      - '80:80' 
      - '443:443' 
      - '81:81' 
    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt
EOF
docker-compose up -d
