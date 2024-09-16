class apache::vhosts {
  # Lese die VHosts-Daten aus Hiera. Falls keine vorhanden sind, wird ein leeres Hash zurückgegeben.
  $vhosts = hiera_hash('apache::vhosts', {})

  # Verwende `create_resources`, um dynamisch VHosts aus den Hiera-Daten zu erstellen
  create_resources('apache::vhost', $vhosts)
}
