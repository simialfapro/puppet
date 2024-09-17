class apache::vhost (
  String $servername,
  String $docroot,
  Optional[String] $port = '80',
  Optional[Boolean] $ssl = false,
) {
  $vhosts = lookup('apache::vhosts', { 'default_value' => [] })
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
  # Erstelle die Konfigurationsdatei für den VHost
  file { "/etc/apache2/sites-enabled/${servername}.conf":
    ensure  => file,
    content => template('apache/vhost.conf.erb'),  # Verweis auf das Template
    notify  => Service['apache2'],  # Neustart von Apache nach Änderungen
  }
}
