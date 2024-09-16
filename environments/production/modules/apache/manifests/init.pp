class apache {
  include apache::install
  include apache::config
  include apache::service
  include apache::vhosts
  $vhosts = lookup('apache::vhosts')
  apache::vhost { $vhosts:
    servername => $vhosts['servername'],
    docroot    => $vhosts['docroot'],
    port       => $vhosts['port'],
    ssl        => $vhosts['ssl'],
  }
}

