class apache::vhost (
  String $servername,
  String $docroot,
  Optional[String] $port = '80',
  Optional[Boolean] $ssl = false,
) {
  # Erstelle die Konfigurationsdatei für den VHost
  file { "/etc/apache2/sites-available/${servername}.conf":
    ensure  => file,
    content => template('apache/vhost.erb'),  # Verweis auf das Template
    notify  => Service['apache2'],  # Neustart von Apache nach Änderungen
  }

  # Aktiviere den VHost mit a2ensite
  exec { "enable-${servername}":
    command => "/usr/sbin/a2ensite ${servername}.conf",
    unless  => "/bin/ls /etc/apache2/sites-enabled | grep ${servername}",
    require => File["/etc/apache2/sites-available/${servername}.conf"],
    notify  => Service['apache2'],
  }
}
