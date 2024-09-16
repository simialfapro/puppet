class apache::config {
  file { '/var/www/html/index.html':
    ensure  => file,
    source  => 'puppet:///modules/apache/index.html', 
    require => Package['apache2'],
  }
}
