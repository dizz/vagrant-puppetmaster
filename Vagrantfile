# -*- mode: ruby -*-
# vi: set ft=ruby :

# OS and VirtualBox specific notes:
# - Do not bind to eth0 - this is NAT'ed and will not help in your OS-auto quest!

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
  
  config.vm.define :openstack_aio do |openstack_aio|

    openstack_aio.vm.hostname = "osaio.cloudcomplab.dev"
    openstack_aio.vm.box = "precise64"
    openstack_aio.vm.box_url = "http://files.vagrantup.com/precise64.box"
    openstack_aio.vm.network :private_network, ip: "192.168.56.4"
    openstack_aio.vm.network :private_network, ip: "192.168.56.5", auto_config: false

    # we need to run an apt update 1st and set the hostname of the puppetmaster - in the real world 
    # a DNS server would look after this.
    openstack_aio.vm.provision :shell, :inline => "apt-get update >/dev/null && echo '192.168.56.2 pm.cloudcomplab.dev pm puppet' >> /etc/hosts"
    
    # Configure box completely via the puppet master provisioner
    openstack_aio.vm.provision :puppet_server, 
                                :puppet_node => "osaio.cloudcomplab.dev",
                                :puppet_server => "pm.cloudcomplab.dev",
                                :options => "--verbose --debug --pluginsync true"
  end # openstack_aio

  config.vm.define :openstack_controller do |openstack_controller|

    openstack_controller.vm.hostname = "oscont.cloudcomplab.dev"
    openstack_controller.vm.box = "precise64"
    openstack_controller.vm.box_url = "http://files.vagrantup.com/precise64.box"
    openstack_controller.vm.network :private_network, ip: "192.168.56.4"
    openstack_controller.vm.network :private_network, ip: "192.168.56.5", auto_config: false

    # we need to run an apt update 1st and set the hostname of the puppetmaster - in the real world 
    # a DNS server would look after this.
    openstack_controller.vm.provision :shell, :inline => "apt-get update >/dev/null && echo '192.168.56.2 pm.cloudcomplab.dev pm puppet' >> /etc/hosts"
    
    # Configure box completely via the puppet master provisioner
    openstack_controller.vm.provision :puppet_server, 
                                :puppet_node => "oscont.cloudcomplab.dev",
                                :puppet_server => "pm.cloudcomplab.dev",
                                :options => "--verbose --debug --pluginsync true"
  end # openstack_controller

  config.vm.define :openstack_compute do |openstack_compute|

    openstack_compute.vm.hostname = "oscomp.cloudcomplab.dev"
    openstack_compute.vm.box = "precise64"
    openstack_compute.vm.box_url = "http://files.vagrantup.com/precise64.box"
    openstack_compute.vm.network :private_network, ip: "192.168.56.4"
    openstack_compute.vm.network :private_network, ip: "192.168.56.5", auto_config: false

    # we need to run an apt update 1st and set the hostname of the puppetmaster - in the real world 
    # a DNS server would look after this.
    openstack_compute.vm.provision :shell, :inline => "apt-get update >/dev/null && echo '192.168.56.2 pm.cloudcomplab.dev pm puppet' >> /etc/hosts"
    
    # Configure box completely via the puppet master provisioner
    openstack_compute.vm.provision :puppet_server, 
                                :puppet_node => "oscomp.cloudcomplab.dev",
                                :puppet_server => "pm.cloudcomplab.dev",
                                :options => "--verbose --debug --pluginsync true"
  end # openstack_compute
end
