class apache::vhosts (
  String $server_admin  = 'admin@example.com',
  String $document_root = '/var/www/html',
  String $server_name   = 'www.example.com',
  String $server_alias  = 'example.com',
) {

  file { '/etc/apache2/sites-available/000-default.conf':
    ensure  => file,
    content => template('apache/vhost.conf.erb'),
  }
}
