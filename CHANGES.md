Platform 0.7.0
-----------------------

Compatibility:

* Requires leap_cli version 1.7.2
* Requires bitmask client version >= 0.7
* Previous releases supported cookies when using the provider API. Now, only
  tokens are supported.
* Includes:
  * leap_mx 0.7.0
  * tapicero 0.7
  * webapp 0.7
  * soledad 0.7

Commits: https://leap.se/git/leap_platform.git/shortlog/refs/tags/0.7.0
Issues fixed: https://leap.se/code/versions/168

Upgrading:

* `gem install leap_cli --version 1.7.2`.
* `cd leap_platform; git pull; git checkout 0.7.0`.
* `leap deploy`
* `leap db destroy --db sessions,tokens` You can ignore message about needing to redeploy (since, in this case, we just want to permanently delete those databases).
* `leap test` to make sure everything is working

New features:

* rotating couchdb databases: CouchDB is not designed to handle ephemeral data, like sessions, because documents are never really deleted (a tombstone document is always kept to record the deletion). To overcome this limitation, we now rotate the `sessions` and `tokens` databases monthly. The new database names are `tokens_XXX` and `sessions_XXX` where XXX is a counter since the epoch that increments every month (not a calendar month, but a month's worth of seconds). Additionally, nagios checks and `leap test run` now will create and destroy test users in the `tmp_users` database, which will get periodically deleted and recreated.
* deployment logging: information on every deploy is logged to `/var/log/leap` on the node, including the user, leap_cli version, and platform version.
* you must now run `leap deploy --downgrade` if you want to deploy an older version over a newer platform version.
* the install source for each custom daemons (e.g. tapicero, etc) can now configured in `common.json`.
* you can configure apt sources in common.json
* improved nagios graphs integration (with pnp4nagios)
* default MTU was reduced to 1400 for better overall compatibility
* install haveged for some minimal entropy on depleted systems
* switch to release branches for webapp, tapicero
* implement weakdh recommendations, and update minimal cipher lists for web TLS connections
* many bug bugfixes, security improvements, and tests


Platform 0.6
-------------------------------------

Compatibility:

* Requires leap_cli version 1.6
* Requires bitmask client version >= 0.5

Commits: https://leap.se/git/leap_platform.git/shortlog/refs/tags/0.6.0

New features:

* single node deployment
* include custom puppet modules and manifests
* couch flexibility
* stunnel rework
* new debian repository structure
* dependency pinning
* leap_cli modularization
* improved cert generation
* monitoring improvements such as per-environment tooling and notifications
* tor hidden service support
* switch away from NIST curve and ensure TLSv1 is used
* tests made significantly more robust
* add support for webapp deployment to a subdomain
* many, many bugfixes and stability improvements
