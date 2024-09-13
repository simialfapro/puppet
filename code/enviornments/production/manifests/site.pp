# /etc/puppetlabs/code/environments/production/manifests/site.pp

node default {
  include apache
}

node 'puppet-node.localdomain' {
  include webserver
}
