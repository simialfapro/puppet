class apache::vhosts (
  $vhost,
) {
  # Lese die VHosts-Daten aus Hiera. Falls keine vorhanden sind, wird ein leeres Hash zurückgegeben.
  #$vhosts = lookup('apache::vhosts', {})
  #notify {"vhosts: $vhosts": }
  # Verwende `create_resources`, um dynamisch VHosts aus den Hiera-Daten zu erstellen
  #create_resources('apache::vhost', $vhosts)
    $vhosts['vhosts'].each |$name, $vhost| {
    apache::vhost { 'apache::vhost':
      servername => $vhost['servername'],
      docroot    => $vhost['docroot'],
      port       => $vhost['port'],
      ssl        => $vhost['ssl'],
    }
  }
}

define apache::vhosts::vhosts (
  Integer $port,
  String[1] $docroot,
  String[1] $servername = $title,
  String $vhost_name = '*',
  Boolean $ssl,
) {
  include apache # contains package['httpd'] and service['httpd']
  include apache::params # contains common config settings

  $vhost_dir = $apache::params::vhost_dir

  # the template used below can access all of the parameters and variable from above.
  file { "/etc/apache2/sites-enabled/${servername}.conf":
    ensure  => file,
    content => template('apache/vhost.conf.erb'),  # Verweis auf das Template
    notify  => Service['apache2'],  # Neustart von Apache nach Änderungen
  }
}
