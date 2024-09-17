class apache::vhosts (
  $vhost,
) {
  # Lese die VHosts-Daten aus Hiera. Falls keine vorhanden sind, wird ein leeres Hash zurückgegeben.
  #$vhosts = lookup('apache::vhosts', {})
  #notify {"vhosts: $vhosts": }
  # Verwende `create_resources`, um dynamisch VHosts aus den Hiera-Daten zu erstellen
  #create_resources('apache::vhost', $vhosts)
    $vhosts['vhosts'].each |$name, $vhost| {
    class { 'apache::vhost':
      servername => $vhost['servername'],
      docroot    => $vhost['docroot'],
      port       => $vhost['port'],
      ssl        => $vhost['ssl'],
    }
  }
}

define apache::vhost (
  Integer $port,
  String[1] $docroot,
  String[1] $servername = $title,
  String $vhost_name = '*',
) {
  include apache # contains package['httpd'] and service['httpd']
  include apache::params # contains common config settings

  $vhost_dir = $apache::params::vhost_dir

  # the template used below can access all of the parameters and variable from above.
  file { "${vhost_dir}/${servername}.conf":
    ensure  => file,
    owner   => 'www',
    group   => 'www',
    mode    => '0644',
    content => template('apache/vhost.conf.erb'),
    require  => Package['apache2'],
    notify    => Service['apache2'],
  }
}
