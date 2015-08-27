#
# Sometimes when we upgrade the platform, we need to ensure that files that
# the platform previously created will get removed.
#
# These file removals don't need to be kept forever: we only need to remove
# files that are present in the prior platform release.
#
# We can assume that the every node is upgraded from the previous platform
# release.
#

class site_config::remove_files {

  #
  # Platform 0.7 removals
  #

  tidy {
    '/etc/rsyslog.d/99-tapicero.conf':;
    '/etc/rsyslog.d/99-leap-mx.conf':;
    '/etc/rsyslog.d/01-webapp.conf':;
    '/etc/rsyslog.d/50-stunnel.conf':;
    '/etc/logrotate.d/mx':;
    '/etc/logrotate.d/stunnel':;
    '/var/log/stunnel4/stunnel.log':;
    'leap_mx':
      path => '/var/log/',
      recurse => true,
      matches => 'leap_mx*';
    'leap_mx_rotate':
      path => '/var/log/leap/',
      recurse => true,
      matches => [ 'mx.log.[0-9]', 'mx.log.[0-9]?', 'mx.log.[6-9]?gz'];
    '/srv/leap/webapp/public/provider.json':;
    '/srv/leap/couchdb/designs/tmp_users':
      recurse => true,
      rmdirs => true;
  }

  # leax-mx logged to /var/log/leap_mx.log in the past
  # we need to use a dumb exec here because file_line doesn't
  # allow removing lines that match a regex in the current version
  # of stdlib, see https://tickets.puppetlabs.com/browse/MODULES-1903
  exec { 'rm_old_leap_mx_log_destination':
      command => "/bin/sed -i '/leap_mx.log/d' /etc/check_mk/logwatch.state",
      onlyif  => "/bin/grep -qe 'leap_mx.log' /etc/check_mk/logwatch.state"
  }

  # Don't use check_mk logwatch to watch bigcouch logs anymore
  # see https://leap.se/code/issues/7375 for more details
  file { '/etc/check_mk/logwatch.d/bigcouch.cfg':
    ensure => absent,
    notify => [
      Exec['remove_bigcouch_logwatch_spoolfiles'],
      Exec['remove_bigcouch_logwatch_stateline']
    ]
  }
  # remove leftover bigcouch logwatch spool files
  exec { 'remove_bigcouch_logwatch_spoolfiles':
    command     => 'find /var/lib/check_mk/logwatch -name \'\\opt\\bigcouch\\var\\log\\bigcouch.log\' -exec rm {} \;',
    refreshonly => true,
  }
  exec { 'remove_bigcouch_logwatch_stateline':
    command     => "sed -i '/bigcouch.log/d' /etc/check_mk/logwatch.state",
    refreshonly => true,
  }
}
