#import "classes/*"

node default {
	host { 'pm.cloudcomplab.dev':
	    ensure       => 'present',
	    host_aliases => ['puppet'],
	    ip           => '192.168.56.2',
	    target       => '/etc/hosts',
  	}
}

node /wp.cloudcomplab.dev/ {
	class {
		wordpress:
		wordpress_db_name =>      "wp_db_wordpush",
		wordpress_db_user =>      "wordpush",
		wordpress_db_password =>  "wordpush0"
	}
}