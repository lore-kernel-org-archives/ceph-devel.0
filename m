From: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: v0.83 released
Date: Tue, 5 Aug 2014 07:09:12 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408050709030.18948@cobra.newdream.net>
References: <alpine.DEB.2.00.1407291820100.5744@cobra.newdream.net>
	<CA+SSH2qOdNne-ExmOjLGnNKfZYXtO+KJ8vSQzvJj07hOK5H8qA@mail.gmail.com>
	<alpine.DEB.2.00.1408050653170.18917@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="557981400-1286242069-1407247752=:18948"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1408050653170.18917-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: debian Only <onlydebian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1286242069-1407247752=:18948
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Oops, fixing ceph-maintainers address.

On Tue, 5 Aug 2014, Sage Weil wrote:

> On Tue, 5 Aug 2014, debian Only wrote:
> > Good news. =C2=A0when this release will public in Debian Wheezy pkgli=
st ?thanks
> > for ur good job
>=20
> I think that, in general, the strategy should be to keep the stable=20
> packages (firefly 0.80.x currently) in the stable downstream repos=20
> (wheezy).  These development releases can either be found at ceph.com, =
or=20
> perhaps they can go into debian unstable or rawhide or similar.  I don'=
t=20
> think it is the release that most users will want when they 'apt-get=20
> install ceph' on a generic system, though!
>=20
> sage
>=20
>=20
> >=20
> >=20
> > 2014-07-30 8:21 GMT+07:00 Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>:
> >       Another Ceph development release! =C2=A0This has been a longer =
cycle,
> >       so there
> >       has been quite a bit of bug fixing and stabilization in this
> >       round.
> >       There is also a bunch of packaging fixes for RPM distros
> >       (RHEL/CentOS,
> >       Fedora, and SUSE) and for systemd. =C2=A0We've also added a new
> >       librados-striper library from Sebastien Ponce that provides a
> >       generic
> >       striping API for applications to code to.
> >=20
> >       Upgrading
> >       ---------
> >=20
> >       * The experimental keyvaluestore-dev OSD backend had an on-disk
> >       format
> >       =C2=A0 change that prevents existing OSD data from being upgrad=
ed.
> >       =C2=A0This
> >       =C2=A0 affects developers and testers only.
> >=20
> >       * mon-specific and osd-specific leveldb options have been
> >       removed.
> >       =C2=A0 From this point onward users should use 'leveldb_' gener=
ic
> >       options and add
> >       =C2=A0 the options in the appropriate sections of their configu=
ration
> >       files.
> >       =C2=A0 Monitors will still maintain the following monitor-speci=
fic
> >       defaults:
> >=20
> >       =C2=A0 =C2=A0 leveldb_write_buffer_size =3D 32*1024*1024 =C2=A0=
=3D 33554432 =C2=A0//
> >       32MB
> >       =C2=A0 =C2=A0 leveldb_cache_size =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=
 512*1024*1204 =3D 536870912 //
> >       512MB
> >       =C2=A0 =C2=A0 leveldb_block_size =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=
 64*1024 =C2=A0 =C2=A0 =C2=A0 =3D 65536 =C2=A0 =C2=A0 //
