class webserver::service {
  service { 'httpd':
    ensure    => running,
    enable    => true,
    require   => File['/etc/httpd/conf.d/vhost.conf'], 
  }
}
