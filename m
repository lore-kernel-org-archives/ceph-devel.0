From: Smart Weblications GmbH - Florian Wiessner
	<f.wiessner@smart-weblications.de>
Subject: upgrade from 0.39 to 0.40 failed...
Date: Sat, 21 Jan 2012 14:27:56 +0100
Message-ID: <4F1ABD5C.1000907@smart-weblications.de>
Reply-To: f.wiessner@smart-weblications.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx04.smart-weblications.de ([188.65.144.39]:35905 "EHLO
	mx04.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751484Ab2AUN2V (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Sat, 21 Jan 2012 08:28:21 -0500
Received: from office.smart-weblications.net (office.smart-weblications.net [91.204.168.193])
	by mx04.smart-weblications.de (Postfix) with ESMTPA id F2629278600F
	for <ceph-devel@vger.kernel.org>; Sat, 21 Jan 2012 13:28:18 +0000 (UTC)
Received: from [192.168.201.110] (unknown [192.168.201.110])
	by office.smart-weblications.net (Postfix) with ESMTP id B58EE5B9CFB
	for <ceph-devel@vger.kernel.org>; Sat, 21 Jan 2012 14:28:17 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi List,


i today upgraded from 0.39 to 0.40 and also from linux 3.1.5 to 3.2.1 a=
nd now
have the following problems:

first of all, i have a 4 node ceph cluster running.

after the kernel upgrade, 2 of 4 osds failed starting because of btrfs-=
bugs so i
now only have two osds available ( i set replication level to 3 so the =
data
should be save)

i upgraded to
ceph version 0.40-1-g7ce8b7a (commit:7ce8b7ae3bbad70fe257db00b6fc566f57=
f17132)

my ceph.conf looks like this:

node03:/etc/ceph# cat ceph.conf
[global]
       pid file =3D /var/run/ceph/$name.pid
       debug ms =3D 1
#       auth supported =3D cephx
       osd journal =3D /data/ceph.journal
       osd_journal_size =3D 512
#       filestore journal writeahead =3D true
#       filestore journal parallel =3D true
        mds max =3D 4

[mon]
       mon data =3D /data/ceph/mon
[mon.0]
       host =3D node01
       mon addr =3D 192.168.0.4:6789
[mon.1]
       host =3D node02
       mon addr =3D 192.168.0.5:6789
[mon.2]
       host =3D node03
       mon addr =3D 192.168.0.6:6789
[mon.3]
       host =3D node04
       mon addr =3D 192.168.0.7:6789

[mds]
#       keyring =3D /etc/ceph/keyring.$name
#       mds dir max commit size 32

[mds.0]
       host =3D node01
[mds.1]
       host =3D node02
[mds.2]
       host =3D node03
[mds.3]
       host =3D node04


[osd]
       sudo =3D true
       osd data =3D /data/ceph/osd
#       keyring =3D /etc/ceph/keyring.$name
[osd.0]
       host =3D node01
[osd.1]
       host =3D node02
[osd.2]
       host =3D node03
[osd.3]
       host =3D node04

i did set up ceph without cephx

so now i upgraded to 0.40 and i have this problem:

node03:/etc/ceph# ceph -w
2012-01-21 14:24:16.177441 7f7c45cc0760 -- :/0 messenger.start
2012-01-21 14:24:16.177628 7f7c45cc0760 -- :/11220 --> 192.168.0.5:6789=
/0 --
auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x22f3f60 con 0x22f3ce0
2012-01-21 14:24:16.177926 7f7c45cbf700 -- 192.168.0.6:0/11220 learned =
my addr
192.168.0.6:0/11220
2012-01-21 14:24:19.177703 7f7c42244700 -- 192.168.0.6:0/11220 mark_dow=
n
0x22f3ce0 -- 0x22f3a70
2012-01-21 14:24:19.177798 7f7c42244700 -- 192.168.0.6:0/11220 -->
192.168.0.6:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x22f3f6=
0 con
0x22f51d0
2012-01-21 14:24:22.177921 7f7c42244700 -- 192.168.0.6:0/11220 mark_dow=
n
0x22f51d0 -- 0x22f4f60
2012-01-21 14:24:22.177999 7f7c42244700 -- 192.168.0.6:0/11220 -->
192.168.0.7:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x22f3f6=
0 con
0x22f3ce0
2012-01-21 14:24:25.178187 7f7c42244700 -- 192.168.0.6:0/11220 mark_dow=
n
0x22f3ce0 -- 0x22f3a70
2012-01-21 14:24:25.178268 7f7c42244700 -- 192.168.0.6:0/11220 -->
192.168.0.6:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x22f3f6=
0 con
0x22f4a50
2012-01-21 14:24:28.178358 7f7c42244700 -- 192.168.0.6:0/11220 mark_dow=
n
0x22f4a50 -- 0x22f47e0
2012-01-21 14:24:28.178431 7f7c42244700 -- 192.168.0.6:0/11220 -->
192.168.0.7:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x22f431=
0 con
0x22f41d0
2012-01-21 14:24:31.178511 7f7c42244700 -- 192.168.0.6:0/11220 mark_dow=
n
0x22f41d0 -- 0x22f3f60
2012-01-21 14:24:31.178582 7f7c42244700 -- 192.168.0.6:0/11220 -->
192.168.0.6:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x22f431=
0 con
0x22f4a50
2012-01-21 14:24:34.178661 7f7c42244700 -- 192.168.0.6:0/11220 mark_dow=
n
0x22f4a50 -- 0x22f47e0
2012-01-21 14:24:34.178729 7f7c42244700 -- 192.168.0.6:0/11220 -->
192.168.0.7:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x22f431=
0 con
0x22f41d0
2012-01-21 14:24:37.178863 7f7c42244700 -- 192.168.0.6:0/11220 mark_dow=
n
0x22f41d0 -- 0x22f3f60
2012-01-21 14:24:37.178928 7f7c42244700 -- 192.168.0.6:0/11220 -->
192.168.0.6:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x22f431=
0 con
0x22f4a50
2012-01-21 14:24:40.179067 7f7c42244700 -- 192.168.0.6:0/11220 mark_dow=
n
0x22f4a50 -- 0x22f47e0
2012-01-21 14:24:40.179156 7f7c42244700 -- 192.168.0.6:0/11220 -->
192.168.0.4:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x22f4b9=
0 con
0x22f4320
2012-01-21 14:24:43.179312 7f7c42244700 -- 192.168.0.6:0/11220 mark_dow=
n
0x22f4320 -- 0x22f40b0
2012-01-21 14:24:43.179380 7f7c42244700 -- 192.168.0.6:0/11220 -->
192.168.0.7:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x22f4b9=
0 con
0x22f4a50
2012-01-21 14:24:46.179464 7f7c42244700 -- 192.168.0.6:0/11220 mark_dow=
n
0x22f4a50 -- 0x22f47e0
2012-01-21 14:24:46.179533 7f7c42244700 -- 192.168.0.6:0/11220 -->
192.168.0.6:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x22f4b9=
0 con
0x22f41d0
2012-01-21 14:24:49.179671 7f7c42244700 -- 192.168.0.6:0/11220 mark_dow=
n
0x22f41d0 -- 0x22f3f60
2012-01-21 14:24:49.179746 7f7c42244700 -- 192.168.0.6:0/11220 -->
192.168.0.5:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x22f431=
0 con
0x22f4a50
^C*** Caught signal (Interrupt) **
 in thread 7f7c45cc0760. Shutting down.


node03:/etc/ceph# rbd ls
2012-01-21 14:25:27.876338 7f80bcf9e760 -- :/0 messenger.start
2012-01-21 14:25:27.876499 7f80bcf9e760 -- :/1011679 --> 192.168.0.4:67=
89/0 --
auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0xa3c020 con 0xa3bda0
2012-01-21 14:25:27.876787 7f80bcf9d700 -- 192.168.0.6:0/1011679 learne=
d my addr
192.168.0.6:0/1011679
2012-01-21 14:25:30.876586 7f80b9569700 -- 192.168.0.6:0/1011679 mark_d=
own
0xa3bda0 -- 0xa3bb30
2012-01-21 14:25:30.876675 7f80b9569700 -- 192.168.0.6:0/1011679 -->
192.168.0.6:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0xa3c020=
 con 0xa402c0
2012-01-21 14:25:33.876794 7f80b9569700 -- 192.168.0.6:0/1011679 mark_d=
own
0xa402c0 -- 0xa40050
2012-01-21 14:25:33.876871 7f80b9569700 -- 192.168.0.6:0/1011679 -->
192.168.0.7:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0xa3bc80=
 con 0xa3c9f0
2012-01-21 14:25:36.876987 7f80b9569700 -- 192.168.0.6:0/1011679 mark_d=
own
0xa3c9f0 -- 0xa3c780
2012-01-21 14:25:36.877068 7f80b9569700 -- 192.168.0.6:0/1011679 -->
192.168.0.4:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x7f80b4=
0008d0
con 0xa3c290
2012-01-21 14:25:39.877248 7f80b9569700 -- 192.168.0.6:0/1011679 mark_d=
own
0xa3c290 -- 0xa3c020
2012-01-21 14:25:39.877324 7f80b9569700 -- 192.168.0.6:0/1011679 -->
192.168.0.7:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x7f80b4=
000af0
con 0x7f80b40008b0
2012-01-21 14:25:42.877424 7f80b9569700 -- 192.168.0.6:0/1011679 mark_d=
own
0x7f80b40008b0 -- 0x7f80b4000e00
2012-01-21 14:25:42.877496 7f80b9569700 -- 192.168.0.6:0/1011679 -->
192.168.0.5:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x7f80b4=
001450
con 0x7f80b4001310
2012-01-21 14:25:45.877624 7f80b9569700 -- 192.168.0.6:0/1011679 mark_d=
own
0x7f80b4001310 -- 0x7f80b4000af0
2012-01-21 14:25:45.877706 7f80b9569700 -- 192.168.0.6:0/1011679 -->
192.168.0.7:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x7f80b4=
0010c0
con 0x7f80b40008b0
2012-01-21 14:25:48.877815 7f80b9569700 -- 192.168.0.6:0/1011679 mark_d=
own
0x7f80b40008b0 -- 0x7f80b4001450
2012-01-21 14:25:48.877889 7f80b9569700 -- 192.168.0.6:0/1011679 -->
192.168.0.5:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x7f80b4=
0010c0
con 0x7f80b40012e0
2012-01-21 14:25:51.877988 7f80b9569700 -- 192.168.0.6:0/1011679 mark_d=
own
0x7f80b40012e0 -- 0x7f80b4000d70
2012-01-21 14:25:51.878060 7f80b9569700 -- 192.168.0.6:0/1011679 -->
192.168.0.7:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x7f80b4=
000a90
con 0x7f80b4000950
2012-01-21 14:25:54.878187 7f80b9569700 -- 192.168.0.6:0/1011679 mark_d=
own
0x7f80b4000950 -- 0x7f80b4000fe0
2012-01-21 14:25:54.878260 7f80b9569700 -- 192.168.0.6:0/1011679 -->
192.168.0.6:6789/0 -- auth(proto 0 30 bytes epoch 0) v1 -- ?+0 0x7f80b4=
000a90
con 0x7f80b4000e90
2012-01-21 14:25:57.876601 7f80bcf9e760 monclient(hunting): authenticat=
e timed
out after 30
2012-01-21 14:25:57.876648 7f80bcf9e760 librados: client.admin authenti=
cation
error (110) Connection timed out
2012-01-21 14:25:57.876768 7f80bcf9e760 -- 192.168.0.6:0/1011679 shutdo=
wn complete.
error: couldn't connect to the cluster!

i am now unable to mount ceph directly as fs, nor access my rbd images.

reverting to 0.39 also does not work, the osds then fail starting claim=
ing that
the filestore does not belong to the osd

Please advise!


--=20

Mit freundlichen Gr=FC=DFen,

=46lorian Wiessner

Smart Weblications GmbH
Martinsberger Str. 1
D-95119 Naila

fon.: +49 9282 9638 200
fax.: +49 9282 9638 205
24/7: +49 900 144 000 00 - 0,99 EUR/Min*
http://www.smart-weblications.de

--
Sitz der Gesellschaft: Naila
Gesch=E4ftsf=FChrer: Florian Wiessner
HRB-Nr.: HRB 3840 Amtsgericht Hof
*aus dem dt. Festnetz, ggf. abweichende Preise aus dem Mobilfunknetz
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
