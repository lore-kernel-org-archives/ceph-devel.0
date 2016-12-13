From: Abhishek L <abhishek.lekshmanan@gmail.com>
Subject: v11.1.0 kraken candidate released
Date: Tue, 13 Dec 2016 03:28:39 +0100
Message-ID: <CAEw75dP3cgkF7kv9Nb9wsoa0K3j4h4zinZJo=gJB8aXSEYDEmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37941 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752965AbcLMC2l (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Dec 2016 21:28:41 -0500
Received: by mail-wm0-f50.google.com with SMTP id f82so97953085wmf.1
        for <ceph-devel@vger.kernel.org>; Mon, 12 Dec 2016 18:28:40 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>, ceph-maintainers@ceph.com, ceph-announce@ceph.com

Hi everyone,

This is the first release candidate for Kraken, the next stable
release series. There have been major changes from jewel with many
features being added. Please note the upgrade process from jewel,
before upgrading.

Major Changes from Jewel
------------------------

- *RADOS*:

  * The new *BlueStore* backend now has a stable disk format and is
    passing our failure and stress testing. Although the backend is
    still flagged as experimental, we encourage users to try it out
    for non-production clusters and non-critical data sets.
  * RADOS now has experimental support for *overwrites on
    erasure-coded* pools. Because the disk format and implementation
    are not yet finalized, there is a special pool option that must be
    enabled to test the new feature.  Enabling this option on a cluster
    will permanently bar that cluster from being upgraded to future
    versions.
  * We now default to the AsyncMessenger (``ms type = async``) instead
    of the legacy SimpleMessenger.  The most noticeable difference is
    that we now use a fixed sized thread pool for network connections
    (instead of two threads per socket with SimpleMessenger).
  * Some OSD failures are now detected almost immediately, whereas
    previously the heartbeat timeout (which defaults to 20 seconds)
    had to expire.  This prevents IO from blocking for an extended
    period for failures where the host remains up but the ceph-osd
    process is no longer running.
  * There is a new ``ceph-mgr`` daemon.  It is currently collocated with
    the monitors by default, and is not yet used for much, but the basic
    infrastructure is now in place.
  * The size of encoded OSDMaps has been reduced.
  * The OSDs now quiesce scrubbing when recovery or rebalancing is in progress.

- *RGW*:

  * RGW now supports a new zone type that can be used for metadata indexing
    via Elasticseasrch.
  * RGW now supports the S3 multipart object copy-part API.
  * It is possible now to reshard an existing bucket. Note that bucket
    resharding currently requires that all IO (especially writes) to
    the specific bucket is quiesced.
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

  * RBD now supports images stored in an *erasure-coded* RADOS pool
    using the new (experimental) overwrite support. Images must be
    created using the new rbd CLI "--data-pool <ec pool>" option to
    specify the EC pool where the backing data objects are
    stored. Attempting to create an image directly on an EC pool will
    not be successful since the image's backing metadata is only
    supported on a replicated pool.
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


Upgrading from Jewel
--------------------

* All clusters must first be upgraded to Jewel 10.2.z before upgrading
  to Kraken 11.2.z (or, eventually, Luminous 12.2.z).

* The ``sortbitwise`` flag must be set on the Jewel cluster before upgrading
  to Kraken.  The latest Jewel (10.2.4+) releases issue a health warning if
  the flag is not set, so this is probably already set.  If it is not, Kraken
  OSDs will refuse to start and will print and error message in their log.


Upgrading
---------

* The list of monitor hosts/addresses for building the monmap can now be
  obtained from DNS SRV records. The service name used in when querying the DNS
  is defined in the "mon_dns_srv_name" config option, which defaults to
  "ceph-mon".

* The 'osd class load list' config option is a list of object class names that
  the OSD is permitted to load (or '*' for all classes). By default it
  contains all existing in-tree classes for backwards compatibility.

* The 'osd class default list' config option is a list of object class
  names (or '*' for all classes) that clients may invoke having only
  the '*', 'x', 'class-read', or 'class-write' capabilities. By
  default it contains all existing in-tree classes for backwards
  compatibility. Invoking classes not listed in 'osd class default
  list' requires a capability naming the class (e.g. 'allow class
  foo').

* The 'rgw rest getusage op compat' config option allows you to dump
  (or not dump) the description of user stats in the S3 GetUsage
  API. This option defaults to false.  If the value is true, the
  reponse data for GetUsage looks like::

    "stats": {
                "TotalBytes": 516,
                "TotalBytesRounded": 1024,
                "TotalEntries": 1
             }

  If the value is false, the reponse for GetUsage looks as it did before::

    {
         516,
         1024,
         1
    }

* The 'osd out ...' and 'osd in ...' commands now preserve the OSD
  weight.  That is, after marking an OSD out and then in, the weight
  will be the same as before (instead of being reset to 1.0).
  Previously the mons would only preserve the weight if the mon
  automatically marked and OSD out and then in, but not when an admin
  did so explicitly.

* The 'ceph osd perf' command will display 'commit_latency(ms)' and
  'apply_latency(ms)'. Previously, the names of these two columns are
  'fs_commit_latency(ms)' and 'fs_apply_latency(ms)'. We remove the
  prefix 'fs_', because they are not filestore specific.

* Monitors will no longer allow pools to be removed by default.  The
  setting mon_allow_pool_delete has to be set to true (defaults to
  false) before they allow pools to be removed.  This is a additional
  safeguard against pools being removed by accident.

* If you have manually specified the monitor user rocksdb via the
  ``mon keyvaluedb = rocksdb`` option, you will need to manually add a
  file to the mon data directory to preserve this option::

     echo rocksdb > /var/lib/ceph/mon/ceph-`hostname`/kv_backend

  New monitors will now use rocksdb by default, but if that file is
  not present, existing monitors will use leveldb.  The ``mon
  keyvaluedb`` option now only affects the backend chosen when a
  monitor is created.

* The 'osd crush initial weight' option allows you to specify a CRUSH
  weight for a newly added OSD.  Previously a value of 0 (the default)
  meant that we should use the size of the OSD's store to weight the
  new OSD.  Now, a value of 0 means it should have a weight of 0, and
  a negative value (the new default) means we should automatically
  weight the OSD based on its size.  If your configuration file
  explicitly specifies a value of 0 for this option you will need to
  change it to a negative value (e.g., -1) to preserve the current
  behavior.

* The `osd crush location` config option is no longer supported.  Please
  update your ceph.conf to use the `crush location` option instead.

* The static libraries are no longer included by the debian
  development packages (lib*-dev) as it is not required per debian
  packaging policy.  The shared (.so) versions are packaged as before.

* The libtool pseudo-libraries (.la files) are no longer included by
  the debian development packages (lib*-dev) as they are not required
  per https://wiki.debian.org/ReleaseGoals/LAFileRemoval and
  https://www.debian.org/doc/manuals/maint-guide/advanced.en.html.

* The jerasure and shec plugins can now detect SIMD instruction at
  runtime and no longer need to be explicitly configured for different
  processors.  The following plugins are now deprecated:
  jerasure_generic, jerasure_sse3, jerasure_sse4, jerasure_neon,
  shec_generic, shec_sse3, shec_sse4, and shec_neon. If you use any of
  these plugins directly you will see a warning in the mon log file.
  Please switch to using just 'jerasure' or 'shec'.

* The librados omap get_keys and get_vals operations include a start key and a
  limit on the number of keys to return.  The OSD now imposes a configurable
  limit on the number of keys and number of total bytes it will respond with,
  which means that a librados user might get fewer keys than they asked for.
  This is necessary to prevent careless users from requesting an unreasonable
  amount of data from the cluster in a single operation.  The new limits are
  configured with `osd_max_omap_entries_per_request`, defaulting to 131,072, and
  'osd_max_omap_bytes_per_request', defaulting to 4MB.



Due to the really long changelog in this release, please read the
detailed feature list here:
http://ceph.com/releases/v11-1-0-kraken-released/

The debian and rpm packages are available at the usual locations at
http://download.ceph.com/debian-kraken/ and
http://download.ceph.com/rpm-kraken respectively. For more details refer
below.


Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://download.ceph.com/tarballs/ceph-11.1.0.tar.gz
* For packages, see http://ceph.com/docs/master/install/get-packages
* For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-deploy

Best,
Abhishek
