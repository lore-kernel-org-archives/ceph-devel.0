From: Sage Weil <sage@inktank.com>
Subject: Re: Cannot restart the osd successful after reboot machine
Date: Thu, 7 Jun 2012 20:33:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206072032260.10292@cobra.newdream.net>
References: <8512670932FB654F81AF0FEF1BE6D49D017E4C4C@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-392733875-1339126423=:10292"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39007 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757858Ab2FHDdt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jun 2012 23:33:49 -0400
In-Reply-To: <8512670932FB654F81AF0FEF1BE6D49D017E4C4C@WHQBEMAIL1.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wiwynn.com
Cc: ceph-devel@vger.kernel.org, Chris_YT_Huang@wiwynn.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-392733875-1339126423=:10292
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 8 Jun 2012, Eric_YH_Chen@wiwynn.com wrote:
> Dear All:
>=20
> In my testing environment, we deploy ceph cluster by version 0.43, kernel=
 3.2.0.
> (We deploy it several months ago, so the version is not the latest one)
> There are 5 MON and 8 OSD in the cluster. =A0We have 5 servers for the mo=
nitors.
> And two storages servers, 4 OSD for each.
>=20
> We meet a situation that we cannot restart the osd service successful aft=
er reboot one of the storage server. (contains 4 OSD).
> Let me describe the scenario more detail.
>=20
> 1. One of the storage server's network have problem. Therefore, we lose f=
our OSD in the cluster.
>=20
> =A0=A0 When I type 'ceph -s', I get some strange message like this.=A0 (s=
orry that I did not copy the clear message immediately)
>=20
> =A0=A0=A0=A0=A0=A0 -276/3108741 degraded =A0(the number is a negative num=
ber, I am sure)
> =A0=A0=A0=A0=A0=A0 8 osds: 4 up, 4 in
>=20
> 2. After fix the broken network, I try to restart the four OSD on it. But=
 some of OSD would fail.
>=20
> 3. I repeat to execute 'service ceph start' on the storage server. Maybe =
after 10 times, all the OSDs finally work fine.
> =A0 And 'ceph health' returns HEALTH_OK
>=20
> Appreciate for any comment for this situation, thanks!=A0 If you want the=
 complete log for all OSD, I can send it to you.
>=20
> 2012-06-07 14:42:36.482616 7f62a02547a0 ceph version 0.43 (commit:9fa8781=
c0147d66fcef7c2dd0e09cd3c69747d37), process ceph-osd, pid 7146
> 2012-06-07 14:42:36.510945 7f62a02547a0 filestore(/srv/disk0) mount FIEMA=
P ioctl is supported
> 2012-06-07 14:42:36.511002 7f62a02547a0 filestore(/srv/disk0) mount did N=
OT detect btrfs
> 2012-06-07 14:42:36.511372 7f62a02547a0 filestore(/srv/disk0) mount found=
 snaps <>
> 2012-06-07 14:42:36.640990 7f62a02547a0 filestore(/srv/disk0) mount: enab=
ling WRITEAHEAD journal mode: btrfs not detected
> 2012-06-07 14:42:36.816868 7f62a02547a0 journal _open /srv/disk0.journal =
fd 16: 1048576000 bytes, block size 4096 bytes, directio =3D 1, aio =3D 0
> 2012-06-07 14:42:36.848522 7f62a02547a0 journal read_entry 410750976 : se=
q 1115076 1278 bytes
> 2012-06-07 14:42:36.848582 7f62a02547a0 journal read_entry 410759168 : se=
q 1115077 1275 bytes
> 2012-06-07 14:42:36.848810 7f62a02547a0 journal read_entry 410767360 : se=
q 1115078 1275 bytes
> 2012-06-07 14:42:36.848835 7f62a02547a0 journal read_entry 410775552 : se=
q 1115079 1272 bytes
> 2012-06-07 14:42:36.848859 7f62a02547a0 journal read_entry 410783744 : se=
q 1115080 1281 bytes
> 2012-06-07 14:42:36.848872 7f62a02547a0 journal read_entry 410791936 : se=
q 1115081 1281 bytes
> 2012-06-07 14:42:36.849181 7f62a02547a0 journal read_entry 410800128 : se=
q 1115082 1275 bytes
> 2012-06-07 14:42:36.849207 7f62a02547a0 journal read_entry 410808320 : se=
q 1115083 1278 bytes
> 2012-06-07 14:42:36.849225 7f62a02547a0 journal read_entry 410816512 : se=
q 1115084 1281 bytes
> 2012-06-07 14:42:36.849239 7f62a02547a0 journal read_entry 410824704 : se=
q 1115085 1275 bytes
> 2012-06-07 14:42:36.849255 7f62a02547a0 journal read_entry 410832896 : se=
q 1115086 1281 bytes
> 2012-06-07 14:42:36.849267 7f62a02547a0 journal read_entry 410841088 : se=
q 1115087 1278 bytes
> 2012-06-07 14:42:36.849282 7f62a02547a0 journal read_entry 410849280 : se=
q 1115088 1275 bytes
> 2012-06-07 14:42:36.849293 7f62a02547a0 journal read_entry 410857472 : se=
q 1115089 1275 bytes
> 2012-06-07 14:42:36.849328 7f62a02547a0 journal _open /srv/disk0.journal =
fd 16: 1048576000 bytes, block size 4096 bytes, directio =3D 1, aio =3D 0
> 2012-06-07 14:42:36.851593 7f62a02547a0 journal close /srv/disk0.journal
> 2012-06-07 14:42:36.852625 7f62a02547a0 filestore(/srv/disk0) mount FIEMA=
P ioctl is supported
> 2012-06-07 14:42:36.852642 7f62a02547a0 filestore(/srv/disk0) mount did N=
OT detect btrfs
> 2012-06-07 14:42:36.852695 7f62a02547a0 filestore(/srv/disk0) mount found=
 snaps <>
