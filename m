From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Bluestore performance bottleneck
Date: Thu, 22 Dec 2016 01:02:15 +0000
Message-ID: <5E3E05AED7F0F044904275810D0CB46504C315@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
References: <5E3E05AED7F0F044904275810D0CB46504C290@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
 <alpine.DEB.2.11.1612220018390.10615@piezo.novalocal>
 <5E3E05AED7F0F044904275810D0CB46504C301@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-cys01nam02on0051.outbound.protection.outlook.com ([104.47.37.51]:62368
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933633AbcLVBC0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 21 Dec 2016 20:02:26 -0500
In-Reply-To: <5E3E05AED7F0F044904275810D0CB46504C301@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Ok, *205 bytes* reduction per IO by removing extents.. Thanks !

2016-12-21 20:00:07.701845 7fcff8412700 30 submit_transaction Rocksdb trans=
action:
Put( Prefix =3D M key =3D 0x00000000000006fc'.0000000009.000000000000000010=
51' Value size =3D 182)
Put( Prefix =3D M key =3D 0x00000000000006fc'._fastinfo' Value size =3D 186=
)
Put( Prefix =3D O key =3D 0x7f8000000000000001b56f21ae217262'd_data.10046b8=
b4567.00000000000028c6!=3D'0xfffffffffffffffeffffffffffffffff6f0005f000'x' =
Value size =3D 45)
Put( Prefix =3D O key =3D 0x7f8000000000000001b56f21ae217262'd_data.10046b8=
b4567.00000000000028c6!=3D'0xfffffffffffffffeffffffffffffffff'o' Value size=
 =3D 1300)
Merge( Prefix =3D b key =3D 0x0000000c8cd00000 Value size =3D 16)
Merge( Prefix =3D b key =3D 0x0000001067700000 Value size =3D 16)



-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel=
.org] On Behalf Of Somnath Roy
Sent: Wednesday, December 21, 2016 4:39 PM
To: Sage Weil
Cc: ceph-devel
Subject: RE: Bluestore performance bottleneck

Yeah, make sense I missed it..I will remove extents and see how much we can=
 save.
But, why a 4K length/offset is started touching 2 shards now if shard is sm=
aller  is still unclear to me ?=20

Thanks & Regards
Somnath

-----Original Message-----
From: Sage Weil [mailto:sweil@redhat.com]
Sent: Wednesday, December 21, 2016 4:21 PM
To: Somnath Roy
Cc: ceph-devel
Subject: RE: Bluestore performance bottleneck

On Thu, 22 Dec 2016, Somnath Roy wrote:
> Sage,
> By reducing shard size I am able to improve bluestore +rocks performance =
by 80% for 60G image. Will do detailed analysis on bigger images.
>=20
> Here is what I changed to reduce decode_some() overhead. It is now loopin=
g 5 times instead of default 33.
>=20
> bluestore_extent_map_shard_max_size =3D 50=20
> bluestore_extent_map_shard_target_size =3D 45
>=20
> Fio output :
> -------------
>         Default:
>         ----------
>=20
>         rbd_iodepth32: (groupid=3D0, jobs=3D5): err=3D 0: pid=3D34420: We=
d Dec 21 17:30:50 2016
>   write: io=3D114208MB, bw=3D63615KB/s, iops=3D15903, runt=3D1838384msec
>     slat (usec): min=3D3, max=3D3878, avg=3D15.63, stdev=3D 8.78
>     clat (usec): min=3D618, max=3D176057, avg=3D20092.56, stdev=3D21017.3=
4
>      lat (usec): min=3D642, max=3D176063, avg=3D20108.20, stdev=3D21017.2=
9
>     clat percentiles (usec):
>      |  1.00th=3D[ 1416],  5.00th=3D[ 2928], 10.00th=3D[ 4320], 20.00th=
=3D[ 6112],
>      | 30.00th=3D[ 7648], 40.00th=3D[ 9152], 50.00th=3D[10944], 60.00th=
=3D[13760],
>      | 70.00th=3D[18816], 80.00th=3D[32384], 90.00th=3D[55552], 95.00th=
=3D[68096],
>      | 99.00th=3D[87552], 99.50th=3D[94720], 99.90th=3D[121344], 99.95th=
=3D[129536],
>      | 99.99th=3D[142336]
>=20
>              Small shards:
>               ----------------
>=20
> rbd_iodepth32: (groupid=3D0, jobs=3D5): err=3D 0: pid=3D34767: Wed Dec 21=
 18:50:30 2016
>   write: io=3D186917MB, bw=3D110585KB/s, iops=3D27646, runt=3D1730819msec
>     slat (usec): min=3D2, max=3D1447, avg=3D14.95, stdev=3D 7.64
>     clat (usec): min=3D531, max=3D541140, avg=3D11547.88, stdev=3D8131.72
>      lat (usec): min=3D544, max=3D541156, avg=3D11562.83, stdev=3D8131.73
>     clat percentiles (msec):
>      |  1.00th=3D[    3],  5.00th=3D[    4], 10.00th=3D[    5], 20.00th=
=3D[    6],
>      | 30.00th=3D[    7], 40.00th=3D[    9], 50.00th=3D[   10], 60.00th=
=3D[   12],
>      | 70.00th=3D[   14], 80.00th=3D[   17], 90.00th=3D[   22], 95.00th=
=3D[   27],
>      | 99.00th=3D[   37], 99.50th=3D[   40], 99.90th=3D[   51], 99.95th=
=3D[   75],
>      | 99.99th=3D[  208]
>=20
>=20
>=20
> *But* here is the overhead I am seeing which I don't quite understand. Se=
e the per io metadata overhead for onode/shard is with smaller shard is ~30=
% more.
>=20
> Default:
> ----------
>=20
> 2016-12-21 17:22:31.693503 7f18aa7c1700 30 submit_transaction Rocksdb tra=
nsaction:
> Put( Prefix =3D M key =3D
> 0x000000000000048a'.0000000009.00000000000000019093' Value size =3D 182)=
=20
> Put( Prefix =3D M key =3D 0x000000000000048a'._fastinfo' Value size =3D 1=
86)=20
> Put( Prefix =3D O key =3D=20
> 0x7f8000000000000001dc3f23'`!rbd_data.10046b8b4567.00000000000024b1!=3D'
> 0xfffffffffffffffeffffffffffffffff6f0014c000'x' Value size =3D 669) Put(=
=20
> Prefix =3D O key =3D=20
> 0x7f8000000000000001dc3f23'`!rbd_data.10046b8b4567.00000000000024b1!=3D'
> 0xfffffffffffffffeffffffffffffffff'o' Value size =3D 462) Merge( Prefix=20
> =3D b key =3D 0x000000069ae00000 Value size =3D 16) Merge( Prefix =3D b k=
ey =3D
> 0x0000001330d00000 Value size =3D 16)
>=20
>=20
> Smaller shard:
> -----------------
>=20
> 2016-12-21 18:52:18.564423 7f3e5d167700 30 submit_transaction Rocksdb tra=
nsaction:
> Put( Prefix =3D M key =3D
> 0x0000000000000691'.0000000009.00000000000000057248' Value size =3D 182)=
=20
> Put( Prefix =3D M key =3D 0x0000000000000691'._fastinfo' Value size =3D 1=
86)=20
> Put( Prefix =3D O key =3D
> 0x7f8000000000000001427b9fe9217262'd_data.10046b8b4567.000000000000348
> f!=3D'0xfffffffffffffffeffffffffffffffff6f00195000'x' Value size =3D 45)=
=20
> Put( Prefix =3D O key =3D
> 0x7f8000000000000001427b9fe9217262'd_data.10046b8b4567.000000000000348
> f!=3D'0xfffffffffffffffeffffffffffffffff6f0019a000'x' Value size =3D 45)=
=20
> Put( Prefix =3D O key =3D
> 0x7f8000000000000001427b9fe9217262'd_data.10046b8b4567.000000000000348
> f!=3D'0xfffffffffffffffeffffffffffffffff'o' Value size =3D 1505) Merge(=20
> Prefix =3D b key =3D 0x00000006b9780000 Value size =3D 16) Merge( Prefix =
=3D b=20
> key =3D 0x0000000c64f00000 Value size =3D 16)
>=20
>=20
> *And* lot of times I am seeing 2 shards are written compare to default. T=
his will be a problem for ZS , may not be for Rocks.
>=20
> Initially, I thought blobs are spanning, but, it seems not the case. See =
the below log snippet , it seems onode itself is bigger now.
>=20
> 2016-12-21 18:40:27.734044 7f3e43934700 20 bluestore(/var/lib/ceph/osd/ce=
ph-0)   onode #1:d1bc6a86:::rbd_data.10046b8b4567.00000000000036a2:head# is=
 1505 (1503 bytes onode + 2 bytes spanning blobs + 0 bytes inline extents)
>=20
> Any idea what's going on ?

The onode has a list of the shards.  Since there are more, the onode is big=
ger.  I wasn't really expecting the shard count to be that high.  The struc=
ture is:

  struct shard_info {
    uint32_t offset =3D 0;  ///< logical offset for start of shard
    uint32_t bytes =3D 0;   ///< encoded bytes
    uint32_t extents =3D 0; ///< extents
    DENC(shard_info, v, p) {
      denc_varint(v.offset, p);
      denc_varint(v.bytes, p);
      denc_varint(v.extents, p);
    }
    void dump(Formatter *f) const;
  };
  vector<shard_info> extent_map_shards; ///< extent map shards (if any)

The offset is the important piece.  The byte and extent counts aren't that =
important... they're mostly there so that a future reshard operation can be=
 more clever (merging or splitting adjacent shards instead of resharding ev=
erything).  Well, the bytes field is currently used, but extents is not at =
all.  We could just drop that field now and add it (or something else) back=
 in later if/when we need it...

sage


>
> Thanks & Regards
> Somnath
>=20
>=20
> -----Original Message-----
> From: Somnath Roy
> Sent: Friday, December 16, 2016 7:23 PM
> To: Sage Weil (sweil@redhat.com)
> Cc: 'ceph-devel'
> Subject: RE: Bluestore performance bottleneck
>=20
> Sage,
> Some update on this. Without decode_some within fault_range() I am able t=
o drive Bluestore + rocksdb close to ~38K iops compare to ~20K iops with de=
code_some. I had to disable data write because I am skipping decode but in =
this device data write is not a bottleneck. I have seen enabling/disabling =
data write is giving similar result. So, in NVME device if we can optimize =
decode_some() for performance Bluestore performance should bump up by ~2X.
> I did some print around decode_some() and it seems it is taking ~60-121 m=
icro sec to finish depending on bytes to decode.
>=20
> Thanks & Regards
> Somnath
>=20
> -----Original Message-----
> From: Somnath Roy
> Sent: Thursday, December 15, 2016 7:30 PM
> To: Sage Weil (sweil@redhat.com)
> Cc: ceph-devel
> Subject: Bluestore performance bottleneck
>=20
> Sage,
> Today morning I was talking about 2x performance drop for Bluestore witho=
ut data/db writes for 1G vs 60G volumes and it turn out the decode_some() i=
s the culprit for that. Presently, I am drilling down that function to iden=
tify what exactly causing this issue, but, most probably it is blob decode =
and le->blob->get_ref() combination. Will confirm that soon. If we can fix =
that we should be able to considerably bump up end-to-end pick performance =
with rocks/ZS on faster NVME. Slower devices most likely we will not be abl=
e to see any benefits other than saving some cpu cost.
>=20
> Thanks & Regards
> Somnath
>=20
>=20
>=20
> ________________________________
>=20
> PLEASE NOTE: The information contained in this electronic mail message is=
 intended only for the use of the designated recipient(s) named above. If t=
he reader of this message is not the intended recipient, you are hereby not=
ified that you have received this message in error and that any review, dis=
semination, distribution, or copying of this message is strictly prohibited=
. If you have received this communication in error, please notify the sende=
r by telephone or e-mail (as shown above) immediately and destroy any and a=
ll copies of this message in your possession (whether hard copies or electr=
onically stored copies).
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in th=
e body of a message to majordomo@vger.kernel.org More majordomo info at  ht=
tp://vger.kernel.org/majordomo-info.html
