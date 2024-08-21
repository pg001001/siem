#!/bin/bash

# Update system packages
echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install necessary dependencies
echo "Installing necessary dependencies..."
sudo apt install -y curl apt-transport-https lsb-release gnupg2

# Add Wazuh repository
echo "Adding Wazuh repository..."
curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | sudo gpg --dearmor -o /usr/share/keyrings/wazuh-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/wazuh-archive-keyring.gpg] https://packages.wazuh.com/4.x/apt/ stable main" | sudo tee /etc/apt/sources.list.d/wazuh.list

# Install Wazuh manager
echo "Installing Wazuh manager..."
sudo apt update
sudo apt install -y wazuh-manager

# Enable and start Wazuh manager service
echo "Enabling and starting Wazuh manager service..."
sudo systemctl daemon-reload
sudo systemctl enable wazuh-manager
sudo systemctl start wazuh-manager

# Install Wazuh API
echo "Installing Wazuh API..."
sudo apt install -y wazuh-api

# Install ELK stack (Elasticsearch, Logstash, Kibana)
echo "Installing Elasticsearch..."
curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elastic-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/elastic-archive-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-8.x.list

# Install Elasticsearch
sudo apt update
sudo apt install -y elasticsearch

# Enable and start Elasticsearch service
sudo systemctl daemon-reload
sudo systemctl enable elasticsearch
sudo systemctl start elasticsearch

# Install Logstash
echo "Installing Logstash..."
sudo apt install -y logstash

# Enable and start Logstash service
sudo systemctl enable logstash
sudo systemctl start logstash

# Install Kibana
echo "Installing Kibana..."
sudo apt install -y kibana

# Enable and start Kibana service
sudo systemctl enable kibana
sudo systemctl start kibana

# Configure Wazuh and Kibana integration
echo "Configuring Wazuh and Kibana integration..."
curl -s https://packages.wazuh.com/4.x/ui/wazuhui-install.sh -o wazuhui-install.sh
chmod +x wazuhui-install.sh
sudo ./wazuhui-install.sh -a

# Enable and start Wazuh API service
echo "Enabling and starting Wazuh API service..."
sudo systemctl enable wazuh-api
sudo systemctl start wazuh-api

# Final message
echo "Wazuh installation with ELK stack completed successfully."
echo "Access Kibana at http://<your_server_ip>:5601 and log in with the default credentials."

