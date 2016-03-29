class fail2ban {
  include fail2ban::params

  $config_file_source_real = $fail2ban::params::config_file_source
  $jail_file_source_real = $fail2ban::params::jail_file_source

  $ddos_jail = $fail2ban::params::ddos_jail
  $loglevel  = $fail2ban::params::loglevel
  $ssh_jail  = $fail2ban::params::ssh_jail

  package { $fail2ban::params::package:
    ensure => installed,
  }

  service { $fail2ban::params::service:
    ensure  => running,
    require => Package[$fail2ban::params::package],
  }

  File {
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service[$fail2ban::params::service],
    require => Package[$fail2ban::params::package],
  }

  file { $fail2ban::params::config_file:
    content => template('fail2ban/fail2ban.local.erb'),
  }

  file { $fail2ban::params::jail_file:
    content => template('fail2ban/jail.local.erb'),
  }

}
