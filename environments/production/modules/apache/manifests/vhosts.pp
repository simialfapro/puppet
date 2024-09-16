class apache::vhosts {
  $server_admin  = 'admin@example.com'
  $document_root = '/var/www/html'
  $server_name   = 'www.example.com'
  $server_alias  = 'example.com'

  file { '/etc/apache2/sites-available/000-default.conf':
    ensure  => file,
    content => template('apache/vhost.conf.erb'),
  }
}
