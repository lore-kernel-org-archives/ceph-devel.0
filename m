From: Ryan Nicholson <Ryan.Nicholson@kcrg.com>
Subject: RE: Rados Performance help needed...
Date: Wed, 31 Oct 2012 22:55:14 +0000
Message-ID: <F5955DC568F9AF4DB00BE0F7E950BE0C3490D07F@BLUPRD0411MB438.namprd04.prod.outlook.com>
References: <F5955DC568F9AF4DB00BE0F7E950BE0C3490D064@BLUPRD0411MB438.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from va3ehsobe004.messaging.microsoft.com ([216.32.180.14]:21121
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759362Ab2JaWzS convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 31 Oct 2012 18:55:18 -0400
Received: from mail64-va3 (localhost [127.0.0.1])	by mail64-va3-R.bigfish.com
 (Postfix) with ESMTP id D866E460190	for <ceph-devel@vger.kernel.org>; Wed, 31
 Oct 2012 22:55:16 +0000 (UTC)
Received: from VA3EHSMHS016.bigfish.com (unknown [10.7.14.252])	by
 mail64-va3.bigfish.com (Postfix) with ESMTP id C57DC3A0076	for
 <ceph-devel@vger.kernel.org>; Wed, 31 Oct 2012 22:55:14 +0000 (UTC)
In-Reply-To: <F5955DC568F9AF4DB00BE0F7E950BE0C3490D064@BLUPRD0411MB438.namprd04.prod.outlook.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ryan Nicholson <Ryan.Nicholson@kcrg.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Correction:

Missed a carriage return when I copy/pasted at first, sorry...

Ryan

-----Original Message-----
=46rom: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Ryan Nicholson
Sent: Wednesday, October 31, 2012 5:50 PM
To: ceph-devel@vger.kernel.org
Subject: Rados Performance help needed...

Guys:
I have some tuning questions. I'm not getting the write speeds I'm expe=
cting, and am open to suggestions.
I using Rados, on Ceph 0.48.0. I have 12 OSD's split up (using crush/ra=
dos pools) into 2 pools this way:
4 OSD Servers
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - Dell 2850's, 12GB ram
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - 64-bit CentOS 6.2
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - 2 SCSI osd's each
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - 1 eSATA osd each
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - Each server is connecte=
d to lan using 2GB/s bond=20
3 Separate Monitor Servers as well
		- Dell 1850's, 8 GB ram
SCSI pool:
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 8 OSD's of 146GB a piece,=
 each made of a pair of Ultra-320 disks in a stripe.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Disks are partitioned wit=
h 20GB at the front for Ceph journal, and the remainder is the OSD part=
ition. Journal is for the OSD on the same disk.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Formatted ext4, mounted (=
rw,noatime,data=3Dwriteback,barrier=3D0,nobh)

Large "data" pool:
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4 OSD's of 3.2TB a piece,=
 each made of an identically configured LaCie Big4 Disk Quadra.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Each LaCie's specs are: 4=
TB of 7200RPM SATA, in a RAID-5 which is handled directly by the local =
hardware, and attached to the server using a 64-bit Sil3124 eSATA card.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Note: The LaCie's do NOT =
support JBOD, believe it or not. you can stripe them tho.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Formatted ext4, mounted (=
rw,noatime,data=3Dwriteback,barrier=3D0,nobh)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Journal for these disks i=
s an entire 146GB SCSI stripe each


Ok, so here's my issue:
As a test, I stopped ceph completely, and at each server, i did a simpl=
e disk/filesystem write/read test. here are those results:
command: (dd if=3D10GB_testFile of /path-to-osd-mount/test.io BS=3D1048=
576)

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SCSI: 10GB file written a=
t 365MB/s to a single SCSI stripe of 2 73GB Ultra-320's.=20
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 same 10GB file read fat 595MB/s.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 eSATA: (same) 10GB file w=
ritten at 275MB/s to a single LaCie and I read that file back at 443MB/=
s.

I understand that real life numbers and dd numbers are hardly ever the =
same.
Now using ceph, I produced 2 identical Rados images called Test20G, and=
 put in both of the pools. I know (leterally by watching the drive acce=
ss lights) that the pools are created to the proper place and writing t=
he desired drives. The images were mounted using the same client, and f=
ormatted ext4. i mounted (rw,noatime,data=3Dwriteback,barrier=3D0,nobh)=
=2E
i did the same dd test, and found the SCSI's to write average 105MB/s, =
and the LaCie's write averaged 25MB/s.
Network Util for each of teh server never crossed 6% on ANY osd server,=
 the sending client never exceeded 27% util.
Now, Help me, I have an entire 140GB journal for the Lacies. I expected=
 them to fare much better than they did??

Any help would be appreciated! Thanks!
Ryan nicholson

Here's the top fo my OSD map: (SCSI is the fast SCSI pool, data is the =
LaCie Pool) pool 0 'data' rep size 2 crush_ruleset 0 object_hash rjenki=
ns pg_num 768 pgp_num 768 last_change 1 owner 0 crash_replay_interval 4=
5 pool 1 'metadata' rep size 2 crush_ruleset 1 object_hash rjenkins pg_=
num 768 pgp_num 768 last_change 1 owner 0 pool 2 'rbd' rep size 2 crush=
_ruleset 2 object_hash rjenkins pg_num 768 pgp_num 768 last_change 1 ow=
ner 0 pool 3 'SCSI' rep size 2 crush_ruleset 3 object_hash rjenkins pg_=
num 1024 pgp_num 1024 last_change 12 owner 0
---------------ceph.conf---------------
; Ceph Cluster SCSI-System Configuration - Ryan Nicholson 10-28-2012 Su=
nPM

