From: bernhard glomm <bernhard.glomm@ecologic.eu>
Subject: how to replace broken mon?
Date: Wed, 4 Sep 2013 14:26:04 +0200
Message-ID: <C138E710-D077-4126-AF2E-8D2AD82B6BF5@ecologic.eu>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: multipart/signed; boundary="Apple-Mail=_918F21E6-12F8-4D07-8A7A-059C955E21E2"; protocol="application/pgp-signature"; micalg=pgp-sha1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx01.ecologic.eu ([85.214.42.230]:58161 "EHLO mx01.ecologic.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754209Ab3IDM0H (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 4 Sep 2013 08:26:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx01.ecologic.eu (Postfix) with ESMTP id E6F42740A0
	for <ceph-devel@vger.kernel.org>; Wed,  4 Sep 2013 14:26:03 +0200 (CEST)
Received: from mx01.ecologic.eu ([127.0.0.1])
	by localhost (mx01.ecologic.eu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CvHlj8szsgkI for <ceph-devel@vger.kernel.org>;
	Wed,  4 Sep 2013 14:26:03 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


--Apple-Mail=_918F21E6-12F8-4D07-8A7A-059C955E21E2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi all,

after some days of successful creating and destroying rbd's, snapshots,
clones and migrating formats all of a sudden one of the monitors doesn't =
work anymore.
I tried to remove and re-add the monitor from the cluster, but that =
doesn't seem to work either.

Here's the situation:
I liked to use ceph-deploy to initiate the cluster.
Due to the broken ceph-create-keys in dumpling I turned to the =
gitbuilder version
now running

ceph version 0.67.2-23-g24f2669 =
(24f2669783e2eb9d9af5ecbe106efed93366ba63)
on uptodate raring systems
All of a sudden the host from which I ran ceph-deploy, and which should =
be one of the
5 monitors (from which 2 are also serving as OSDs) has fallen out of the =
quorum as you can see here
(yes, time is in sync on all nodes):

------------------
root@nuke36[/0]:~ # ceph -s
2013-09-04 11:09:56.039547 7f7a8820f700  1 -- :/0 messenger.start
2013-09-04 11:09:56.040646 7f7a8820f700  1 -- :/1016260 --> =
192.168.242.92:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 =
0x7f7a8000e8f0 con 0x7f7a8000e4e0
2013-09-04 11:09:56.041304 7f7a84a08700  1 -- 192.168.242.36:0/1016260 =
learned my addr 192.168.242.36:0/1016260
2013-09-04 11:09:56.042843 7f7a86a0c700  1 -- 192.168.242.36:0/1016260 =
<=3D=3D mon.3 192.168.242.92:6789/0 1 =3D=3D=3D=3D mon_map v1 =3D=3D=3D=3D=
 776+0+0 (2241333437 0 0) 0x7f7a70000c30 con 0x7f7a8000e4e0
2013-09-04 11:09:56.043038 7f7a86a0c700  1 -- 192.168.242.36:0/1016260 =
<=3D=3D mon.3 192.168.242.92:6789/0 2 =3D=3D=3D=3D auth_reply(proto 2 0 =
Success) v1 =3D=3D=3D=3D 33+0+0 (2063715990 0 0) 0x7f7a70001060 con =
0x7f7a8000e4e0
2013-09-04 11:09:56.043324 7f7a86a0c700  1 -- 192.168.242.36:0/1016260 =
--> 192.168.242.92:6789/0 -- auth(proto 2 32 bytes epoch 0) v1 -- ?+0 =
0x7f7a74001af0 con 0x7f7a8000e4e0
2013-09-04 11:09:56.044197 7f7a86a0c700  1 -- 192.168.242.36:0/1016260 =
<=3D=3D mon.3 192.168.242.92:6789/0 3 =3D=3D=3D=3D auth_reply(proto 2 0 =
Success) v1 =3D=3D=3D=3D 206+0+0 (3910749728 0 0) 0x7f7a70001060 con =
0x7f7a8000e4e0
2013-09-04 11:09:56.044375 7f7a86a0c700  1 -- 192.168.242.36:0/1016260 =
--> 192.168.242.92:6789/0 -- auth(proto 2 165 bytes epoch 0) v1 -- ?+0 =
0x7f7a740020d0 con 0x7f7a8000e4e0
2013-09-04 11:09:56.045376 7f7a86a0c700  1 -- 192.168.242.36:0/1016260 =
<=3D=3D mon.3 192.168.242.92:6789/0 4 =3D=3D=3D=3D auth_reply(proto 2 0 =
Success) v1 =3D=3D=3D=3D 393+0+0 (3802320753 0 0) 0x7f7a700008f0 con =
0x7f7a8000e4e0
2013-09-04 11:09:56.045457 7f7a86a0c700  1 -- 192.168.242.36:0/1016260 =
--> 192.168.242.92:6789/0 -- mon_subscribe({monmap=3D0+}) v2 -- ?+0 =
0x7f7a8000ed80 con 0x7f7a8000e4e0
2013-09-04 11:09:56.045550 7f7a8820f700  1 -- 192.168.242.36:0/1016260 =
--> 192.168.242.92:6789/0 -- mon_subscribe({monmap=3D2+,osdmap=3D0}) v2 =
-- ?+0 0x7f7a800079f0 con 0x7f7a8000e4e0
2013-09-04 11:09:56.045559 7f7a8820f700  1 -- 192.168.242.36:0/1016260 =
--> 192.168.242.92:6789/0 -- mon_subscribe({monmap=3D2+,osdmap=3D0}) v2 =
-- ?+0 0x7f7a8000fa10 con 0x7f7a8000e4e0
2013-09-04 11:09:56.046376 7f7a86a0c700  1 -- 192.168.242.36:0/1016260 =
<=3D=3D mon.3 192.168.242.92:6789/0 5 =3D=3D=3D=3D mon_map v1 =3D=3D=3D=3D=
 776+0+0 (2241333437 0 0) 0x7f7a70001290 con 0x7f7a8000e4e0
2013-09-04 11:09:56.046417 7f7a86a0c700  1 -- 192.168.242.36:0/1016260 =
<=3D=3D mon.3 192.168.242.92:6789/0 6 =3D=3D=3D=3D =
mon_subscribe_ack(300s) v1 =3D=3D=3D=3D 20+0+0 (1524320885 0 0) =
0x7f7a70001480 con 0x7f7a8000e4e0
2013-09-04 11:09:56.046429 7f7a86a0c700  1 -- 192.168.242.36:0/1016260 =
<=3D=3D mon.3 192.168.242.92:6789/0 7 =3D=3D=3D=3D osd_map(22..22 src =
has 1..22) v3 =3D=3D=3D=3D 2355+0+0 (11792226 0 0) 0x7f7a70001f70 con =
0x7f7a8000e4e0
2013-09-04 11:09:56.046828 7f7a86a0c700  1 -- 192.168.242.36:0/1016260 =
<=3D=3D mon.3 192.168.242.92:6789/0 8 =3D=3D=3D=3D =
mon_subscribe_ack(300s) v1 =3D=3D=3D=3D 20+0+0 (1524320885 0 0) =
0x7f7a700008f0 con 0x7f7a8000e4e0
2013-09-04 11:09:56.046948 7f7a86a0c700  1 -- 192.168.242.36:0/1016260 =
<=3D=3D mon.3 192.168.242.92:6789/0 9 =3D=3D=3D=3D osd_map(22..22 src =
has 1..22) v3 =3D=3D=3D=3D 2355+0+0 (11792226 0 0) 0x7f7a700008c0 con =
0x7f7a8000e4e0
2013-09-04 11:09:56.047071 7f7a86a0c700  1 -- 192.168.242.36:0/1016260 =
<=3D=3D mon.3 192.168.242.92:6789/0 10 =3D=3D=3D=3D =
mon_subscribe_ack(300s) v1 =3D=3D=3D=3D 20+0+0 (1524320885 0 0) =
0x7f7a70000df0 con 0x7f7a8000e4e0
2013-09-04 11:09:56.047547 7f7a8820f700  1 -- 192.168.242.36:0/1016260 =
--> 192.168.242.92:6789/0 -- mon_command({"prefix": =
"get_command_descriptions"} v 0) v1 -- ?+0 0x7f7a8000b0f0 con =
0x7f7a8000e4e0
2013-09-04 11:09:56.050938 7f7a86a0c700  1 -- 192.168.242.36:0/1016260 =
<=3D=3D mon.3 192.168.242.92:6789/0 11 =3D=3D=3D=3D =
mon_command_ack([{"prefix": "get_command_descriptions"}]=3D0  v0) v1 =
=3D=3D=3D=3D 72+0+24040 (1092875540 0 2922658865) 0x7f7a700008c0 con =
0x7f7a8000e4e0
2013-09-04 11:09:56.089981 7f7a8820f700  1 -- 192.168.242.36:0/1016260 =
--> 192.168.242.92:6789/0 -- mon_command({"prefix": "status"} v 0) v1 -- =
?+0 0x7f7a8000b0d0 con 0x7f7a8000e4e0
2013-09-04 11:09:56.091348 7f7a86a0c700  1 -- 192.168.242.36:0/1016260 =
<=3D=3D mon.3 192.168.242.92:6789/0 12 =3D=3D=3D=3D =
mon_command_ack([{"prefix": "status"}]=3D0  v0) v1 =3D=3D=3D=3D 54+0+558 =
(1155462804 0 1174924833) 0x7f7a70000db0 con 0x7f7a8000e4e0
  cluster b085fba3-8e17-443c-bb61-7758504538f8
   health HEALTH_WARN 1 mons down, quorum 0,1,3,4 =
atom01,atom02,ping,pong
   monmap e1: 5 mons at =
{atom01=3D192.168.242.31:6789/0,atom02=3D192.168.242.32:6789/0,nuke36=3D19=
2.168.242.36:6789/0,ping=3D192.168.242.92:6789/0,pong=3D192.168.242.93:678=
9/0}, election epoch 26, quorum 0,1,3,4 atom01,atom02,ping,pong
   osdmap e22: 2 osds: 2 up, 2 in
    pgmap v46761: 1192 pgs: 1192 active+clean; 7806 MB data, 20618 MB =
used, 3702 GB / 3722 GB avail; 9756B/s wr, 0op/s
   mdsmap e17: 1/1/1 up {0=3Dpong=3Dup:active}, 1 up:standby

2013-09-04 11:09:56.096071 7f7a8820f700  1 -- 192.168.242.36:0/1016260 =
mark_down 0x7f7a8000e4e0 -- 0x7f7a8000e280
2013-09-04 11:09:56.096516 7f7a8820f700  1 -- 192.168.242.36:0/1016260 =
mark_down_all
2013-09-04 11:09:56.097065 7f7a8820f700  1 -- 192.168.242.36:0/1016260 =
shutdown complete.
------------------

this is the ceph.conf that was generated during ceph-deploy (well I =
added the debug lines obviously)

------------------
root@nuke36[/0]:~ # cat /etc/ceph/ceph.conf
[global]
fsid =3D b085fba3-8e17-443c-bb61-7758504538f8
mon_initial_members =3D ping, pong, nuke36, atom01, atom02
mon_host =3D =
192.168.242.92,192.168.242.93,192.168.242.36,192.168.242.31,192.168.242.32=

auth_supported =3D cephx
osd_journal_size =3D 1024
filestore_xattr_use_omap =3D true
debug ms =3D 1
debug mon =3D 20
------------------

after a reboot of the node I now find

------------------
root@nuke36[/1]:~ # ps ax | egrep ceph
  855 ?        Ssl    0:00 /usr/bin/ceph-mon --cluster=3Dceph -i nuke36 =
-f
  856 ?        Ss     0:00 /usr/bin/python /usr/sbin/ceph-create-keys =
--cluster=3Dceph -i nuke36
 1813 pts/1    R+     0:00 egrep --color=3Dauto ceph
------------------

with ceph-create-keys runing infinetly,
while the key files but already exist

------------------
root@nuke36[/1]:~ # ls -lh /etc/ceph/
total 88K
-rw-r--r-- 1 root root  72 Aug 30 15:54 ceph.bootstrap-mds.keyring
-rw-r--r-- 1 root root  72 Aug 30 15:54 ceph.bootstrap-osd.keyring
-rw------- 1 root root  64 Aug 30 15:54 ceph.client.admin.keyring
-rw-r--r-- 1 root root 303 Sep  4 10:19 ceph.conf
-rw-r--r-- 1 root root 59K Sep  3 10:15 ceph.log
-rw-r--r-- 1 root root  73 Aug 30 15:53 ceph.mon.keyring
-rw-r--r-- 1 root root  92 Aug 30 00:03 rbdmap
------------------

and

------------------
root@nuke36[/1]:~ # tree -pfugiAD /var/lib/ceph/
/var/lib/ceph
[drwxr-xr-x root     root     Aug 30 15:54]  /var/lib/ceph/bootstrap-mds
[-rw------- root     root     Aug 30 15:54]  =
/var/lib/ceph/bootstrap-mds/ceph.keyring
[drwxr-xr-x root     root     Aug 30 15:54]  /var/lib/ceph/bootstrap-osd
[-rw------- root     root     Aug 30 15:54]  =
/var/lib/ceph/bootstrap-osd/ceph.keyring
[drwxr-xr-x root     root     Aug 30  0:00]  /var/lib/ceph/mds
[drwxr-xr-x root     root     Aug 30 15:53]  /var/lib/ceph/mon
[drwxr-xr-x root     root     Aug 30 15:53]  =
/var/lib/ceph/mon/ceph-nuke36
[-rw-r--r-- root     root     Aug 30 15:53]  =
/var/lib/ceph/mon/ceph-nuke36/done
[-rw-r--r-- root     root     Aug 30 15:53]  =
/var/lib/ceph/mon/ceph-nuke36/keyring
[drwxr-xr-x root     root     Sep  4 11:16]  =
/var/lib/ceph/mon/ceph-nuke36/store.db
[-rw-r--r-- root     root     Sep  3  6:21]  =
/var/lib/ceph/mon/ceph-nuke36/store.db/007726.sst
[-rw-r--r-- root     root     Sep  3  6:21]  =
/var/lib/ceph/mon/ceph-nuke36/store.db/007727.sst
[-rw-r--r-- root     root     Sep  3  6:21]  =
/var/lib/ceph/mon/ceph-nuke36/store.db/007728.sst
[-rw-r--r-- root     root     Sep  3  6:21]  =
/var/lib/ceph/mon/ceph-nuke36/store.db/007729.sst
[-rw-r--r-- root     root     Sep  3  6:21]  =
/var/lib/ceph/mon/ceph-nuke36/store.db/007730.sst
[-rw-r--r-- root     root     Sep  4 10:14]  =
/var/lib/ceph/mon/ceph-nuke36/store.db/007767.sst
[-rw-r--r-- root     root     Sep  4 10:14]  =
/var/lib/ceph/mon/ceph-nuke36/store.db/007768.sst
[-rw-r--r-- root     root     Sep  4 10:14]  =
/var/lib/ceph/mon/ceph-nuke36/store.db/007769.sst
[-rw-r--r-- root     root     Sep  4 10:14]  =
/var/lib/ceph/mon/ceph-nuke36/store.db/007770.sst
[-rw-r--r-- root     root     Sep  4 10:14]  =
/var/lib/ceph/mon/ceph-nuke36/store.db/007772.sst
[-rw-r--r-- root     root     Sep  4 10:14]  =
/var/lib/ceph/mon/ceph-nuke36/store.db/007773.sst
[-rw-r--r-- root     root     Sep  4 10:14]  =
/var/lib/ceph/mon/ceph-nuke36/store.db/007774.sst
[-rw-r--r-- root     root     Sep  4 10:14]  =
/var/lib/ceph/mon/ceph-nuke36/store.db/007775.sst
[-rw-r--r-- root     root     Sep  4 10:18]  =
/var/lib/ceph/mon/ceph-nuke36/store.db/007777.sst
[-rw-r--r-- root     root     Sep  4 10:19]  =
/var/lib/ceph/mon/ceph-nuke36/store.db/007780.sst
[-rw-r--r-- root     root     Sep  4 11:16]  =
/var/lib/ceph/mon/ceph-nuke36/store.db/007783.sst
[-rw-r--r-- root     root     Sep  4 11:16]  =
/var/lib/ceph/mon/ceph-nuke36/store.db/007784.log
[-rw-r--r-- root     root     Sep  4 11:16]  =
/var/lib/ceph/mon/ceph-nuke36/store.db/CURRENT
[-rw-r--r-- root     root     Aug 30 15:53]  =
/var/lib/ceph/mon/ceph-nuke36/store.db/LOCK
[-rw-r--r-- root     root     Sep  4 11:16]  =
/var/lib/ceph/mon/ceph-nuke36/store.db/LOG
[-rw-r--r-- root     root     Sep  4 10:19]  =
/var/lib/ceph/mon/ceph-nuke36/store.db/LOG.old
[-rw-r--r-- root     root     Sep  4 11:16]  =
/var/lib/ceph/mon/ceph-nuke36/store.db/MANIFEST-007782
[-rw-r--r-- root     root     Aug 30 15:53]  =
/var/lib/ceph/mon/ceph-nuke36/upstart
[drwxr-xr-x root     root     Aug 30  0:00]  /var/lib/ceph/osd
[drwxr-xr-x root     root     Aug 30 15:53]  /var/lib/ceph/tmp
------------------

to compare with atom01 which is still running in the cluster...

------------------
root@atom01[/0]:~ # tree -pfugiAD /var/lib/ceph/
/var/lib/ceph
[drwxr-xr-x root     root     Aug 30 15:54]  /var/lib/ceph/bootstrap-mds
[-rw------- root     root     Aug 30 15:54]  =
/var/lib/ceph/bootstrap-mds/ceph.keyring
[drwxr-xr-x root     root     Aug 30 15:54]  /var/lib/ceph/bootstrap-osd
[-rw------- root     root     Aug 30 15:54]  =
/var/lib/ceph/bootstrap-osd/ceph.keyring
[drwxr-xr-x root     root     Aug 30  0:00]  /var/lib/ceph/mds
[drwxr-xr-x root     root     Aug 30 15:53]  /var/lib/ceph/mon
[drwxr-xr-x root     root     Aug 30 15:53]  =
/var/lib/ceph/mon/ceph-atom01
[-rw-r--r-- root     root     Aug 30 15:53]  =
/var/lib/ceph/mon/ceph-atom01/done
[-rw-r--r-- root     root     Aug 30 15:53]  =
/var/lib/ceph/mon/ceph-atom01/keyring
[drwxr-xr-x root     root     Sep  4 11:18]  =
/var/lib/ceph/mon/ceph-atom01/store.db
[-rw-r--r-- root     root     Sep  4 11:25]  =
/var/lib/ceph/mon/ceph-atom01/store.db/006339.log
[-rw-r--r-- root     root     Sep  4 11:18]  =
/var/lib/ceph/mon/ceph-atom01/store.db/006342.sst
[-rw-r--r-- root     root     Sep  4 11:18]  =
/var/lib/ceph/mon/ceph-atom01/store.db/006343.sst
[-rw-r--r-- root     root     Sep  4 11:18]  =
/var/lib/ceph/mon/ceph-atom01/store.db/006344.sst
[-rw-r--r-- root     root     Sep  4 11:18]  =
/var/lib/ceph/mon/ceph-atom01/store.db/006345.sst
[-rw-r--r-- root     root     Sep  4 11:18]  =
/var/lib/ceph/mon/ceph-atom01/store.db/006346.sst
[-rw-r--r-- root     root     Sep  4 11:18]  =
/var/lib/ceph/mon/ceph-atom01/store.db/006347.sst
[-rw-r--r-- root     root     Sep  4 11:18]  =
/var/lib/ceph/mon/ceph-atom01/store.db/006348.sst
[-rw-r--r-- root     root     Aug 30 15:53]  =
/var/lib/ceph/mon/ceph-atom01/store.db/CURRENT
[-rw-r--r-- root     root     Aug 30 15:53]  =
/var/lib/ceph/mon/ceph-atom01/store.db/LOCK
[-rw-r--r-- root     root     Sep  4 11:18]  =
/var/lib/ceph/mon/ceph-atom01/store.db/LOG
[-rw-r--r-- root     root     Aug 30 15:53]  =
/var/lib/ceph/mon/ceph-atom01/store.db/LOG.old
[-rw-r--r-- root     root     Sep  4 11:18]  =
/var/lib/ceph/mon/ceph-atom01/store.db/MANIFEST-000004
[-rw-r--r-- root     root     Aug 30 15:53]  =
/var/lib/ceph/mon/ceph-atom01/upstart
[drwxr-xr-x root     root     Aug 30  0:00]  /var/lib/ceph/osd
[drwxr-xr-x root     root     Aug 30 15:53]  /var/lib/ceph/tmp
------------------

the problem with ceph-create-keys seemed to have been fixed with =
wip-4924
since in that version "rbd create" wouldn't work I switched to
deb =
http://gitbuilder.ceph.com/ceph-deb-raring-x86_64-basic/ref/dumpling/    =
   raring main
(runing on an uptodate raring)
I thought of just removing and than re-adding the failing mon but who do =
I do that?
The documentation on
http://ceph.com/docs/master/rados/operations/add-or-rm-mons/
says:
"service ceph -a stop mon.{mon-id}"

------------------
root@nuke36[/1]:~ # service ceph -a stop mon.nuke36
/etc/init.d/ceph: mon.nuke36 not found (/etc/ceph/ceph.conf defines , =
/var/lib/ceph defines )
root@nuke36[/1]:~ # service ceph -a stop mon.c
/etc/init.d/ceph: mon.c not found (/etc/ceph/ceph.conf defines , =
/var/lib/ceph defines )
root@nuke36[/1]:~ # service ceph -a stop mon.2
/etc/init.d/ceph: mon.2 not found (/etc/ceph/ceph.conf defines , =
/var/lib/ceph defines )
root@nuke36[/1]:~ # service ceph -a stop mon.ceph-nuke36
/etc/init.d/ceph: mon.ceph-nuke36 not found (/etc/ceph/ceph.conf defines =
, /var/lib/ceph defines )
------------------

that doesn't help, manually stopping the daemon doesn't work either =
(respawning, okay)
but this combination leaves me quite curious

------------------
root@atom01[/0]:~ # ceph health detail
HEALTH_WARN 1 mons down, quorum 0,1,3,4 atom01,atom02,ping,pong
mon.nuke36 (rank 2) addr 192.168.242.36:6789/0 is down (out of quorum)
root@atom01[/0]:~ # service ceph -a stop mon.nuke36
/etc/init.d/ceph: mon.nuke36 not found (/etc/ceph/ceph.conf defines , =
/var/lib/ceph defines )
/etc/init.d/ceph: mon.2 not found (/etc/ceph/ceph.conf defines , =
/var/lib/ceph defines )
root@atom01[/0]:~ # service ceph -a stop mon.rank2
------------------

something seems to be out of sync, at least with the documentation?
any hint how to proceed from here?

TIA

Bernhard


--Apple-Mail=_918F21E6-12F8-4D07-8A7A-059C955E21E2
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQEcBAEBAgAGBQJSJybcAAoJEHt+VBZXpX4EhQMIAI9A/pymXTuWP9p0IACimcrG
VrWuEMbjQRsSV8RwsA+xZSY4veIzmzMl4ntWx/7Tb7IKhx5/3uFw2P6Uiqe4q73e
mF2A7EnwoWFfeJYanIsRC9jFtiFV2a2X3pSwV+WAtDZMRAl+c1zHRaFGzgaiRHuY
StKIhQPSbx2qTuHi2PnBoe3lGBMNKDUBu7Mlccr1r30zGSOw8HYQvtUdnMUSK+yx
yXe8jET7cU6sB1tAi7P3fBf+y2KllRrQe96b6/5Ls8fIp+cOZdt/AVnbuesaFDh/
KR0qiROW0e9M4/br1AuIXoax0b1SrQ1gxorpi8fJ8dP6CroIes0uf1F4CVzL1vo=
=Fc7m
-----END PGP SIGNATURE-----

--Apple-Mail=_918F21E6-12F8-4D07-8A7A-059C955E21E2--
