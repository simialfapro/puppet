class apache::install {
  # Apache-Paket installieren
  package { 'apache2':
    ensure => installed,
  }

  exec { 'enable_ssl_module':
    command => '/usr/sbin/a2enmod ssl',
    unless  => '/usr/sbin/a2query -m ssl',
    require => Package['apache2'],  # Nur ausführen, wenn Apache installiert ist
    notify  => Service['apache2'],  # Apache nach der Aktivierung neu starten
  }
}
