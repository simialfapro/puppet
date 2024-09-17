class apache::vhosts (
  $vhosts,
) {
    $vhosts['vhosts'].each |$name, $vhost| {
    apache::vhosts::vhost { "/etc/apache2/sites-enabled/${name}.conf":
      port       => $vhost['port'],
      docroot    => $vhost['docroot'],
      servername => $vhost['servername'],
      ssl        => $vhost['ssl'],
    }
  }
}

define apache::vhosts::vhost ( 
  Integer $port,
  String[1] $docroot,
  String[1] $servername,
  Boolean $ssl,
) {
  file { "${name}":
    ensure  => present,
    content => template('apache/vhost.conf.erb'),
    notify  => Service['apache2'],
  }
}
