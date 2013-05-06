# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define :puppet_master do |master_config|

    # All Vagrant configuration is done here. The most common configuration
    # options are documented and commented below. For a complete reference,
    # please see the online documentation at vagrantup.com.
    master_config.vm.hostname = "pm.cloudcomplab.dev"
    # Every Vagrant virtual environment requires a box to build off of.
    master_config.vm.box = "precise64"

    # The url from where the box can be downloaded if it doesn't already exist on the user's system.
    master_config.vm.box_url = "http://files.vagrantup.com/precise64.box"

    # Assign this VM to a host-only network IP, allowing you to access it
    # via the IP. Host-only networks can talk to the host machine as well as
    # any other machines on the same network, but cannot be accessed (through this
    # network interface) by any external networks.
    master_config.vm.network :private_network, ip: "192.168.56.2"
      
    # Share an additional folder to the guest VM. The first argument is
    # an identifier, the second is the path on the guest to mount the
    # folder, and the third is the path on the host to the actual folder.

    # Bootstrap puppet - install initial puppet packages via the shell provisioner
    master_config.vm.provision :shell, :path => "puppet_master_src/puppet_master.sh"
    
    # Configure puppet completely via the puppet provisioner
    master_config.vm.provision :puppet, :module_path => "puppet_master_src/modules", :manifests_path => "puppet_master_src/manifests", :manifest_file  => "default.pp"

    # All puppet code to be used by managed nodes should be placed under
    # all_src/ and they'll be placed into the correct place. This includes puppet config files.
    # This will be the same for foreman
    master_config.vm.synced_folder "all_src/manifests", "/etc/puppet/manifests"
    master_config.vm.synced_folder "all_src/modules", "/etc/puppet/modules"
    master_config.vm.synced_folder "all_src/hieradata", "/etc/puppet/hieradata"
  
  end # master_config
  
end
