From: Sage Weil <sage@inktank.com>
Subject: Re: [ceph-users] 0.61 Cuttlefish released
Date: Tue, 7 May 2013 07:25:34 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1305070724110.10631@cobra.newdream.net>
References: <alpine.DEB.2.00.1305061744430.9909@cobra.newdream.net> <CAC+dAwEnMrD8uDGLXCxa+B0hBCNfeUX5_6Aon+G8-RpvAqD-ZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-827649284-1367936734=:10631"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52511 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119Ab3EGOZe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 May 2013 10:25:34 -0400
In-Reply-To: <CAC+dAwEnMrD8uDGLXCxa+B0hBCNfeUX5_6Aon+G8-RpvAqD-ZQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Laskovy <igor.laskovy@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-827649284-1367936734=:10631
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 7 May 2013, Igor Laskovy wrote:
> Hi,
> where can I read more about=A0ceph-disk?

Hmm... you can less /usr/bin/ceph-disk.. or you can read the tracker=20
ticket to write a man page at http://tracker.ceph.com/issues/2774 :)

In all seriousness, 'ceph-disk -h' or 'ceph-disk <command> -h' and lookin=
g=20
at how ceph-deploy uses it is the best reference.

sage

>=20
>=20
> On Tue, May 7, 2013 at 5:51 AM, Sage Weil <sage@inktank.com> wrote:
>       Spring has arrived (at least for some of us), and a new stable
>       release of
>       Ceph is ready! =A0Thank you to everyone who has contributed to
>       this release!
>=20
>       Bigger ticket items since v0.56.x "Bobtail":
>=20
>       =A0* ceph-deploy: our new deployment tool to replace 'mkcephfs'
>       =A0* robust RHEL/CentOS support
>       =A0* ceph-disk: many improvements to support hot-plugging devices
>       via chef
>       =A0 =A0and ceph-deploy
>       =A0* ceph-disk: dm-crypt support for OSD disks
>       =A0* ceph-disk: 'list' command to see available (and used) disks
>       =A0* rbd: incremental backups
>       =A0* rbd-fuse: access RBD images via fuse
>       =A0* librbd: autodetection of VM flush support to allow safe
>       enablement of
>       =A0 =A0the writeback cache
>       =A0* osd: improved small write, snap trimming, and overall
>       performance
>       =A0* osd: PG splitting
>       =A0* osd: per-pool quotas (object and byte)
>       =A0* osd: tool for importing, exporting, removing PGs from OSD
>       data store
>       =A0* osd: improved clean-shutdown behavior
>       =A0* osd: noscrub, nodeepscrub options
>       =A0* osd: more robust scrubbing, repair, ENOSPC handling
>       =A0* osd: improved memory usage, log trimming
>       =A0* osd: improved journal corruption detection
>       =A0* ceph: new 'df' command
>       =A0* mon: new storage backend (leveldb)
>       =A0* mon: config-keys service
>       =A0* mon, crush: new commands to manage CRUSH entirely via CLI
>       =A0* mon: avoid marking entire subtrees (e.g., racks) out
>       automatically
>       =A0* rgw: CORS support
>       =A0* rgw: misc API fixes
>       =A0* rgw: ability to listen to fastcgi on a port
>       =A0* sysvinit, upstart: improved support for standardized data
>       locations
>       =A0* mds: backpointers on all data and metadata objects
>       =A0* mds: faster fail-over
>       =A0* mds: many many bug fixes
>       =A0* ceph-fuse: many stability improvements
>=20
>       Notable changes since v0.60:
>=20
>       =A0* rbd: incremental backups
>       =A0* rbd: only set STRIPINGV2 feature if striping parameters are
>       =A0 =A0incompatible with old versions
>       =A0* rbd: require allow-shrink for resizing images down
>       =A0* librbd: many bug fixes
>       =A0* rgw: fix object corruption on COPY to self
>       =A0* rgw: new sysvinit script for rpm-based systems
>       =A0* rgw: allow buckets with _
>       =A0* rgw: CORS support
>       =A0* mon: many fixes
>       =A0* mon: improved trimming behavior
>       =A0* mon: fix data conversion/upgrade problem (from bobtail)
>       =A0* mon: ability to tune leveldb
>       =A0* mon: config-keys service to store arbitrary data on monitor
>       =A0* mon: osd crush add|link|unlink|add-bucket ... commands
>       =A0* mon: trigger leveldb compaction on trim
>       =A0* osd: per-rados pool quotas (objects, bytes)
>       =A0* osd: tool to export, import, and delete PGs from an
>       individual OSD data
>       =A0 =A0store
>       =A0* osd: notify mon on clean shutdown to avoid IO stall
>       =A0* osd: improved detection of corrupted journals
>       =A0* osd: ability to tune leveldb
>       =A0* osd: improve client request throttling
>       =A0* osd, librados: fixes to the LIST_SNAPS operation
>       =A0* osd: improvements to scrub error repair
>       =A0* osd: better prevention of wedging OSDs with ENOSPC
>       =A0* osd: many small fixes
>       =A0* mds: fix xattr handling on root inode
>       =A0* mds: fixed bugs in journal replay
>       =A0* mds: many fixes
>       =A0* librados: clean up snapshot constant definitions
>       =A0* libcephfs: calls to query CRUSH topology (used by Hadoop)
>       =A0* ceph-fuse, libcephfs: misc fixes to mds session management
>       =A0* ceph-fuse: disabled cache invalidation (again) due to
>       potential
>       =A0 =A0deadlock with kernel
>       =A0* sysvinit: try to start all daemons despite early failures
>       =A0* ceph-disk: new list command
>       =A0* ceph-disk: hotplug fixes for RHEL/CentOS
>       =A0* ceph-disk: fix creation of OSD data partitions on >2TB disks
>       =A0* osd: fix udev rules for RHEL/CentOS systems
>       =A0* fix daemon logging during initial startup
>=20
>       There are a few things to keep in mind when upgrading from
>       Bobtail,
>       specifically with the monitor daemons. =A0Please see the upgrade
>       guide
>       and/or the complete release notes. =A0In short: upgrade all of
>       your monitors
>       (more or less) at once.
>=20
>       Cuttlefish is the first Ceph release on our new three-month
>       stable release
>       cycle. =A0We are very pleased to have pulled everything together
>       on schedule
>       (well, only a week later than planned). =A0The next stable
>       release, which
>       will be code-named Dumpling, is slated for three months from now
>       (beginning of August).
>=20
>       You can download v0.61 Cuttlefish from the usual locations:
>=20
>       =A0* Git at git://github.com/ceph/ceph.git
>       =A0* Tarball at http://ceph.com/download/ceph-0.61.tar.gz
>       =A0* For Debian/Ubuntu packages, see
>       http://ceph.com/docs/master/install/debian
>       =A0* For RPMs, see http://ceph.com/docs/master/install/rpm
>       _______________________________________________
>       ceph-users mailing list
>       ceph-users@lists.ceph.com
>       http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>=20
>=20
>=20
>=20
> --
> Igor Laskovy
> facebook.com/igor.laskovy
> studiogrizzly.com
>=20
>=20
--557981400-827649284-1367936734=:10631--
