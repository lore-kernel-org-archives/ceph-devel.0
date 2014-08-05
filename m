From: debian Only <onlydebian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: v0.83 released
Date: Tue, 5 Aug 2014 11:58:10 +0700
Message-ID: <CA+SSH2qOdNne-ExmOjLGnNKfZYXtO+KJ8vSQzvJj07hOK5H8qA@mail.gmail.com>
References: <alpine.DEB.2.00.1407291820100.5744@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1952056370=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1407291820100.5744-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: ceph-maintainers-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============1952056370==
Content-Type: multipart/alternative; boundary=f46d043c08ccc41cb004ffdab3c2

--f46d043c08ccc41cb004ffdab3c2
Content-Type: text/plain; charset=UTF-8

Good news.  when this release will public in Debian Wheezy pkglist ?
thanks for ur good job


2014-07-30 8:21 GMT+07:00 Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>:

> Another Ceph development release!  This has been a longer cycle, so there
> has been quite a bit of bug fixing and stabilization in this round.
> There is also a bunch of packaging fixes for RPM distros (RHEL/CentOS,
> Fedora, and SUSE) and for systemd.  We've also added a new
> librados-striper library from Sebastien Ponce that provides a generic
> striping API for applications to code to.
>
> Upgrading
> ---------
>
> * The experimental keyvaluestore-dev OSD backend had an on-disk format
>   change that prevents existing OSD data from being upgraded.  This
>   affects developers and testers only.
>
> * mon-specific and osd-specific leveldb options have been removed.
>   From this point onward users should use 'leveldb_' generic options and
> add
>   the options in the appropriate sections of their configuration files.
>   Monitors will still maintain the following monitor-specific defaults:
>
>     leveldb_write_buffer_size = 32*1024*1024  = 33554432  // 32MB
>     leveldb_cache_size        = 512*1024*1204 = 536870912 // 512MB
>     leveldb_block_size        = 64*1024       = 65536     // 64KB
>     leveldb_compression       = false
>     leveldb_log               = ""
>
>   OSDs will still maintain the following osd-specific defaults:
>
>     leveldb_log               = ""
>
> Notable Changes
> ---------------
>
> * ceph-disk: fix dmcrypt support (Stephen Taylor)
> * cephtool: fix help (Yilong Zhao)
> * cephtool: test cleanup (Joao Eduardo Luis)
> * doc: librados example fixes (Kevin Dalley)
> * doc: many doc updates (John Wilkins)
> * doc: update erasure docs (Loic Dachary, Venky Shankar)
> * filestore: disable use of XFS hint (buggy on old kernels) (Samuel Just)
> * filestore: fix xattr spillout (Greg Farnum, Haomai Wang)
> * keyvaluestore: header cache (Haomai Wang)
> * librados_striper: striping library for librados (Sebastien Ponce)
> * libs3: update to latest (Danny Al-Gaaf)
> * log: fix derr level (Joao Eduardo Luis)
> * logrotate: fix osd log rotation on ubuntu (Sage Weil)
> * mds: fix xattr bug triggered by ACLs (Yan, Zheng)
> * misc memory leaks, cleanups, fixes (Danny Al-Gaaf, Sahid Ferdjaoui)
> * misc suse fixes (Danny Al-Gaaf)
> * misc word size fixes (Kevin Cox)
> * mon: drop mon- and osd- specific leveldb options (Joao Eduardo Luis)
> * mon: ec pool profile fixes (Loic Dachary)
> * mon: fix health down messages (Sage Weil)
> * mon: fix quorum feature check (#8738, Greg Farnum)
> * mon: 'osd crush reweight-subtree ...' (Sage Weil)
> * mon, osd: relax client EC support requirements (Sage Weil)
> * mon: some instrumentation (Sage Weil)
> * objecter: flag operations that are redirected by caching (Sage Weil)
> * osd: clean up shard_id_t, shard_t (Loic Dachary)
> * osd: fix connection reconnect race (Greg Farnum)
> * osd: fix dumps (Joao Eduardo Luis)
> * osd: fix erasure-code lib initialization (Loic Dachary)
> * osd: fix extent normalization (Adam Crume)
> * osd: fix loopback msgr issue (Ma Jianpeng)
> * osd: fix LSB release parsing (Danny Al-Gaaf)
> * osd: improved backfill priorities (Sage Weil)
> * osd: many many core fixes (Samuel Just)
> * osd, mon: config sanity checks on start (Sage Weil, Joao Eduardo Luis)
> * osd: sharded threadpool to improve parallelism (Somnath Roy)
> * osd: simple io prioritization for scrub (Sage Weil)
> * osd: simple scrub throttling (Sage Weil)
> * osd: tests for bench command (Loic Dachary)
> * osd: use xfs hint less frequently (Ilya Dryomov)
> * pybind/rados: fix small timeouts (John Spray)
> * qa: xfstests updates (Ilya Dryomov)
> * rgw: cache bucket info (Yehuda Sadeh)
> * rgw: cache decoded user info (Yehuda Sadeh)
> * rgw: fix multipart object attr regression (#8452, Yehuda Sadeh)
> * rgw: fix radosgw-admin 'show log' command (#8553, Yehuda Sadeh)
> * rgw: fix URL decoding (#8702, Brian Rak)
> * rgw: handle empty extra pool name (Yehuda Sadeh)
> * rpm: do not restart daemons on upgrade (Alfredo Deza)
> * rpm: misc packaging fixes for rhel7 (Sandon Van Ness)
> * rpm: split ceph-common from ceph (Sandon Van Ness)
> * systemd: wrap started daemons in new systemd environment (Sage Weil, Dan
>   Mick)
> * sysvinit: less sensitive to failures (Sage Weil)
> * upstart: increase max open files limit (Sage Weil)
>
> Getting Ceph
> ------------
>
> * Git at git://github.com/ceph/ceph.git
> * Tarball at http://ceph.com/download/ceph-0.83.tar.gz
> * For packages, see http://ceph.com/docs/master/install/get-packages
> * For ceph-deploy, see
> http://ceph.com/docs/master/install/install-ceph-deploy
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--f46d043c08ccc41cb004ffdab3c2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Good news. =C2=A0when this release will public in Debian W=
heezy pkglist ?<div>thanks for ur good job</div></div><div class=3D"gmail_e=
xtra"><br><br><div class=3D"gmail_quote">2014-07-30 8:21 GMT+07:00 Sage Wei=
l <span dir=3D"ltr">&lt;<a href=3D"mailto:sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org" target=3D"_blan=
k">sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org</a>&gt;</span>:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Another Ceph development release! =C2=A0This=
 has been a longer cycle, so there<br>
has been quite a bit of bug fixing and stabilization in this round.<br>
There is also a bunch of packaging fixes for RPM distros (RHEL/CentOS,<br>
Fedora, and SUSE) and for systemd. =C2=A0We&#39;ve also added a new<br>
librados-striper library from Sebastien Ponce that provides a generic<br>
striping API for applications to code to.<br>
<br>
Upgrading<br>
---------<br>
<br>
* The experimental keyvaluestore-dev OSD backend had an on-disk format<br>
=C2=A0 change that prevents existing OSD data from being upgraded. =C2=A0Th=
is<br>
=C2=A0 affects developers and testers only.<br>
<br>
* mon-specific and osd-specific leveldb options have been removed.<br>
=C2=A0 From this point onward users should use &#39;leveldb_&#39; generic o=
ptions and add<br>
=C2=A0 the options in the appropriate sections of their configuration files=
.<br>
=C2=A0 Monitors will still maintain the following monitor-specific defaults=
:<br>
<br>
=C2=A0 =C2=A0 leveldb_write_buffer_size =3D 32*1024*1024 =C2=A0=3D 33554432=
 =C2=A0// 32MB<br>
=C2=A0 =C2=A0 leveldb_cache_size =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 512*1024*12=
04 =3D 536870912 // 512MB<br>
=C2=A0 =C2=A0 leveldb_block_size =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 64*1024 =C2=
=A0 =C2=A0 =C2=A0 =3D 65536 =C2=A0 =C2=A0 // 64KB<br>
=C2=A0 =C2=A0 leveldb_compression =C2=A0 =C2=A0 =C2=A0 =3D false<br>
=C2=A0 =C2=A0 leveldb_log =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D &quot;&quot;<br>
<br>
=C2=A0 OSDs will still maintain the following osd-specific defaults:<br>
<br>
=C2=A0 =C2=A0 leveldb_log =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D &quot;&quot;<br>
<br>
Notable Changes<br>
---------------<br>
<br>
* ceph-disk: fix dmcrypt support (Stephen Taylor)<br>
* cephtool: fix help (Yilong Zhao)<br>
* cephtool: test cleanup (Joao Eduardo Luis)<br>
* doc: librados example fixes (Kevin Dalley)<br>
* doc: many doc updates (John Wilkins)<br>
* doc: update erasure docs (Loic Dachary, Venky Shankar)<br>
* filestore: disable use of XFS hint (buggy on old kernels) (Samuel Just)<b=
r>
* filestore: fix xattr spillout (Greg Farnum, Haomai Wang)<br>
* keyvaluestore: header cache (Haomai Wang)<br>
* librados_striper: striping library for librados (Sebastien Ponce)<br>
* libs3: update to latest (Danny Al-Gaaf)<br>
* log: fix derr level (Joao Eduardo Luis)<br>
* logrotate: fix osd log rotation on ubuntu (Sage Weil)<br>
* mds: fix xattr bug triggered by ACLs (Yan, Zheng)<br>
* misc memory leaks, cleanups, fixes (Danny Al-Gaaf, Sahid Ferdjaoui)<br>
* misc suse fixes (Danny Al-Gaaf)<br>
* misc word size fixes (Kevin Cox)<br>
* mon: drop mon- and osd- specific leveldb options (Joao Eduardo Luis)<br>
* mon: ec pool profile fixes (Loic Dachary)<br>
* mon: fix health down messages (Sage Weil)<br>
* mon: fix quorum feature check (#8738, Greg Farnum)<br>
* mon: &#39;osd crush reweight-subtree ...&#39; (Sage Weil)<br>
* mon, osd: relax client EC support requirements (Sage Weil)<br>
* mon: some instrumentation (Sage Weil)<br>
* objecter: flag operations that are redirected by caching (Sage Weil)<br>
* osd: clean up shard_id_t, shard_t (Loic Dachary)<br>
* osd: fix connection reconnect race (Greg Farnum)<br>
* osd: fix dumps (Joao Eduardo Luis)<br>
* osd: fix erasure-code lib initialization (Loic Dachary)<br>
* osd: fix extent normalization (Adam Crume)<br>
* osd: fix loopback msgr issue (Ma Jianpeng)<br>
* osd: fix LSB release parsing (Danny Al-Gaaf)<br>
* osd: improved backfill priorities (Sage Weil)<br>
* osd: many many core fixes (Samuel Just)<br>
* osd, mon: config sanity checks on start (Sage Weil, Joao Eduardo Luis)<br=
>
* osd: sharded threadpool to improve parallelism (Somnath Roy)<br>
* osd: simple io prioritization for scrub (Sage Weil)<br>
* osd: simple scrub throttling (Sage Weil)<br>
* osd: tests for bench command (Loic Dachary)<br>
* osd: use xfs hint less frequently (Ilya Dryomov)<br>
* pybind/rados: fix small timeouts (John Spray)<br>
* qa: xfstests updates (Ilya Dryomov)<br>
* rgw: cache bucket info (Yehuda Sadeh)<br>
* rgw: cache decoded user info (Yehuda Sadeh)<br>
* rgw: fix multipart object attr regression (#8452, Yehuda Sadeh)<br>
* rgw: fix radosgw-admin &#39;show log&#39; command (#8553, Yehuda Sadeh)<b=
r>
* rgw: fix URL decoding (#8702, Brian Rak)<br>
* rgw: handle empty extra pool name (Yehuda Sadeh)<br>
* rpm: do not restart daemons on upgrade (Alfredo Deza)<br>
* rpm: misc packaging fixes for rhel7 (Sandon Van Ness)<br>
* rpm: split ceph-common from ceph (Sandon Van Ness)<br>
* systemd: wrap started daemons in new systemd environment (Sage Weil, Dan<=
br>
=C2=A0 Mick)<br>
* sysvinit: less sensitive to failures (Sage Weil)<br>
* upstart: increase max open files limit (Sage Weil)<br>
<br>
Getting Ceph<br>
------------<br>
<br>
* Git at git://<a href=3D"http://github.com/ceph/ceph.git" target=3D"_blank=
">github.com/ceph/ceph.git</a><br>
* Tarball at <a href=3D"http://ceph.com/download/ceph-0.83.tar.gz" target=
=3D"_blank">http://ceph.com/download/ceph-0.83.tar.gz</a><br>
* For packages, see <a href=3D"http://ceph.com/docs/master/install/get-pack=
ages" target=3D"_blank">http://ceph.com/docs/master/install/get-packages</a=
><br>
* For ceph-deploy, see <a href=3D"http://ceph.com/docs/master/install/insta=
ll-ceph-deploy" target=3D"_blank">http://ceph.com/docs/master/install/insta=
ll-ceph-deploy</a><br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
</blockquote></div><br></div>

--f46d043c08ccc41cb004ffdab3c2--

--===============1952056370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1952056370==--
