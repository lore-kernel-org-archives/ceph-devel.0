From: Kevan Rehm <krehm@cray.com>
Subject: bluestore bug#15724: bluefs _replay file with link count 0:
Date: Thu, 14 Jul 2016 18:49:26 +0000
Message-ID: <D3AD48E4.B62F9%krehm@cray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from esa2.cray.iphmx.com ([68.232.143.164]:43857 "EHLO
	esa2.cray.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbcGNStb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Jul 2016 14:49:31 -0400
Content-Language: en-US
Content-ID: <DEC9E474F0E71E439ACB82253B8A2D66@namprd11.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel (ceph-devel@vger.kernel.org)" <ceph-devel@vger.kernel.org>

Greetings,

Bug #15724 reports several occurrences of an OSD that will not start du=
e
to the message "bluefs _replay file with link count 0:".  I have also h=
ad
several occurrences of this in the last couple of days, using a ceph bu=
ilt
from master a couple of weeks ago.

I jacked up the bluefs debug tracing and have been working through the
reading of the transaction log by the OSD during startup, and I can see
what appears to be a bad transaction that is causing this, see below.
(Probably also the cause of the segmentation fault that occurred just
before this incident.)

Before I fry any more brain cells, I'd like to know if someone is alrea=
dy
fixing this, or if someone has any advice to offer, like where the prob=
lem
most likely lies.   If not, I'll keep digging.


Here is what we see after the transaction log has been read, the OSD ge=
ts
excited and bails:


2016-07-13 16:03:03.933669 7fb6617c1800 20 bluefs _read got 4096
2016-07-13 16:03:03.933671 7fb6617c1800 10 bluefs _replay 0x5cf000: sto=
p:
uuid 4ef0859e-06e8-51c2-9612-add7269b0100 !=3D super.uuid
7eb30434-317a-4844-b8d1-6f8cb37585d1
2016-07-13 16:03:03.933678 7fb6617c1800 10 bluefs _replay log file size
was 0x5cf000
2016-07-13 16:03:03.933731 7fb6617c1800 -1 bluefs _replay file with lin=
k
count 0: file(ino 113 size 71354938 mtime 2016-07-12 17:05:53.738683 bd=
ev
1 extents=20
[1:904921088+1048576,1:910163968+2097152,1:916455424+2097152,1:93113548=
8+20
97152,1:937426944+2097152,1:943718400+2097152,1:950009856+2097152,1:960=
4956
16+58720256])
2016-07-13 16:03:03.933739 7fb6617c1800 -1 bluefs mount failed to repla=
y
log: (5) Input/output error
2016-07-13 16:03:03.933753 7fb6617c1800 20 bluefs _stop_alloc
2016-07-13 16:03:03.933754 7fb6617c1800 10 bitmapalloc:shutdown instanc=
e
140421450426752
2016-07-13 16:03:03.933924 7fb6617c1800 -1
bluestore(/var/lib/ceph/osd/ceph-20) _open_db failed bluefs mount: (5)
Input/output error


Starting from the front of the log, here are the first references to in=
o
113 in the transaction log:

2016-07-13 16:03:03.900994 7fb6617c1800 20 bluefs _replay 0x562000:
op_file_update  file(ino 113 size 0 mtime 2016-07-12 17:05:48.312770 bd=
ev
1 extents [])
2016-07-13 16:03:03.900996 7fb6617c1800 30 bluefs _get_file ino 113 =3D
0x7fb66aafbb90 (new)
2016-07-13 16:03:03.900997 7fb6617c1800 20 bluefs _replay 0x562000:
op_dir_link  db/000145.log to 113
2016-07-13 16:03:03.900998 7fb6617c1800 30 bluefs _get_file ino 113 =3D
0x7fb66aafbb90
=8A
2016-07-13 16:03:03.901047 7fb6617c1800 20 bluefs _replay 0x56e000:
op_file_update  file(ino 113 size 23 mtime 2016-07-12 17:05:48.314814 b=
dev
1 extents [1:904921088+1048576])
2016-07-13 16:03:03.901048 7fb6617c1800 30 bluefs _get_file ino 113 =3D
0x7fb66aafbb90


Lots of op_file_updates are applied to ino 113 in the log, leading up t=
o
this final one.


2016-07-13 16:03:03.924173 7fb6617c1800 20 bluefs _replay 0x5ab000:
op_file_update  file(ino 113 size 71359362 mtime 2016-07-12
17:05:49.420150 bdev 1 extents
[1:904921088+1048576,1:910163968+2097152,1:916455424+2097152,1:93113548=
8+20
97152,1:937426944+2097152,1:943718400+2097152,1:950009856+2097152,1:960=
4956
16+58720256])
2016-07-13 16:03:03.924176 7fb6617c1800 30 bluefs _get_file ino 113 =3D
0x7fb66aafbb90


Next ino 113's filename is renamed from 000145.log to 000151.log, follo=
wed
by an update, so it must be coming from BlueRocksEnv::ReuseWritableFile=
().


2016-07-13 16:03:03.925181 7fb6617c1800 10 bluefs _replay 0x5b4000:
txn(seq 77743 len 982 crc 98786513)
2016-07-13 16:03:03.925182 7fb6617c1800 20 bluefs _replay 0x5b4000:
op_dir_link  db/000151.log to 113
2016-07-13 16:03:03.925183 7fb6617c1800 30 bluefs _get_file ino 113 =3D
0x7fb66aafbb90
2016-07-13 16:03:03.925184 7fb6617c1800 20 bluefs _replay 0x5b4000:
op_dir_unlink  db/000145.log
2016-07-13 16:03:03.925186 7fb6617c1800 20 bluefs _replay 0x5b4000:
op_file_update  file(ino 113 size 71359362 mtime 2016-07-12
17:05:53.738683 bdev 1 extents
[1:904921088+1048576,1:910163968+2097152,1:916455424+2097152,1:93113548=
8+20
97152,1:937426944+2097152,1:943718400+2097152,1:950009856+2097152,1:960=
4956
16+58720256])
2016-07-13 16:03:03.925197 7fb6617c1800 30 bluefs _get_file ino 113 =3D
0x7fb66aafbb90


In txn 77752, ino 113 and its filename get removed via a
BlueRocksEnv::DeleteFile() call, followed by an update with the origina=
l
allocation.  Bad news.  Don't yet know where the update is coming from.
So now we have an ino 113 with no links, and a series of extents which =
it
doesn't really own.


2016-07-13 16:03:03.929686 7fb6617c1800 20 bluefs _replay 0x5be000:
op_file_remove 113
2016-07-13 16:03:03.929687 7fb6617c1800 20 bluefs _replay 0x5be000:
op_dir_unlink  db/000150.log
=8A
2016-07-13 16:03:03.929689 7fb6617c1800 20 bluefs _replay 0x5be000:
op_file_update  file(ino 113 size 71354938 mtime 2016-07-12
17:05:53.738683 bdev 1 extents
[1:904921088+1048576,1:910163968+2097152,1:916455424+2097152,1:93113548=
8+20
97152,1:937426944+2097152,1:943718400+2097152,1:950009856+2097152,1:960=
4956
16+58720256])
2016-07-13 16:03:03.929693 7fb6617c1800 30 bluefs _get_file ino 113 =3D
0x7fb66aafc880 (new)


The end result is an ino without a link, and an unhappy OSD.


2016-07-13 16:03:03.933669 7fb6617c1800 20 bluefs _read got 4096
2016-07-13 16:03:03.933671 7fb6617c1800 10 bluefs _replay 0x5cf000: sto=
p:
uuid 4ef0859e-06e8-51c2-9612-add7269b0100 !=3D super.uuid
7eb30434-317a-4844-b8d1-6f8cb37585d1
2016-07-13 16:03:03.933678 7fb6617c1800 10 bluefs _replay log file size
was 0x5cf000

2016-07-13 16:03:03.933731 7fb6617c1800 -1 bluefs _replay file with lin=
k
count 0: file(ino 113 size 71354938 mtime 2016-07-12 17:05:53.738683 bd=
ev
1 extents=20
[1:904921088+1048576,1:910163968+2097152,1:916455424+2097152,1:93113548=
8+20
97152,1:937426944+2097152,1:943718400+2097152,1:950009856+2097152,1:960=
4956
16+58720256])



I do have the OSD logs showing the original segfault plus the error
mentioned here, but I had to fix the block device so that I could move =
on.
  I can upload the logs if someone is interested, but they're large.

Thanks, Kevan

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
