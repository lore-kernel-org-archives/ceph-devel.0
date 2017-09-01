From: Sage Weil <sage@newdream.net>
Subject: RE: v12.2.0 Luminous released
Date: Fri, 1 Sep 2017 17:26:29 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1709011725030.20435@piezo.novalocal>
References: <871snukzhl.fsf@suse.com> <5E8375A3997FBC42861D5766794B0C5C1C7C7550@EX10MBOX03.pnnl.gov>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-724737504-1504286791=:20435"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58563 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752143AbdIAR0c (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Sep 2017 13:26:32 -0400
In-Reply-To: <5E8375A3997FBC42861D5766794B0C5C1C7C7550@EX10MBOX03.pnnl.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Felix, Evan J" <Evan.Felix@pnnl.gov>
Cc: 'Abhishek Lekshmanan' <abhishek@suse.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-724737504-1504286791=:20435
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 1 Sep 2017, Felix, Evan J wrote:
> Is there documentation about how to deal with a pool application 
> association that is not one of cephfs, rbd, or rgw? We have multiple 
> pools that have nothing to do with those applications, we just use the 
> objects in them directly using the librados API calls.  I don’t really 
> want health warnings always showing in my status screens.

Hi Evan,

Just

 ceph osd pool application enable $pool myapp

See

 http://docs.ceph.com/docs/master/rados/operations/pools/#associate-pool-to-application

sage


