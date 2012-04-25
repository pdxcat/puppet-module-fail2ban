#
#
#

class fail2ban (
  $config_file = "puppet://$server/modules/fail2ban/fail2ban.conf",
  $jail_file = "puppet://$server/modules/fail2ban/jail.conf"
) {
  package { 'fail2ban': ensure => installed }

  service { 'fail2ban':
    ensure  => running,
    require => Package['fail2ban'],
  }

  file { '/etc/fail2ban/fail2ban.conf':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => $config_file,
    notify  => Service['fail2ban'],
    require => Package['fail2ban'],
  }

  file { '/etc/fail2ban/jail.conf':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => $jail_file,
    notify  => Service['fail2ban'],
    require => Package['fail2ban'],
  }

}
