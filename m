From: Michael Menge <michael.menge@zdv.uni-tuebingen.de>
Subject: OSD don't start after upgrade form 0.47.2 to 0.56.1
Date: Wed, 16 Jan 2013 16:42:31 +0100
Message-ID: <20130116164231.794017mcpq641x7r@webmail.uni-tuebingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx09.uni-tuebingen.de ([134.2.3.2]:38925 "EHLO
	mx09.uni-tuebingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754033Ab3APPmd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jan 2013 10:42:33 -0500
Received: from wm03.uni-tuebingen.de (wm03.uni-tuebingen.de [134.2.3.21])
	by mx09.uni-tuebingen.de (8.13.6/8.13.6) with ESMTP id r0GFgVns018801
	for <ceph-devel@vger.kernel.org>; Wed, 16 Jan 2013 16:42:31 +0100
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi List,

i tried to upgrade my ceph cluster from 0.47.2 (openSuSE buildservice =20
for SLES 11 SP2) to 0.56.1 (ceph.com/rpm/sles11/)

At first I updated only one server (mon.b / osd.2) and restartet ceph =20
on this server. After a short time /etc/init.d/ceph -a status showed =20
"not running"
for most osd

At this time i tried stopping ceph on all hosts, but some osd processes
where hanging in diskwait. I updated the others and after the processes
where still not responsiv i rebootet the systems.

After restarting ceph, the osds updated the filesystem, but stoped =20
short afterwards.

hpb020102 had the following log entries

------------------
2013-01-16 15:40:25.297036 7fd348387760  0 filestore(/srv/osd.2) mount =
=20
=46IEMAP io
ctl is supported and appears to work
2013-01-16 15:40:25.297049 7fd348387760  0 filestore(/srv/osd.2) mount =
=20
=46IEMAP io
ctl is disabled via 'filestore fiemap' config option
2013-01-16 15:40:25.297392 7fd348387760  0 filestore(/srv/osd.2) mount =
=20
did NOT d
etect btrfs
2013-01-16 15:40:25.297402 7fd348387760  0 filestore(/srv/osd.2) mount =
=20
syncfs(2)
  syscall not supported
2013-01-16 15:40:25.297405 7fd348387760  0 filestore(/srv/osd.2) mount =
=20
no syncfs
(2), must use sync(2).
2013-01-16 15:40:25.297407 7fd348387760  0 filestore(/srv/osd.2) mount =
=20
WARNING:
multiple ceph-osd daemons on the same host will be slow
2013-01-16 15:40:25.297480 7fd348387760  0 filestore(/srv/osd.2) mount =
=20
found sna
ps <>
2013-01-16 15:40:25.364304 7fd348387760  0 filestore(/srv/osd.2) =20
mount: enabling
  WRITEAHEAD journal mode: btrfs not detected
2013-01-16 15:40:25.373353 7fd348387760  1 journal _open =20
/srv/osd.2.journal fd 2
1: 1048576000 bytes, block size 4096 bytes, directio =3D 1, aio =3D 0
2013-01-16 15:40:25.373431 7fd348387760  1 journal _open =20
/srv/osd.2.journal fd 2
1: 1048576000 bytes, block size 4096 bytes, directio =3D 1, aio =3D 0
2013-01-16 15:40:25.374388 7fd348387760  1 journal close /srv/osd.2.jou=
rnal
2013-01-16 15:40:25.430719 7fd348387760  0 filestore(/srv/osd.2) mount =
=20
=46IEMAP io
ctl is supported and appears to work
2013-01-16 15:40:25.430731 7fd348387760  0 filestore(/srv/osd.2) mount =
=20
=46IEMAP io
ctl is disabled via 'filestore fiemap' config option
2013-01-16 15:40:25.431011 7fd348387760  0 filestore(/srv/osd.2) mount =
=20
did NOT d
etect btrfs
2013-01-16 15:40:25.431017 7fd348387760  0 filestore(/srv/osd.2) mount =
=20
syncfs(2)
  syscall not supported
2013-01-16 15:40:25.431018 7fd348387760  0 filestore(/srv/osd.2) mount =
=20
no syncfs
(2), must use sync(2).
2013-01-16 15:40:25.431019 7fd348387760  0 filestore(/srv/osd.2) mount =
=20
WARNING:
multiple ceph-osd daemons on the same host will be slow
2013-01-16 15:40:25.431041 7fd348387760  0 filestore(/srv/osd.2) mount =
=20
found sna
ps <>
2013-01-16 15:40:25.489620 7fd348387760  0 filestore(/srv/osd.2) =20
mount: enabling
  WRITEAHEAD journal mode: btrfs not detected
2013-01-16 15:40:25.494361 7fd348387760  1 journal _open =20
/srv/osd.2.journal fd 2
9: 1048576000 bytes, block size 4096 bytes, directio =3D 1, aio =3D 0
2013-01-16 15:40:25.494417 7fd348387760  1 journal _open =20
/srv/osd.2.journal fd 2
9: 1048576000 bytes, block size 4096 bytes, directio =3D 1, aio =3D 0
2013-01-16 15:40:25.494679 7fd348387760 -1 filestore(/srv/osd.2) could =
=20
not find
23c2fcde/osd_superblock/0//-1 in index: (2) No such file or directory
2013-01-16 15:40:25.494694 7fd348387760 -1 osd.2 0 OSD::init() : =20
unable to read
osd superblock
2013-01-16 15:40:25.495001 7fd348387760  1 journal close /srv/osd.2.jou=
rnal
2013-01-16 15:40:25.495665 7fd348387760 -1 ESC[0;31m ** ERROR: osd =20
init failed:
(22) Invalid argumentESC[0m
-----------------------

hpb020103-hpb020106 showed
--------------------
2013-01-16 15:47:56.886005 7f504e1e9760  0 filestore(/srv/osd.5) mount =
=20
=46IEMAP io
ctl is supported and appears to work
2013-01-16 15:47:56.886017 7f504e1e9760  0 filestore(/srv/osd.5) mount =
=20
=46IEMAP io
ctl is disabled via 'filestore fiemap' config option
2013-01-16 15:47:56.886291 7f504e1e9760  0 filestore(/srv/osd.5) mount =
=20
did NOT d
etect btrfs
2013-01-16 15:47:56.886298 7f504e1e9760  0 filestore(/srv/osd.5) mount =
=20
syncfs(2)
  syscall not supported
2013-01-16 15:47:56.886300 7f504e1e9760  0 filestore(/srv/osd.5) mount =
=20
no syncfs
(2), must use sync(2).
2013-01-16 15:47:56.886301 7f504e1e9760  0 filestore(/srv/osd.5) mount =
=20
WARNING:
multiple ceph-osd daemons on the same host will be slow
2013-01-16 15:47:56.886351 7f504e1e9760  0 filestore(/srv/osd.5) mount =
=20
found sna
ps <>
2013-01-16 15:47:56.945149 7f504e1e9760  0 filestore(/srv/osd.5) =20
mount: enabling
  WRITEAHEAD journal mode: btrfs not detected
2013-01-16 15:47:56.953456 7f504e1e9760  1 journal _open =20
/srv/osd.5.journal fd 2
1: 1048576000 bytes, block size 4096 bytes, directio =3D 1, aio =3D 0
2013-01-16 15:47:56.953545 7f504e1e9760  1 journal _open =20
/srv/osd.5.journal fd 2
1: 1048576000 bytes, block size 4096 bytes, directio =3D 1, aio =3D 0
2013-01-16 15:47:56.955011 7f504e1e9760  1 journal close /srv/osd.5.jou=
rnal
2013-01-16 15:47:56.956254 7f504e1e9760  2 osd.5 0 mounting /srv/osd.5 =
=20
/srv/osd.
5.journal
2013-01-16 15:47:57.011776 7f504e1e9760  0 filestore(/srv/osd.5) mount =
=20
=46IEMAP io
ctl is supported and appears to work
2013-01-16 15:47:57.011788 7f504e1e9760  0 filestore(/srv/osd.5) mount =
=20
=46IEMAP io
ctl is disabled via 'filestore fiemap' config option
2013-01-16 15:47:57.012059 7f504e1e9760  0 filestore(/srv/osd.5) mount =
=20
did NOT d
etect btrfs
2013-01-16 15:47:57.012067 7f504e1e9760  0 filestore(/srv/osd.5) mount =
=20
syncfs(2)
  syscall not supported
2013-01-16 15:47:57.012068 7f504e1e9760  0 filestore(/srv/osd.5) mount =
=20
no syncfs
(2), must use sync(2).
2013-01-16 15:47:57.012069 7f504e1e9760  0 filestore(/srv/osd.5) mount =
=20
WARNING:
multiple ceph-osd daemons on the same host will be slow
2013-01-16 15:47:57.012091 7f504e1e9760  0 filestore(/srv/osd.5) mount =
=20
found sna
ps <>
2013-01-16 15:47:57.070836 7f504e1e9760  0 filestore(/srv/osd.5) =20
mount: enabling
  WRITEAHEAD journal mode: btrfs not detected
2013-01-16 15:47:57.074997 7f504e1e9760  1 journal _open =20
/srv/osd.5.journal fd 2
9: 1048576000 bytes, block size 4096 bytes, directio =3D 1, aio =3D 0
2013-01-16 15:47:57.075050 7f504e1e9760  1 journal _open =20
/srv/osd.5.journal fd 2
9: 1048576000 bytes, block size 4096 bytes, directio =3D 1, aio =3D 0
2013-01-16 15:47:57.075210 7f504e1e9760  2 osd.5 0 boot
2013-01-16 15:47:57.075270 7f504e1e9760 10 osd.5 0 read_superblock =20
sb(9bacc7ad-7
b46-4549-b0d7-c7d9fab3d413 osd.5 99249929-183e-4d9b-9558-e5a4e239a190 =20
e2450 [194
8,2450] lci=3D[2417,2450])
2013-01-16 15:47:57.075292 7f504e1e9760 20 osd.5 0 get_map 2450 - =20
loading and de
coding 0x7f5044003da0
2013-01-16 15:47:57.075322 7f504e1e9760 10 osd.5 0 add_map_bl 2450 4416=
 bytes
2013-01-16 15:47:57.075394 7f504e1e9760 10 osd.5 2450 load_pgs
2013-01-16 15:47:57.076206 7f504e1e9760 10 osd.5 2450 load_pgs =20
skipping non-pg t
emp
2013-01-16 15:47:57.077660 7f504e1e9760 -1 *** Caught signal (Aborted) =
**
  in thread 7f504e1e9760

  ceph version 0.56.1 (e4a541624df62ef353e754391cbbb707f54b16f7)
  1: ceph-osd() [0x7cb52d]
  2: (()+0xf7c0) [0x7f504dbf77c0]
  3: (gsignal()+0x35) [0x7f504c366b55]
  4: (abort()+0x181) [0x7f504c368131]
  5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f504cbf5e4d]
  6: (()+0xbcff6) [0x7f504cbf3ff6]
  7: (()+0xbd023) [0x7f504cbf4023]
  8: (()+0xbd11e) [0x7f504cbf411e]
  9: (ceph::buffer::list::iterator::copy(unsigned int, char*)+0xae) [0x=
81253e]
  10: (PG::peek_map_epoch(ObjectStore*, coll_t, =20
ceph::buffer::list*)+0x99) [0x697
029]
  11: (OSD::load_pgs()+0xd44) [0x63f2e4]
  12: (OSD::init()+0x9f4) [0x655404]
  13: (main()+0x2ec8) [0x578548]
  14: (__libc_start_main()+0xe6) [0x7f504c352c36]
  15: ceph-osd() [0x5752a9]
  NOTE: a copy of the executable, or `objdump -rdS <executable>` is =20
needed to int
erpret this.

--- begin dump of recent events ---
------------------------------
If needed I can send the output of "objdump -rdS /usr/bin/ceph-osd" (60=
 MB)

ceph thinks that one osd is still alive, but i know they are all down.
ceph -s
    health HEALTH_WARN 58 pgs backfill; 919 pgs degraded; 52 pgs down; =
=20
156 pgs recovering; 439 pgs stale; 52 pgs stuck inactive; 439 pgs =20
stuck stale; 1020 pgs stuck unclean; recovery 10289/21740 degraded =20
(47.328%); 780/10870 unfound (7.176%)
    monmap e5: 5 mons at =20
{b=3D10.23.3.2:6789/0,c=3D10.23.3.3:6789/0,d=3D10.23.3.4:6789/0,e=3D10.=
23.3.5:6789/0,f=3D10.23.3.6:6789/0}, election epoch 100, quorum 0,1,2,3=
,4 =20
b,c,d,e,f
    osdmap e2728: 5 osds: 1 up, 1 in
     pgmap v3395922: 1352 pgs: 49 stale+active+recovering, 52 down, 55 =
=20
stale+active+recovering+degraded+wait_backfill, 332 =20
stale+active+clean, 49 active+recovering+degraded, 812 =20
active+degraded, 3 =20
stale+active+recovering+degraded+remapped+wait_backfill; 29598 MB =20
data, 15385 MB used, 385 GB / 400 GB avail; 10289/21740 degraded =20
(47.328%); 780/10870 unfound (7.176%)
    mdsmap e524439: 1/1/1 up {0=3Db=3Dup:replay}, 1 up:standby, 5 =20
up:oneshot-replay(laggy or crashed)

--------

So what did I miss in the upgrade process?
How can I recover the osds or if not possible, how do I return to
a clean state


Best regards

     Michael Menge







-----------------------------------------------------------------------=
---------

M.Menge                                Tel.: (49) 7071/29-70316
Universit=C3=A4t T=C3=BCbingen                   Fax.: (49) 7071/29-591=
2
Zentrum f=C3=BCr Datenverarbeitung          mail: =20
michael.menge@zdv.uni-tuebingen.de
W=C3=A4chterstra=C3=9Fe 76
72074 T=C3=BCbingen
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
