class site_apt::leap_repo {
  apt::sources_list {'leap.list':
    content => "deb http://deb.leap.se/debian $::lsbdistcodename main"
  }

}