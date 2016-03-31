class fail2ban::params {

  case $::osfamily {
    'Debian': {
      $package            = 'fail2ban'
      $service            = 'fail2ban'
      $config_file        = '/etc/fail2ban/fail2ban.local'
      $jail_file          = '/etc/fail2ban/jail.local'

      if versioncmp($::operatingsystemrelease, '16.04') >= 0  {
        $ddos_jail          = 'sshd-ddos'
        $loglevel           = 'INFO'
        $ssh_jail           = 'sshd'
      } else {
        $ddos_jail          = 'ssh-ddos'
        $loglevel           = '3'
        $ssh_jail           = 'ssh'
      }
    }

    'RedHat': {
      $package            = 'fail2ban'
      $service            = 'fail2ban'
      $config_file        = '/etc/fail2ban/fail2ban.local'
      $jail_file          = '/etc/fail2ban/jail.local'

      case $::operatingsystemmajrelease {
        '5': {
          $ddos_jail          = undef
          $loglevel           = '3'
          $ssh_jail           = 'ssh-iptables'
        }
        default: {
          $ddos_jail          = 'sshd-ddos'
          $loglevel           = 'INFO'
          $ssh_jail           = 'sshd'
        }
      }
    }

    default:  {
      fail("osfamily ${::osfamily} not supported")
    }
  }


}
