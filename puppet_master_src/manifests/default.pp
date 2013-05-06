node default {
  
  #TODO extract common variables e.g. hostnames

  host { 'pm.cloudcomplab.dev':
    ensure       => 'present',
    host_aliases => ['puppet'],
    ip           => '192.168.56.2',
    target       => '/etc/hosts',
  }

  package {'puppetmaster':
    ensure  =>  latest,
    require => Host['pm.cloudcomplab.dev'],
  }
    
  # Configure puppetdb and its underlying database
  class { 'puppetdb': 
    listen_address => 'pm.cloudcomplab.dev',
    ssl_listen_address => 'pm.cloudcomplab.dev',
    require => Package['puppetmaster'],
    puppetdb_version => latest,
  }

  # Configure the puppet master to use puppetdb
  class { 'puppetdb::master::config': }
    
  class {'dashboard':
    dashboard_site => $fqdn,
    dashboard_port => '3000',
    require        => Package["puppetmaster"],
  }
 
  ##we copy rather than symlinking as puppet will manage this
  file {'/etc/puppet/puppet.conf':
    ensure => present,
    owner => root,
    group => root,
    source => "/vagrant/all_src/puppet.conf",
    notify  =>  [Service['puppetmaster'],Service['puppet-dashboard'],Service['puppet-dashboard-workers']],
    require => Package['puppetmaster'],
  }
    
  file {'/etc/puppet/autosign.conf':
    ensure => link,
    owner => root,
    group => root,
    source => "/vagrant/all_src/autosign.conf",
    notify  =>  [Service['puppetmaster'],Service['puppet-dashboard'],Service['puppet-dashboard-workers']],
    require => Package['puppetmaster'],
  }
  
  file {'/etc/puppet/auth.conf':
    ensure => link,
    owner => root,
    group => root,
    source => "/vagrant/all_src/auth.conf",
    notify  =>  [Service['puppetmaster'],Service['puppet-dashboard'],Service['puppet-dashboard-workers']],
    require => Package['puppetmaster'],
  }
  
  file {'/etc/puppet/fileserver.conf':
    ensure => link,
    owner => root,
    group => root,
    source => "/vagrant/all_src/fileserver.conf",
    notify  =>  [Service['puppetmaster'],Service['puppet-dashboard'],Service['puppet-dashboard-workers']],
    require => Package['puppetmaster'],
  }
  
  file {'/etc/puppet/modules':
    mode  => '0644',
    recurse => true,
  }
  
  file { '/etc/puppet/hiera.yaml':
    ensure => link,
    owner => root,
    group => root,
    source => "/vagrant/all_src/hiera.yaml",
    notify  =>  [Service['puppetmaster'],Service['puppet-dashboard'],Service['puppet-dashboard-workers']],
  }
  
  file { '/etc/puppet/hieradata':
    mode => '0644',
    recurse => true,
  }

}