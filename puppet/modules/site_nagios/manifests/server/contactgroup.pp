define site_nagios::server::contactgroup ($contact_emails) {

  nagios_contactgroup { $name:
    members => $name
  }
}
