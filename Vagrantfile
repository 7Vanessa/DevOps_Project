Vagrant.configure("2") do |config|
  # Define the box for Ubuntu 18.04
  config.vm.box = "ubuntu/bionic64"

  # Create three VMs with private network IPs
  config.vm.define "jenkins" do |jenkins|
    jenkins.vm.network "forwarded_port", guest: 8080, host: 8080
    jenkins.vm.network "private_network", ip: "192.168.33.10"
    jenkins.vm.hostname = "jenkins"
    jenkins.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = 2
    end

    # Provision Jenkins VM
    jenkins.vm.provision "shell", path: "provision_jenkins.sh", privileged: false
  end

  config.vm.define "slave1" do |slave1|
    slave1.vm.network "forwarded_port", guest: 8081, host: 8081
    slave1.vm.network "private_network", ip: "192.168.33.11"
    slave1.vm.hostname = "slave1"
    slave1.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = 2
    end

    # Provision Slave1 VM
    slave1.vm.provision "shell", path: "provision_slave1.sh", privileged: false
  end

  config.vm.define "slave2" do |slave2|
    slave2.vm.network "forwarded_port", guest: 8082, host: 8082
    slave2.vm.network "private_network", ip: "192.168.33.12"
    slave2.vm.hostname = "slave2"
    slave2.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = 2
    end

    # Provision Slave2 VM
    slave2.vm.provision "shell", path: "provision_slave2.sh", privileged: false
  end
end