[global]
;=A0=A0=A0=A0=A0=A0=A0 auth supported =3D cephx
=A0=A0=A0=A0=A0=A0=A0 log file =3D /ceph/log/ceph-$name.log
=A0=A0=A0=A0=A0=A0=A0 pid file =3D /ceph/lock/ceph-$name.pid
=A0=A0=A0=A0=A0=A0=A0=20
[client]
=A0=A0=A0=A0=A0=A0=A0 rbd cache =3D true

[mon]
=A0=A0=A0=A0=A0=A0=A0 mon data =3D /ceph/mon/$name


[mon.a]
=A0=A0=A0=A0=A0=A0=A0 host =3D ceph-mdc1.storage.broadcast.kcrg
=A0=A0=A0=A0=A0=A0=A0 mon addr =3D 10.9.181.10:6789
;=A0=A0=A0=A0=A0=A0 debug mon =3D 1
[mon.b]
=A0=A0=A0=A0=A0=A0=A0 host =3D ceph-mdc2.storage.broadcast.kcrg
=A0=A0=A0=A0=A0=A0=A0 mon addr =3D 10.9.181.11:6789
;=A0=A0=A0=A0=A0=A0 debug mon =3D 1
[mon.c]
=A0=A0=A0=A0=A0=A0=A0 host =3D ceph-mdc3.storage.broadcast.kcrg
=A0=A0=A0=A0=A0=A0=A0 mon addr =3D 10.9.181.12:6789
;=A0=A0=A0=A0=A0=A0 debug mon =3D 1

[mds]
;=A0=A0=A0=A0=A0=A0 keyring =3D /ceph/security/keyring.$name

[mds.a]
=A0=A0=A0=A0=A0=A0=A0 host =3D ceph-mdc1.storage.broadcast.kcrg ;=A0=A0=
=A0=A0=A0=A0 debug mds =3D 1

[mds.b]
=A0=A0=A0=A0=A0=A0=A0 host =3D ceph-mdc2.storage.broadcast.kcrg ;=A0=A0=
=A0=A0=A0=A0 debug mds =3D 1 [mds.c]
=A0=A0=A0=A0=A0=A0=A0 host =3D ceph-mdc3.storage.broadcast.kcrg ;=A0=A0=
=A0=A0=A0=A0 debug mds =3D 1

[osd]
=A0=A0=A0=A0=A0=A0=A0 osd journal size =3D 0
=A0=A0=A0=A0=A0=A0=A0 osd data =3D /ceph/osd/$name
;=A0=A0=A0=A0=A0=A0 debug osd =3D 1
=A0=A0=A0=A0=A0=A0=A0 journal dio =3D true
=A0=A0=A0=A0=A0=A0=A0 journal aio =3D true
=A0=A0=A0=A0=A0=A0=A0 filestore xattr use omap =3D true

[osd.0]
=A0=A0=A0=A0=A0=A0=A0 host =3D ceph-osd1.storage.broadcast.kcrg
=A0=A0=A0=A0=A0=A0=A0 osd journal =3D /dev/sda1
[osd.1]
=A0=A0=A0=A0=A0=A0=A0 host =3D ceph-osd1.storage.broadcast.kcrg
=A0=A0=A0=A0=A0=A0=A0 osd journal =3D /dev/sdb1
[osd.2]
=A0=A0=A0=A0=A0=A0=A0 host =3D ceph-osd1.storage.broadcast.kcrg
=A0=A0=A0=A0=A0=A0=A0 osd journal =3D /dev/sdc

[osd.3]
=A0=A0=A0=A0=A0=A0=A0 host =3D ceph-osd2.storage.broadcast.kcrg
=A0=A0=A0=A0=A0=A0=A0 osd journal =3D /dev/sda1
[osd.4]
=A0=A0=A0=A0=A0=A0=A0 host =3D ceph-osd2.storage.broadcast.kcrg
=A0=A0=A0=A0=A0=A0=A0 osd journal =3D /dev/sdb1
[osd.5]
=A0=A0=A0=A0=A0=A0=A0 host =3D ceph-osd2.storage.broadcast.kcrg
=A0=A0=A0=A0=A0=A0=A0 osd journal =3D /dev/sdc

[osd.6]
=A0=A0=A0=A0=A0=A0=A0 host =3D ceph-osd3.storage.broadcast.kcrg
=A0=A0=A0=A0=A0=A0=A0 osd journal =3D /dev/sda1
[osd.7]
=A0=A0=A0=A0=A0=A0=A0 host =3D ceph-osd3.storage.broadcast.kcrg
=A0=A0=A0=A0=A0=A0=A0 osd journal =3D /dev/sdb1
[osd.8]
=A0=A0=A0=A0=A0=A0=A0 host =3D ceph-osd3.storage.broadcast.kcrg
=A0=A0=A0=A0=A0=A0=A0 osd journal =3D /dev/sdc

[osd.9]
=A0=A0=A0=A0=A0=A0=A0 host =3D ceph-osd4.storage.broadcast.kcrg
=A0=A0=A0=A0=A0=A0=A0 osd journal =3D /dev/sda1
[osd.10]
=A0=A0=A0=A0=A0=A0=A0 host =3D ceph-osd4.storage.broadcast.kcrg
=A0=A0=A0=A0=A0=A0=A0 osd journal =3D /dev/sdb1
[osd.11]
=A0=A0=A0=A0=A0=A0=A0 host =3D ceph-osd4.storage.broadcast.kcrg
=A0=A0=A0=A0=A0=A0=A0 osd journal =3D /dev/sdc



Ryan Nicholson|Engineer
KCRG-TV9 | Digital Television
=A0319.361.5102
=A0501 Second Ave SE
=A0Cedar Rapids, IA 52401
=A0ryan.nicholson@kcrg.com




--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
