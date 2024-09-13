class webserver::install {
  package { 'httpd':
    ensure => installed,
  }
}
