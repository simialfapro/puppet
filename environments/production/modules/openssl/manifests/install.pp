class openssl::install {
  package { 'openssl':
    ensure => installed,
  }
}
