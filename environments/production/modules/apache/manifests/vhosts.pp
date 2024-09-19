class apache::vhosts (
  $vhosts,
) {
  $vhosts['vhosts'].each |$name, $vhost| {
  if $vhost['ssl'] == true {
    $port = 443
  } else {
    $port = 80
  }
    apache::vhosts::vhost { "/etc/apache2/sites-enabled/${name}.conf":
      port       => $port,
      docroot    => $vhost['docroot'],
      servername => $vhost['servername'],
      ssl        => $vhost['ssl'],
      cert_path  => $vhost['cert_path'],
      cert_key   => $vhost['cert_key'],
      redirect   => $vhost['redirect'],
      backend    => $vhost['backend'],
    }
  }
}

define apache::vhosts::vhost ( 
  Integer $port,
  String[1] $docroot,
  String[1] $servername,
  Boolean $ssl,
  Optional $cert_path = "/etc/ssl/cert/${servername}",
  Optional $key_path = "/etc/ssl/private/${servername}",
  Boolean $redirect = false,
  Optional[String[1]] $backend = undef,

) {
  
  if $redirect == true and $backend == undef {
    fail("Parameter 'backend' is required when 'redirect' is true.")
  }

  if $ssl == true{
    class { 'openssl':
      cert_path   => $cert_path,
      key_path    => $key_path,
      common_name => $servername,
    }
  }
  file { "${name}":
    ensure  => present,
    content => template('apache/vhost.conf.erb'),
    notify  => Service['apache2'],
  }
}
