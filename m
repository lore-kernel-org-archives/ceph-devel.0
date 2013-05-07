From: John Wilkins <john.wilkins-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: 0.61 Cuttlefish released
Date: Tue, 7 May 2013 09:42:42 -0700
Message-ID: <CAM2gkg54w_ugCD=_O5day=O=jVBt4V9Y=cw9xnucBTN-xf_1Hg@mail.gmail.com>
References: <alpine.DEB.2.00.1305061744430.9909@cobra.newdream.net>
	<CAC+dAwEnMrD8uDGLXCxa+B0hBCNfeUX5_6Aon+G8-RpvAqD-ZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0088691586=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAC+dAwEnMrD8uDGLXCxa+B0hBCNfeUX5_6Aon+G8-RpvAqD-ZQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Igor Laskovy <igor.laskovy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0088691586==
Content-Type: multipart/alternative; boundary=bcaec50163c39868c804dc2381ac

--bcaec50163c39868c804dc2381ac
Content-Type: text/plain; charset=UTF-8

Igor,

I haven't closed out 3674, because I haven't covered that part yet. Chef
docs are now in the wiki, but I'll be adding ceph-disk docs shortly.


On Tue, May 7, 2013 at 3:25 AM, Igor Laskovy <igor.laskovy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Hi,
>
> where can I read more about ceph-disk?
>
>
> On Tue, May 7, 2013 at 5:51 AM, Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:
>
>> Spring has arrived (at least for some of us), and a new stable release of
>> Ceph is ready!  Thank you to everyone who has contributed to this release!
>>
>> Bigger ticket items since v0.56.x "Bobtail":
>>
>>  * ceph-deploy: our new deployment tool to replace 'mkcephfs'
>>  * robust RHEL/CentOS support
>>  * ceph-disk: many improvements to support hot-plugging devices via chef
>>    and ceph-deploy
>>  * ceph-disk: dm-crypt support for OSD disks
>>  * ceph-disk: 'list' command to see available (and used) disks
>>  * rbd: incremental backups
>>  * rbd-fuse: access RBD images via fuse
>>  * librbd: autodetection of VM flush support to allow safe enablement of
>>    the writeback cache
>>  * osd: improved small write, snap trimming, and overall performance
>>  * osd: PG splitting
>>  * osd: per-pool quotas (object and byte)
>>  * osd: tool for importing, exporting, removing PGs from OSD data store
>>  * osd: improved clean-shutdown behavior
>>  * osd: noscrub, nodeepscrub options
>>  * osd: more robust scrubbing, repair, ENOSPC handling
>>  * osd: improved memory usage, log trimming
>>  * osd: improved journal corruption detection
>>  * ceph: new 'df' command
>>  * mon: new storage backend (leveldb)
>>  * mon: config-keys service
>>  * mon, crush: new commands to manage CRUSH entirely via CLI
>>  * mon: avoid marking entire subtrees (e.g., racks) out automatically
>>  * rgw: CORS support
>>  * rgw: misc API fixes
>>  * rgw: ability to listen to fastcgi on a port
>>  * sysvinit, upstart: improved support for standardized data locations
>>  * mds: backpointers on all data and metadata objects
>>  * mds: faster fail-over
>>  * mds: many many bug fixes
>>  * ceph-fuse: many stability improvements
>>
>> Notable changes since v0.60:
>>
>>  * rbd: incremental backups
>>  * rbd: only set STRIPINGV2 feature if striping parameters are
>>    incompatible with old versions
>>  * rbd: require allow-shrink for resizing images down
>>  * librbd: many bug fixes
>>  * rgw: fix object corruption on COPY to self
>>  * rgw: new sysvinit script for rpm-based systems
>>  * rgw: allow buckets with _
>>  * rgw: CORS support
>>  * mon: many fixes
>>  * mon: improved trimming behavior
>>  * mon: fix data conversion/upgrade problem (from bobtail)
>>  * mon: ability to tune leveldb
>>  * mon: config-keys service to store arbitrary data on monitor
>>  * mon: osd crush add|link|unlink|add-bucket ... commands
>>  * mon: trigger leveldb compaction on trim
>>  * osd: per-rados pool quotas (objects, bytes)
>>  * osd: tool to export, import, and delete PGs from an individual OSD data
>>    store
>>  * osd: notify mon on clean shutdown to avoid IO stall
>>  * osd: improved detection of corrupted journals
>>  * osd: ability to tune leveldb
>>  * osd: improve client request throttling
>>  * osd, librados: fixes to the LIST_SNAPS operation
>>  * osd: improvements to scrub error repair
>>  * osd: better prevention of wedging OSDs with ENOSPC
>>  * osd: many small fixes
>>  * mds: fix xattr handling on root inode
>>  * mds: fixed bugs in journal replay
>>  * mds: many fixes
>>  * librados: clean up snapshot constant definitions
>>  * libcephfs: calls to query CRUSH topology (used by Hadoop)
>>  * ceph-fuse, libcephfs: misc fixes to mds session management
>>  * ceph-fuse: disabled cache invalidation (again) due to potential
>>    deadlock with kernel
>>  * sysvinit: try to start all daemons despite early failures
>>  * ceph-disk: new list command
>>  * ceph-disk: hotplug fixes for RHEL/CentOS
>>  * ceph-disk: fix creation of OSD data partitions on >2TB disks
>>  * osd: fix udev rules for RHEL/CentOS systems
>>  * fix daemon logging during initial startup
>>
>> There are a few things to keep in mind when upgrading from Bobtail,
>> specifically with the monitor daemons.  Please see the upgrade guide
>> and/or the complete release notes.  In short: upgrade all of your monitors
>> (more or less) at once.
>>
>> Cuttlefish is the first Ceph release on our new three-month stable release
>> cycle.  We are very pleased to have pulled everything together on schedule
>> (well, only a week later than planned).  The next stable release, which
>> will be code-named Dumpling, is slated for three months from now
>> (beginning of August).
>>
>> You can download v0.61 Cuttlefish from the usual locations:
>>
>>  * Git at git://github.com/ceph/ceph.git
>>  * Tarball at http://ceph.com/download/ceph-0.61.tar.gz
>>  * For Debian/Ubuntu packages, see
>> http://ceph.com/docs/master/install/debian
>>  * For RPMs, see http://ceph.com/docs/master/install/rpm
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
>
>
>
> --
> Igor Laskovy
> facebook.com/igor.laskovy
> studiogrizzly.com
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>