> 
> Evan Felix
> 
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Abhishek Lekshmanan
> Sent: Tuesday, August 29, 2017 11:20 AM
> To: ceph-devel@vger.kernel.org; ceph-users@ceph.com; ceph-maintainers@ceph.com; ceph-announce@ceph.com
> Subject: v12.2.0 Luminous released 
> 
> 
> We're glad to announce the first release of Luminous v12.2.x long term stable release series. There have been major changes since Kraken
> (v11.2.z) and Jewel (v10.2.z), and the upgrade process is non-trivial.
> Please read the release notes carefully.
> 
> For more details, links & changelog please refer to the complete release notes entry at the Ceph blog:
> http://ceph.com/releases/v12-2-0-luminous-released/
> 
> 
> Major Changes from Kraken
> -------------------------
> 
> - *General*:
>   * Ceph now has a simple, built-in web-based dashboard for monitoring cluster
>     status.
> 
> - *RADOS*:
>   * *BlueStore*:
>     - The new *BlueStore* backend for *ceph-osd* is now stable and the
>       new default for newly created OSDs.  BlueStore manages data
>       stored by each OSD by directly managing the physical HDDs or
>       SSDs without the use of an intervening file system like XFS.
>       This provides greater performance and features.
>     - BlueStore supports full data and metadata checksums
>       of all data stored by Ceph.
>     - BlueStore supports inline compression using zlib, snappy, or LZ4. (Ceph
>       also supports zstd for RGW compression but zstd is not recommended for
>       BlueStore for performance reasons.)
> 
>   * *Erasure coded* pools now have full support for overwrites
>     allowing them to be used with RBD and CephFS.
> 
>   * *ceph-mgr*:
>     - There is a new daemon, *ceph-mgr*, which is a required part of
>       any Ceph deployment.  Although IO can continue when *ceph-mgr*
>       is down, metrics will not refresh and some metrics-related calls
>       (e.g., `ceph df`) may block.  We recommend deploying several
>       instances of *ceph-mgr* for reliability.  See the notes on
>       Upgrading below.
>     - The *ceph-mgr* daemon includes a REST-based management API.
>       The API is still experimental and somewhat limited but
>       will form the basis for API-based management of Ceph going forward.
>     - ceph-mgr also includes a Prometheus exporter plugin, which can provide Ceph
>       perfcounters to Prometheus.
>     - ceph-mgr now has a Zabbix plugin. Using zabbix_sender it sends trapper
>       events to a Zabbix server containing high-level information of the Ceph
>       cluster. This makes it easy to monitor a Ceph cluster's status and send
>       out notifications in case of a malfunction.
> 
>   * The overall *scalability* of the cluster has improved. We have
>     successfully tested clusters with up to 10,000 OSDs.
>   * Each OSD can now have a device class associated with
>     it (e.g., `hdd` or `ssd`), allowing CRUSH rules to trivially map
>     data to a subset of devices in the system.  Manually writing CRUSH
>     rules or manual editing of the CRUSH is normally not required.
>   * There is a new upmap exception mechanism that allows individual PGs to be moved around to achieve
>     a *perfect distribution* (this requires luminous clients).
>   * Each OSD now adjusts its default configuration based on whether the
>     backing device is an HDD or SSD. Manual tuning generally not required.
>   * The prototype mClock QoS queueing algorithm is now available.
>   * There is now a *backoff* mechanism that prevents OSDs from being
>     overloaded by requests to objects or PGs that are not currently able to
>     process IO.
>   * There is a simplified OSD replacement process that is more robust.
>   * You can query the supported features and (apparent) releases of
>     all connected daemons and clients with `ceph features`
>   * You can configure the oldest Ceph client version you wish to allow to
>     connect to the cluster via `ceph osd set-require-min-compat-client` and
>     Ceph will prevent you from enabling features that will break compatibility
>     with those clients.
>   * Several `sleep` settings, include `osd_recovery_sleep`,
>     `osd_snap_trim_sleep`, and `osd_scrub_sleep` have been
>     reimplemented to work efficiently.  (These are used in some cases
>     to work around issues throttling background work.)
>   * Pools are now expected to be associated with the application using them.
>     Upon completing the upgrade to Luminous, the cluster will attempt to associate
>     existing pools to known applications (i.e. CephFS, RBD, and RGW). In-use pools
>     that are not associated to an application will generate a health warning. Any
>     unassociated pools can be manually associated using the new
>     `ceph osd pool application enable` command. For more details see
>     `associate pool to application` in the documentation.
> 
> - *RGW*:
> 
>   * RGW *metadata search* backed by ElasticSearch now supports end
>     user requests service via RGW itself, and also supports custom
>     metadata fields. A query language a set of RESTful APIs were
>     created for users to be able to search objects by their
>     metadata. New APIs that allow control of custom metadata fields
>     were also added.
>   * RGW now supports *dynamic bucket index sharding*. This has to be enabled via
>     the `rgw dyamic resharding` configurable. As the number of objects in a
>     bucket grows, RGW will automatically reshard the bucket index in response.
>     No user intervention or bucket size capacity planning is required.
>   * RGW introduces *server side encryption* of uploaded objects with
>     three options for the management of encryption keys: automatic
>     encryption (only recommended for test setups), customer provided
>     keys similar to Amazon SSE-C specification, and through the use of
>     an external key management service (Openstack Barbican) similar
>     to Amazon SSE-KMS specification.
>   * RGW now has preliminary AWS-like bucket policy API support.  For
>     now, policy is a means to express a range of new authorization
>     concepts.  In the future it will be the foundation for additional
>     auth capabilities such as STS and group policy.
>   * RGW has consolidated the several metadata index pools via the use of rados
>     namespaces.
>   * S3 Object Tagging API has been added; while APIs are
>     supported for GET/PUT/DELETE object tags and in PUT object
>     API, there is no support for tags on Policies & Lifecycle yet
>   * RGW multisite now supports for enabling or disabling sync at a
>     bucket level.
> 
> - *RBD*:
> 
>   * RBD now has full, stable support for *erasure coded pools* via the new
>     `--data-pool` option to `rbd create`.
>   * RBD mirroring's rbd-mirror daemon is now highly available. We
>     recommend deploying several instances of rbd-mirror for
>     reliability.
>   * RBD mirroring's rbd-mirror daemon should utilize unique Ceph user
>     IDs per instance to support the new mirroring dashboard.
>   * The default 'rbd' pool is no longer created automatically during
>     cluster creation. Additionally, the name of the default pool used
>     by the rbd CLI when no pool is specified can be overridden via a
>     new `rbd default pool = <pool name>` configuration option.
>   * Initial support for deferred image deletion via new `rbd
>     trash` CLI commands. Images, even ones actively in-use by
>     clones, can be moved to the trash and deleted at a later time.
>   * New pool-level `rbd mirror pool promote` and `rbd mirror pool
>     demote` commands to batch promote/demote all mirrored images
>     within a pool.
>   * Mirroring now optionally supports a configurable replication delay
>     via the `rbd mirroring replay delay = <seconds>` configuration
>     option.
>   * Improved discard handling when the object map feature is enabled.
>   * rbd CLI `import` and `copy` commands now detect sparse and
>     preserve sparse regions.
>   * Images and Snapshots will now include a creation timestamp.
>   * Specifying user authorization capabilities for RBD clients has been
>     simplified. The general syntax for using RBD capability profiles is
>     "mon 'profile rbd' osd 'profile rbd[-read-only][ pool={pool-name}[, ...]]'".
>     For more details see "User Management" in the documentation.
> 
> - *CephFS*:
> 
>   * *Multiple active MDS daemons* is now considered stable.  The number
>     of active MDS servers may be adjusted up or down on an active CephFS file
>     system.
>   * CephFS *directory fragmentation* is now stable and enabled by
>     default on new filesystems.  To enable it on existing filesystems
>     use "ceph fs set <fs_name> allow_dirfrags".  Large or very busy
>     directories are sharded and (potentially) distributed across
>     multiple MDS daemons automatically.
>   * Directory subtrees can be explicitly pinned to specific MDS daemons in
>     cases where the automatic load balancing is not desired or effective.
>   * Client keys can now be created using the new `ceph fs authorize` command
>     to create keys with access to the given CephFS file system and all of its
>     data pools.
>   * When running 'df' on a CephFS filesystem comprising exactly one data pool,
>     the result now reflects the file storage space used and available in that
>     data pool (fuse client only).
> 
> - *Miscellaneous*:
> 
>   * Release packages are now being built for *Debian Stretch*.  Note
>     that QA is limited to CentOS and Ubuntu (xenial and trusty).  The
>     distributions we build for now include:
> 
>     - CentOS 7 (x86_64 and aarch64)
>     - Debian 8 Jessie (x86_64)
>     - Debian 9 Stretch (x86_64)
>     - Ubuntu 16.04 Xenial (x86_64 and aarch64)
>     - Ubuntu 14.04 Trusty (x86_64)
> 
>   * A first release of Ceph for FreeBSD is available which contains a full set
>     of features, other than Bluestore. It will run everything needed to build a
>     storage cluster. For clients, all access methods are available, albeit
>     CephFS is only accessible through a Fuse implementation. RBD images can be
>     mounted on FreeBSD systems through rbd-ggate
>     Ceph versions are released through the regular FreeBSD ports and packages
>     system. The most current version is available as: net/ceph-devel. Once
>     Luminous goes into official release, this version will be available as
>     net/ceph. Future development releases will be available via net/ceph-devel
> 
>   * *CLI changes*:
> 
>     - The `ceph -s` or `ceph status` command has a fresh look.
>     - `ceph mgr metadata` will dump metadata associated with each mgr
>       daemon.
>     - `ceph versions` or `ceph {osd,mds,mon,mgr} versions`
>       summarize versions of running daemons.
>     - `ceph {osd,mds,mon,mgr} count-metadata <property>` similarly
>       tabulates any other daemon metadata visible via the `ceph
>       {osd,mds,mon,mgr} metadata` commands.
>     - `ceph features` summarizes features and releases of connected
>       clients and daemons.
>     - `ceph osd require-osd-release <release>` replaces the old
>       `require_RELEASE_osds` flags.
>     - `ceph osd pg-upmap`, `ceph osd rm-pg-upmap`, `ceph osd
>       pg-upmap-items`, `ceph osd rm-pg-upmap-items` can explicitly
>       manage `upmap` items
>     - `ceph osd getcrushmap` returns a crush map version number on
>       stderr, and `ceph osd setcrushmap [version]` will only inject
>       an updated crush map if the version matches.  This allows crush
>       maps to be updated offline and then reinjected into the cluster
>       without fear of clobbering racing changes (e.g., by newly added
>       osds or changes by other administrators).
>     - `ceph osd create` has been replaced by `ceph osd new`.  This
>       should be hidden from most users by user-facing tools like
>       `ceph-disk`.
>     - `ceph osd destroy` will mark an OSD destroyed and remove its
>       cephx and lockbox keys.  However, the OSD id and CRUSH map entry
>       will remain in place, allowing the id to be reused by a
>       replacement device with minimal data rebalancing.
>     - `ceph osd purge` will remove all traces of an OSD from the
>       cluster, including its cephx encryption keys, dm-crypt lockbox
>       keys, OSD id, and crush map entry.
>     - `ceph osd ls-tree <name>` will output a list of OSD ids under
>       the given CRUSH name (like a host or rack name).  This is useful
>       for applying changes to entire subtrees.  For example, `ceph
>       osd down `ceph osd ls-tree rack1``.
>     - `ceph osd {add,rm}-{noout,noin,nodown,noup}` allow the
>       `noout`, `noin`, `nodown`, and `noup` flags to be applied to
>       specific OSDs.
>     - `ceph osd safe-to-destroy <osd(s)>` will report whether it is safe to
>       remove or destroy OSD(s) without reducing data durability or redundancy.
>     - `ceph osd ok-to-stop <osd(s)>` will report whether it is okay to stop
>       OSD(s) without immediately compromising availability (i.e., all PGs
>       should remain active but may be degraded).
>     - `ceph log last [n]` will output the last *n* lines of the cluster
>       log.
>     - `ceph mgr dump` will dump the MgrMap, including the currently active
>       ceph-mgr daemon and any standbys.
>     - `ceph mgr module ls` will list active ceph-mgr modules.
>     - `ceph mgr module {enable,disable} <name>` will enable or
>       disable the named mgr module.  The module must be present in the
>       configured `mgr_module_path` on the host(s) where `ceph-mgr` is
>       running.
>     - `ceph osd crush ls <node>` will list items (OSDs or other CRUSH nodes)
>       directly beneath a given CRUSH node.
>     - `ceph osd crush swap-bucket <src> <dest>` will swap the
>       contents of two CRUSH buckets in the hierarchy while preserving
>       the buckets' ids.  This allows an entire subtree of devices to
>       be replaced (e.g., to replace an entire host of FileStore OSDs
>       with newly-imaged BlueStore OSDs) without disrupting the
>       distribution of data across neighboring devices.
>     - `ceph osd set-require-min-compat-client <release>` configures
>       the oldest client release the cluster is required to support.
>       Other changes, like CRUSH tunables, will fail with an error if
>       they would violate this setting.  Changing this setting also
>       fails if clients older than the specified release are currently
>       connected to the cluster.
>     - `ceph config-key dump` dumps config-key entries and their
>       contents.  (The existing `ceph config-key list` only dumps the key
>       names, not the values.)
>     - `ceph config-key list` is deprecated in favor of `ceph config-key ls`.
>     - `ceph config-key put` is deprecated in favor of `ceph config-key set`.
>     - `ceph auth list` is deprecated in favor of `ceph auth ls`.
>     - `ceph osd crush rule list` is deprecated in favor of `ceph osd crush rule ls`.
>     - `ceph osd set-{full,nearfull,backfillfull}-ratio` sets the
>       cluster-wide ratio for various full thresholds (when the cluster
>       refuses IO, when the cluster warns about being close to full,
>       when an OSD will defer rebalancing a PG to itself,
>       respectively).
>     - `ceph osd reweightn` will specify the `reweight` values for
>       multiple OSDs in a single command.  This is equivalent to a series of
>       `ceph osd reweight` commands.
>     - `ceph osd crush {set,rm}-device-class` manage the new
>       CRUSH *device class* feature. Note that manually creating or deleting
>       a device class name is generally not necessary as it will be smart
>       enough to be self-managed. `ceph osd crush class ls` and
>       `ceph osd crush class ls-osd` will output all existing device classes
>       and a list of OSD ids under the given device class respectively.
>     - `ceph osd crush rule create-replicated` replaces the old
>       `ceph osd crush rule create-simple` command to create a CRUSH
>       rule for a replicated pool.  Notably it takes a `class` argument
>       for the *device class* the rule should target (e.g., `ssd` or
>       `hdd`).
>     - `ceph mon feature ls` will list monitor features recorded in the
>       MonMap.  `ceph mon feature set` will set an optional feature (none of
>       these exist yet).
>     - `ceph tell <daemon> help` will now return a usage summary.
>     - `ceph fs authorize` creates a new client key with caps automatically
>       set to access the given CephFS file system.
>     - The `ceph health` structured output (JSON or XML) no longer contains
>       'timechecks' section describing the time sync status.  This
>       information is now available via the 'ceph time-sync-status'
>       command.
>     - Certain extra fields in the `ceph health` structured output that
>       used to appear if the mons were low on disk space (which duplicated
>       the information in the normal health warning messages) are now gone.
>     - The `ceph -w` output no longer contains audit log entries by default.
>       Add a `--watch-channel=audit` or `--watch-channel=*` to see them.
>     - New "ceph -w" behavior - the "ceph -w" output no longer contains
>       I/O rates, available space, pg info, etc. because these are no
>       longer logged to the central log (which is what `ceph -w`
>       shows). The same information can be obtained by running `ceph pg
>       stat`; alternatively, I/O rates per pool can be determined using
>       `ceph osd pool stats`. Although these commands do not
>       self-update like `ceph -w` did, they do have the ability to
>       return formatted output by providing a `--format=<format>`
>       option.
>     - Added new commands `pg force-recovery` and
>       `pg-force-backfill`. Use them to boost recovery or backfill
>       priority of specified pgs, so they're recovered/backfilled
>       before any other. Note that these commands don't interrupt
>       ongoing recovery/backfill, but merely queue specified pgs before
>       others so they're recovered/backfilled as soon as possible. New
>       commands `pg cancel-force-recovery` and `pg
>       cancel-force-backfill` restore default recovery/backfill
>       priority of previously forced pgs.
> 
> Major Changes from Jewel
> ------------------------
> 
> - *RADOS*:
> 
>   * We now default to the AsyncMessenger (`ms type = async`) instead
>     of the legacy SimpleMessenger.  The most noticeable difference is
>     that we now use a fixed sized thread pool for network connections
>     (instead of two threads per socket with SimpleMessenger).
>   * Some OSD failures are now detected almost immediately, whereas
>     previously the heartbeat timeout (which defaults to 20 seconds)
>     had to expire.  This prevents IO from blocking for an extended
>     period for failures where the host remains up but the ceph-osd
>     process is no longer running.
>   * The size of encoded OSDMaps has been reduced.
>   * The OSDs now quiesce scrubbing when recovery or rebalancing is in progress.
> 
> - *RGW*:
> 
>   * RGW now supports the S3 multipart object copy-part API.
>   * It is possible now to reshard an existing bucket offline. Offline
>     bucket resharding currently requires that all IO (especially
>     writes) to the specific bucket is quiesced.  (For automatic online
>     resharding, see the new feature in Luminous above.)
>   * RGW now supports data compression for objects.
>   * Civetweb version has been upgraded to 1.8
>   * The Swift static website API is now supported (S3 support has been added
>     previously).
>   * S3 bucket lifecycle API has been added. Note that currently it only supports
>     object expiration.
>   * Support for custom search filters has been added to the LDAP auth
>     implementation.
>   * Support for NFS version 3 has been added to the RGW NFS gateway.
>   * A Python binding has been created for librgw.
> 
> - *RBD*:
> 
>   * The rbd-mirror daemon now supports replicating dynamic image
>     feature updates and image metadata key/value pairs from the
>     primary image to the non-primary image.
>   * The number of image snapshots can be optionally restricted to a
>     configurable maximum.
>   * The rbd Python API now supports asynchronous IO operations.
> 
> - *CephFS*:
> 
>   * libcephfs function definitions have been changed to enable proper
>     uid/gid control.  The library version has been increased to reflect the
>     interface change.
>   * Standby replay MDS daemons now consume less memory on workloads
>     doing deletions.
>   * Scrub now repairs backtrace, and populates `damage ls` with
>     discovered errors.
>   * A new `pg_files` subcommand to `cephfs-data-scan` can identify
>     files affected by a damaged or lost RADOS PG.
>   * The false-positive "failing to respond to cache pressure" warnings have
>     been fixed.
> 
> 
> Upgrade from Jewel or Kraken
> ----------------------------
> #. Ensure that the `sortbitwise` flag is enabled::
>      # ceph osd set sortbitwise
> #. Make sure your cluster is stable and healthy (no down or
>    recoverying OSDs).  (Optional, but recommended.) #. Do not create any new erasure-code pools while upgrading the monitors.
> #. You can monitor the progress of your upgrade at each stage with the
>    `ceph versions` command, which will tell you what ceph version is
>    running for each type of daemon.
> #. Set the `noout` flag for the duration of the upgrade. (Optional
>    but recommended.)::
>      # ceph osd set noout
> #. Upgrade monitors by installing the new packages and restarting the
>    monitor daemons.  Note that, unlike prior releases, the ceph-mon
>    daemons *must* be upgraded first::
>      # systemctl restart ceph-mon.target
>    Verify the monitor upgrade is complete once all monitors are up by
>    looking for the `luminous` feature string in the mon map.  For
>    example::
>      # ceph mon feature ls
>    should include `luminous` under persistent features::
>      on current monmap (epoch NNN)
>         persistent: [kraken,luminous]
>         required: [kraken,luminous]
> #. Add or restart `ceph-mgr` daemons.  If you are upgrading from
>    kraken, upgrade packages and restart ceph-mgr daemons with::
>      # systemctl restart ceph-mgr.target
>    If you are upgrading from kraken, you may already have ceph-mgr
>    daemons deployed.  If not, or if you are upgrading from jewel, you
>    can deploy new daemons with tools like ceph-deploy or ceph-ansible.
>    For example::
>      # ceph-deploy mgr create HOST
>    Verify the ceph-mgr daemons are running by checking `ceph -s`::
>      # ceph -s
>      ...
>        services:
>         mon: 3 daemons, quorum foo,bar,baz
>         mgr: foo(active), standbys: bar, baz
>      ...
> #. Upgrade all OSDs by installing the new packages and restarting the
>    ceph-osd daemons on all hosts::
>      # systemctl restart ceph-osd.target
>    You can monitor the progress of the OSD upgrades with the new
>    `ceph versions` or `ceph osd versions` command::
>      # ceph osd versions
>      {
>         "ceph version 12.2.0 (...) luminous (stable)": 12,
>         "ceph version 10.2.6 (...)": 3,
>      }
> #. Upgrade all CephFS daemons by upgrading packages and restarting
>    daemons on all hosts::
>      # systemctl restart ceph-mds.target #. Upgrade all radosgw daemons by upgrading packages and restarting
>    daemons on all hosts::
>      # systemctl restart radosgw.target
> #. Complete the upgrade by disallowing pre-luminous OSDs and enabling
>    all new Luminous-only functionality::
>      # ceph osd require-osd-release luminous
>    If you set `noout` at the beginning, be sure to clear it with::
>      # ceph osd unset noout
> #. Verify the cluster is healthy with `ceph health`.
> 
> 
> Upgrading from pre-Jewel releases (like Hammer)
> -----------------------------------------------
> 
> You *must* first upgrade to Jewel (10.2.z) before attempting an upgrade to Luminous.
> 
> 
> Upgrade compatibility notes, Kraken to Luminous
> -----------------------------------------------
> 
> * The configuration option `osd pool erasure code stripe width` has
>   been replaced by `osd pool erasure code stripe unit`, and given
>   the ability to be overridden by the erasure code profile setting
>   `stripe_unit`. For more details see
>   :ref:`erasure-code-profiles`.
> 
> * rbd and cephfs can use erasure coding with bluestore. This may be
>   enabled by setting `allow_ec_overwrites` to `true` for a pool. Since
>   this relies on bluestore's checksumming to do deep scrubbing,
>   enabling this on a pool stored on filestore is not allowed.
> 
> * The `rados df` JSON output now prints numeric values as numbers instead of
>   strings.
> 
> * The `mon_osd_max_op_age` option has been renamed to
>   `mon_osd_warn_op_age` (default: 32 seconds), to indicate we
>   generate a warning at this age.  There is also a new
>   `mon_osd_err_op_age_ratio` that is a expressed as a multitple of
>   `mon_osd_warn_op_age` (default: 128, for roughly 60 minutes) to
>   control when an error is generated.
> 
> * The default maximum size for a single RADOS object has been reduced from
>   100GB to 128MB.  The 100GB limit was completely impractical in practice
>   while the 128MB limit is a bit high but not unreasonable.  If you have an
>   application written directly to librados that is using objects larger than
>   128MB you may need to adjust `osd_max_object_size`.
> 
> * The semantics of the `rados ls` and librados object listing
>   operations have always been a bit confusing in that "whiteout"
>   objects (which logically don't exist and will return ENOENT if you
>   try to access them) are included in the results.  Previously
>   whiteouts only occurred in cache tier pools.  In luminous, logically
>   deleted but snapshotted objects now result in a whiteout object, and
>   as a result they will appear in `rados ls` results, even though
>   trying to read such an object will result in ENOENT.  The `rados
>   listsnaps` operation can be used in such a case to enumerate which
>   snapshots are present.
>   This may seem a bit strange, but is less strange than having a
>   deleted-but-snapshotted object not appear at all and be completely
>   hidden from librados's ability to enumerate objects.  Future
>   versions of Ceph will likely include an alternative object
>   enumeration interface that makes it more natural and efficient to
>   enumerate all objects along with their snapshot and clone metadata.
> 
> * The deprecated `crush_ruleset` property has finally been removed;
>   please use  `crush_rule` instead for the `osd pool get ...` and `osd
>   pool set ...` commands.
> 
> * The `osd pool default crush replicated ruleset` option has been
>   removed and replaced by the `psd pool default crush rule` option.
>   By default it is -1, which means the mon will pick the first type
>   replicated rule in the CRUSH map for replicated pools.  Erasure
>   coded pools have rules that are automatically created for them if
>   they are not specified at pool creation time.
> 
> * We no longer test the FileStore ceph-osd backend in combination with
>   btrfs.  We recommend against using btrfs.  If you are using
>   btrfs-based OSDs and want to upgrade to luminous you will need to
>   add the follwing to your ceph.conf::
> 
>     enable experimental unrecoverable data corrupting features = btrfs
> 
>   The code is mature and unlikely to change, but we are only
>   continuing to test the Jewel stable branch against btrfs.  We
>   recommend moving these OSDs to FileStore with XFS or BlueStore.
> * The `ruleset-*` properties for the erasure code profiles have been
>   renamed to `crush-*` to (1) move away from the obsolete 'ruleset'
>   term and to be more clear about their purpose.  There is also a new
>   optional `crush-device-class` property to specify a CRUSH device
>   class to use for the erasure coded pool.  Existing erasure code
>   profiles will be converted automatically when upgrade completes
>   (when the `ceph osd require-osd-release luminous` command is run)
>   but any provisioning tools that create erasure coded pools may need
>   to be updated.
> * The structure of the XML output for `osd crush tree` has changed
>   slightly to better match the `osd tree` output.  The top level
>   structure is now `nodes` instead of `crush_map_roots`.
> * When assigning a network to the public network and not to
>   the cluster network the network specification of the public
>   network will be used for the cluster network as well.
>   In older versions this would lead to cluster services
>   being bound to 0.0.0.0:<port>, thus making the
>   cluster service even more publicly available than the
>   public services. When only specifying a cluster network it
>   will still result in the public services binding to 0.0.0.0.
> 
> * In previous versions, if a client sent an op to the wrong OSD, the OSD
>   would reply with ENXIO.  The rationale here is that the client or OSD is
>   clearly buggy and we want to surface the error as clearly as possible.
>   We now only send the ENXIO reply if the osd_enxio_on_misdirected_op option
>   is enabled (it's off by default).  This means that a VM using librbd that
>   previously would have gotten an EIO and gone read-only will now see a
>   blocked/hung IO instead.
> 
> * The "journaler allow split entries" config setting has been removed.
> 
> * The 'mon_warn_osd_usage_min_max_delta' config option has been
>   removed and the associated health warning has been disabled because
>   it does not address clusters undergoing recovery or CRUSH rules that do
>   not target all devices in the cluster.
> 
> * Added new configuration "public bind addr" to support dynamic
>   environments like Kubernetes. When set the Ceph MON daemon could
>   bind locally to an IP address and advertise a different IP address
>   `public addr` on the network.
> 
> * The crush `choose_args` encoding has been changed to make it
>   architecture-independent. If you deployed Luminous dev releases or
>   12.1.0 rc release and made use of the CRUSH choose_args feature, you
>   need to remove all choose_args mappings from your CRUSH map before
>   starting the upgrade.
> 
> 
> - *librados*:
> 
>   * Some variants of the omap_get_keys and omap_get_vals librados
>     functions have been deprecated in favor of omap_get_vals2 and
>     omap_get_keys2.  The new methods include an output argument
>     indicating whether there are additional keys left to fetch.
>     Previously this had to be inferred from the requested key count vs
>     the number of keys returned, but this breaks with new OSD-side
>     limits on the number of keys or bytes that can be returned by a
>     single omap request.  These limits were introduced by kraken but
>     are effectively disabled by default (by setting a very large limit
>     of 1 GB) because users of the newly deprecated interface cannot
>     tell whether they should fetch more keys or not.  In the case of
>     the standalone calls in the C++ interface
>     (IoCtx::get_omap_{keys,vals}), librados has been updated to loop on
>     the client side to provide a correct result via multiple calls to
>     the OSD.  In the case of the methods used for building
>     multi-operation transactions, however, client-side looping is not
>     practical, and the methods have been deprecated.  Note that use of
>     either the IoCtx methods on older librados versions or the
>     deprecated methods on any version of librados will lead to
>     incomplete results if/when the new OSD limits are enabled.
> 
>   * The original librados rados_objects_list_open (C) and objects_begin
>     (C++) object listing API, deprecated in Hammer, has finally been
>     removed.  Users of this interface must update their software to use
>     either the rados_nobjects_list_open (C) and nobjects_begin (C++) API or
>     the new rados_object_list_begin (C) and object_list_begin (C++) API
>     before updating the client-side librados library to Luminous.
>     Object enumeration (via any API) with the latest librados version
>     and pre-Hammer OSDs is no longer supported.  Note that no in-tree
>     Ceph services rely on object enumeration via the deprecated APIs, so
>     only external librados users might be affected.
>     The newest (and recommended) rados_object_list_begin (C) and
>     object_list_begin (C++) API is only usable on clusters with the
>     SORTBITWISE flag enabled (Jewel and later).  (Note that this flag is
>     required to be set before upgrading beyond Jewel.)
> 
> - *CephFS*:
> 
>   * When configuring ceph-fuse mounts in /etc/fstab, a new syntax is
>     available that uses "ceph.<arg>=<val>" in the options column, instead
>     of putting configuration in the device column.  The old style syntax
>     still works.  See the documentation page "Mount CephFS in your
>     file systems table" for details.
>   * CephFS clients without the 'p' flag in their authentication capability
>     string will no longer be able to set quotas or any layout fields.  This
>     flag previously only restricted modification of the pool and namespace
>     fields in layouts.
>   * CephFS will generate a health warning if you have fewer standby daemons
>     than it thinks you wanted.  By default this will be 1 if you ever had
>     a standby, and 0 if you did not.  You can customize this using
>     `ceph fs set <fs> standby_count_wanted <number>`.  Setting it
>     to zero will effectively disable the health check.
>   * The "ceph mds tell ..." command has been removed.  It is superceded
>     by "ceph tell mds.<id> ..."
>   * The `apply` mode of cephfs-journal-tool has been removed
> 
> Getting Ceph
> ------------
> 
> * Git at git://github.com/ceph/ceph.git
> * Tarball at http://download.ceph.com/tarballs/ceph-12.2.0.tar.gz
> * For packages, see http://docs.ceph.com/docs/master/install/get-packages/
> * For ceph-deploy, see http://docs.ceph.com/docs/master/install/install-ceph-deploy
> * Release git sha1: 32ce2a3ae5239ee33d6150705cdb24d43bab910c
> 
> --
> Abhishek Lekshmanan
> SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
> N?????r??y??????X??ǧv???)޺{.n?????z?]z????ay?ʇڙ??j??f???h??????w??????j:+v???w????????????zZ+???????j"????i
--8323329-724737504-1504286791=:20435--
