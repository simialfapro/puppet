class apache {
  include apache::install
  include apache::config
  include apache::service
  $vhosts = lookup('apache::vhosts', { 'default_value' => {} })
  notify { "VHosts data: ${vhosts}": }
  # Iteration über die VHosts und Erstellen jedes VHosts
  $vhosts['vhosts'].each |$name, $vhost| {
    apache::vhost { $vhost['servername']:
      servername => $vhost['servername'],
      docroot    => $vhost['docroot'],
      port       => $vhost['port'],
      ssl        => $vhost['ssl'],
    }
  }
}


    /*
    class { 'apache::vhost':
      servername => $vhost['servername'],
      docroot    => $vhost['docroot'],
      port       => $vhost['port'],
      ssl        => $vhost['ssl'],
    }*/
