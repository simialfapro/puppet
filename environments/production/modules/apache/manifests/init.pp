class apache {
  include apache::install
  include apache::config
  include apache::service
}
