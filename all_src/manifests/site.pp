# import "classes/*"

node /osaio.cloudcomplab.dev/ {

	# TODO apt-get install ubuntu-cloud-keyring
	# TODO /etc/apt/sources.list.d/grizzly.list
	# TODO deb http://ubuntu-cloud.archive.canonical.com/ubuntu precise-updates/grizzly main
	# TODO apt-get update

	apt::source { 'openstack_grizzly':
		location	=> "http://ubuntu-cloud.archive.canonical.com/ubuntu",
		release		=> "precise-updates/grizzly",
		repos		=> "main",
		required_packages => 'ubuntu-cloud-keyring',
	}

	exec { '/usr/bin/apt-get update':
		refreshonly => true,
		logoutput   => true,
		subscribe   => Apt::Source["openstack_grizzly"],
	}

	Exec['/usr/bin/apt-get update'] -> Package<||>

	include 'apache'

	class { 'cinder::setup_test_volume': } -> Service<||>

	# it's likely that this class is no longer 100% with quantum
	class { 'openstack::all':
		public_address          => $ipaddress_eth1,
		public_interface        => 'eth1',
		private_interface       => 'eth2',
		admin_email             => 'god@hell.io',
		admin_password          => 'dontask',
		secret_key				=> 'dontask',
		mysql_root_password		=> 'mysequel2.0',
		keystone_db_password    => 'stpeter',
		keystone_admin_token    => 'stpeter',
		nova_db_password        => 'nero',
		nova_user_password      => 'nero',
		glance_db_password      => 'gluncie',
		glance_user_password    => 'glunce',
		rabbit_password         => 'zaio-baio',
		rabbit_user             => 'zaiche',
		libvirt_type            => 'qemu',
		floating_range          => '192.168.56.64/28',
		fixed_range             => '10.0.0.0/24',
		verbose                 => true,
		auto_assign_floating_ip => false
	}

	class { 'openstack::auth_file':
		admin_password       => 'dontask',
		keystone_admin_token => 'stpeter',
		controller_node      => '127.0.0.1',
	}
}