-- 
John Wilkins
Senior Technical Writer
Intank
john.wilkins-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org
(415) 425-9599
http://inktank.com

--bcaec50163c39868c804dc2381ac
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Igor,=C2=A0<div><br></div><div>I haven&#39;t closed out 36=
74, because I haven&#39;t covered that part yet. Chef docs are now in the w=
iki, but I&#39;ll be adding ceph-disk docs shortly.</div></div><div class=
=3D"gmail_extra">
<br><br><div class=3D"gmail_quote">On Tue, May 7, 2013 at 3:25 AM, Igor Las=
kovy <span dir=3D"ltr">&lt;<a href=3D"mailto:igor.laskovy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=
=3D"_blank">igor.laskovy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">
<div dir=3D"ltr">Hi,<div><br></div><div>where can I read more about=C2=A0<s=
pan style=3D"font-family:arial,sans-serif;font-size:13px">ceph-disk?</span>=
</div></div><div class=3D"gmail_extra"><div><div class=3D"h5"><br><br><div =
class=3D"gmail_quote">
On Tue, May 7, 2013 at 5:51 AM, Sage Weil <span dir=3D"ltr">&lt;<a href=3D"=
mailto:sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org" target=3D"_blank">sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org</a>&gt;</span> =
wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Spring has arrived (at least for some of us)=
, and a new stable release of<br>
Ceph is ready! =C2=A0Thank you to everyone who has contributed to this rele=
ase!<br>
<br>
Bigger ticket items since v0.56.x &quot;Bobtail&quot;:<br>
<br>
=C2=A0* ceph-deploy: our new deployment tool to replace &#39;mkcephfs&#39;<=
br>
=C2=A0* robust RHEL/CentOS support<br>
=C2=A0* ceph-disk: many improvements to support hot-plugging devices via ch=
ef<br>
=C2=A0 =C2=A0and ceph-deploy<br>
=C2=A0* ceph-disk: dm-crypt support for OSD disks<br>
=C2=A0* ceph-disk: &#39;list&#39; command to see available (and used) disks=
<br>
=C2=A0* rbd: incremental backups<br>
=C2=A0* rbd-fuse: access RBD images via fuse<br>
=C2=A0* librbd: autodetection of VM flush support to allow safe enablement =
of<br>
=C2=A0 =C2=A0the writeback cache<br>
=C2=A0* osd: improved small write, snap trimming, and overall performance<b=
r>
=C2=A0* osd: PG splitting<br>
=C2=A0* osd: per-pool quotas (object and byte)<br>
=C2=A0* osd: tool for importing, exporting, removing PGs from OSD data stor=
e<br>
=C2=A0* osd: improved clean-shutdown behavior<br>
=C2=A0* osd: noscrub, nodeepscrub options<br>
=C2=A0* osd: more robust scrubbing, repair, ENOSPC handling<br>
=C2=A0* osd: improved memory usage, log trimming<br>
=C2=A0* osd: improved journal corruption detection<br>
=C2=A0* ceph: new &#39;df&#39; command<br>
=C2=A0* mon: new storage backend (leveldb)<br>
=C2=A0* mon: config-keys service<br>
=C2=A0* mon, crush: new commands to manage CRUSH entirely via CLI<br>
=C2=A0* mon: avoid marking entire subtrees (e.g., racks) out automatically<=
br>
=C2=A0* rgw: CORS support<br>
=C2=A0* rgw: misc API fixes<br>
=C2=A0* rgw: ability to listen to fastcgi on a port<br>
=C2=A0* sysvinit, upstart: improved support for standardized data locations=
<br>
=C2=A0* mds: backpointers on all data and metadata objects<br>
=C2=A0* mds: faster fail-over<br>
=C2=A0* mds: many many bug fixes<br>
=C2=A0* ceph-fuse: many stability improvements<br>
<br>
Notable changes since v0.60:<br>
<br>
=C2=A0* rbd: incremental backups<br>
=C2=A0* rbd: only set STRIPINGV2 feature if striping parameters are<br>
=C2=A0 =C2=A0incompatible with old versions<br>
=C2=A0* rbd: require allow-shrink for resizing images down<br>
=C2=A0* librbd: many bug fixes<br>
=C2=A0* rgw: fix object corruption on COPY to self<br>
=C2=A0* rgw: new sysvinit script for rpm-based systems<br>
=C2=A0* rgw: allow buckets with _<br>
=C2=A0* rgw: CORS support<br>
=C2=A0* mon: many fixes<br>
=C2=A0* mon: improved trimming behavior<br>
=C2=A0* mon: fix data conversion/upgrade problem (from bobtail)<br>
=C2=A0* mon: ability to tune leveldb<br>
=C2=A0* mon: config-keys service to store arbitrary data on monitor<br>
=C2=A0* mon: osd crush add|link|unlink|add-bucket ... commands<br>
=C2=A0* mon: trigger leveldb compaction on trim<br>
=C2=A0* osd: per-rados pool quotas (objects, bytes)<br>
=C2=A0* osd: tool to export, import, and delete PGs from an individual OSD =
data<br>
=C2=A0 =C2=A0store<br>
=C2=A0* osd: notify mon on clean shutdown to avoid IO stall<br>
=C2=A0* osd: improved detection of corrupted journals<br>
=C2=A0* osd: ability to tune leveldb<br>
=C2=A0* osd: improve client request throttling<br>
=C2=A0* osd, librados: fixes to the LIST_SNAPS operation<br>
=C2=A0* osd: improvements to scrub error repair<br>
=C2=A0* osd: better prevention of wedging OSDs with ENOSPC<br>
=C2=A0* osd: many small fixes<br>
=C2=A0* mds: fix xattr handling on root inode<br>
=C2=A0* mds: fixed bugs in journal replay<br>
=C2=A0* mds: many fixes<br>
=C2=A0* librados: clean up snapshot constant definitions<br>
=C2=A0* libcephfs: calls to query CRUSH topology (used by Hadoop)<br>
=C2=A0* ceph-fuse, libcephfs: misc fixes to mds session management<br>
=C2=A0* ceph-fuse: disabled cache invalidation (again) due to potential<br>
=C2=A0 =C2=A0deadlock with kernel<br>
=C2=A0* sysvinit: try to start all daemons despite early failures<br>
=C2=A0* ceph-disk: new list command<br>
=C2=A0* ceph-disk: hotplug fixes for RHEL/CentOS<br>
=C2=A0* ceph-disk: fix creation of OSD data partitions on &gt;2TB disks<br>
=C2=A0* osd: fix udev rules for RHEL/CentOS systems<br>
=C2=A0* fix daemon logging during initial startup<br>
<br>
There are a few things to keep in mind when upgrading from Bobtail,<br>
specifically with the monitor daemons. =C2=A0Please see the upgrade guide<b=
r>
and/or the complete release notes. =C2=A0In short: upgrade all of your moni=
tors<br>
(more or less) at once.<br>
<br>
Cuttlefish is the first Ceph release on our new three-month stable release<=
br>
cycle. =C2=A0We are very pleased to have pulled everything together on sche=
dule<br>
(well, only a week later than planned). =C2=A0The next stable release, whic=
h<br>
will be code-named Dumpling, is slated for three months from now<br>
(beginning of August).<br>
<br>
You can download v0.61 Cuttlefish from the usual locations:<br>
<br>
=C2=A0* Git at git://<a href=3D"http://github.com/ceph/ceph.git" target=3D"=
_blank">github.com/ceph/ceph.git</a><br>
=C2=A0* Tarball at <a href=3D"http://ceph.com/download/ceph-0.61.tar.gz" ta=
rget=3D"_blank">http://ceph.com/download/ceph-0.61.tar.gz</a><br>
=C2=A0* For Debian/Ubuntu packages, see <a href=3D"http://ceph.com/docs/mas=
ter/install/debian" target=3D"_blank">http://ceph.com/docs/master/install/d=
ebian</a><br>
=C2=A0* For RPMs, see <a href=3D"http://ceph.com/docs/master/install/rpm" t=
arget=3D"_blank">http://ceph.com/docs/master/install/rpm</a><br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
</blockquote></div><br><br clear=3D"all"><div><br></div></div></div><span c=
lass=3D"HOEnZb"><font color=3D"#888888">-- <br><div dir=3D"ltr">Igor Laskov=
y<br><a href=3D"http://facebook.com/igor.laskovy" target=3D"_blank">faceboo=
k.com/igor.laskovy</a><br>
<div><a href=3D"http://studiogrizzly.com" target=3D"_blank">studiogrizzly.c=
om</a></div>
</div>
</font></span></div>
<br>_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
<br></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>John Wil=
kins<br>Senior Technical Writer<br>Intank<br><a href=3D"mailto:john.wilkins=
@inktank.com" target=3D"_blank">john.wilkins-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org</a><br>(415) 425-9=
599<br>
<a href=3D"http://inktank.com" target=3D"_blank">http://inktank.com</a>
</div>

--bcaec50163c39868c804dc2381ac--

--===============0088691586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0088691586==--