> 2012-06-07 14:42:36.852714 7f62a02547a0 filestore(/srv/disk0) mount: enab=
ling WRITEAHEAD journal mode: btrfs not detected
> 2012-06-07 14:42:36.855399 7f62a02547a0 journal _open /srv/disk0.journal =
fd 24: 1048576000 bytes, block size 4096 bytes, directio =3D 1, aio =3D 0
> 2012-06-07 14:42:36.855429 7f62a02547a0 journal read_entry 410750976 : se=
q 1115076 1278 bytes
> 2012-06-07 14:42:36.855450 7f62a02547a0 journal read_entry 410759168 : se=
q 1115077 1275 bytes
> 2012-06-07 14:42:36.855464 7f62a02547a0 journal read_entry 410767360 : se=
q 1115078 1275 bytes
> 2012-06-07 14:42:36.855476 7f62a02547a0 journal read_entry 410775552 : se=
q 1115079 1272 bytes
> 2012-06-07 14:42:36.855487 7f62a02547a0 journal read_entry 410783744 : se=
q 1115080 1281 bytes
> 2012-06-07 14:42:36.855501 7f62a02547a0 journal read_entry 410791936 : se=
q 1115081 1281 bytes
> 2012-06-07 14:42:36.855514 7f62a02547a0 journal read_entry 410800128 : se=
q 1115082 1275 bytes
> 2012-06-07 14:42:36.855525 7f62a02547a0 journal read_entry 410808320 : se=
q 1115083 1278 bytes
> 2012-06-07 14:42:36.855536 7f62a02547a0 journal read_entry 410816512 : se=
q 1115084 1281 bytes
> 2012-06-07 14:42:36.855547 7f62a02547a0 journal read_entry 410824704 : se=
q 1115085 1275 bytes
> 2012-06-07 14:42:36.855558 7f62a02547a0 journal read_entry 410832896 : se=
q 1115086 1281 bytes
> 2012-06-07 14:42:36.855569 7f62a02547a0 journal read_entry 410841088 : se=
q 1115087 1278 bytes
> 2012-06-07 14:42:36.855580 7f62a02547a0 journal read_entry 410849280 : se=
q 1115088 1275 bytes
> 2012-06-07 14:42:36.855591 7f62a02547a0 journal read_entry 410857472 : se=
q 1115089 1275 bytes
> 2012-06-07 14:42:36.855615 7f62a02547a0 journal _open /srv/disk0.journal =
fd 24: 1048576000 bytes, block size 4096 bytes, directio =3D 1, aio =3D 0
> 2012-06-07 14:42:45.975088 7f6292f49700 osd.4 9 handle_osd_map fsid 520ab=
01f-cd87-4214-b6ce-d4f7c29da98a !=3D 00000000-0000-0000-0000-000000000000
> 2012-06-07 14:42:47.104389 7f6292f49700 osd.4 9 handle_osd_map fsid 520ab=
01f-cd87-4214-b6ce-d4f7c29da98a !=3D 00000000-0000-0000-0000-000000000000
> 2012-06-07 14:42:50.416604 7f6292f49700 osd.4 9 handle_osd_map fsid 520ab=
01f-cd87-4214-b6ce-d4f7c29da98a !=3D 00000000-0000-0000-0000-000000000000
> 2012-06-07 14:42:51.566632 7f6292f49700 osd.4 9 handle_osd_map fsid 520ab=
01f-cd87-4214-b6ce-d4f7c29da98a !=3D 00000000-0000-0000-0000-000000000000
> 2012-06-07 14:42:53.026978 7f6292f49700 osd.4 9 handle_osd_map fsid 520ab=
01f-cd87-4214-b6ce-d4f7c29da98a !=3D 00000000-0000-0000-0000-000000000000
> 2012-06-07 14:42:56.246388 7f6292f49700 osd.4 9 handle_osd_map fsid 520ab=
01f-cd87-4214-b6ce-d4f7c29da98a !=3D 00000000-0000-0000-0000-000000000000
> 2012-06-07 14:42:57.563794 7f6292f49700 osd.4 9 handle_osd_map fsid 520ab=
01f-cd87-4214-b6ce-d4f7c29da98a !=3D 00000000-0000-0000-0000-000000000000
> 2012-06-07 14:42:59.296518 7f6292f49700 osd.4 9 handle_osd_map fsid 520ab=
01f-cd87-4214-b6ce-d4f7c29da98a !=3D 00000000-0000-0000-0000-000000000000
> 2012-06-07 14:43:00.571422 7f6292f49700 osd.4 9 handle_osd_map fsid 520ab=
01f-cd87-4214-b6ce-d4f7c29da98a !=3D 00000000-0000-0000-0000-000000000000

