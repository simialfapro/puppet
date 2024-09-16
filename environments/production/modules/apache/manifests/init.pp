class apache {
  include apache::install
  include apache::config
  include apache::service
  include apache::vhosts
  class { "apache::vhost":
    servername => lookup("apache::vhosts::servername"),
    docroot    => lookup("apache::vhosts::docroot")
  }
}

