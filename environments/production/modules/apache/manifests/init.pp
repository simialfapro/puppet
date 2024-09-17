class apache {
  include apache::install
  include apache::config
  include apache::service
  $vhosts = lookup('apache::vhosts', { 'default_value' => {} })
  notify { "VHosts data: ${vhosts}": }
  class{ "apache::vhosts":
    vhosts => $vhosts,
  } 
  # Iteration über die VHosts und Erstellen jedes VHosts
}

