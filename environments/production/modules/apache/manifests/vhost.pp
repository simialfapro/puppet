class apache::vhost (
  String $servername,
  String $docroot,
  Optional[String] $port = '80',
  Optional[Array] $ssl = false,
) {
  # Erstelle die Konfigurationsdatei für den VHost
  file { "/etc/apache2/sites-enabled/${servername}.conf":
    ensure  => file,
    content => template('apache/vhost.conf.erb'),  # Verweis auf das Template
    notify  => Service['apache2'],  # Neustart von Apache nach Änderungen
  }
}
