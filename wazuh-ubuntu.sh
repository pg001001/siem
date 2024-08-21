#!/bin/bash

# Update the system
sudo apt update && sudo apt upgrade -y

# Install dependencies
sudo apt install -y curl apt-transport-https lsb-release gnupg2 software-properties-common

# Add the Elasticsearch GPG key
curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg

# Add the Elasticsearch repository
echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-8.x.list

# Update the package list
sudo apt update

# Install Elasticsearch, Logstash, and Kibana
sudo apt install -y elasticsearch logstash kibana

# Start and enable Elasticsearch
sudo systemctl enable --now elasticsearch
sudo systemctl start elasticsearch

# Wait for Elasticsearch to start
sleep 30

# Start and enable Kibana
sudo systemctl enable --now kibana
sudo systemctl start kibana

# Start and enable Logstash
sudo systemctl enable --now logstash
sudo systemctl start logstash

# Install Wazuh
curl -s https://packages.wazuh.com/4.8/wazuh-install.sh -o wazuh-install.sh
chmod +x wazuh-install.sh
sudo ./wazuh-install.sh -a

# Enable and start Wazuh Manager service
sudo systemctl enable wazuh-manager
sudo systemctl start wazuh-manager

# Enable and start Filebeat
sudo systemctl enable filebeat
sudo systemctl start filebeat

# Restart Kibana to apply Wazuh plugin configuration
sudo systemctl restart kibana

echo "Wazuh and ELK Stack installation is complete!"
