From: Abhishek L <abhishek@suse.com>
Subject: v12.1.0 Luminous RC released
Date: Fri, 23 Jun 2017 17:13:57 +0200
Message-ID: <874lv6losq.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:49974 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754545AbdFWPOE (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Fri, 23 Jun 2017 11:14:04 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com, ceph-announce@ceph.com

This is the first release candidate for Luminous, the next long term
stable release.

Ceph Luminous will be the foundation for the next long-term
stable release series.  There have been major changes since Kraken
(v11.2.z) and Jewel (v10.2.z).

Major Changes from Kraken
-------------------------

- *General*:

  * Ceph now has a simple, built-in web-based dashboard for monitoring
    cluster status.

- *RADOS*:

  * *BlueStore*:

    - The new *BlueStore* backend for *ceph-osd* is now stable and the new
      default for newly created OSDs.  BlueStore manages data stored by each OSD
      by directly managing the physical HDDs or SSDs without the use of an
      intervening file system like XFS.  This provides greater performance
      and features.
    - BlueStore supports *full data and metadata checksums* of all
      data stored by Ceph.
    - BlueStore supports inline compression using zlib, snappy, or LZ4.  (Ceph
      also supports zstd for RGW compression but zstd is not recommended for
      BlueStore for performance reasons.)

  * *Erasure coded* pools now have full support for *overwrites*,
    allowing them to be used with RBD and CephFS.

  * *ceph-mgr*:

    - There is a new daemon, *ceph-mgr*, which is a required part of any
      Ceph deployment.  Although IO can continue when *ceph-mgr* is
      down, metrics will not refresh and some metrics-related calls
      (e.g., ``ceph df``) may block.  We recommend deploying several instances of
      *ceph-mgr* for reliability.  See the notes on `Upgrading`_ below.
    - The *ceph-mgr* daemon includes a REST-based management API.  The
      API is still experimental and somewhat limited but will form the basis
      for API-based management of Ceph going forward.

  * The overall *scalability* of the cluster has improved. We have
    successfully tested clusters with up to 10,000 OSDs.
  * Each OSD can now have a *device class* associated with it (e.g., `hdd` or
    `ssd`), allowing CRUSH rules to trivially map data to a subset of devices
    in the system.  Manually writing CRUSH rules or manual editing of the CRUSH
    is normally not required.
  * You can now *optimize CRUSH weights* can now be optimized to
    maintain a *near-perfect distribution of data* across OSDs.
  * There is also a new `upmap` exception mechanism that allows
    individual PGs to be moved around to achieve a *perfect
    distribution* (this requires luminous clients).
  * Each OSD now adjusts its default configuration based on whether the
    backing device is an HDD or SSD.  Manual tuning generally not required.
  * The prototype *mclock QoS queueing algorithm* is now available.
  * There is now a *backoff* mechanism that prevents OSDs from being
    overloaded by requests to objects or PGs that are not currently able to
    process IO.
  * There is a *simplified OSD replacement process* that is more robust.
  * You can query the supported features and (apparent) releases of
    all connected daemons and clients with ``ceph features``.
  * You can configure the oldest Ceph client version you wish to allow to
    connect to the cluster via ``ceph osd set-require-min-compat-client`` and
    Ceph will prevent you from enabling features that will break compatibility
    with those clients.
  * Several `sleep` settings, include ``osd_recovery_sleep``,
    ``osd_snap_trim_sleep``, and ``osd_scrub_sleep`` have been
    reimplemented to work efficiently.  (These are used in some cases
    to work around issues throttling background work.)

- *RGW*:

  * RGW *metadata search* backed by ElasticSearch now supports end
    user requests service via RGW itself, and also supports custom
    metadata fields. A query language a set of RESTful APIs were
    created for users to be able to search objects by their
    metadata. New APIs that allow control of custom metadata fields
    were also added.
  * RGW now supports *dynamic bucket index sharding*.  As the number
    of objects in a bucket grows, RGW will automatically reshard the
    bucket index in response.  No user intervention or bucket size
    capacity planning is required.
  * RGW introduces *server side encryption* of uploaded objects with
    three options for the management of encryption keys: automatic
    encryption (only recommended for test setups), customer provided
    keys similar to Amazon SSE-C specification, and through the use of
    an external key management service (Openstack Barbician) similar
    to Amazon SSE-KMS specification.
  * RGW now has preliminary AWS-like bucket policy API support.  For
    now, policy is a means to express a range of new authorization
    concepts.  In the future it will be the founation for additional
    auth capabilities such as STS and group policy.
  * RGW has consolidated the several metadata index pools via the use of rados
    namespaces.

- *RBD*:

  * RBD now has full, stable support for *erasure coded pools* via the new
    ``--data-pool`` option to ``rbd create``.
  * RBD mirroring's rbd-mirror daemon is now highly available. We
    recommend deploying several instances of rbd-mirror for
    reliability.
  * The default 'rbd' pool is no longer created automatically during
    cluster creation. Additionally, the name of the default pool used
    by the rbd CLI when no pool is specified can be overridden via a
    new ``rbd default pool = <pool name>`` configuration option.
  * Initial support for deferred image deletion via new ``rbd
    trash`` CLI commands. Images, even ones actively in-use by
    clones, can be moved to the trash and deleted at a later time.
  * New pool-level ``rbd mirror pool promote`` and ``rbd mirror pool
    demote`` commands to batch promote/demote all mirrored images
    within a pool.
  * Mirroring now optionally supports a configurable replication delay
    via the ``rbd mirroring replay delay = <seconds>`` configuration
    option.
  * Improved discard handling when the object map feature is enabled.
  * rbd CLI ``import`` and ``copy`` commands now detect sparse and
    preserve sparse regions.
  * Snapshots will now include a creation timestamp

- *CephFS*:

  * *Multiple active MDS daemons* is now considered stable.  The number
    of active MDS servers may be adjusted up or down on an active CephFS file
    system.
  * CephFS *directory fragmentation* is now stable and enabled by
    default on new filesystems.  To enable it on existing filesystems
    use "ceph fs set <fs_name> allow_dirfrags".  Large or very busy
    directories are sharded and (potentially) distributed across
    multiple MDS daemons automatically.
  * Directory subtrees can be explicitly pinned to specific MDS daemons in
    cases where the automatic load balancing is not desired or effective.

- *Miscellaneous*:

  * Release packages are now being built for *Debian Stretch*.  The
    distributions we build for now includes:

    - CentOS 7 (x86_64 and aarch64)
    - Debian 8 Jessie (x86_64)
    - Debian 9 Stretch (x86_64)
    - Ubuntu 16.04 Xenial (x86_64 and aarch64)
    - Ubuntu 14.04 Trusty (x86_64)

    Note that QA is limited to CentOS and Ubuntu (xenial and trusty).

  * *CLI changes*:

    - The ``ceph -s`` or ``ceph status`` command has a fresh look.
    - ``ceph {osd,mds,mon} versions`` summarizes versions of running daemons.
    - ``ceph {osd,mds,mon} count-metadata <property>`` similarly
      tabulates any other daemon metadata visible via the ``ceph
      {osd,mds,mon} metadata`` commands.
    - ``ceph features`` summarizes features and releases of connected
      clients and daemons.
    - ``ceph osd require-osd-release <release>`` replaces the old
      ``require_RELEASE_osds`` flags.
    - ``ceph osd pg-upmap``, ``ceph osd rm-pg-upmap``, ``ceph osd
      pg-upmap-items``, ``ceph osd rm-pg-upmap-items`` can explicitly
      manage `upmap` items.
    - ``ceph osd getcrushmap`` returns a crush map version number on
      stderr, and ``ceph osd setcrushmap [version]`` will only inject
      an updated crush map if the version matches.  This allows crush
      maps to be updated offline and then reinjected into the cluster
      without fear of clobbering racing changes (e.g., by newly added
      osds or changes by other administrators).
    - ``ceph osd create`` has been replaced by ``ceph osd new``.  This
      should be hidden from most users by user-facing tools like
      `ceph-disk`.
    - ``ceph osd destroy`` will mark an OSD destroyed and remove its
      cephx and lockbox keys.  However, the OSD id and CRUSH map entry
      will remain in place, allowing the id to be reused by a
      replacement device with minimal data rebalancing.
    - ``ceph osd purge`` will remove all traces of an OSD from the
      cluster, including its cephx encryption keys, dm-crypt lockbox
      keys, OSD id, and crush map entry.
    - ``ceph osd ls-tree <name>`` will output a list of OSD ids under
      the given CRUSH name (like a host or rack name).  This is useful
      for applying changes to entire subtrees.  For example, ``ceph
      osd down `ceph osd ls-tree rack1```.
    - ``ceph osd {add,rm}-{noout,noin,nodown,noup}`` allow the
      `noout`, `nodown`, `noin`, and `noup` flags to be applied to
      specific OSDs.
    - ``ceph log last [n]`` will output the last *n* lines of the cluster
      log.
    - ``ceph mgr dump`` will dump the MgrMap, including the currently active
      ceph-mgr daemon and any standbys.
    - ``ceph osd crush swap-bucket <src> <dest>`` will swap the
      contents of two CRUSH buckets in the hierarchy while preserving
      the buckets' ids.  This allows an entire subtree of devices to
      be replaced (e.g., to replace an entire host of FileStore OSDs
      with newly-imaged BlueStore OSDs) without disrupting the
      distribution of data across neighboring devices.
    - ``ceph osd set-require-min-compat-client <release>`` configures
      the oldest client release the cluster is required to support.
      Other changes, like CRUSH tunables, will fail with an error if
      they would violate this setting.  Changing this setting also
      fails if clients older than the specified release are currently
      connected to the cluster.
    - ``ceph config-key dump`` dumps config-key entries and their
      contents.  (The exist ``ceph config-key ls`` only dumps the key
      names, not the values.)
    - ``ceph osd set-{full,nearfull,backfillfull}-ratio`` sets the
      cluster-wide ratio for various full thresholds (when the cluster
      refuses IO, when the cluster warns about being close to full,
      when an OSD will defer rebalancing a PG to itself,
      respectively).
    - ``ceph osd reweightn`` will specify the `reweight` values for
      multiple OSDs in a single command.  This is equivalent to a series of
      ``ceph osd reweight`` commands.
    - ``ceph crush class {create,rm,ls}`` manage the new CRUSH *device
      class* feature.  ``ceph crush set-device-class <osd> <class>``
      will set the clas for a particular device.
    - ``ceph mon feature ls`` will list monitor features recorded in the
      MonMap.  ``ceph mon feature set`` will set an optional feature (none of
      these exist yet).

Major Changes from Jewel
------------------------

- *RADOS*:

  * We now default to the AsyncMessenger (``ms type = async``) instead
    of the legacy SimpleMessenger.  The most noticeable difference is
    that we now use a fixed sized thread pool for network connections
    (instead of two threads per socket with SimpleMessenger).
  * Some OSD failures are now detected almost immediately, whereas
    previously the heartbeat timeout (which defaults to 20 seconds)
    had to expire.  This prevents IO from blocking for an extended
    period for failures where the host remains up but the ceph-osd
    process is no longer running.
  * The size of encoded OSDMaps has been reduced.
  * The OSDs now quiesce scrubbing when recovery or rebalancing is in progress.

- *RGW*:

  * RGW now supports the S3 multipart object copy-part API.
  * It is possible now to reshard an existing bucket offline. Offline
    bucket resharding currently requires that all IO (especially
    writes) to the specific bucket is quiesced.  (For automatic online
    resharding, see the new feature in Luminous above.)
  * RGW now supports data compression for objects.
  * Civetweb version has been upgraded to 1.8
  * The Swift static website API is now supported (S3 support has been added
    previously).
  * S3 bucket lifecycle API has been added. Note that currently it only supports
    object expiration.
  * Support for custom search filters has been added to the LDAP auth
    implementation.
  * Support for NFS version 3 has been added to the RGW NFS gateway.
  * A Python binding has been created for librgw.

- *RBD*:

  * The rbd-mirror daemon now supports replicating dynamic image
    feature updates and image metadata key/value pairs from the
    primary image to the non-primary image.
  * The number of image snapshots can be optionally restricted to a
    configurable maximum.
  * The rbd Python API now supports asynchronous IO operations.

- *CephFS*:

  * libcephfs function definitions have been changed to enable proper
    uid/gid control.  The library version has been increased to reflect the
    interface change.
  * Standby replay MDS daemons now consume less memory on workloads
    doing deletions.
  * Scrub now repairs backtrace, and populates `damage ls` with
    discovered errors.
  * A new `pg_files` subcommand to `cephfs-data-scan` can identify
    files affected by a damaged or lost RADOS PG.
  * The false-positive "failing to respond to cache pressure" warnings have
    been fixed.

For more details refer to the detailed blog entry at
http://ceph.com/releases/v12-1-0-luminous-rc-released/

* Git at git://github.com/ceph/ceph.git
* Tarball at http://download.ceph.com/tarballs/ceph-12.1.0.tar.gz
* For packages, see http://docs.ceph.com/docs/master/install/get-packages/
* For ceph-deploy, see http://docs.ceph.com/docs/master/install/install-ceph-deploy
* Release sha1: 262617c9f16c55e863693258061c5b25dea5b086

--
Abhishek Lekshmanan
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
