# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "centos/7"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder ".", "/vagrant", disabled: true

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  
  # ssh key configuration for windows only
  #config.vm.provision "shell" do |s|
  #  ssh_pub_key = File.readlines('h:\.ssh\vagrant\centos7_rsa.pub').first.strip
  #  s.inline = <<-SHELL
  #   echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
  #   SHELL
  #   end
  
  config.vm.provision "shell", inline: <<-SHELL
     CHECK="$(sudo yum list installed | grep ^git)"
     if [ -z "$CHECK" ]; 
     	then
     		yum install -y git
     	else
     		echo "git is already installed"
     fi
     SHELL

  config.vm.provision "shell", inline: <<-SHELL
    # if git doesn't exist create it and clone in the centos7 repo
    if [ ! -e /home/vagrant/git ];
      then
        echo "creating git dir"
        sudo mkdir /home/vagrant/git
        cd /home/vagrant/git
        echo "cloning centos7 repo"
        git clone https://github.com/simon71/centos7.git
        echo "copying startup.sh to home folder"
        cp /home/vagrant/git/centos7/startup.sh /home/vagrant/startup.sh
	    chmod u+x /home/vagrant/startup.sh
        chown vagrant:vagrant /home/vagrant/startup.sh

    # if the git directory does already exist, then only replace centos7 dir
    # not the whole git dir
      else
        echo "replacing existing centos7 dir"
        sudo rm -fr home/vagrant/git/centos7
        echo "updating centos7 repo"
        git clone https://github.com/simon71/centos7.git /home/vagrant/git
        echo "updating startup.sh"
        cp /home/vagrant/git/centos7/startup.sh /home/vagrant/startup.sh
        chmod u+x /home/vagrant/startup.sh
        chown vagrant:vagrant /home/vagrant/startup.sh
    fi
    SHELL
end
