#!/bin/bash

# Install necessary packages on the slave VM (e.g., Docker)
sudo apt update
sudo apt install -y docker.io
sudo apt install -y git nodejs

# Install npm
sudo apt install -y npm

# Wait for Jenkins to be fully initialized on the "jenkins" VM
sleep 120

# Create "jenkins" user and group (if not already present)
sudo groupadd jenkins
sudo useradd -g jenkins -m -s /bin/bash jenkins

# Generate the SSH key pair for the Jenkins agent
ssh-keygen -f /home/jenkins/.ssh/jenkins_agent_key -N ""

# Adjust ownership and permissions of the .ssh directory and key files
sudo chown -R jenkins:jenkins /home/jenkins/.ssh
sudo chmod 700 /home/jenkins/.ssh
sudo chmod 644 /home/jenkins/.ssh/known_hosts

# Add the target host (192.168.33.10) to the Known Hosts file
sudo ssh-keyscan 192.168.33.10 >> /home/jenkins/.ssh/known_hosts

# Copy the generated public key to the known_hosts file
cat /home/jenkins/.ssh/jenkins_agent_key.pub | sudo tee -a /home/jenkins/.ssh/known_hosts
