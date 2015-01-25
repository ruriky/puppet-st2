define st2::pack::config (
  $pack   = $name,
  $config = undef,
) {
  if $config {
    validate_hash($config)
    $_config = $config
  } else {
    $_hiera_lookup = hiera("st2::pack::${pack}", {})
    validate_hash($_hiera_lookup)
    $_config = $_hiera_lookup
  }

  file { "/opt/stackstorm/packs/${pack}/config.yaml":
    ensure  => file,
    mode    => 0440,
    content => template('st2/config.yaml.erb'),
    before  => Exec["install-st2-pack-${pack}"],
  }
}