This problem has since been fixed.

> 2012-06-07 14:43:11.428808 7f628b11f700 -- 192.168.123.2:6800/7146 >> 192=
=2E168.123.3:0/552115952 pipe(0x4ff2c80 sd=3D41 pgs=3D0 cs=3D0 l=3D0).accep=
t peer addr is really 192.168.123.3:0/552115952 (socket is 192.168.123.3:43=
234/0)
> 2012-06-07 14:43:25.204361 7f628fd41700 osd.4 225 pg[2.ac( v 46'5107 lc 9=
'5101 (9'4099,46'5107] n=3D165 ec=3D1 les/c 214/214 222/222/222) [4,1] r=3D=
0 lpr=3D225 lcod 0'0 mlcod 0'0 active+recovering m=3D1] watch: ctx->obc=3D0=
x5e5a000 cookie=3D13 oi.version=3D5102 ctx->at_version=3D225'5108
> 2012-06-07 14:43:25.204405 7f628fd41700 osd.4 225 pg[2.ac( v 46'5107 lc 9=
'5101 (9'4099,46'5107] n=3D165 ec=3D1 les/c 214/214 222/222/222) [4,1] r=3D=
0 lpr=3D225 lcod 0'0 mlcod 0'0 active+recovering m=3D1] watch: oi.user_vers=
ion=3D215
> osd/ReplicatedPG.cc: In function 'void ReplicatedPG::populate_obc_watcher=
s(ReplicatedPG::ObjectContext*)' thread 7f629474c700 time 2012-06-07 14:43:=
25.232802
> osd/ReplicatedPG.cc: 3380: FAILED assert(obc->unconnected_watchers.size()=
 =3D=3D 0)

As has this one.

If you upgrade to 0.47.2, both issues should be resolved!  :)

sage



> ceph version 0.43 (commit:9fa8781c0147d66fcef7c2dd0e09cd3c69747d37)
> 1: /usr/bin/ceph-osd() [0x52f1e2]
> 2: (ReplicatedPG::_applied_recovered_object(ObjectStore::Transaction*, Re=
plicatedPG::ObjectContext*)+0x182) [0x52f692]
> 3: (Finisher::finisher_thread_entry()+0x190) [0x74a870]
> 4: (()+0x7efc) [0x7f629fc2befc]
> 5: (clone()+0x6d) [0x7f629e25c59d]
> ceph version 0.43 (commit:9fa8781c0147d66fcef7c2dd0e09cd3c69747d37)
> 1: /usr/bin/ceph-osd() [0x52f1e2]
> 2: (ReplicatedPG::_applied_recovered_object(ObjectStore::Transaction*, Re=
plicatedPG::ObjectContext*)+0x182) [0x52f692]
> 3: (Finisher::finisher_thread_entry()+0x190) [0x74a870]
> 4: (()+0x7efc) [0x7f629fc2befc]
> 5: (clone()+0x6d) [0x7f629e25c59d]
> *** Caught signal (Aborted) **
> in thread 7f629474c700
> ceph version 0.43 (commit:9fa8781c0147d66fcef7c2dd0e09cd3c69747d37)
> 1: /usr/bin/ceph-osd() [0x6e3866]
> 2: (()+0x10060) [0x7f629fc34060]
> 3: (gsignal()+0x35) [0x7f629e1af3a5]
> 4: (abort()+0x17b) [0x7f629e1b2b0b]
> 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f629ea6fd7d]
> 6: (()+0xb9f26) [0x7f629ea6df26]
> 7: (()+0xb9f53) [0x7f629ea6df53]
> 8: (()+0xba04e) [0x7f629ea6e04e]
> 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+=
0x200) [0x678bc0]
> 10: /usr/bin/ceph-osd() [0x52f1e2]
> 11: (ReplicatedPG::_applied_recovered_object(ObjectStore::Transaction*, R=
eplicatedPG::ObjectContext*)+0x182) [0x52f692]
> 12: (Finisher::finisher_thread_entry()+0x190) [0x74a870]
> 13: (()+0x7efc) [0x7f629fc2befc]
> 14: (clone()+0x6d) [0x7f629e25c59d]
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-392733875-1339126423=:10292--
