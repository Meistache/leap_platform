class site_apt {

  include ::apt

  apt::apt_conf { '90disable-pdiffs':
    content => 'Acquire::PDiffs "false";';
  }

  include ::apt::unattended_upgrades
}
