# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.hostname = "APT-S3"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network :forwarded_port, guest: 8080, host: 8080

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  config.vm.network :private_network, ip: "33.33.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.

  # config.vm.network :public_network

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "", ""

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise64"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.

  config.vm.define 'ubuntu-12.04' do |c|
    c.vm.box = "precise64"
    config.vm.provider :vmware_fusion do |vmware, override|
      override.vm.box_url = "http://files.vagrantup.com/precise64_vmware_fusion.box"
    end
    config.vm.provider :virtualbox do |virtualbox, override|
      override.vm.box_url = "http://files.vagrantup.com/precise64.box"
    end
    config.vm.provider :aws do |aws, override|
      override.vm.box_url = "https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box"
    end
  end

#  config.vm.define 'centos-6.4' do |c|
#      c.vm.box = "centos-6-4"
#    config.vm.provider :vmware_fusion do |vmware, override|
#      override.vm.box_url = "https://dl.dropbox.com/u/5721940/vagrant-boxes/vagrant-centos-6.4-x86_64-vmware_fusion.box"
#    end
#    config.vm.provider :virtualbox do |virtualbox, override|
#      override.vm.box_url = "http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20130427.box"
#    end
#    config.vm.provider :aws do |aws, override|
#      override.vm.box_url = "https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box"
#    end
#  end

  # View the documentation for the provider you're using for more
  # information on available options.

  config.ssh.max_tries = 40
  config.ssh.timeout   = 120

  # The path to the Berksfile to use with Vagrant Berkshelf
  # config.berkshelf.berksfile_path = "./Berksfile"

  # Enabling the Berkshelf plugin. To enable this globally, add this configuration
  # option to your ~/.vagrant.d/Vagrantfile file
  config.berkshelf.enabled = true

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to exclusively install and copy to Vagrant's shelf.
  # config.berkshelf.only = []

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to skip installing and copying to Vagrant's shelf.
  # config.berkshelf.except = []

#  config.vm.provision :shell,
#      :inline => "apt-get update && apt-get -y upgrade"

  config.vm.provision :shell, :inline => "sudo apt-get -y install curl"
  config.vm.provision :shell, :inline => "curl -L https://www.opscode.com/chef/install.sh | sudo bash"

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["cookbooks", "~/.berkshelf/cookbooks"]
    chef.roles_path = "roles"
    chef.data_bags_path = "data_bags"
    chef.provisioning_path = "/tmp/vagrant-chef"
    chef.run_list = [
      "recipe[apt-s3-cookbook::default]"
    ]
  end
end
