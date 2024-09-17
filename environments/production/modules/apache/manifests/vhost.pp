class apache::vhost (
  String $servername = "example.com",
  String $docroot = "var/www/example",
  Optional[String] $port = '80',
  Optional[Boolean] $ssl = false,
) {
  # Erstelle die Konfigurationsdatei für den VHost
  file { "/etc/apache2/sites-enabled/${servername}.conf":
    ensure  => file,
    content => template('apache/vhost.conf.erb'),  # Verweis auf das Template
    notify  => Service['apache2'],  # Neustart von Apache nach Änderungen
  }
}
