From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: Bluestore performance bottleneck
Date: Thu, 22 Dec 2016 23:10:51 +0000
Message-ID: <EB02EE10422E4A40A1EE787A4AC27FBE0456CC@ULS-OP-MBXIP02.sdcorp.global.sandisk.com>
References: <5E3E05AED7F0F044904275810D0CB46504C290@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
 <alpine.DEB.2.11.1612220018390.10615@piezo.novalocal>
 <5E3E05AED7F0F044904275810D0CB46504C301@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
 <5E3E05AED7F0F044904275810D0CB46504C315@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
 <alpine.DEB.2.11.1612220129050.10615@piezo.novalocal>
 <5E3E05AED7F0F044904275810D0CB46504C355@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
 <62d79c2e-bf7b-9c09-883d-615fedf152b8@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2nam03on0065.outbound.protection.outlook.com ([104.47.42.65]:16176
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756699AbcLVXLA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 22 Dec 2016 18:11:00 -0500
In-Reply-To: <62d79c2e-bf7b-9c09-883d-615fedf152b8@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, Somnath Roy <Somnath.Roy@sandisk.com>, Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Dramatic changes to the RSS usage due to changes in these parameters seems =
completely terrifying to me. Seems like something about the oNode trimming =
logic isn't working correctly.

Allen Samuels
SanDisk |a Western Digital brand
2880 Junction Avenue, San Jose, CA 95134
T: +1 408 801 7030| M: +1 408 780 6416
allen.samuels@SanDisk.com


> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Mark Nelson
> Sent: Thursday, December 22, 2016 2:23 PM
> To: Somnath Roy <Somnath.Roy@sandisk.com>; Sage Weil
> <sweil@redhat.com>
> Cc: ceph-devel <ceph-devel@vger.kernel.org>
> Subject: Re: Bluestore performance bottleneck
>=20
> Hi Somnath,
>=20
> Based on your testing, I went through and did some single OSD tests with
> master (pre-extent patch) with different sharding target/max settings on
> one of our NVMe nodes:
>=20
> https://drive.google.com/uc?export=3Ddownload&id=3D0B2gTBZrkrnpZb2ZWcVZ
> HbzJRVHc
>=20
> What I saw is that for 4k min_alloc/max_alloc/max_blob sizes, decreasing =
the
> sharding target/max helped to a point where it started hurting more than =
it
> helped.  The peak is probably somewhere between 100/200 and 200/400,
> though we may want to error on higher values rather than lower.
>   RSS memory usage of the OSD increased dramatically as the target/max
> sizes shrunk.  CPU usage didn't change dramatically, though was a little =
lower
> at the extremes where performance was lowest.
>=20
> For reference, 16k min_alloc pegs at around 20K IOPS in this test as well=
,
> meaning that I think we may be hitting a common bottleneck holding us to
> 20K write IOPS per OSD.
>=20
> I noticed that as the target/max size shrunk, certain code paths became
> more heavily worked however.  RocksDB generally took about a 2x larger
> percentage of the used CPU, with a lot of it going toward CRC calculation=
s.
> We also spent a lot more time in BlueStore::ExtentMap::init_shards doing
> key appends, and triming the TwoQCache. Given that the IOPS dropped
> precipitously, while overall CPU usage remained high and memory usage
> increased dramatically, there may be some opportunities to tune these are=
as
> of the code.  One example might be to avoid doing string appends in the k=
ey
> encoding by switching to a different data structure.
>=20
> FWIW, I did not notice any resharding during the steady state for any of
> these tests.
>=20
> Mark
>=20
> On 12/21/2016 08:25 PM, Somnath Roy wrote:
> > << How many blobs are in each shard, and how many shards are there?
> > Is there any easy way to find out these other than adding some log ?
> >
> >
> > -----Original Message-----
> > From: Sage Weil [mailto:sweil@redhat.com]
> > Sent: Wednesday, December 21, 2016 5:30 PM
> > To: Somnath Roy
> > Cc: ceph-devel
> > Subject: RE: Bluestore performance bottleneck
> >
> > How many blobs are in each shard, and how many shards are there?
> >
> > If we go this route, I think we'll want a larger threshold for the inli=
ne blobs
> (stored in the onode key) so that "normal" objects without a zillion blob=
s still
> fit in one key...
> >
> > sage
> >
> > On Thu, 22 Dec 2016, Somnath Roy wrote:
> >
> >> Ok, *205 bytes* reduction per IO by removing extents.. Thanks !
> >>
> >> 2016-12-21 20:00:07.701845 7fcff8412700 30 submit_transaction Rocksdb
> transaction:
> >> Put( Prefix =3D M key =3D
> >> 0x00000000000006fc'.0000000009.00000000000000001051' Value size =3D
> >> 182) Put( Prefix =3D M key =3D 0x00000000000006fc'._fastinfo' Value si=
ze
> >> =3D 186) Put( Prefix =3D O key =3D
> >>
> 0x7f8000000000000001b56f21ae217262'd_data.10046b8b4567.0000000000002
> 8
> >> c 6!=3D'0xfffffffffffffffeffffffffffffffff6f0005f000'x' Value size =3D
> >> 45) Put( Prefix =3D O key =3D
> >>
> 0x7f8000000000000001b56f21ae217262'd_data.10046b8b4567.0000000000002
> 8
> >> c 6!=3D'0xfffffffffffffffeffffffffffffffff'o' Value size =3D 1300) Mer=
ge(
> >> Prefix =3D b key =3D 0x0000000c8cd00000 Value size =3D 16) Merge( Pref=
ix =3D
> >> b key =3D 0x0000001067700000 Value size =3D 16)
> >>
> >>
> >>
> >> -----Original Message-----
> >> From: ceph-devel-owner@vger.kernel.org
> >> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Somnath Roy
> >> Sent: Wednesday, December 21, 2016 4:39 PM
> >> To: Sage Weil
> >> Cc: ceph-devel
> >> Subject: RE: Bluestore performance bottleneck
> >>
> >> Yeah, make sense I missed it..I will remove extents and see how much w=
e
> can save.
> >> But, why a 4K length/offset is started touching 2 shards now if shard =
is
> smaller  is still unclear to me ?
> >>
> >> Thanks & Regards
> >> Somnath
> >>
> >> -----Original Message-----
> >> From: Sage Weil [mailto:sweil@redhat.com]
> >> Sent: Wednesday, December 21, 2016 4:21 PM
> >> To: Somnath Roy
> >> Cc: ceph-devel
> >> Subject: RE: Bluestore performance bottleneck
> >>
> >> On Thu, 22 Dec 2016, Somnath Roy wrote:
> >>> Sage,
> >>> By reducing shard size I am able to improve bluestore +rocks
> performance by 80% for 60G image. Will do detailed analysis on bigger
> images.
> >>>
> >>> Here is what I changed to reduce decode_some() overhead. It is now
> looping 5 times instead of default 33.
> >>>
> >>> bluestore_extent_map_shard_max_size =3D 50
> >>> bluestore_extent_map_shard_target_size =3D 45
> >>>
> >>> Fio output :
> >>> -------------
> >>>         Default:
> >>>         ----------
> >>>
> >>>         rbd_iodepth32: (groupid=3D0, jobs=3D5): err=3D 0: pid=3D34420=
: Wed Dec 21
> 17:30:50 2016
> >>>   write: io=3D114208MB, bw=3D63615KB/s, iops=3D15903, runt=3D1838384m=
sec
> >>>     slat (usec): min=3D3, max=3D3878, avg=3D15.63, stdev=3D 8.78
> >>>     clat (usec): min=3D618, max=3D176057, avg=3D20092.56, stdev=3D210=
17.34
> >>>      lat (usec): min=3D642, max=3D176063, avg=3D20108.20, stdev=3D210=
17.29
> >>>     clat percentiles (usec):
> >>>      |  1.00th=3D[ 1416],  5.00th=3D[ 2928], 10.00th=3D[ 4320], 20.00=
th=3D[ 6112],
> >>>      | 30.00th=3D[ 7648], 40.00th=3D[ 9152], 50.00th=3D[10944], 60.00=
th=3D[13760],
> >>>      | 70.00th=3D[18816], 80.00th=3D[32384], 90.00th=3D[55552], 95.00=
th=3D[68096],
> >>>      | 99.00th=3D[87552], 99.50th=3D[94720], 99.90th=3D[121344],
> 99.95th=3D[129536],
> >>>      | 99.99th=3D[142336]
> >>>
> >>>              Small shards:
> >>>               ----------------
> >>>
> >>> rbd_iodepth32: (groupid=3D0, jobs=3D5): err=3D 0: pid=3D34767: Wed De=
c 21
> 18:50:30 2016
> >>>   write: io=3D186917MB, bw=3D110585KB/s, iops=3D27646, runt=3D1730819=
msec
> >>>     slat (usec): min=3D2, max=3D1447, avg=3D14.95, stdev=3D 7.64
> >>>     clat (usec): min=3D531, max=3D541140, avg=3D11547.88, stdev=3D813=
1.72
> >>>      lat (usec): min=3D544, max=3D541156, avg=3D11562.83, stdev=3D813=
1.73
> >>>     clat percentiles (msec):
> >>>      |  1.00th=3D[    3],  5.00th=3D[    4], 10.00th=3D[    5], 20.00=
th=3D[    6],
> >>>      | 30.00th=3D[    7], 40.00th=3D[    9], 50.00th=3D[   10], 60.00=
th=3D[   12],
> >>>      | 70.00th=3D[   14], 80.00th=3D[   17], 90.00th=3D[   22], 95.00=
th=3D[   27],
> >>>      | 99.00th=3D[   37], 99.50th=3D[   40], 99.90th=3D[   51], 99.95=
th=3D[   75],
> >>>      | 99.99th=3D[  208]
> >>>
> >>>
> >>>
> >>> *But* here is the overhead I am seeing which I don't quite understand=
.
> See the per io metadata overhead for onode/shard is with smaller shard is
> ~30% more.
> >>>
> >>> Default:
> >>> ----------
> >>>
> >>> 2016-12-21 17:22:31.693503 7f18aa7c1700 30 submit_transaction Rocksdb
> transaction:
> >>> Put( Prefix =3D M key =3D
> >>> 0x000000000000048a'.0000000009.00000000000000019093' Value size =3D
> >>> 182) Put( Prefix =3D M key =3D 0x000000000000048a'._fastinfo' Value s=
ize
> >>> =3D 186) Put( Prefix =3D O key =3D
> >>>
> 0x7f8000000000000001dc3f23'`!rbd_data.10046b8b4567.00000000000024b1!=3D'
> >>> 0xfffffffffffffffeffffffffffffffff6f0014c000'x' Value size =3D 669)
> >>> Put( Prefix =3D O key =3D
> >>>
> 0x7f8000000000000001dc3f23'`!rbd_data.10046b8b4567.00000000000024b1!=3D'
> >>> 0xfffffffffffffffeffffffffffffffff'o' Value size =3D 462) Merge(
> >>> Prefix =3D b key =3D 0x000000069ae00000 Value size =3D 16) Merge( Pre=
fix =3D
> >>> b key =3D
> >>> 0x0000001330d00000 Value size =3D 16)
> >>>
> >>>
> >>> Smaller shard:
> >>> -----------------
> >>>
> >>> 2016-12-21 18:52:18.564423 7f3e5d167700 30 submit_transaction
> Rocksdb transaction:
> >>> Put( Prefix =3D M key =3D
> >>> 0x0000000000000691'.0000000009.00000000000000057248' Value size =3D
> >>> 182) Put( Prefix =3D M key =3D 0x0000000000000691'._fastinfo' Value s=
ize
> >>> =3D 186) Put( Prefix =3D O key =3D
> >>>
> 0x7f8000000000000001427b9fe9217262'd_data.10046b8b4567.0000000000003
> >>> 48 f!=3D'0xfffffffffffffffeffffffffffffffff6f00195000'x' Value size =
=3D
> >>> 45) Put( Prefix =3D O key =3D
> >>>
> 0x7f8000000000000001427b9fe9217262'd_data.10046b8b4567.0000000000003
> >>> 48 f!=3D'0xfffffffffffffffeffffffffffffffff6f0019a000'x' Value size =
=3D
> >>> 45) Put( Prefix =3D O key =3D
> >>>
> 0x7f8000000000000001427b9fe9217262'd_data.10046b8b4567.0000000000003
> >>> 48 f!=3D'0xfffffffffffffffeffffffffffffffff'o' Value size =3D 1505)
> >>> Merge( Prefix =3D b key =3D 0x00000006b9780000 Value size =3D 16) Mer=
ge(
> >>> Prefix =3D b key =3D 0x0000000c64f00000 Value size =3D 16)
> >>>
> >>>
> >>> *And* lot of times I am seeing 2 shards are written compare to defaul=
t.
> This will be a problem for ZS , may not be for Rocks.
> >>>
> >>> Initially, I thought blobs are spanning, but, it seems not the case. =
See the
> below log snippet , it seems onode itself is bigger now.
> >>>
> >>> 2016-12-21 18:40:27.734044 7f3e43934700 20
> bluestore(/var/lib/ceph/osd/ceph-0)   onode
> #1:d1bc6a86:::rbd_data.10046b8b4567.00000000000036a2:head# is 1505
> (1503 bytes onode + 2 bytes spanning blobs + 0 bytes inline extents)
> >>>
> >>> Any idea what's going on ?
> >>
> >> The onode has a list of the shards.  Since there are more, the onode i=
s
> bigger.  I wasn't really expecting the shard count to be that high.  The
> structure is:
> >>
> >>   struct shard_info {
> >>     uint32_t offset =3D 0;  ///< logical offset for start of shard
> >>     uint32_t bytes =3D 0;   ///< encoded bytes
> >>     uint32_t extents =3D 0; ///< extents
> >>     DENC(shard_info, v, p) {
> >>       denc_varint(v.offset, p);
> >>       denc_varint(v.bytes, p);
> >>       denc_varint(v.extents, p);
> >>     }
> >>     void dump(Formatter *f) const;
> >>   };
> >>   vector<shard_info> extent_map_shards; ///< extent map shards (if
> >> any)
> >>
> >> The offset is the important piece.  The byte and extent counts aren't =
that
> important... they're mostly there so that a future reshard operation can =
be
> more clever (merging or splitting adjacent shards instead of resharding
> everything).  Well, the bytes field is currently used, but extents is not=
 at all.
> We could just drop that field now and add it (or something else) back in =
later
> if/when we need it...
> >>
> >> sage
> >>
> >>
> >>>
> >>> Thanks & Regards
> >>> Somnath
> >>>
> >>>
> >>> -----Original Message-----
> >>> From: Somnath Roy
> >>> Sent: Friday, December 16, 2016 7:23 PM
> >>> To: Sage Weil (sweil@redhat.com)
> >>> Cc: 'ceph-devel'
> >>> Subject: RE: Bluestore performance bottleneck
> >>>
> >>> Sage,
> >>> Some update on this. Without decode_some within fault_range() I am
> able to drive Bluestore + rocksdb close to ~38K iops compare to ~20K iops
> with decode_some. I had to disable data write because I am skipping decod=
e
> but in this device data write is not a bottleneck. I have seen
> enabling/disabling data write is giving similar result. So, in NVME devic=
e if we
> can optimize decode_some() for performance Bluestore performance
> should bump up by ~2X.
> >>> I did some print around decode_some() and it seems it is taking ~60-1=
21
> micro sec to finish depending on bytes to decode.
> >>>
> >>> Thanks & Regards
> >>> Somnath
> >>>
> >>> -----Original Message-----
> >>> From: Somnath Roy
> >>> Sent: Thursday, December 15, 2016 7:30 PM
> >>> To: Sage Weil (sweil@redhat.com)
> >>> Cc: ceph-devel
> >>> Subject: Bluestore performance bottleneck
> >>>
> >>> Sage,
> >>> Today morning I was talking about 2x performance drop for Bluestore
> without data/db writes for 1G vs 60G volumes and it turn out the
> decode_some() is the culprit for that. Presently, I am drilling down that
> function to identify what exactly causing this issue, but, most probably =
it is
> blob decode and le->blob->get_ref() combination. Will confirm that soon. =
If
> we can fix that we should be able to considerably bump up end-to-end pick
> performance with rocks/ZS on faster NVME. Slower devices most likely we
> will not be able to see any benefits other than saving some cpu cost.
> >>>
> >>> Thanks & Regards
> >>> Somnath
> >>>
> >>>
> >>>
> >>> ________________________________
> >>>
> >>> PLEASE NOTE: The information contained in this electronic mail messag=
e
> is intended only for the use of the designated recipient(s) named above. =
If
> the reader of this message is not the intended recipient, you are hereby
> notified that you have received this message in error and that any review=
,
> dissemination, distribution, or copying of this message is strictly prohi=
bited. If
> you have received this communication in error, please notify the sender b=
y
> telephone or e-mail (as shown above) immediately and destroy any and all
> copies of this message in your possession (whether hard copies or
> electronically stored copies).
> >>>
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> >>> in the body of a message to majordomo@vger.kernel.org More
> majordomo
> >>> info at  http://vger.kernel.org/majordomo-info.html
> >>>
> >>>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> >> in the body of a message to majordomo@vger.kernel.org More
> majordomo
> >> info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > in the body of a message to majordomo@vger.kernel.org More
> majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in =
the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