> >       64KB
> >       =C2=A0 =C2=A0 leveldb_compression =C2=A0 =C2=A0 =C2=A0 =3D fals=
e
> >       =C2=A0 =C2=A0 leveldb_log =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =3D ""
> >=20
> >       =C2=A0 OSDs will still maintain the following osd-specific defa=
ults:
> >=20
> >       =C2=A0 =C2=A0 leveldb_log =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =3D ""
> >=20
> >       Notable Changes
> >       ---------------
> >=20
> >       * ceph-disk: fix dmcrypt support (Stephen Taylor)
> >       * cephtool: fix help (Yilong Zhao)
> >       * cephtool: test cleanup (Joao Eduardo Luis)
> >       * doc: librados example fixes (Kevin Dalley)
> >       * doc: many doc updates (John Wilkins)
> >       * doc: update erasure docs (Loic Dachary, Venky Shankar)
> >       * filestore: disable use of XFS hint (buggy on old kernels)
> >       (Samuel Just)
> >       * filestore: fix xattr spillout (Greg Farnum, Haomai Wang)
> >       * keyvaluestore: header cache (Haomai Wang)
> >       * librados_striper: striping library for librados (Sebastien
> >       Ponce)
> >       * libs3: update to latest (Danny Al-Gaaf)
> >       * log: fix derr level (Joao Eduardo Luis)
> >       * logrotate: fix osd log rotation on ubuntu (Sage Weil)
> >       * mds: fix xattr bug triggered by ACLs (Yan, Zheng)
> >       * misc memory leaks, cleanups, fixes (Danny Al-Gaaf, Sahid
> >       Ferdjaoui)
> >       * misc suse fixes (Danny Al-Gaaf)
> >       * misc word size fixes (Kevin Cox)
> >       * mon: drop mon- and osd- specific leveldb options (Joao Eduard=
o
> >       Luis)
> >       * mon: ec pool profile fixes (Loic Dachary)
> >       * mon: fix health down messages (Sage Weil)
> >       * mon: fix quorum feature check (#8738, Greg Farnum)
> >       * mon: 'osd crush reweight-subtree ...' (Sage Weil)
> >       * mon, osd: relax client EC support requirements (Sage Weil)
> >       * mon: some instrumentation (Sage Weil)
> >       * objecter: flag operations that are redirected by caching (Sag=
e
> >       Weil)
> >       * osd: clean up shard_id_t, shard_t (Loic Dachary)
> >       * osd: fix connection reconnect race (Greg Farnum)
> >       * osd: fix dumps (Joao Eduardo Luis)
> >       * osd: fix erasure-code lib initialization (Loic Dachary)
> >       * osd: fix extent normalization (Adam Crume)
> >       * osd: fix loopback msgr issue (Ma Jianpeng)
> >       * osd: fix LSB release parsing (Danny Al-Gaaf)
> >       * osd: improved backfill priorities (Sage Weil)
> >       * osd: many many core fixes (Samuel Just)
> >       * osd, mon: config sanity checks on start (Sage Weil, Joao
> >       Eduardo Luis)
> >       * osd: sharded threadpool to improve parallelism (Somnath Roy)
> >       * osd: simple io prioritization for scrub (Sage Weil)
> >       * osd: simple scrub throttling (Sage Weil)
> >       * osd: tests for bench command (Loic Dachary)
> >       * osd: use xfs hint less frequently (Ilya Dryomov)
> >       * pybind/rados: fix small timeouts (John Spray)
> >       * qa: xfstests updates (Ilya Dryomov)
> >       * rgw: cache bucket info (Yehuda Sadeh)
> >       * rgw: cache decoded user info (Yehuda Sadeh)
> >       * rgw: fix multipart object attr regression (#8452, Yehuda
> >       Sadeh)
> >       * rgw: fix radosgw-admin 'show log' command (#8553, Yehuda
> >       Sadeh)
> >       * rgw: fix URL decoding (#8702, Brian Rak)
> >       * rgw: handle empty extra pool name (Yehuda Sadeh)
> >       * rpm: do not restart daemons on upgrade (Alfredo Deza)
> >       * rpm: misc packaging fixes for rhel7 (Sandon Van Ness)
> >       * rpm: split ceph-common from ceph (Sandon Van Ness)
> >       * systemd: wrap started daemons in new systemd environment (Sag=
e
> >       Weil, Dan
> >       =C2=A0 Mick)
> >       * sysvinit: less sensitive to failures (Sage Weil)
> >       * upstart: increase max open files limit (Sage Weil)
> >=20
> >       Getting Ceph
> >       ------------
> >=20
> >       * Git at git://github.com/ceph/ceph.git
> >       * Tarball at http://ceph.com/download/ceph-0.83.tar.gz
> >       * For packages, see
> >       http://ceph.com/docs/master/install/get-packages
> >       * For ceph-deploy, see
> >       http://ceph.com/docs/master/install/install-ceph-deploy
> >       _______________________________________________
> >       ceph-users mailing list
> >       ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> >       http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >=20
> >=20
> >=20
> >=20
--557981400-1286242069-1407247752=:18948
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--557981400-1286242069-1407247752=:18948--
