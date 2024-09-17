class apache {
  include apache::install
  include apache::config
  include apache::service
  include apache::vhosts
  $vhosts = lookup('apache::vhosts')

  $vhosts.each |$vhost| {
    apache::vhost { $vhost['servername']:
      servername => $vhost['servername'],
      docroot    => $vhost['docroot'],
      port       => $vhost['port'],
      ssl        => $vhost['ssl'],
    }
  }
}

