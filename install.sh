# Update the system
sudo apt update && sudo apt upgrade -y

curl -sO https://packages.wazuh.com/4.8/wazuh-install.sh 
sudo bash ./wazuh-install.sh -a -o

wget https://packages.wazuh.com/integrations/elastic/4.x-8.x/dashboards/wz-es-4.x-8.x-dashboards.ndjson

sudo tar -O -xvf wazuh-install-files.tar wazuh-install-files/wazuh-passwords.txt
