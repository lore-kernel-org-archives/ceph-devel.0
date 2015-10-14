From: Sage Weil <sage@newdream.net>
Subject: RE: v9.1.0 Infernalis release candidate released
Date: Wed, 14 Oct 2015 14:29:46 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510141427480.16833@cobra.newdream.net>
References: <alpine.DEB.2.00.1510131356001.27022@cobra.newdream.net> <BC97738F8E7C8742BABED7F06FB9DF9192520E74@SATLEXDAG01.amd.com> <alpine.DEB.2.00.1510141038050.6589@cobra.newdream.net> <BC97738F8E7C8742BABED7F06FB9DF919252102A@SATLEXDAG01.amd.com>
 <alpine.DEB.2.00.1510141357230.16833@cobra.newdream.net> <BC97738F8E7C8742BABED7F06FB9DF9192521074@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52527 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932101AbbJNV3r (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Oct 2015 17:29:47 -0400
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF9192521074@SATLEXDAG01.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 14 Oct 2015, Deneau, Tom wrote:
> > -----Original Message-----
> > From: Sage Weil [mailto:sage@newdream.net]
> > Sent: Wednesday, October 14, 2015 3:59 PM
> > To: Deneau, Tom
> > Cc: ceph-devel@vger.kernel.org
> > Subject: RE: v9.1.0 Infernalis release candidate released
> > 
> > On Wed, 14 Oct 2015, Deneau, Tom wrote:
> > > Trying to bring up a cluster using the pre-built binary packages on
> > Ubuntu Trusty:
> > > Installed using "ceph-deploy install --dev infernalis `hostname`"
> > >
> > > This install seemed to work but then when I later tried
> > >    ceph-deploy --overwrite-conf mon create-initial it failed with
> > > [][INFO  ] Running command: ceph --cluster=ceph --admin-daemon
> > > /var/run/ceph/ceph-mon.myhost.asok \ mon_status [][ERROR ]
> > > admin_socket: exception getting command descriptions: [Errno 2] No
> > > such file or directory
> > >
> > > and indeed /var/run/ceph was empty.
> > >
> > > I wasn't sure if this was due to an existing user named ceph (I hadn't
> > > checked) but I did a userdel of ceph and ceph-deploy uninstall and
> > reinstall.
> > >
> > > Now the install part is getting an error near where it tries to create
> > the ceph user.
> > >
> > > [][DEBUG ] Adding system user ceph....done [][DEBUG ] Setting system
> > > user ceph properties..Processing triggers for libc-bin (2.19-0ubuntu6.6)
> > ...
> > > [][WARNIN] usermod: user 'ceph' does not exist
> > >
> > > Any suggestions for recovering from this situation?
> > 
> > I'm guessing this is.. trusty?  Did you remove the package, then veirfy
> > the user is deleted, then (re)install?  You may need to do a dpkg purge
> > (not just uninstall/remove) to make it forget its state...
> > 
> > I'm re-running the ceph-deploy test suite (centos7, trusty) to make sure
> > nothing is awry...
> > 
> > 	http://pulpito.ceph.com/sage-2015-10-14_13:55:41-ceph-deploy-
> > infernalis---basic-vps/
> > 
> > sage
> > 
> 
> Yes, did the steps above including purge.
> Could I just manually create the ceph user to get around this?

You could, but since the above tests just passed, I'm super curious why 
it's failing for you.  This is the relevant piece of code:

	https://github.com/ceph/ceph/blob/infernalis/debian/ceph-common.postinst#L60

After it fails, is ceph in /etc/passwd?  Is there anything in 
/etc/default/ceph that could be clobbering the defaults?

sage



