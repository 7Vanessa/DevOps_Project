#!/bin/bash

# Install required packages
sudo apt-get update
sudo apt-get install -y build-essential

# Generate SSH key for Jenkins user
sudo mkdir -p /home/jenkins/.ssh
sudo ssh-keygen -t rsa -b 2048 -N "" -f /home/jenkins/.ssh/jenkins_agent_key

# Set permissions for the SSH key files
sudo chmod 600 /home/jenkins/.ssh/jenkins_agent_key
sudo chmod 644 /home/jenkins/.ssh/jenkins_agent_key.pub

# Add the Jenkins user's public key to known_hosts
sudo ssh-keyscan -H localhost >> /home/jenkins/.ssh/known_hosts

# Change ownership of .ssh directory to Jenkins user
sudo chown -R jenkins:jenkins /home/jenkins/.ssh