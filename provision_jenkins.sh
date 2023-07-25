#!/bin/bash

# Add the Jenkins repository and install Jenkins
sudo apt update
sudo apt install -y gnupg2

echo "Adding apt-keys"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 5BA31D57EF5975CA
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update

echo "Installing java"
sudo apt install -y openjdk-11-jre openjdk-11-jdk
java -version

echo "Installing git git-ftp nodejs"
sudo apt install -y git git-ftp nodejs

echo "Installing jenkins"
sudo apt install -y --allow-unauthenticated jenkins

echo "Put online"
filename="/var/lib/jenkins/hudson.model.UpdateCenter.xml"
sudo sed -i "s/https/http/" $filename
sudo /var/lib/dpkg/info/ca-certificates-java.postinst configure

echo "Restart jenkins"
sudo systemctl restart jenkins

echo "Password"
JENKINSPWD=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)
echo "Jenkins initial password: $JENKINSPWD"

# Wait for Jenkins to be fully initialized
sleep 60

# Install necessary packages (e.g., Docker) on slave VMs
sudo apt install -y docker.io

# Install npm
sudo apt install -y npm

# Generate the SSH key pair for the Jenkins agent
ssh-keygen -f ~/.ssh/jenkins_agent_key -N ""

# Create the .ssh directory for the Jenkins user
sudo mkdir -p /var/lib/jenkins/.ssh
sudo chmod 700 /var/lib/jenkins/.ssh

# Create the known_hosts file for Jenkins
sudo touch /var/lib/jenkins/.ssh/known_hosts
sudo chown jenkins:jenkins /var/lib/jenkins/.ssh/known_hosts
sudo chmod 644 /var/lib/jenkins/.ssh/known_hosts

# Copy the generated public key to the known_hosts file
cat ~/.ssh/jenkins_agent_key.pub | sudo tee -a /var/lib/jenkins/.ssh/known_hosts