> 
> -- Tom
> 
> > 
> > > -- Tom
> > >
> > > > -----Original Message-----
> > > > From: Sage Weil [mailto:sage@newdream.net]
> > > > Sent: Wednesday, October 14, 2015 12:40 PM
> > > > To: Deneau, Tom
> > > > Cc: ceph-devel@vger.kernel.org
> > > > Subject: RE: v9.1.0 Infernalis release candidate released
> > > >
> > > > On Wed, 14 Oct 2015, Deneau, Tom wrote:
> > > > > I tried an rpmbuild on Fedora21 from the tarball which seemed to
> > > > > work
> > > > ok.
> > > > > But having trouble doing "ceph-deploy --overwrite-conf mon create-
> > > > initial" with 9.1.0".
> > > > > This is using ceph-deploy version 1.5.24.
> > > > > Is this part of the "needs Fedora 22 or later" story?
> > > >
> > > > Yeah I think so, but it's probably mostly a "tested fc22 and it
> > worked"
> > > > situation.  THis is probably what is failing:
> > > >
> > > > https://github.com/ceph/ceph-
> > > > deploy/blob/master/ceph_deploy/hosts/fedora/__init__.py#L21
> > > >
> > > > So maybe the specfile isn't using systemd for fc21?
> > > >
> > > > sage
> > > >
> > > >
> > > > >
> > > > > -- Tom
> > > > >
> > > > > [myhost][DEBUG ] create a done file to avoid re-doing the mon
> > > > > deployment [myhost][DEBUG ] create the init path if it does not
> > > > > exist [myhost][DEBUG ] locating the `service` executable...
> > > > > [myhost][INFO  ] Running command: /usr/sbin/service ceph -c
> > > > > /etc/ceph/ceph.conf start mon.myhost [myhost][WARNIN] The service
> > > > > command supports only basic LSB actions (start, stop, restart,
> > > > > try-
> > > > restart, reload, force-reload, sta\ tus). For other actions, please
> > > > try to use systemctl.
> > > > > [myhost][ERROR ] RuntimeError: command returned non-zero exit
> > status:
> > > > > 2 [ceph_deploy.mon][ERROR ] Failed to execute command:
> > > > > /usr/sbin/service ceph -c /etc/ceph/ceph.conf start mon.myhost
> > > > > [ceph_deploy][ERROR ] GenericError: Failed to create 1 monitors
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> > > > > > owner@vger.kernel.org] On Behalf Of Sage Weil
> > > > > > Sent: Tuesday, October 13, 2015 4:02 PM
> > > > > > To: ceph-announce@ceph.com; ceph-devel@vger.kernel.org; ceph-
> > > > > > users@ceph.com; ceph-maintainers@ceph.com
> > > > > > Subject: v9.1.0 Infernalis release candidate released
> > > > > >
> > > > > > This is the first Infernalis release candidate.  There have been
> > > > > > some major changes since hammer, and the upgrade process is non-
> > > > trivial.
> > > > > > Please read carefully.
> > > > > >
> > > > > > Getting the release candidate
> > > > > > -----------------------------
> > > > > >
> > > > > > The v9.1.0 packages are pushed to the development release
> > > > repositories::
> > > > > >
> > > > > >   http://download.ceph.com/rpm-testing
> > > > > >   http://download.ceph.com/debian-testing
> > > > > >
> > > > > > For for info, see::
> > > > > >
> > > > > >   http://docs.ceph.com/docs/master/install/get-packages/
> > > > > >
> > > > > > Or install with ceph-deploy via::
> > > > > >
> > > > > >   ceph-deploy install --testing HOST
> > > > > >
> > > > > > Known issues
> > > > > > ------------
> > > > > >
> > > > > > * librbd and librados ABI compatibility is broken.  Be careful
> > > > > >   installing this RC on client machines (e.g., those running
> > qemu).
> > > > > >   It will be fixed in the final v9.2.0 release.
> > > > > >
> > > > > > Major Changes from Hammer
> > > > > > -------------------------
> > > > > >
> > > > > > * *General*:
> > > > > >   * Ceph daemons are now managed via systemd (with the exception
> > of
> > > > > >     Ubuntu Trusty, which still uses upstart).
> > > > > >   * Ceph daemons run as 'ceph' user instead root.
> > > > > >   * On Red Hat distros, there is also an SELinux policy.
> > > > > > * *RADOS*:
> > > > > >   * The RADOS cache tier can now proxy write operations to the
> > base
> > > > > >     tier, allowing writes to be handled without forcing migration
> > of
> > > > > >     an object into the cache.
> > > > > >   * The SHEC erasure coding support is no longer flagged as
> > > > > >     experimental. SHEC trades some additional storage space for
> > faster
> > > > > >     repair.
> > > > > >   * There is now a unified queue (and thus prioritization) of
> > client
> > > > > >     IO, recovery, scrubbing, and snapshot trimming.
> > > > > >   * There have been many improvements to low-level repair tooling
> > > > > >     (ceph-objectstore-tool).
> > > > > >   * The internal ObjectStore API has been significantly cleaned
> > > > > > up in order
> > > > > >     to faciliate new storage backends like NewStore.
> > > > > > * *RGW*:
> > > > > >   * The Swift API now supports object expiration.
> > > > > >   * There are many Swift API compatibility improvements.
> > > > > > * *RBD*:
> > > > > >   * The ``rbd du`` command shows actual usage (quickly, when
> > > > > >     object-map is enabled).
> > > > > >   * The object-map feature has seen many stability improvements.
> > > > > >   * Object-map and exclusive-lock features can be enabled or
> > disabled
> > > > > >     dynamically.
> > > > > >   * You can now store user metadata and set persistent librbd
> > options
> > > > > >     associated with individual images.
> > > > > >   * The new deep-flatten features allows flattening of a clone and
> > all
> > > > > >     of its snapshots.  (Previously snapshots could not be
> > flattened.)
> > > > > >   * The export-diff command command is now faster (it uses aio).
> > > > > > There is also
> > > > > >     a new fast-diff feature.
> > > > > >   * The --size argument can be specified with a suffix for units
> > > > > >     (e.g., ``--size 64G``).
> > > > > >   * There is a new ``rbd status`` command that, for now, shows who
> > has
> > > > > >     the image open/mapped.
> > > > > > * *CephFS*:
> > > > > >   * You can now rename snapshots.
> > > > > >   * There have been ongoing improvements around administration,
> > > > > > diagnostics,
> > > > > >     and the check and repair tools.
> > > > > >   * The caching and revocation of client cache state due to unused
> > > > > >     inodes has been dramatically improved.
> > > > > >   * The ceph-fuse client behaves better on 32-bit hosts.
> > > > > >
> > > > > > Distro compatibility
> > > > > > --------------------
> > > > > >
> > > > > > We have decided to drop support for many older distributions so
> > > > > > that we can move to a newer compiler toolchain (e.g., C++11).
> > > > > > Although it is still possible to build Ceph on older
> > > > > > distributions by installing backported development tools, we are
> > > > > > not building and publishing release packages for ceph.com.
> > > > > >
> > > > > > In particular,
> > > > > >
> > > > > > * CentOS 7 or later; we have dropped support for CentOS 6 (and
> > other
> > > > > >   RHEL 6 derivatives, like Scientific Linux 6).
> > > > > > * Debian Jessie 8.x or later; Debian Wheezy 7.x's g++ has
> > incomplete
> > > > > >   support for C++11 (and no systemd).
> > > > > > * Ubuntu Trusty 14.04 or later; Ubuntu Precise 12.04 is no longer
> > > > > >   supported.
> > > > > > * Fedora 22 or later.
> > > > > >
> > > > > > Upgrading from Firefly
> > > > > > ----------------------
> > > > > >
> > > > > > Upgrading directly from Firefly v0.80.z is not possible.  All
> > > > > > clusters must first upgrade to Hammer v0.94.4 or a later v0.94.z
> > > > > > release; only then is it possible to upgrade to Infernalis 9.2.z.
> > > > > >
> > > > > > Note that v0.94.4 isn't released yet, but you can upgrade to a
> > > > > > test build from gitbuilder with::
> > > > > >
> > > > > >   ceph-deploy install --dev hammer HOST
> > > > > >
> > > > > > The v0.94.4 Hammer point release will be out before v9.2.0
> > > > > > Infernalis
> > > > is.
> > > > > >
> > > > > > Upgrading from Hammer
> > > > > > ---------------------
> > > > > >
> > > > > > * For all distributions that support systemd (CentOS 7, Fedora,
> > Debian
> > > > > >   Jessie 8.x, OpenSUSE), ceph daemons are now managed using
> > > > > > native
> > > > systemd
> > > > > >   files instead of the legacy sysvinit scripts.  For example,::
> > > > > >
> > > > > >     systemctl start ceph.target       # start all daemons
> > > > > >     systemctl status ceph-osd@12      # check status of osd.12
> > > > > >
> > > > > >   The main notable distro that is *not* yet using systemd is
> > > > > > Ubuntu
> > > > trusty
> > > > > >   14.04.  (The next Ubuntu LTS, 16.04, will use systemd instead
> > > > > > of
> > > > > > upstart.)
> > > > > >
> > > > > > * Ceph daemons now run as user and group ``ceph`` by default.  The
> > > > > >   ceph user has a static UID assigned by Fedora and Debian (also
> > used
> > > > > >   by derivative distributions like RHEL/CentOS and Ubuntu).  On
> > SUSE
> > > > > >   the ceph user will currently get a dynamically assigned UID when
> > the
> > > > > >   user is created.
> > > > > >
> > > > > >   If your systems already have a ceph user, upgrading the
> > > > > > package will cause
> > > > > >   problems.  We suggest you first remove or rename the existing
> > 'ceph'
> > > > > > user
> > > > > >   before upgrading.
> > > > > >
> > > > > >   When upgrading, administrators have two options:
> > > > > >
> > > > > >    #. Add the following line to ``ceph.conf`` on all hosts::
> > > > > >
> > > > > >         setuser match path = /var/lib/ceph/$type/$cluster-$id
> > > > > >
> > > > > >       This will make the Ceph daemons run as root (i.e., not drop
> > > > > >       privileges and switch to user ceph) if the daemon's data
> > > > > >       directory is still owned by root.  Newly deployed daemons
> > will
> > > > > >       be created with data owned by user ceph and will run with
> > > > > >       reduced privileges, but upgraded daemons will continue to
> > run as
> > > > > >       root.
> > > > > >
> > > > > >    #. Fix the data ownership during the upgrade.  This is the
> > > > > > preferred option,
> > > > > >       but is more work.  The process for each host would be to:
> > > > > >
> > > > > >       #. Upgrade the ceph package.  This creates the ceph user
> > > > > > and
> > > > group.
> > > > > > For
> > > > > > 	 example::
> > > > > >
> > > > > > 	   ceph-deploy install --stable infernalis HOST
> > > > > >
> > > > > >       #. Stop the daemon(s).::
> > > > > >
> > > > > > 	   service ceph stop           # fedora, centos, rhel, debian
> > > > > > 	   stop ceph-all               # ubuntu
> > > > > >
> > > > > >       #. Fix the ownership::
> > > > > >
> > > > > > 	   chown -R ceph:ceph /var/lib/ceph
> > > > > >
> > > > > >       #. Restart the daemon(s).::
> > > > > >
> > > > > > 	   start ceph-all                # ubuntu
> > > > > > 	   systemctl start ceph.target   # debian, centos, fedora,
> > rhel
> > > > > >
> > > > > > * The on-disk format for the experimental KeyValueStore OSD
> > > > > > backend
> > > > has
> > > > > >   changed.  You will need to remove any OSDs using that backend
> > > > > > before
> > > > you
> > > > > >   upgrade any test clusters that use it.
> > > > > >
> > > > > > Upgrade notes
> > > > > > -------------
> > > > > >
> > > > > > * When a pool quota is reached, librados operations now block
> > > > > > indefinitely,
> > > > > >   the same way they do when the cluster fills up.  (Previously
> > > > > > they would return
> > > > > >   -ENOSPC).  By default, a full cluster or pool will now block.
> > > > > > If
> > > > your
> > > > > >   librados application can handle ENOSPC or EDQUOT errors
> > > > > > gracefully, you can
> > > > > >   get error returns instead by using the new librados
> > > > > > OPERATION_FULL_TRY flag.
> > > > > >
> > > > > > Notable changes
> > > > > > ---------------
> > > > > >
> > > > > > NOTE: These notes are somewhat abbreviated while we find a less
> > > > > > time- consuming process for generating them.
> > > > > >
> > > > > > * build: C++11 now supported
> > > > > > * build: many cmake improvements
> > > > > > * build: OSX build fixes (Yan, Zheng)
> > > > > > * build: remove rest-bench
> > > > > > * ceph-disk: many fixes (Loic Dachary)
> > > > > > * ceph-disk: support for multipath devices (Loic Dachary)
> > > > > > * ceph-fuse: mostly behave on 32-bit hosts (Yan, Zheng)
> > > > > > * ceph-objectstore-tool: many improvements (David Zafman)
> > > > > > * common: bufferlist performance tuning (Piotr Dalek, Sage Weil)
> > > > > > * common: make mutex more efficient
> > > > > > * common: some async compression infrastructure (Haomai Wang)
> > > > > > * librados: add FULL_TRY and FULL_FORCE flags for dealing with
> > > > > > full clusters or pools (Sage Weil)
> > > > > > * librados: fix notify completion race (#13114 Sage Weil)
> > > > > > * librados, libcephfs: randomize client nonces (Josh Durgin)
> > > > > > * librados: pybind: fix binary omap values (Robin H. Johnson)
> > > > > > * librbd: fix reads larger than the cache size (Lu Shi)
> > > > > > * librbd: metadata filter fixes (Haomai Wang)
> > > > > > * librbd: use write_full when possible (Zhiqiang Wang)
> > > > > > * mds: avoid emitting cap warnigns before evicting session (John
> > > > > > Spray)
> > > > > > * mds: fix expected holes in journal objects (#13167 Yan, Zheng)
> > > > > > * mds: fix SnapServer crash on deleted pool (John Spray)
> > > > > > * mds: many fixes (Yan, Zheng, John Spray, Greg Farnum)
> > > > > > * mon: add cache over MonitorDBStore (Kefu Chai)
> > > > > > * mon: 'ceph osd metadata' can dump all osds (Haomai Wang)
> > > > > > * mon: detect kv backend failures (Sage Weil)
> > > > > > * mon: fix CRUSH map test for new pools (Sage Weil)
> > > > > > * mon: fix min_last_epoch_clean tracking (Kefu Chai)
> > > > > > * mon: misc scaling fixes (Sage Weil)
> > > > > > * mon: streamline session handling, fix memory leaks (Sage Weil)
> > > > > > * mon: upgrades must pass through hammer (Sage Weil)
> > > > > > * msg/async: many fixes (Haomai Wang)
> > > > > > * osd: cache proxy-write support (Zhiqiang Wang, Samuel Just)
> > > > > > * osd: configure promotion based on write recency (Zhiqiang
> > > > > > Wang)
> > > > > > * osd: don't send dup MMonGetOSDMap requests (Sage Weil, Kefu
> > > > > > Chai)
> > > > > > * osd: erasure-code: fix SHEC floating point bug (#12936 Loic
> > > > > > Dachary)
> > > > > > * osd: erasure-code: update to ISA-L 2.14 (Yuan Zhou)
> > > > > > * osd: fix hitset object naming to use GMT (Kefu Chai)
> > > > > > * osd: fix misc memory leaks (Sage Weil)
> > > > > > * osd: fix peek_queue locking in FileStore (Xinze Chi)
> > > > > > * osd: fix promotion vs full cache tier (Samuel Just)
> > > > > > * osd: fix replay requeue when pg is still activating (#13116
> > > > > > Samuel
> > > > > > Just)
> > > > > > * osd: fix scrub stat bugs (Sage Weil, Samuel Just)
> > > > > > * osd: force promotion for ops EC can't handle (Zhiqiang Wang)
> > > > > > * osd: improve behavior on machines with large memory pages
> > > > > > (Steve
> > > > > > Capper)
> > > > > > * osd: merge multiple setattr calls into a setattrs call (Xinxin
> > > > > > Shu)
> > > > > > * osd: newstore prototype (Sage Weil)
> > > > > > * osd: ObjectStore internal API refactor (Sage Weil)
> > > > > > * osd: SHEC no longer experimental
> > > > > > * osd: throttle evict ops (Yunchuan Wen)
> > > > > > * osd: upgrades must pass through hammer (Sage Weil)
> > > > > > * osd: use SEEK_HOLE / SEEK_DATA for sparse copy (Xinxin Shu)
> > > > > > * rbd: rbd-replay-prep and rbd-replay improvements (Jason
> > > > > > Dillaman)
> > > > > > * rgw: expose the number of unhealthy workers through admin
> > > > > > socket (Guang
> > > > > > Yang)
> > > > > > * rgw: fix casing of Content-Type header (Robin H. Johnson)
> > > > > > * rgw: fix decoding of X-Object-Manifest from GET on Swift DLO
> > > > > > (Radslow
> > > > > > Rzarzynski)
> > > > > > * rgw: fix sysvinit script
> > > > > > * rgw: fix sysvinit script w/ multiple instances (Sage Weil,
> > > > > > Pavan
> > > > > > Rallabhandi)
> > > > > > * rgw: improve handling of already removed buckets in expirer
> > > > > > (Radoslaw
> > > > > > Rzarzynski)
> > > > > > * rgw: log to /var/log/ceph instead of /var/log/radosgw
> > > > > > * rgw: rework X-Trans-Id header to be conform with Swift API
> > > > > > (Radoslaw
> > > > > > Rzarzynski)
> > > > > > * rgw: s3 encoding-type for get bucket (Jeff Weber)
> > > > > > * rgw: set max buckets per user in ceph.conf (Vikhyat Umrao)
> > > > > > * rgw: support for Swift expiration API (Radoslaw Rzarzynski,
> > > > > > Yehuda
> > > > > > Sadeh)
> > > > > > * rgw: user rm is idempotent (Orit Wasserman)
> > > > > > * selinux policy (Boris Ranto, Milan Broz)
> > > > > > * systemd: many fixes (Sage Weil, Owen Synge, Boris Ranto, Dan
> > > > > > van der
> > > > > > Ster)
> > > > > > * systemd: run daemons as user ceph
> > > > > >
> > > > > > Getting Ceph
> > > > > > ------------
> > > > > >
> > > > > > * Git at git://github.com/ceph/ceph.git
> > > > > > * Tarball at http://download.ceph.com/tarballs/ceph-9.1.0.tar.gz
> > > > > > * For packages, see
> > > > > > http://ceph.com/docs/master/install/get-packages
> > > > > > * For ceph-deploy, see
> > > > > > http://ceph.com/docs/master/install/install-ceph-
> > > > > > deploy
> > > > > > --
> > > > > > To unsubscribe from this list: send the line "unsubscribe
> > > > > > ceph-devel" in the body of a message to
> > > > > > majordomo@vger.kernel.org More majordomo info at
> > > > > > http://vger.kernel.org/majordomo-info.html
> > > > >
> > > > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > > in the body of a message to majordomo@vger.kernel.org More majordomo
> > > info at  http://vger.kernel.org/majordomo-info.html
> > >
> > >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
