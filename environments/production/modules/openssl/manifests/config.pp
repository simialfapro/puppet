class openssl::config (
  String $country        = 'CH',
  String $state          = 'Zürich',
  String $locality       = 'Zürich',
  String $organization   = '3dbambuu',
  String $common_name    = $trusted['certname'],
  String $cert_path      = '/etc/ssl/certs',
  String $key_path       = '/etc/ssl/private',
  Integer $days          = 365,           
) {
}

define openssl::config::generate (
  String $country        = 'CH',
  String $state          = 'Zürich',
  String $locality       = 'Zürich',
  String $organization   = '3dbambuu',
  String $common_name    = $trusted['certname'],
  String $cert_path      = '/etc/ssl/certs',
  String $key_path       = '/etc/ssl/private',
  Integer $days          = 365,     
){
file { $cert_path:
    ensure => directory,
    mode   => '0755',
  }
  file { $key_path:
    ensure => directory,
    mode   => '0700',
  }
  $cert_file = "${cert_path}/${common_name}.crt"
  $key_file  = "${key_path}/${common_name}.key"
  $csr_file  = "/tmp/${common_name}.csr"
  file { "/tmp/openssl.cnf":
    ensure  => file,
    content => template('openssl/openssl.cnf.erb'),
  }
  exec { "generate_private_key_${common_name}":
    command => "/usr/bin/openssl genrsa -out ${key_file} 2048",
    creates => $key_file,
    require => File[$key_path],
  }
  exec { "generate_csr_${common_name}":
    command => "/usr/bin/openssl req -new -key ${key_file} -out ${csr_file} -config /tmp/openssl.cnf",
    creates => $csr_file,
    require => Exec["generate_private_key_${common_name}"],
  }
  exec { "generate_self_signed_cert_${common_name}":
    command => "/usr/bin/openssl x509 -req -days ${days} -in ${csr_file} -signkey ${key_file} -out ${cert_file}",
    creates => $cert_file,
    require => Exec["generate_csr_${common_name}"],
  }
  file { $csr_file:
    ensure => absent,
    require => Exec["generate_self_signed_cert_${common_name}"],
  }
}
