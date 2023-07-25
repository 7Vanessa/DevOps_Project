# Devops-CI/CD Pipeline Setup using Vagrant and Jenkins
The aime of this project is to produce the necessary configuration files that will be able to set up a basic CI/CD pipeline using Vagrant, Jenkins and Docker.


## Prerequisites:
In order to be able to use the configuration files for the setup, make the following are installed on your machine:
- Install [Oracle VM VirtualBox](https://www.virtualbox.org/wiki/Downloads),
- Install [Vagrant](https://developer.hashicorp.com/vagrant/downloads),
- Install [Git](https://git-scm.com/).

## Step 1 - Clone the GitHub repository
Clone this GitHub repository in the desired directory of your local machine with:

```
git clone https://github.com/7Vanessa/DevOps_Project.git
```

## Step 2 - Vagrant Setup
The Vagrantfile provided in the repository defines the VMs configuration.

For this next step, open a terminal in the project's directory and run the following command: 

```
vagrant up
```

This command will create three VMs: ```"jenkins"```, ```"slave1"``` and ```slave2``` with the respective private network IPs: 192.168.33.10, 192.168.33.11, and 192.168.33.12.
It will also provision Jenkins and Docker.

## Step 3 - Jenkins configuration
After the VMs have successfully been created, Jenkins will be installed and running on the 'jenkins' VM.

The next step will be to access the Jenkins interface by open a tab in the browser of your local machine and navigate to http://192.168.33.10:8080. 

The opening page will prompt you to enter the Jenkins initial password. This password can be found in the terminal after the '''vagrant up''' command has been run. Or it also can be found by running this command:
```
vagrant ssh jenkins -c "sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
```

Paste this initial password and Install the recommended plugins when prompted. Then, set up your admin account.