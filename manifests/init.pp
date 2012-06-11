class fail2ban (
  $config_file = undef,
  $jail_file   = undef
) {
  include fail2ban::data

  if !$config_file {
    $config_file_source_real = $fail2ban::data::config_file_source
  } else {
    $config_file_source_real = $config_file
  }

  if !$jail_file {
    $jail_file_source_real = $fail2ban::data::jail_file_source
  } else {
    $jail_file_source_real = $jail_file
  }

  package { $fail2ban::data::package:
    ensure => installed,
  }

  service { $fail2ban::data::service:
    ensure  => running,
    require => Package[$fail2ban::data::package],
  }

  File {
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service[$fail2ban::data::service],
    require => Package[$fail2ban::data::package],
  }

  file { $fail2ban::data::config_file:
    source => $config_file_source_real,
  }

  file { '/etc/fail2ban/jail.conf':
    source => $jail_file_source_real,
  }

}
