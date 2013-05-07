From: Igor Laskovy <igor.laskovy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: 0.61 Cuttlefish released
Date: Tue, 7 May 2013 13:25:09 +0300
Message-ID: <CAC+dAwEnMrD8uDGLXCxa+B0hBCNfeUX5_6Aon+G8-RpvAqD-ZQ@mail.gmail.com>
References: <alpine.DEB.2.00.1305061744430.9909@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1623576799=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1305061744430.9909-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============1623576799==
Content-Type: multipart/alternative; boundary=047d7b4141165900ec04dc1e3b19

--047d7b4141165900ec04dc1e3b19
Content-Type: text/plain; charset=ISO-8859-1

Hi,

where can I read more about ceph-disk?


On Tue, May 7, 2013 at 5:51 AM, Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:

> Spring has arrived (at least for some of us), and a new stable release of
> Ceph is ready!  Thank you to everyone who has contributed to this release!
>
> Bigger ticket items since v0.56.x "Bobtail":
>
>  * ceph-deploy: our new deployment tool to replace 'mkcephfs'
>  * robust RHEL/CentOS support
>  * ceph-disk: many improvements to support hot-plugging devices via chef
>    and ceph-deploy
>  * ceph-disk: dm-crypt support for OSD disks
>  * ceph-disk: 'list' command to see available (and used) disks
>  * rbd: incremental backups
>  * rbd-fuse: access RBD images via fuse
>  * librbd: autodetection of VM flush support to allow safe enablement of
>    the writeback cache
>  * osd: improved small write, snap trimming, and overall performance
>  * osd: PG splitting
>  * osd: per-pool quotas (object and byte)
>  * osd: tool for importing, exporting, removing PGs from OSD data store
>  * osd: improved clean-shutdown behavior
>  * osd: noscrub, nodeepscrub options
>  * osd: more robust scrubbing, repair, ENOSPC handling
>  * osd: improved memory usage, log trimming
>  * osd: improved journal corruption detection
>  * ceph: new 'df' command
>  * mon: new storage backend (leveldb)
>  * mon: config-keys service
>  * mon, crush: new commands to manage CRUSH entirely via CLI
>  * mon: avoid marking entire subtrees (e.g., racks) out automatically
>  * rgw: CORS support
>  * rgw: misc API fixes
>  * rgw: ability to listen to fastcgi on a port
>  * sysvinit, upstart: improved support for standardized data locations
>  * mds: backpointers on all data and metadata objects
>  * mds: faster fail-over
>  * mds: many many bug fixes
>  * ceph-fuse: many stability improvements
>
> Notable changes since v0.60:
>
>  * rbd: incremental backups
>  * rbd: only set STRIPINGV2 feature if striping parameters are
>    incompatible with old versions
>  * rbd: require allow-shrink for resizing images down
>  * librbd: many bug fixes
>  * rgw: fix object corruption on COPY to self
>  * rgw: new sysvinit script for rpm-based systems
>  * rgw: allow buckets with _
>  * rgw: CORS support
>  * mon: many fixes
>  * mon: improved trimming behavior
>  * mon: fix data conversion/upgrade problem (from bobtail)
>  * mon: ability to tune leveldb
>  * mon: config-keys service to store arbitrary data on monitor
>  * mon: osd crush add|link|unlink|add-bucket ... commands
>  * mon: trigger leveldb compaction on trim
>  * osd: per-rados pool quotas (objects, bytes)
>  * osd: tool to export, import, and delete PGs from an individual OSD data
>    store
>  * osd: notify mon on clean shutdown to avoid IO stall
>  * osd: improved detection of corrupted journals
>  * osd: ability to tune leveldb
>  * osd: improve client request throttling
>  * osd, librados: fixes to the LIST_SNAPS operation
>  * osd: improvements to scrub error repair
>  * osd: better prevention of wedging OSDs with ENOSPC
>  * osd: many small fixes
>  * mds: fix xattr handling on root inode
>  * mds: fixed bugs in journal replay
>  * mds: many fixes
>  * librados: clean up snapshot constant definitions
>  * libcephfs: calls to query CRUSH topology (used by Hadoop)
>  * ceph-fuse, libcephfs: misc fixes to mds session management
>  * ceph-fuse: disabled cache invalidation (again) due to potential
>    deadlock with kernel
>  * sysvinit: try to start all daemons despite early failures
>  * ceph-disk: new list command
>  * ceph-disk: hotplug fixes for RHEL/CentOS
>  * ceph-disk: fix creation of OSD data partitions on >2TB disks
>  * osd: fix udev rules for RHEL/CentOS systems
>  * fix daemon logging during initial startup
>
> There are a few things to keep in mind when upgrading from Bobtail,
> specifically with the monitor daemons.  Please see the upgrade guide
> and/or the complete release notes.  In short: upgrade all of your monitors
> (more or less) at once.
>
> Cuttlefish is the first Ceph release on our new three-month stable release
> cycle.  We are very pleased to have pulled everything together on schedule
> (well, only a week later than planned).  The next stable release, which
> will be code-named Dumpling, is slated for three months from now
> (beginning of August).
>
> You can download v0.61 Cuttlefish from the usual locations:
>
>  * Git at git://github.com/ceph/ceph.git
>  * Tarball at http://ceph.com/download/ceph-0.61.tar.gz
>  * For Debian/Ubuntu packages, see
> http://ceph.com/docs/master/install/debian
>  * For RPMs, see http://ceph.com/docs/master/install/rpm
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>



