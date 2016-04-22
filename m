From: =?UTF-8?B?0JLQsNGB0LjQu9C40Lkg0JDQvdCz0LDQv9C+0LI=?=
	<angapov@gmail.com>
Subject: Re: [ceph-users] v10.2.0 Jewel released
Date: Fri, 22 Apr 2016 12:18:56 +0300
Message-ID: <CAGtbiz1cFOSbBWadhyq+HtxhTKvfQnHg1LZRsDeLC=mdM0jNuA@mail.gmail.com>
References: <alpine.DEB.2.11.1604211425400.2760@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33242 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978AbcDVJS6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Apr 2016 05:18:58 -0400
Received: by mail-wm0-f66.google.com with SMTP id r12so2629701wme.0
        for <ceph-devel@vger.kernel.org>; Fri, 22 Apr 2016 02:18:57 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1604211425400.2760@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>, ceph-maintainers@ceph.com, ceph-announce@ceph.com

Cool, thanks!

I see many new features in RGW, but where the documentation or
something like that can be found?

Kind regards, Vasily.

2016-04-21 21:30 GMT+03:00 Sage Weil <sage@redhat.com>:
> This major release of Ceph will be the foundation for the next
> long-term stable release.  There have been many major changes since
> the Infernalis (9.2.x) and Hammer (0.94.x) releases, and the upgrade
> process is non-trivial. Please read these release notes carefully.
>
> For the complete release notes, please see
>
>    http://ceph.com/releases/v10-2-0-jewel-released/
>
>
> Major Changes from Infernalis
> -----------------------------
>
> - *CephFS*:
>
>   * This is the first release in which CephFS is declared stable and
>     production ready!  Several features are disabled by default, including
>     snapshots and multiple active MDS servers.
>   * The repair and disaster recovery tools are now feature-complete.
>   * A new cephfs-volume-manager module is included that provides a
>     high-level interface for creating "shares" for OpenStack Manila
>     and similar projects.
>   * There is now experimental support for multiple CephFS file systems
>     within a single cluster.
>
> - *RGW*:
>
>   * The multisite feature has been almost completely rearchitected and
>     rewritten to support any number of clusters/sites, bidirectional
>     fail-over, and active/active configurations.
>   * You can now access radosgw buckets via NFS (experimental).
>   * The AWS4 authentication protocol is now supported.
>   * There is now support for S3 request payer buckets.
>   * The new multitenancy infrastructure improves compatibility with
>     Swift, which provides a separate container namespace for each
>     user/tenant.
>   * The OpenStack Keystone v3 API is now supported.  There are a range
>     of other small Swift API features and compatibility improvements
>     as well, including bulk delete and SLO (static large objects).
>
> - *RBD*:
>
>   * There is new support for mirroring (asynchronous replication) of
>     RBD images across clusters.  This is implemented as a per-RBD
>     image journal that can be streamed across a WAN to another site,
>     and a new rbd-mirror daemon that performs the cross-cluster
>     replication.
>   * The exclusive-lock, object-map, fast-diff, and journaling features
>     can be enabled or disabled dynamically. The deep-flatten features
>     can be disabled dynamically but not re-enabled.
>   * The RBD CLI has been rewritten to provide command-specific help
>     and full bash completion support.
>   * RBD snapshots can now be renamed.
>
> - *RADOS*:
>
>   * BlueStore, a new OSD backend, is included as an experimental
>     feature.  The plan is for it to become the default backend in the
>     K or L release.
>   * The OSD now persists scrub results and provides a librados API to
>     query results in detail.
>   * We have revised our documentation to recommend *against* using
>     ext4 as the underlying filesystem for Ceph OSD daemons due to
>     problems supporting our long object name handling.
>
> Major Changes from Hammer
> -------------------------
>
> - *General*:
>
>   * Ceph daemons are now managed via systemd (with the exception of
>     Ubuntu Trusty, which still uses upstart).
>   * Ceph daemons run as 'ceph' user instead of 'root'.
>   * On Red Hat distros, there is also an SELinux policy.
>
> - *RADOS*:
>
>   * The RADOS cache tier can now proxy write operations to the base
>     tier, allowing writes to be handled without forcing migration of
>     an object into the cache.
>   * The SHEC erasure coding support is no longer flagged as
>     experimental. SHEC trades some additional storage space for faster
>     repair.
>   * There is now a unified queue (and thus prioritization) of client
>     IO, recovery, scrubbing, and snapshot trimming.
>   * There have been many improvements to low-level repair tooling
>     (ceph-objectstore-tool).
>   * The internal ObjectStore API has been significantly cleaned up in order
>     to faciliate new storage backends like BlueStore.
>
> - *RGW*:
>
>   * The Swift API now supports object expiration.
>   * There are many Swift API compatibility improvements.
>
> - *RBD*:
>
>   * The ``rbd du`` command shows actual usage (quickly, when
>     object-map is enabled).
>   * The object-map feature has seen many stability improvements.
>   * The object-map and exclusive-lock features can be enabled or disabled
>     dynamically.
>   * You can now store user metadata and set persistent librbd options
>     associated with individual images.
>   * The new deep-flatten features allow flattening of a clone and all
>     of its snapshots.  (Previously snapshots could not be flattened.)
>   * The export-diff command is now faster (it uses aio).  There is also
>     a new fast-diff feature.
>   * The --size argument can be specified with a suffix for units
>     (e.g., ``--size 64G``).
>   * There is a new ``rbd status`` command that, for now, shows who has
>     the image open/mapped.
>
> - *CephFS*:
>
>   * You can now rename snapshots.
>   * There have been ongoing improvements around administration, diagnostics,
>     and the check and repair tools.
>   * The caching and revocation of client cache state due to unused
>     inodes has been dramatically improved.
>   * The ceph-fuse client behaves better on 32-bit hosts.
>
> Distro compatibility
> --------------------
>
> Starting with Infernalis, we have dropped support for many older
> distributions so that we can move to a newer compiler toolchain (e.g.,
> C++11).  Although it is still possible to build Ceph on older
> distributions by installing backported development tools, we are not
> building and publishing release packages for ceph.com.
>
> We now build packages for the following distributions and architectures:
>
> - x86_64:
>
>   * CentOS 7.x.  We have dropped support for CentOS 6 (and other RHEL 6
>     derivatives, like Scientific Linux 6).
>   * Debian Jessie 8.x.  Debian Wheezy 7.x's g++ has incomplete support
>     for C++11 (and no systemd).
>   * Ubuntu Xenial 16.04 and Trusty 14.04.  Ubuntu Precise 12.04 is no
>     longer supported.
>   * Fedora 22 or later.
>
> - aarch64 / arm64:
>
>   * Ubuntu Xenial 16.04.
>
> Upgrading from Infernalis or Hammer
> -----------------------------------
>
> * We now recommend against using ``ext4`` as the underlying file
>   system for Ceph OSDs, especially when RGW or other users of long
>   RADOS object names are used.  For more information about why, please
>   see `Filesystem Recommendations`_.
>
>   If you have an existing cluster that uses ext4 for the OSDs but uses only
>   RBD and/or CephFS, then the ext4 limitations will not affect you.  Before
>   upgrading, be sure add the following to ``ceph.conf`` to allow the OSDs to
>   start::
>
>     osd max object name len = 256
>     osd max object namespace len = 64
>
>   Keep in mind that if you set these lower object name limits and
>   later decide to use RGW on this cluster, it will have problems
>   storing S3/Swift objects with long names.  This startup check can also be
>   disabled via the below option, although this is not recommended::
>
>     osd check max object name len on startup = false
>
> .. _Filesystem Recommendations: ../configuration/filesystem-recommendations
>
> * There are no major compatibility changes since Infernalis.  Simply
>   upgrading the daemons on each host and restarting all daemons is
>   sufficient.
>
> * The rbd CLI no longer accepts the deprecated '--image-features' option
>   during create, import, and clone operations.  The '--image-feature'
>   option should be used instead.
>
> * The rbd legacy image format (version 1) is deprecated with the Jewel release.
>   Attempting to create a new version 1 RBD image will result in a warning.
>   Future releases of Ceph will remove support for version 1 RBD images.
>
> * The 'send_pg_creates' and 'map_pg_creates' mon CLI commands are
>   obsolete and no longer supported.
>
> * A new configure option 'mon_election_timeout' is added to specifically
>   limit max waiting time of monitor election process, which was previously
>   restricted by 'mon_lease'.
>
> * CephFS filesystems created using versions older than Firefly (0.80) must
>   use the new 'cephfs-data-scan tmap_upgrade' command after upgrading to
>   Jewel.  See 'Upgrading' in the CephFS documentation for more information.
>
> * The 'ceph mds setmap' command has been removed.
>
> * The default RBD image features for new images have been updated to
>   enable the following: exclusive lock, object map, fast-diff, and
>   deep-flatten. These features are not currently supported by the RBD
>   kernel driver nor older RBD clients. They can be disabled on a per-image
>   basis via the RBD CLI, or the default features can be updated to the
>   pre-Jewel setting by adding the following to the client section of the Ceph
>   configuration file::
>
>     rbd default features = 1
>
> * The rbd legacy image format (version 1) is deprecated with the Jewel
>   release.
>
> * After upgrading, users should set the 'sortbitwise' flag to enable the new
>   internal object sort order::
>
>     ceph osd set sortbitwise
>
>   This flag is important for the new object enumeration API and for
>   new backends like BlueStore.
>
> * The rbd CLI no longer permits creating images and snapshots with potentially
>   ambiguous names (e.g. the '/' and '@' characters are disallowed). The
>   validation can be temporarily disabled by adding "--rbd-validate-names=false"
>   to the rbd CLI when creating an image or snapshot. It can also be disabled
>   by adding the following to the client section of the Ceph configuration file::
>
>     rbd validate names = false
>
> Upgrading from Hammer
> ---------------------
>
> * All cluster nodes must first upgrade to Hammer v0.94.4 or a later
>   v0.94.z release; only then is it possible to upgrade to Jewel
>   10.2.z.
>
> * For all distributions that support systemd (CentOS 7, Fedora, Debian
>   Jessie 8.x, OpenSUSE), ceph daemons are now managed using native systemd
>   files instead of the legacy sysvinit scripts.  For example,::
>
>     systemctl start ceph.target       # start all daemons
>     systemctl status ceph-osd@12      # check status of osd.12
>
>   The main notable distro that is *not* yet using systemd is Ubuntu trusty
>   14.04.  (The next Ubuntu LTS, 16.04, will use systemd instead of upstart.)
>
> * Ceph daemons now run as user and group ``ceph`` by default.  The
>   ceph user has a static UID assigned by Fedora and Debian (also used by
>   derivative distributions like RHEL/CentOS and Ubuntu).  On SUSE the same
>   UID/GID as in Fedora and Debian will be used, *provided it is not already
>   assigned*. In the unlikely event the preferred UID or GID is assigned to a
>   different user/group, ceph will get a dynamically assigned UID/GID.
>
>   If your systems already have a ceph user, upgrading the package will cause
>   problems.  We suggest you first remove or rename the existing 'ceph' user
>   and 'ceph' group before upgrading.
>
>   When upgrading, administrators have two options:
>
>    #. Add the following line to ``ceph.conf`` on all hosts::
>
>         setuser match path = /var/lib/ceph/$type/$cluster-$id
>
>       This will make the Ceph daemons run as root (i.e., not drop
>       privileges and switch to user ceph) if the daemon's data
>       directory is still owned by root.  Newly deployed daemons will
>       be created with data owned by user ceph and will run with
>       reduced privileges, but upgraded daemons will continue to run as
>       root.
>
>    #. Fix the data ownership during the upgrade.  This is the
>       preferred option, but it is more work and can be very time
>       consuming.  The process for each host is to:
>
>       #. Upgrade the ceph package.  This creates the ceph user and group.  For
>          example::
>
>            ceph-deploy install --stable jewel HOST
>
>       #. Stop the daemon(s).::
>
>            service ceph stop           # fedora, centos, rhel, debian
>            stop ceph-all               # ubuntu
>
>       #. Fix the ownership::
>
>            chown -R ceph:ceph /var/lib/ceph
>
>       #. Restart the daemon(s).::
>
>            start ceph-all                # ubuntu
>            systemctl start ceph.target   # debian, centos, fedora, rhel
>
>       Alternatively, the same process can be done with a single daemon
>       type, for example by stopping only monitors and chowning only
>       ``/var/lib/ceph/mon``.
>
> * The on-disk format for the experimental KeyValueStore OSD backend has
>   changed.  You will need to remove any OSDs using that backend before you
>   upgrade any test clusters that use it.
>
> * When a pool quota is reached, librados operations now block indefinitely,
>   the same way they do when the cluster fills up.  (Previously they would return
>   -ENOSPC.)  By default, a full cluster or pool will now block.  If your
>   librados application can handle ENOSPC or EDQUOT errors gracefully, you can
>   get error returns instead by using the new librados OPERATION_FULL_TRY flag.
>
> * The return code for librbd's rbd_aio_read and Image::aio_read API methods no
>   longer returns the number of bytes read upon success.  Instead, it returns 0
>   upon success and a negative value upon failure.
>
> * 'ceph scrub', 'ceph compact' and 'ceph sync force' are now DEPRECATED.  Users
>   should instead use 'ceph mon scrub', 'ceph mon compact' and
>   'ceph mon sync force'.
>
> * 'ceph mon_metadata' should now be used as 'ceph mon metadata'. There is no
>   need to deprecate this command (same major release since it was first
>   introduced).
>
> * The `--dump-json` option of "osdmaptool" is replaced by `--dump json`.
>
> * The commands of "pg ls-by-{pool,primary,osd}" and "pg ls" now take "recovering"
>   instead of "recovery", to include the recovering pgs in the listed pgs.
>
> Upgrading from Firefly
> ----------------------
>
> Upgrading directly from Firefly v0.80.z is not recommended.  It is
> possible to do a direct upgrade, but not without downtime, as all OSDs
> must be stopped, upgraded, and then restarted.  We recommend that
> clusters be first upgraded to Hammer v0.94.6 or a later v0.94.z
> release; only then is it possible to upgrade to Jewel 10.2.z for an
> online upgrade (see below).
>
> To do an offline upgrade directly from Firefly, all Firefly OSDs must
> be stopped and marked down before any Jewel OSDs will be allowed
> to start up.  This fencing is enforced by the Jewel monitor, so
> you should use an upgrade procedure like:
>
>   #. Upgrade Ceph on monitor hosts
>   #. Restart all ceph-mon daemons
>   #. Set noout::
>        ceph osd set noout
>   #. Upgrade Ceph on all OSD hosts
>   #. Stop all ceph-osd daemons
>   #. Mark all OSDs down with something like::
>        ceph osd down `seq 0 1000`
>   #. Start all ceph-osd daemons
>   #. Let the cluster settle and then unset noout::
>        ceph osd unset noout
>   #. Upgrade and restart any remaining daemons (ceph-mds, radosgw)
>
>
> Getting Ceph
> ------------
>
> * Git at git://github.com/ceph/ceph.git
> * Tarball at http://download.ceph.com/tarballs/ceph-10.2.0.tar.gz
> * For packages, see http://ceph.com/docs/master/install/get-packages
> * For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-deploy
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
