# --- puppet-node.localdomain

node 'puppet-node.localdomain' {
  class { 'apache::vhosts':
    server_admin  => lookup('apache::server_admin'),
    document_root => lookup('apache::document_root'),
    server_name   => lookup('apache::server_name'),
    server_alias  => lookup('apache::server_alias'),
  }
}
