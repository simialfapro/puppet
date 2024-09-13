class webserver::config {
  file { '/etc/httpd/conf.d/vhost.conf':
    ensure  => file,
    content => template('apache/apache.conf.erb'),  #
    require => Package['httpd'],
  }l

  file { '/var/www/html/index.html':
    ensure  => file,
    source  => 'puppet:///modules/apache/index.html', 
    require => Package['httpd'],
  }
}
