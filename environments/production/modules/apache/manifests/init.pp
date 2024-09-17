class apache {
  include apache::install
  include apache::config
  include apache::service
  $vhosts = lookup('apache::vhosts', { 'default_value' => {} })
  class{ "apache::vhosts":
    vhosts => $vhosts,
  } 
}

