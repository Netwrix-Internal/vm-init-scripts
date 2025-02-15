#!/bin/bash

### START INSTALL DOCKER ###
# Update our packages list and install the required Docker dependencies
sudo apt update -y

# Install dependencies and pre-requisite packages
sudo apt install apt-transport-https ca-certificates curl software-properties-common gnupg lsb-release -y

# Get the GPG key which is needed to connect to the Docker repository
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add the Docker repository to the sources list
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Refresh packages again
sudo apt update -y

# Install docker-ce (not docker.io)
sudo apt install docker-ce -y

# Add your user to docker group to use docker commands without sudo
sudo usermod -aG docker $USER
### END INSTALL DOCKER ###

### START INSTALL DOCKER COMPOSE ###
# Download latest version of Docker Compose
sudo curl -L https://github.com/docker/compose/releases/download/v2.26.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

# Make it executable
sudo chmod +x /usr/local/bin/docker-compose
### END INSTALL DOCKER COMPOSE ###

### PROMPT FOR REBOOT ###
read -p "Docker installation complete. Would you like to reboot now? (y/n): " REBOOT_RESPONSE
if [[ "$REBOOT_RESPONSE" =~ ^[Yy]$ ]]; then
    echo "Rebooting now..."
    sudo reboot
else
    echo "Reboot skipped. Please reboot later for all changes to take effect."
fi
