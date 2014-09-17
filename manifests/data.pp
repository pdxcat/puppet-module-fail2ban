class fail2ban::data {

  case $::osfamily {
    default:  { fail("osfamily ${::osfamily} not supported") }
    'Debian': {
      $package            = 'fail2ban'
      $service            = 'fail2ban'
      $config_file        = '/etc/fail2ban/fail2ban.conf'
      $jail_file          = '/etc/fail2ban/jail.conf'
      $config_file_source = 'puppet:///modules/fail2ban/debian/fail2ban.conf'
      $jail_file_source   = 'puppet:///modules/fail2ban/debian/jail.conf'
    }
    'FreeBSD': {
      $package            = 'security/fail2ban'
      $service            = 'fail2ban'
      $config_file        = '/usr/local/etc/fail2ban/fail2ban.conf'
      $jail_file          = '/usr/local/etc/fail2ban/jail.conf'
      $config_file_source = 'puppet:///modules/fail2ban/freebsd/fail2ban.conf'
      $jail_file_source   = 'puppet:///modules/fail2ban/freebsd/jail.conf'
    }
    'RedHat': {
      $package            = 'fail2ban'
      $service            = 'fail2ban'
      $config_file        = '/etc/fail2ban/fail2ban.conf'
      $jail_file          = '/etc/fail2ban/jail.conf'
      $config_file_source = 'puppet:///modules/fail2ban/redhat/fail2ban.conf'
      $jail_file_source   = 'puppet:///modules/fail2ban/redhat/jail.conf'
    }
  }

}