-- 
Igor Laskovy
facebook.com/igor.laskovy
studiogrizzly.com

--047d7b4141165900ec04dc1e3b19
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div style>where can I read more about=
=A0<span style=3D"font-family:arial,sans-serif;font-size:13px">ceph-disk?</=
span></div></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quo=
te">On Tue, May 7, 2013 at 5:51 AM, Sage Weil <span dir=3D"ltr">&lt;<a href=
=3D"mailto:sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org" target=3D"_blank">sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org</a>&gt;</sp=
an> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Spring has arrived (at least for some of us)=
, and a new stable release of<br>
Ceph is ready! =A0Thank you to everyone who has contributed to this release=
!<br>
<br>
Bigger ticket items since v0.56.x &quot;Bobtail&quot;:<br>
<br>
=A0* ceph-deploy: our new deployment tool to replace &#39;mkcephfs&#39;<br>
=A0* robust RHEL/CentOS support<br>
=A0* ceph-disk: many improvements to support hot-plugging devices via chef<=
br>
=A0 =A0and ceph-deploy<br>
=A0* ceph-disk: dm-crypt support for OSD disks<br>
=A0* ceph-disk: &#39;list&#39; command to see available (and used) disks<br=
>
=A0* rbd: incremental backups<br>
=A0* rbd-fuse: access RBD images via fuse<br>
=A0* librbd: autodetection of VM flush support to allow safe enablement of<=
br>
=A0 =A0the writeback cache<br>
=A0* osd: improved small write, snap trimming, and overall performance<br>
=A0* osd: PG splitting<br>
=A0* osd: per-pool quotas (object and byte)<br>
=A0* osd: tool for importing, exporting, removing PGs from OSD data store<b=
r>
=A0* osd: improved clean-shutdown behavior<br>
=A0* osd: noscrub, nodeepscrub options<br>
=A0* osd: more robust scrubbing, repair, ENOSPC handling<br>
=A0* osd: improved memory usage, log trimming<br>
=A0* osd: improved journal corruption detection<br>
=A0* ceph: new &#39;df&#39; command<br>
=A0* mon: new storage backend (leveldb)<br>
=A0* mon: config-keys service<br>
=A0* mon, crush: new commands to manage CRUSH entirely via CLI<br>
=A0* mon: avoid marking entire subtrees (e.g., racks) out automatically<br>
=A0* rgw: CORS support<br>
=A0* rgw: misc API fixes<br>
=A0* rgw: ability to listen to fastcgi on a port<br>
=A0* sysvinit, upstart: improved support for standardized data locations<br=
>
=A0* mds: backpointers on all data and metadata objects<br>
=A0* mds: faster fail-over<br>
=A0* mds: many many bug fixes<br>
=A0* ceph-fuse: many stability improvements<br>
<br>
Notable changes since v0.60:<br>
<br>
=A0* rbd: incremental backups<br>
=A0* rbd: only set STRIPINGV2 feature if striping parameters are<br>
=A0 =A0incompatible with old versions<br>
=A0* rbd: require allow-shrink for resizing images down<br>
=A0* librbd: many bug fixes<br>
=A0* rgw: fix object corruption on COPY to self<br>
=A0* rgw: new sysvinit script for rpm-based systems<br>
=A0* rgw: allow buckets with _<br>
=A0* rgw: CORS support<br>
=A0* mon: many fixes<br>
=A0* mon: improved trimming behavior<br>
=A0* mon: fix data conversion/upgrade problem (from bobtail)<br>
=A0* mon: ability to tune leveldb<br>
=A0* mon: config-keys service to store arbitrary data on monitor<br>
=A0* mon: osd crush add|link|unlink|add-bucket ... commands<br>
=A0* mon: trigger leveldb compaction on trim<br>
=A0* osd: per-rados pool quotas (objects, bytes)<br>
=A0* osd: tool to export, import, and delete PGs from an individual OSD dat=
a<br>
=A0 =A0store<br>
=A0* osd: notify mon on clean shutdown to avoid IO stall<br>
=A0* osd: improved detection of corrupted journals<br>
=A0* osd: ability to tune leveldb<br>
=A0* osd: improve client request throttling<br>
=A0* osd, librados: fixes to the LIST_SNAPS operation<br>
=A0* osd: improvements to scrub error repair<br>
=A0* osd: better prevention of wedging OSDs with ENOSPC<br>
=A0* osd: many small fixes<br>
=A0* mds: fix xattr handling on root inode<br>
=A0* mds: fixed bugs in journal replay<br>
=A0* mds: many fixes<br>
=A0* librados: clean up snapshot constant definitions<br>
=A0* libcephfs: calls to query CRUSH topology (used by Hadoop)<br>
=A0* ceph-fuse, libcephfs: misc fixes to mds session management<br>
=A0* ceph-fuse: disabled cache invalidation (again) due to potential<br>
=A0 =A0deadlock with kernel<br>
=A0* sysvinit: try to start all daemons despite early failures<br>
=A0* ceph-disk: new list command<br>
=A0* ceph-disk: hotplug fixes for RHEL/CentOS<br>
=A0* ceph-disk: fix creation of OSD data partitions on &gt;2TB disks<br>
=A0* osd: fix udev rules for RHEL/CentOS systems<br>
=A0* fix daemon logging during initial startup<br>
<br>
There are a few things to keep in mind when upgrading from Bobtail,<br>
specifically with the monitor daemons. =A0Please see the upgrade guide<br>
and/or the complete release notes. =A0In short: upgrade all of your monitor=
s<br>
(more or less) at once.<br>
<br>
Cuttlefish is the first Ceph release on our new three-month stable release<=
br>
cycle. =A0We are very pleased to have pulled everything together on schedul=
e<br>
(well, only a week later than planned). =A0The next stable release, which<b=
r>
will be code-named Dumpling, is slated for three months from now<br>
(beginning of August).<br>
<br>
You can download v0.61 Cuttlefish from the usual locations:<br>
<br>
=A0* Git at git://<a href=3D"http://github.com/ceph/ceph.git" target=3D"_bl=
ank">github.com/ceph/ceph.git</a><br>
=A0* Tarball at <a href=3D"http://ceph.com/download/ceph-0.61.tar.gz" targe=
t=3D"_blank">http://ceph.com/download/ceph-0.61.tar.gz</a><br>
=A0* For Debian/Ubuntu packages, see <a href=3D"http://ceph.com/docs/master=
/install/debian" target=3D"_blank">http://ceph.com/docs/master/install/debi=
an</a><br>
=A0* For RPMs, see <a href=3D"http://ceph.com/docs/master/install/rpm" targ=
et=3D"_blank">http://ceph.com/docs/master/install/rpm</a><br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div dir=3D"=
ltr">Igor Laskovy<br><a href=3D"http://facebook.com/igor.laskovy" target=3D=
"_blank">facebook.com/igor.laskovy</a><br><div><a href=3D"http://studiogriz=
zly.com" target=3D"_blank">studiogrizzly.com</a></div>
</div>
</div>

--047d7b4141165900ec04dc1e3b19--

--===============1623576799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1623576799==--
