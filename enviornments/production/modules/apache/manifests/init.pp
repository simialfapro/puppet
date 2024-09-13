class webserver {
  include webserver::install
  include webserver::config
  include webserver::service
}
