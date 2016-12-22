From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Bluestore performance bottleneck
Date: Thu, 22 Dec 2016 00:04:49 +0000
Message-ID: <5E3E05AED7F0F044904275810D0CB46504C290@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sn1nam01on0047.outbound.protection.outlook.com ([104.47.32.47]:48448
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1758525AbcLVAE6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 21 Dec 2016 19:04:58 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Sage Weil (sweil@redhat.com)" <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Sage,
By reducing shard size I am able to improve bluestore +rocks performance by=
 80% for 60G image. Will do detailed analysis on bigger images.

Here is what I changed to reduce decode_some() overhead. It is now looping =
5 times instead of default 33.

bluestore_extent_map_shard_max_size =3D 50
bluestore_extent_map_shard_target_size =3D 45

Fio output :
-------------
        Default:
        ----------

        rbd_iodepth32: (groupid=3D0, jobs=3D5): err=3D 0: pid=3D34420: Wed =
Dec 21 17:30:50 2016
  write: io=3D114208MB, bw=3D63615KB/s, iops=3D15903, runt=3D1838384msec
    slat (usec): min=3D3, max=3D3878, avg=3D15.63, stdev=3D 8.78
    clat (usec): min=3D618, max=3D176057, avg=3D20092.56, stdev=3D21017.34
     lat (usec): min=3D642, max=3D176063, avg=3D20108.20, stdev=3D21017.29
    clat percentiles (usec):
     |  1.00th=3D[ 1416],  5.00th=3D[ 2928], 10.00th=3D[ 4320], 20.00th=3D[=
 6112],
     | 30.00th=3D[ 7648], 40.00th=3D[ 9152], 50.00th=3D[10944], 60.00th=3D[=
13760],
     | 70.00th=3D[18816], 80.00th=3D[32384], 90.00th=3D[55552], 95.00th=3D[=
68096],
     | 99.00th=3D[87552], 99.50th=3D[94720], 99.90th=3D[121344], 99.95th=3D=
[129536],
     | 99.99th=3D[142336]

             Small shards:
              ----------------

rbd_iodepth32: (groupid=3D0, jobs=3D5): err=3D 0: pid=3D34767: Wed Dec 21 1=
8:50:30 2016
  write: io=3D186917MB, bw=3D110585KB/s, iops=3D27646, runt=3D1730819msec
    slat (usec): min=3D2, max=3D1447, avg=3D14.95, stdev=3D 7.64
    clat (usec): min=3D531, max=3D541140, avg=3D11547.88, stdev=3D8131.72
     lat (usec): min=3D544, max=3D541156, avg=3D11562.83, stdev=3D8131.73
    clat percentiles (msec):
     |  1.00th=3D[    3],  5.00th=3D[    4], 10.00th=3D[    5], 20.00th=3D[=
    6],
     | 30.00th=3D[    7], 40.00th=3D[    9], 50.00th=3D[   10], 60.00th=3D[=
   12],
     | 70.00th=3D[   14], 80.00th=3D[   17], 90.00th=3D[   22], 95.00th=3D[=
   27],
     | 99.00th=3D[   37], 99.50th=3D[   40], 99.90th=3D[   51], 99.95th=3D[=
   75],
     | 99.99th=3D[  208]



*But* here is the overhead I am seeing which I don't quite understand. See =
the per io metadata overhead for onode/shard is with smaller shard is ~30% =
more.

Default:
----------

2016-12-21 17:22:31.693503 7f18aa7c1700 30 submit_transaction Rocksdb trans=
action:
Put( Prefix =3D M key =3D 0x000000000000048a'.0000000009.000000000000000190=
93' Value size =3D 182)
Put( Prefix =3D M key =3D 0x000000000000048a'._fastinfo' Value size =3D 186=
)
Put( Prefix =3D O key =3D 0x7f8000000000000001dc3f23'`!rbd_data.10046b8b456=
7.00000000000024b1!=3D'0xfffffffffffffffeffffffffffffffff6f0014c000'x' Valu=
e size =3D 669)
Put( Prefix =3D O key =3D 0x7f8000000000000001dc3f23'`!rbd_data.10046b8b456=
7.00000000000024b1!=3D'0xfffffffffffffffeffffffffffffffff'o' Value size =3D=
 462)
Merge( Prefix =3D b key =3D 0x000000069ae00000 Value size =3D 16)
Merge( Prefix =3D b key =3D 0x0000001330d00000 Value size =3D 16)


Smaller shard:
-----------------

2016-12-21 18:52:18.564423 7f3e5d167700 30 submit_transaction Rocksdb trans=
action:
Put( Prefix =3D M key =3D 0x0000000000000691'.0000000009.000000000000000572=
48' Value size =3D 182)
Put( Prefix =3D M key =3D 0x0000000000000691'._fastinfo' Value size =3D 186=
)
Put( Prefix =3D O key =3D 0x7f8000000000000001427b9fe9217262'd_data.10046b8=
b4567.000000000000348f!=3D'0xfffffffffffffffeffffffffffffffff6f00195000'x' =
Value size =3D 45)
Put( Prefix =3D O key =3D 0x7f8000000000000001427b9fe9217262'd_data.10046b8=
b4567.000000000000348f!=3D'0xfffffffffffffffeffffffffffffffff6f0019a000'x' =
Value size =3D 45)
Put( Prefix =3D O key =3D 0x7f8000000000000001427b9fe9217262'd_data.10046b8=
b4567.000000000000348f!=3D'0xfffffffffffffffeffffffffffffffff'o' Value size=
 =3D 1505)
Merge( Prefix =3D b key =3D 0x00000006b9780000 Value size =3D 16)
Merge( Prefix =3D b key =3D 0x0000000c64f00000 Value size =3D 16)


*And* lot of times I am seeing 2 shards are written compare to default. Thi=
s will be a problem for ZS , may not be for Rocks.

Initially, I thought blobs are spanning, but, it seems not the case. See th=
e below log snippet , it seems onode itself is bigger now.

2016-12-21 18:40:27.734044 7f3e43934700 20 bluestore(/var/lib/ceph/osd/ceph=
-0)   onode #1:d1bc6a86:::rbd_data.10046b8b4567.00000000000036a2:head# is 1=
505 (1503 bytes onode + 2 bytes spanning blobs + 0 bytes inline extents)

Any idea what's going on ?

Thanks & Regards
Somnath


-----Original Message-----
From: Somnath Roy
Sent: Friday, December 16, 2016 7:23 PM
To: Sage Weil (sweil@redhat.com)
Cc: 'ceph-devel'
Subject: RE: Bluestore performance bottleneck

Sage,
Some update on this. Without decode_some within fault_range() I am able to =
drive Bluestore + rocksdb close to ~38K iops compare to ~20K iops with deco=
de_some. I had to disable data write because I am skipping decode but in th=
is device data write is not a bottleneck. I have seen enabling/disabling da=
ta write is giving similar result. So, in NVME device if we can optimize de=
code_some() for performance Bluestore performance should bump up by ~2X.
I did some print around decode_some() and it seems it is taking ~60-121 mic=
ro sec to finish depending on bytes to decode.

Thanks & Regards
Somnath

-----Original Message-----
From: Somnath Roy
Sent: Thursday, December 15, 2016 7:30 PM
To: Sage Weil (sweil@redhat.com)
Cc: ceph-devel
Subject: Bluestore performance bottleneck

Sage,
Today morning I was talking about 2x performance drop for Bluestore without=
 data/db writes for 1G vs 60G volumes and it turn out the decode_some() is =
the culprit for that. Presently, I am drilling down that function to identi=
fy what exactly causing this issue, but, most probably it is blob decode an=
d le->blob->get_ref() combination. Will confirm that soon. If we can fix th=
at we should be able to considerably bump up end-to-end pick performance wi=
th rocks/ZS on faster NVME. Slower devices most likely we will not be able =
to see any benefits other than saving some cpu cost.

Thanks & Regards
Somnath



________________________________

PLEASE NOTE: The information contained in this electronic mail message is i=
ntended only for the use of the designated recipient(s) named above. If the=
 reader of this message is not the intended recipient, you are hereby notif=
ied that you have received this message in error and that any review, disse=
mination, distribution, or copying of this message is strictly prohibited. =
If you have received this communication in error, please notify the sender =
by telephone or e-mail (as shown above) immediately and destroy any and all=
 copies of this message in your possession (whether hard copies or electron=
ically stored copies).

