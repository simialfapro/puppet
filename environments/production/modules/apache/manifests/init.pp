class apache {
  include apache::install
  include apache::config
  include apache::service
  include apache::vhosts
  include apache::vhost
  $vhosts = lookup('apache::vhosts')
  notify { "Vhosts Data: ${vhosts}": }

  $vhosts.each |$vhost| {
    apache::vhost { $vhost['servername']:
      servername => $vhost['servername'],
      docroot    => $vhost['docroot'],
      port       => $vhost['port'],
      ssl        => $vhost['ssl'],
    }
  }
}

