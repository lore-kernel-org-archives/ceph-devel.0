From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Bluestore assert
Date: Fri, 2 Sep 2016 20:18:42 +0000
Message-ID: <BL2PR02MB211595930224CC5D83806B9BF4E50@BL2PR02MB2115.namprd02.prod.outlook.com>
References: <BL2PR02MB2115443F5ACA3459E2CEBFBAF41D0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608231343530.25678@piezo.us.to>
  <CY1PR02MB2123D6119409C1F61BF39A46F4EA0@CY1PR02MB2123.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608242042510.25681@piezo.us.to>
 <CY1PR02MB21235A07222322180C0E2BDFF4EA0@CY1PR02MB2123.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608242132460.25681@piezo.us.to>
    <BL2PR02MB21154C4E291C96D597444649F4E00@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608311318350.19032@piezo.us.to>
  <BL2PR02MB21153A76E39772A143A638EEF4E50@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1609021627100.31624@piezo.us.to>
 <BL2PR02MB2115D290C0F978DB7B2D1DD4F4E50@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1609021749210.31624@piezo.us.to>
 <BL2PR02MB2115DE43126DFD3E07D18684F4E50@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1609021925520.31624@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sn1nam02on0070.outbound.protection.outlook.com ([104.47.36.70]:59777
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752500AbcIBUSp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 2 Sep 2016 16:18:45 -0400
In-Reply-To: <alpine.DEB.2.11.1609021925520.31624@piezo.us.to>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Sage,
I am running with big runway values now (min 100 MB, max 400MB) and will ke=
ep you posted on this.
One point, if I give this big runway values, the allocation will be very fr=
equent (and probably unnecessarily for most of the cases) , no harm with th=
at ?

Thanks & Regards
Somnath

-----Original Message-----
From: Sage Weil [mailto:sweil@redhat.com]=20
Sent: Friday, September 02, 2016 12:27 PM
To: Somnath Roy
Cc: Mark Nelson; ceph-devel
Subject: RE: Bluestore assert

On Fri, 2 Sep 2016, Somnath Roy wrote:
> Sage,
> It is probably the universal compaction that is generating bigger files, =
other than that I don't see the following tuning will be generating large f=
iles.
> I will try some universal compaction tuning related to file size and conf=
irm.
> Yeah, big bluefs_min_log_runway value will probably shield the assert for=
 now , but, I am afraid since we don't have control to the file size , we c=
an't possibly sure about the value we should be giving with bluefs_min_log_=
runway for assert not to hit in future long runs.
> Can't we do like this ?
>=20
> //Basically, checking the length of the log as well if (runway <=20
> g_conf->bluefs_min_log_runway) || (runway < log_writer=20
> ->buffer.length() {  //allocate }

Oh, I see what you mean.  Yeah, I'll add that in--certainly doesn't hurt.

And I think just configuring a long runway won't hurt either (e.g., 100MB).

That's probably enough to be safe, but once we fix the flush thing I mentio=
ned that will make this go away.

s

>=20
> Thanks & Regards
> Somnath
>=20
> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com]
> Sent: Friday, September 02, 2016 10:57 AM
> To: Somnath Roy
> Cc: Mark Nelson; ceph-devel
> Subject: RE: Bluestore assert
>=20
> On Fri, 2 Sep 2016, Somnath Roy wrote:
> > Here is my rocksdb option :
> >=20
> >         bluestore_rocksdb_options =3D "max_write_buffer_number=3D16,min=
_write_buffer_number_to_merge=3D2,recycle_log_file_num=3D16,compaction_thre=
ads=3D32,flusher_threads=3D8,max_background_compactions=3D32,max_background=
_flushes=3D8,max_bytes_for_level_base=3D5368709120,write_buffer_size=3D8388=
6080,level0_file_num_compaction_trigger=3D4,level0_slowdown_writes_trigger=
=3D400,level0_stop_writes_trigger=3D800,stats_dump_period_sec=3D10,compacti=
on_style=3DkCompactionStyleUniversal"
> >=20
> > one discrepancy I can see here on max_bytes_for_level_base , it=20
> > should be same as level 0 size. Initially, I had bigger=20
> > min_write_buffer_number_to_merge and that's how I calculated. Now,=20
> > level 0 size is the following
> >=20
> > write_buffer_size * min_write_buffer_number_to_merge *=20
> > level0_file_num_compaction_trigger =3D 80MB * 2 * 4 =3D ~640MB
> >=20
> > I should adjust max_bytes_for_level_base to the similar value probably.
> >=20
> > Please find the level 10 log here. The log I captured during replay (cr=
ashed again) after it crashed originally because of the same reason.
> >=20
> > https://drive.google.com/file/d/0B7W-S0z_ymMJSnA3R2dyellYZ0U/view?us
> > p=3D
> > sharing
> >=20
> > Thanks for the explanation , I got it now why it is trying to flush=20
> > inode 1.
> >=20
> > But, shouldn't we check the length as well during runway check=20
> > rather than just relying on bluefs_min_log_runway only.
>=20
> That's what this does:
>=20
>   uint64_t runway =3D log_writer->file->fnode.get_allocated() -=20
> log_writer->pos;
>=20
> Anyway, I think I see what's going on.  There are a ton of _fsync and _fl=
ush_range calls that have to flush the fnode, and the fnode is pretty big (=
maybe 5k?) because it has so many extents (your tunables are generating rea=
lly big files).
>=20
> I think this is just a matter of the runway configurable being too small =
for your configuration.  Try bumping bluefs_min_log_runway by 10x.
>=20
> Well, actually, we could improve this a bit.  Right now rocksdb is callin=
g lots of flush on a bit sst, and a final fsync at the end.  Bluefs is logg=
ing the updated fnode every time the flush changes the file size, and then =
only writing it to disk when the final fsync happens.  Instead, it could/sh=
ould put the dirty fnode on a list and only at log flush time flush append =
the latest fnodes to the log and write it out.
>=20
> I'll add it to the trello board.  I think it's not that big a deal..=20
> except when you have really big files.
>=20
> sage
>=20
>=20
>  >
> > Thanks & Regards
> > Somnath
> >=20
> > -----Original Message-----
> > From: Sage Weil [mailto:sweil@redhat.com]
> > Sent: Friday, September 02, 2016 9:35 AM
> > To: Somnath Roy
> > Cc: Mark Nelson; ceph-devel
> > Subject: RE: Bluestore assert
> >=20
> >=20
> >=20
> > On Fri, 2 Sep 2016, Somnath Roy wrote:
> >=20
> > > Sage,
> > > Tried to do some analysis on the inode assert, following looks suspic=
ious.
> > >=20
> > >    -10> 2016-08-31 17:55:56.921075 7faf14fff700 10 bluefs _fsync 0x7f=
af12075140 file(ino 693 size 0x19c2c265 mtime 2016-08-31 17:55:56.919038 bd=
ev 1 extents [1:0x6e500000+100000,1:0x6e700000+100000,1:0x6ea00000+200000,1=
:0x6ed00000+200000,1:0x6f000000+200000,1:0x6f300000+200000,1:0x6f600000+200=
000,1:0x6f900000+200000,1:0x6fc00000+200000,1:0x6ff00000+100000,1:0x7010000=
0+200000,1:0x70400000+200000,1:0x70700000+200000,1:0x70a00000+100000,1:0x70=
c00000+200000,1:0x70f00000+100000,1:0x71100000+200000,1:0x71400000+200000,1=
:0x71700000+200000,1:0x71a00000+100000,1:0x71c00000+100000,1:0x71e00000+100=
000,1:0x72000000+100000,1:0x72200000+200000,1:0x72500000+200000,1:0x7280000=
0+100000,1:0x72a00000+100000,1:0x72c00000+200000,1:0x72f00000+100000,1:0x73=
100000+200000,1:0x73400000+100000,1:0x73600000+200000,1:0x73900000+200000,1=
:0x73c00000+200000,1:0x73f00000+200000,1:0x74300000+200000,1:0x74600000+200=
000,1:0x74900000+200000,1:0x74c00000+200000,1:0x74f00000+100000,1:0x7510000=
0+100000,1:0x7!
 53!
>  00!
> >  000+100000,1:0x75600000+100000,1:0x75800000+100000,1:0x75a00000+200000=
,1:0x75d00000+100000,1:0x75f00000+100000,1:0x76100000+100000,1:0x76400000+2=
00000,1:0x76700000+200000,1:0x76a00000+300000,1:0x76e00000+200000,1:0x77100=
000+100000,1:0x77300000+100000,1:0x77500000+100000,1:0x77700000+300000,1:0x=
77b00000+200000,1:0x77e00000+200000,1:0x78100000+100000,1:0x78300000+200000=
,1:0x78600000+200000,1:0x78900000+100000,1:0x78c00000+100000,1:0x78e00000+1=
00000,1:0x79000000+100000,1:0x79200000+100000,1:0x79400000+200000,1:0x79700=
000+100000,1:0x79900000+200000,1:0x79c00000+200000,1:0x79f00000+100000,1:0x=
7a100000+200000,1:0x7a400000+200000,1:0x7a700000+100000,1:0x7a900000+200000=
,1:0x7ac00000+100000,1:0x7ae00000+100000,1:0x7b000000+100000,1:0x7b200000+2=
00000,1:0x7b500000+100000,1:0x7b800000+200000,1:0x7bb00000+100000,1:0x7bd00=
000+200000,1:0x7c000000+100000,1:0x7c200000+200000,1:0x7c500000+100000,1:0x=
7c700000+100000,1:0x7c900000+200000,1:0x7cc00000+100000,1:0x7ce00000+100000=
,1:0x7d000000+!
 10!
>  00!
> > =20
> > 00,1:0x7d200000+100000,1:0x7d400000+100000,1:0x7d600000+100000,1:0x7
> > d8
> > 00000+10e00000])
> > >     -9> 2016-08-31 17:55:56.921117 7faf14fff700 10 bluefs _flush 0x7f=
af12075140 no dirty data on file(ino 693 size 0x19c2c265 mtime 2016-08-31 1=
7:55:56.919038 bdev 1 extents [1:0x6e500000+100000,1:0x6e700000+100000,1:0x=
6ea00000+200000,1:0x6ed00000+200000,1:0x6f000000+200000,1:0x6f300000+200000=
,1:0x6f600000+200000,1:0x6f900000+200000,1:0x6fc00000+200000,1:0x6ff00000+1=
00000,1:0x70100000+200000,1:0x70400000+200000,1:0x70700000+200000,1:0x70a00=
000+100000,1:0x70c00000+200000,1:0x70f00000+100000,1:0x71100000+200000,1:0x=
71400000+200000,1:0x71700000+200000,1:0x71a00000+100000,1:0x71c00000+100000=
,1:0x71e00000+100000,1:0x72000000+100000,1:0x72200000+200000,1:0x72500000+2=
00000,1:0x72800000+100000,1:0x72a00000+100000,1:0x72c00000+200000,1:0x72f00=
000+100000,1:0x73100000+200000,1:0x73400000+100000,1:0x73600000+200000,1:0x=
73900000+200000,1:0x73c00000+200000,1:0x73f00000+200000,1:0x74300000+200000=
,1:0x74600000+200000,1:0x74900000+200000,1:0x74c00000+200000,1:0x74f00000+1=
00000,1:0x7510!
 00!
>  00!
> >  +100000,1:0x75300000+100000,1:0x75600000+100000,1:0x75800000+100000,1:=
0x75a00000+200000,1:0x75d00000+100000,1:0x75f00000+100000,1:0x76100000+1000=
00,1:0x76400000+200000,1:0x76700000+200000,1:0x76a00000+300000,1:0x76e00000=
+200000,1:0x77100000+100000,1:0x77300000+100000,1:0x77500000+100000,1:0x777=
00000+300000,1:0x77b00000+200000,1:0x77e00000+200000,1:0x78100000+100000,1:=
0x78300000+200000,1:0x78600000+200000,1:0x78900000+100000,1:0x78c00000+1000=
00,1:0x78e00000+100000,1:0x79000000+100000,1:0x79200000+100000,1:0x79400000=
+200000,1:0x79700000+100000,1:0x79900000+200000,1:0x79c00000+200000,1:0x79f=
00000+100000,1:0x7a100000+200000,1:0x7a400000+200000,1:0x7a700000+100000,1:=
0x7a900000+200000,1:0x7ac00000+100000,1:0x7ae00000+100000,1:0x7b000000+1000=
00,1:0x7b200000+200000,1:0x7b500000+100000,1:0x7b800000+200000,1:0x7bb00000=
+100000,1:0x7bd00000+200000,1:0x7c000000+100000,1:0x7c200000+200000,1:0x7c5=
00000+100000,1:0x7c700000+100000,1:0x7c900000+200000,1:0x7cc00000+100000,1:=
0x7ce00000+100!
 00!
>  0,!
> > =20
> > 1:0x7d000000+100000,1:0x7d200000+100000,1:0x7d400000+100000,1:0x7d60
> > 00
> > 00+100000,1:0x7d800000+10e00000])
> > >     -8> 2016-08-31 17:55:56.921137 7faf14fff700 10 bluefs wait_for_ai=
o 0x7faf12075140
> > >     -7> 2016-08-31 17:55:56.931541 7faf14fff700 10 bluefs wait_for_ai=
o 0x7faf12075140 done in 0.010402
> > >     -6> 2016-08-31 17:55:56.931551 7faf14fff700 20 bluefs _fsync file=
 metadata was dirty (31278) on file(ino 693 size 0x19c2c265 mtime 2016-08-3=
1 17:55:56.919038 bdev 1 extents [1:0x6e500000+100000,1:0x6e700000+100000,1=
:0x6ea00000+200000,1:0x6ed00000+200000,1:0x6f000000+200000,1:0x6f300000+200=
000,1:0x6f600000+200000,1:0x6f900000+200000,1:0x6fc00000+200000,1:0x6ff0000=
0+100000,1:0x70100000+200000,1:0x70400000+200000,1:0x70700000+200000,1:0x70=
a00000+100000,1:0x70c00000+200000,1:0x70f00000+100000,1:0x71100000+200000,1=
:0x71400000+200000,1:0x71700000+200000,1:0x71a00000+100000,1:0x71c00000+100=
000,1:0x71e00000+100000,1:0x72000000+100000,1:0x72200000+200000,1:0x7250000=
0+200000,1:0x72800000+100000,1:0x72a00000+100000,1:0x72c00000+200000,1:0x72=
f00000+100000,1:0x73100000+200000,1:0x73400000+100000,1:0x73600000+200000,1=
:0x73900000+200000,1:0x73c00000+200000,1:0x73f00000+200000,1:0x74300000+200=
000,1:0x74600000+200000,1:0x74900000+200000,1:0x74c00000+200000,1:0x74f0000=
0+100000,1:0x7!
 51!
>  00!
> >  000+100000,1:0x75300000+100000,1:0x75600000+100000,1:0x75800000+100000=
,1:0x75a00000+200000,1:0x75d00000+100000,1:0x75f00000+100000,1:0x76100000+1=
00000,1:0x76400000+200000,1:0x76700000+200000,1:0x76a00000+300000,1:0x76e00=
000+200000,1:0x77100000+100000,1:0x77300000+100000,1:0x77500000+100000,1:0x=
77700000+300000,1:0x77b00000+200000,1:0x77e00000+200000,1:0x78100000+100000=
,1:0x78300000+200000,1:0x78600000+200000,1:0x78900000+100000,1:0x78c00000+1=
00000,1:0x78e00000+100000,1:0x79000000+100000,1:0x79200000+100000,1:0x79400=
000+200000,1:0x79700000+100000,1:0x79900000+200000,1:0x79c00000+200000,1:0x=
79f00000+100000,1:0x7a100000+200000,1:0x7a400000+200000,1:0x7a700000+100000=
,1:0x7a900000+200000,1:0x7ac00000+100000,1:0x7ae00000+100000,1:0x7b000000+1=
00000,1:0x7b200000+200000,1:0x7b500000+100000,1:0x7b800000+200000,1:0x7bb00=
000+100000,1:0x7bd00000+200000,1:0x7c000000+100000,1:0x7c200000+200000,1:0x=
7c500000+100000,1:0x7c700000+100000,1:0x7c900000+200000,1:0x7cc00000+100000=
,1:0x7ce00000+!
 10!
>  00!
> > =20
> > 00,1:0x7d000000+100000,1:0x7d200000+100000,1:0x7d400000+100000,1:0x7
> > d6
> > 00000+100000,1:0x7d800000+10e00000]), flushing log
> > >=20
> > > The above looks good, it is about to call _flush_and_sync_log() after=
 this.
> >=20
> > Yes, although this file is huge (0x19c2c265 =3D 432194149 ~ 400MB)... W=
hat rocksdb options did you pass in?  I'm guessing this is a log file, but =
we generally want those smallish (maybe 16MB - 64MB, so that L0 SST generat=
ion isn't too slow).
> >=20
> > >     -5> 2016-08-31 17:55:56.931588 7faf14fff700 10 bluefs _flush_and_=
sync_log txn(seq 31278 len 0x50e146 crc 0x58a6b9ab)
> > >     -4> 2016-08-31 17:55:56.933951 7faf14fff700 10 bluefs _pad_bl pad=
ding with 0xe94 zeros
> > >     -3> 2016-08-31 17:55:56.934079 7faf14fff700 20 bluefs flush_bdev
> > >     -2> 2016-08-31 17:55:56.934257 7faf14fff700 10 bluefs _flush 0x7f=
af2e824140 0xce9000~50f000 to file(ino 1 size 0xce9000 mtime 0.000000 bdev =
0 extents [0:0xba00000+500000,0:0xfd00000+c00000])
> > >     -1> 2016-08-31 17:55:56.934274 7faf14fff700 10 bluefs _flush_rang=
e 0x7faf2e824140 pos 0xce9000 0xce9000~50f000 to file(ino 1 size 0xce9000 m=
time 0.000000 bdev 0 extents [0:0xba00000+500000,0:0xfd00000+c00000])
> > >      0> 2016-08-31 17:55:56.939745 7faf14fff700 -1
> > > os/bluestore/BlueFS.cc: In function 'int=20
> > > BlueFS::_flush_range(BlueFS::FileWriter*, uint64_t, uint64_t)'
> > > thread
> > > 7faf14fff700 time 2016-08-31 17:55:56.934282
> > > os/bluestore/BlueFS.cc: 1390: FAILED assert(h->file->fnode.ino !=3D=20
> > > 1)
> > >=20
> > >  ceph version 11.0.0-1946-g9a5cfe2
> > > (9a5cfe2e8e8c79b976c34e593993d74b58fce885)
> > >  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> > > const*)+0x80) [0x56073c27c7d0]
> > >  2: (BlueFS::_flush_range(BlueFS::FileWriter*, unsigned long,=20
> > > unsigned
> > > long)+0x1d69) [0x56073bf4e109]
> > >  3: (BlueFS::_flush(BlueFS::FileWriter*, bool)+0xa7)=20
> > > [0x56073bf4e2d7]
> > >  4: (BlueFS::_flush_and_sync_log(std::unique_lock<std::mutex>&,
> > > unsigned long, unsigned long)+0x443) [0x56073bf4fe13]
> > >  5: (BlueFS::_fsync(BlueFS::FileWriter*,
> > > std::unique_lock<std::mutex>&)+0x35b) [0x56073bf5140b]
> > >  6: (BlueRocksWritableFile::Sync()+0x62) [0x56073bf68be2]
> > >  7: (rocksdb::WritableFileWriter::SyncInternal(bool)+0x2d1)
> > > [0x56073c0f24b1]
> > >  8: (rocksdb::WritableFileWriter::Sync(bool)+0xf0)=20
> > > [0x56073c0f3960]
> > >  9:=20
> > > (rocksdb::CompactionJob::FinishCompactionOutputFile(rocksdb::Statu
> > > s const&, rocksdb::CompactionJob::SubcompactionState*)+0x4e6)
> > > [0x56073c1354c6]
> > >  10:=20
> > > (rocksdb::CompactionJob::ProcessKeyValueCompaction(rocksdb::Compac
> > > ti
> > > on
> > > Job::SubcompactionState*)+0x14ea) [0x56073c137c8a]
> > >  11: (rocksdb::CompactionJob::Run()+0x479) [0x56073c138c09]
> > >  12: (rocksdb::DBImpl::BackgroundCompaction(bool*,
> > > rocksdb::JobContext*, rocksdb::LogBuffer*, void*)+0x9c0)=20
> > > [0x56073c0275d0]
> > >  13: (rocksdb::DBImpl::BackgroundCallCompaction(void*)+0xbf)
> > > [0x56073c03443f]
> > >  14: (rocksdb::ThreadPool::BGThread(unsigned long)+0x1d9)=20
> > > [0x56073c0eb039]
> > >  15: (()+0x9900d3) [0x56073c0eb0d3]
> > >  16: (()+0x76fa) [0x7faf3d1106fa]
> > >  17: (clone()+0x6d) [0x7faf3af70b5d]
> > >=20
> > >=20
> > > Now, as you can see it is calling _flush() with inode 1 , why ? is th=
is expected ?
> >=20
> > Yes.  The metadata for the log file is dirty (the file size changed), s=
o bluefs is flushing it's journal (ino 1) to update the fnode.
> >=20
> > But this is very concerning:
> >=20
> > >     -2> 2016-08-31 17:55:56.934257 7faf14fff700 10 bluefs _flush
> > > 0x7faf2e824140 0xce9000~50f000 to file(ino 1 size 0xce9000 mtime
> > > 0.000000 bdev 0 extents [0:0xba00000+500000,0:0xfd00000+c00000])
> >=20
> > 0xce9000~50f000 is a ~5 MB write.  Why would we ever write that much to=
 the bluefs metadata journal at once?  That's why it's blowign the runway. =
=20
> > We have ~17MB allocated (0:0xba00000+500000,0:0xfd00000+c00000), we're =
at offset ~13MB, and we're writing ~5MB.
> >=20
> > > Question :
> > > ------------
> > >=20
> > > 1. Why we are using the existing log_write to do a runway check ?
> > >=20
> > > https://github.com/ceph/ceph/blob/master/src/os/bluestore/BlueFS.c
> > > c#
> > > L1
> > > 280
> > >=20
> > > Shouldn't the log_writer needs to be reinitialed with the FileWriter =
rocksdb sent with sync call ?
> >=20
> > It's the bluefs journal writer.. that's the runway we're worried about.
> >=20
> > > 2. The runway check is not considering the request length , so,=20
> > > why it is not expecting to allocate here=20
> > > (https://github.com/ceph/ceph/blob/master/src/os/bluestore/BlueFS.
> > > cc
> > > #L
> > > 1388)
> > >=20
> > > If the snippet is not sufficient, let me know if you want me to uploa=
d the level 10 log or need 20/20 log to proceed further.
> >=20
> > The level 10 log is probably enough...
> >=20
> > Thanks!
> > sage
> >=20
> > >=20
> > > Thanks & Regards
> > > Somnath
> > >=20
> > >=20
> > > -----Original Message-----
> > > From: Somnath Roy
> > > Sent: Thursday, September 01, 2016 3:59 PM
> > > To: 'Sage Weil'
> > > Cc: Mark Nelson; ceph-devel
> > > Subject: RE: Bluestore assert
> > >=20
> > > Sage,
> > > Created the following pull request on rocksdb repo, please take a loo=
k.
> > >=20
> > > https://github.com/facebook/rocksdb/pull/1313
> > >=20
> > > The fix is working fine for me.
> > >=20
> > > Thanks & Regards
> > > Somnath
> > >=20
> > > -----Original Message-----
> > > From: Sage Weil [mailto:sweil@redhat.com]
> > > Sent: Wednesday, August 31, 2016 6:20 AM
> > > To: Somnath Roy
> > > Cc: Mark Nelson; ceph-devel
> > > Subject: RE: Bluestore assert
> > >=20
> > > On Tue, 30 Aug 2016, Somnath Roy wrote:
> > > > Sage,
> > > > I did some debugging on the rocksdb bug., here is my findings.
> > > >=20
> > > > 1. The log file number is added to log_recycle_files and *not* in l=
og_delete_files from the following if loop, which is expected.
> > > >=20
> > > > https://github.com/facebook/rocksdb/blob/56dd03411534d0957a6f698
> > > > f4
> > > > 60
> > > > 60
> > > > 9bf7cea4b63/db/db_impl.cc#L854
> > > >=20
> > > > 2. But, it is there in the candidate list in the following loop.
> > > >=20
> > > > https://github.com/facebook/rocksdb/blob/56dd03411534d0957a6f698
> > > > f4
> > > > 60
> > > > 60
> > > > 9bf7cea4b63/db/db_impl.cc#L1000
> > > >=20
> > > >=20
> > > > 3. This means it is added in full_scan_candidate_files from the=20
> > > > following  from a full scan (?)
> > > >=20
> > > > https://github.com/facebook/rocksdb/blob/56dd03411534d0957a6f698
> > > > f4
> > > > 60
> > > > 60
> > > > 9bf7cea4b63/db/db_impl.cc#L834
> > > >=20
> > > > Added some log entries to verify , need to wait 6 hours :-(
> > > >=20
> > > > 4. Probably, #3 is not unusual , but the check in the following see=
ms not sufficient to keep the file.
> > > >=20
> > > > https://github.com/facebook/rocksdb/blob/56dd03411534d0957a6f698
> > > > f4
> > > > 60
> > > > 60
> > > > 9bf7cea4b63/db/db_impl.cc#L1013
> > > >=20
> > > > Again, added some log to see the state.log_number during that time.=
 BTW, I have seen the following check probably noop as state.prev_log_numbe=
r is always coming 0.
> > > >=20
> > > > (number =3D=3D state.prev_log_number)
> > > >=20
> > > > 5. So, the quick solution I am thinking is to put a check to see if=
 the log is in recycle list and avoid deleting from the above part (?).
> > >=20
> > > That seems reasonable.  I suggest coding this up and submitting a PR =
to github.com/facebook/rocksdb, and ask in the comment if there is a better=
 solution.
> > >=20
> > > Probably the recycle list should be turned into a set so that the che=
ck is O(log n)...
> > >=20
> > > Thanks!
> > > sage
> > >=20
> > >=20
> > > >=20
> > > > Let me know what you think.
> > > >=20
> > > > Thanks & Regards
> > > > Somnath
> > > > -----Original Message-----
> > > > From: Somnath Roy
> > > > Sent: Sunday, August 28, 2016 7:37 AM
> > > > To: 'Sage Weil'
> > > > Cc: 'Mark Nelson'; 'ceph-devel'
> > > > Subject: RE: Bluestore assert
> > > >=20
> > > > Sage,
> > > > Some updates on this.
> > > >=20
> > > > 1. The issue is reproduced with the latest rocksdb master as well.
> > > >=20
> > > > 2. The issue is *not happening* if I run disabling rocksdb log recy=
cling. This proves our root cause is right.
> > > >=20
> > > > 3. Running some more performance tests by disabling log recycling ,=
 but, initial impression is, it is introducing spikes and output is not as =
stable as enabling log recycling.
> > > >=20
> > > > 4. Created a rocksdb issue for this
> > > > (https://github.com/facebook/rocksdb/issues/1303)
> > > >=20
> > > > Thanks & Regards
> > > > Somnath
> > > >=20
> > > >=20
> > > > -----Original Message-----
> > > > From: Somnath Roy
> > > > Sent: Thursday, August 25, 2016 2:35 PM
> > > > To: 'Sage Weil'
> > > > Cc: 'Mark Nelson'; 'ceph-devel'
> > > > Subject: RE: Bluestore assert
> > > >=20
> > > > Sage,
> > > > Hope you are able to download the log I shared via google doc.
> > > > It seems the bug is around this portion.
> > > >=20
> > > > 2016-08-25 00:44:03.348710 7f7c117ff700  4 rocksdb: adding log=20
> > > > 254 to recycle list
> > > >=20
> > > > 2016-08-25 00:44:03.348722 7f7c117ff700  4 rocksdb: adding log=20
> > > > 256 to recycle list
> > > >=20
> > > > 2016-08-25 00:44:03.348725 7f7c117ff700  4 rocksdb: (Original=20
> > > > Log Time
> > > > 2016/08/25-00:44:03.347467) [default] Level-0 commit table #258=20
> > > > started
> > > > 2016-08-25 00:44:03.348727 7f7c117ff700  4 rocksdb: (Original=20
> > > > Log Time
> > > > 2016/08/25-00:44:03.348225) [default] Level-0 commit table #258:=20
> > > > memtable #1 done
> > > > 2016-08-25 00:44:03.348729 7f7c117ff700  4 rocksdb: (Original=20
> > > > Log Time
> > > > 2016/08/25-00:44:03.348227) [default] Level-0 commit table #258:=20
> > > > memtable #2 done
> > > > 2016-08-25 00:44:03.348730 7f7c117ff700  4 rocksdb: (Original=20
> > > > Log Time
> > > > 2016/08/25-00:44:03.348239) EVENT_LOG_v1 {"time_micros":=20
> > > > 1472111043348233, "job": 88, "event": "flush_finished", "lsm_state"=
:=20
> > > > [3, 4, 0, 0, 0, 0, 0], "immutable_memtables": 0}
> > > > 2016-08-25 00:44:03.348735 7f7c117ff700  4 rocksdb: (Original=20
> > > > Log Time
> > > > 2016/08/25-00:44:03.348297) [default] Level summary: base level=20
> > > > 1 max bytes base 5368709120 files[3 4 0 0 0 0 0] max score 0.75
> > > >=20
> > > > 2016-08-25 00:44:03.348751 7f7c117ff700  4 rocksdb: [JOB 88] Try to=
 delete WAL files size 131512372, prev total WAL file size 131834601, numbe=
r of live WAL files 3.
> > > >=20
> > > > 2016-08-25 00:44:03.348761 7f7c117ff700 10 bluefs unlink=20
> > > > db.wal/000256.log
> > > > 2016-08-25 00:44:03.348766 7f7c117ff700 20 bluefs _drop_link had=20
> > > > refs
> > > > 1 on file(ino 19 size 0x3f3ddd9 mtime 2016-08-25 00:41:26.298423=20
> > > > bdev
> > > > 0 extents
> > > > [0:0xc500000+200000,0:0xcb00000+800000,0:0xd700000+700000,0:0xe2
> > > > 00
> > > > 00
> > > > 0+
> > > > 800000,0:0xee00000+800000,0:0xfa00000+800000,0:0x10600000+700000
> > > > ,0
> > > > :0
> > > > x1
> > > > 1100000+700000,0:0x11c00000+800000,0:0x12800000+100000])
> > > > 2016-08-25 00:44:03.348775 7f7c117ff700 20 bluefs _drop_link=20
> > > > destroying file(ino 19 size 0x3f3ddd9 mtime 2016-08-25
> > > > 00:41:26.298423 bdev 0 extents
> > > > [0:0xc500000+200000,0:0xcb00000+800000,0:0xd700000+700000,0:0xe2
> > > > 00
> > > > 00
> > > > 0+
> > > > 800000,0:0xee00000+800000,0:0xfa00000+800000,0:0x10600000+700000
> > > > ,0
> > > > :0
> > > > x1
> > > > 1100000+700000,0:0x11c00000+800000,0:0x12800000+100000])
> > > > 2016-08-25 00:44:03.348794 7f7c117ff700 10 bluefs unlink=20
> > > > db.wal/000254.log
> > > > 2016-08-25 00:44:03.348796 7f7c117ff700 20 bluefs _drop_link had=20
> > > > refs
> > > > 1 on file(ino 18 size 0x3f3d402 mtime 2016-08-25 00:41:26.299110=20
> > > > bdev
> > > > 0 extents
> > > > [0:0x6500000+400000,0:0x6d00000+700000,0:0x7800000+800000,0:0x84
> > > > 00
> > > > 00
> > > > 0+
> > > > 800000,0:0x9000000+800000,0:0x9c00000+700000,0:0xa700000+900000,0:
> > > > 0x
> > > > b4
> > > > 00000+800000,0:0xc000000+500000])
> > > > 2016-08-25 00:44:03.348803 7f7c117ff700 20 bluefs _drop_link=20
> > > > destroying file(ino 18 size 0x3f3d402 mtime 2016-08-25
> > > > 00:41:26.299110 bdev 0 extents
> > > > [0:0x6500000+400000,0:0x6d00000+700000,0:0x7800000+800000,0:0x84
> > > > 00
> > > > 00
> > > > 0+
> > > > 800000,0:0x9000000+800000,0:0x9c00000+700000,0:0xa700000+900000,0:
> > > > 0x
> > > > b4
> > > > 00000+800000,0:0xc000000+500000])
> > > >=20
> > > > So, log 254 is added to the recycle list and at the same time it is=
 added for deletion. It seems there is a race condition in this portion (?)=
.
> > > >=20
> > > > I was going through the rocksdb code and I found the following.
> > > >=20
> > > > 1. DBImpl::FindObsoleteFiles is the one that is responsible for pop=
ulating log_recycle_files and log_delete_files. It is also deleting entries=
 from alive_log_files_. But, this is always under mutex_ lock.
> > > >=20
> > > > 2. Log is deleted from DBImpl::DeleteObsoleteFileImpl which is *not=
* under lock , but iterating over log_delete_files. This is fishy but it sh=
ouldn't be the reason for same log number end up in two list.
> > > >=20
> > > > 3. I saw all the places but the following  place alive_log_files_ (=
within DBImpl::WriteImpl)  is accessed without lock.
> > > >=20
> > > > 4625       alive_log_files_.back().AddSize(log_entry.size());  =20
> > > >=20
> > > > Can it be reintroducing the same log number (254) , I am not sure.
> > > >=20
> > > > Summary, it seems a rocksb bug and making recycle_log_file_num =3D =
0 should *bypass* that. I need to check the performance impact for this tho=
ugh.
> > > >=20
> > > > Should I post this to rocksdb community or any other place from whe=
re I can get response from rocksdb folks ?
> > > >=20
> > > > Thanks & Regards
> > > > Somnath
> > > >=20
> > > >=20
> > > > -----Original Message-----
> > > > From: Somnath Roy
> > > > Sent: Wednesday, August 24, 2016 2:52 PM
> > > > To: 'Sage Weil'
> > > > Cc: Mark Nelson; ceph-devel
> > > > Subject: RE: Bluestore assert
> > > >=20
> > > > Sage,
> > > > Thanks for looking , glad that we figured out something :-)..
> > > > So, you want me to reproduce this with only debug_bluefs =3D 20/20 =
? Don't need bluestore log ?
> > > > Hope my root partition doesn't get full , this crash happened=20
> > > > after
> > > > 6 hours :-) ,
> > > >=20
> > > > Thanks & Regards
> > > > Somnath
> > > >=20
> > > > -----Original Message-----
> > > > From: Sage Weil [mailto:sweil@redhat.com]
> > > > Sent: Wednesday, August 24, 2016 2:34 PM
> > > > To: Somnath Roy
> > > > Cc: Mark Nelson; ceph-devel
> > > > Subject: RE: Bluestore assert
> > > >=20
> > > > On Wed, 24 Aug 2016, Somnath Roy wrote:
> > > > > Sage, It is there in the following github link I posted=20
> > > > > earlier..You can see 3 logs there..
> > > > >=20
> > > > > https://github.com/somnathr/ceph/commit/b69811eb2b87f25cf017b3
> > > > > 9c
> > > > > 68
> > > > > 7d
> > > > > 88
> > > > > a1b28fcc39
> > > >=20
> > > > Ah sorry, got it.
> > > >=20
> > > > And looking at the crash and code the weird error you're getting ma=
kes perfect sense: it's coming from the ReuseWritableFile() function (which=
 gets and error on rename and returns that).  It shouldn't ever fail, so th=
ere is either a bug in the bluefs code or the rocksdb recycling code.
> > > >=20
> > > > I think we need a full bluefs log leading up to the crash so we can=
 find out what happened to the file that is missing...
> > > >=20
> > > > sage
> > > >=20
> > > >=20
> > > >=20
> > > >  >
> > > > > Thanks & Regards
> > > > > Somnath
> > > > >=20
> > > > >=20
> > > > > -----Original Message-----
> > > > > From: Sage Weil [mailto:sweil@redhat.com]
> > > > > Sent: Wednesday, August 24, 2016 1:43 PM
> > > > > To: Somnath Roy
> > > > > Cc: Mark Nelson; ceph-devel
> > > > > Subject: RE: Bluestore assert
> > > > >=20
> > > > > On Wed, 24 Aug 2016, Somnath Roy wrote:
> > > > > > Sage,
> > > > > > I got the db assert log from submit_transaction in the followin=
g location.
> > > > > >=20
> > > > > > https://github.com/somnathr/ceph/commit/b69811eb2b87f25cf017
> > > > > > b3
> > > > > > 9c
> > > > > > 68
> > > > > > 7d
> > > > > > 88
> > > > > > a1b28fcc39
> > > > > >=20
> > > > > > This is the log with level 1/20 and with my hook of printing ro=
cksdb::writebatch transaction. I have uploaded 3 osd logs and a common patt=
ern before crash is the following.
> > > > > >=20
> > > > > >    -34> 2016-08-24 02:37:22.074321 7ff151fff700  4 rocksdb:=20
> > > > > > reusing log 266 from recycle list
> > > > > >=20
> > > > > >    -33> 2016-08-24 02:37:22.074332 7ff151fff700 10 bluefs renam=
e db.wal/000266.log -> db.wal/000271.log
> > > > > >    -32> 2016-08-24 02:37:22.074338 7ff151fff700 20 bluefs renam=
e dir db.wal (0x7ff18bdfdec0) file 000266.log not found
> > > > > >    -31> 2016-08-24 02:37:22.074341 7ff151fff700  4 rocksdb: [de=
fault] New memtable created with log file: #271. Immutable memtables: 0.
> > > > > >=20
> > > > > > It is trying to rename the wal file it seems and old file is no=
t found. You can see the transaction printed in the log along with error co=
de like this.
> > > > >=20
> > > > > How much of the log do you have? Can you post what you have somew=
here?
> > > > >=20
> > > > > Thanks!
> > > > > sage
> > > > >=20
> > > > >=20
> > > > > >=20
> > > > > >    -30> 2016-08-24 02:37:22.074486 7ff151fff700 -1 rocksdb:=20
> > > > > > submit_transaction error: NotFound:  code =3D 1=20
> > > > > > rocksdb::WriteBatch =3D Put( Prefix =3D M key =3D
> > > > > > 0x0000000000001483'.0000000087.00000000000000035303')
> > > > > > Put( Prefix =3D M key =3D 0x0000000000001483'._info') Put(=20
> > > > > > Prefix =3D O key =3D
> > > > > > '--'0x800000000000000137863de5'.!=3Drbd_data.105b6b8b4567.0000
> > > > > > 00
> > > > > > 00
> > > > > > 00
> > > > > > 89
> > > > > > ac
> > > > > > e7!'0xfffffffffffffffeffffffffffffffff)
> > > > > > Delete( Prefix =3D B key =3D 0x000004e73ae72000) Put( Prefix =
=3D B=20
> > > > > > key =3D
> > > > > > 0x000004e73af72000) Merge( Prefix =3D T key =3D
> > > > > > 'bluestore_statfs')
> > > > > >=20
> > > > > > Hope my decoding of the key is proper, I have reused pretty_bin=
ary_string() of Bluestore after removing 1st 2 bytes of the key which is pr=
efix and a '0'.
> > > > > >=20
> > > > > > Any suggestion on the next step of root causing this db assert =
if log rename is not enough hint ?
> > > > > >=20
> > > > > > BTW, I ran this time with bluefs_compact_log_sync =3D true and =
without commenting the inode number asserts. I didn't hit those asserts as =
well as no corruption  so far. Seems like bug of async compaction. Will try=
 to reproduce with verbose log that one later.
> > > > > >=20
> > > > > > Thanks & Regards
> > > > > > Somnath
> > > > > >=20
> > > > > > -----Original Message-----
> > > > > > From: Somnath Roy
> > > > > > Sent: Tuesday, August 23, 2016 7:46 AM
> > > > > > To: 'Sage Weil'
> > > > > > Cc: Mark Nelson; ceph-devel
> > > > > > Subject: RE: Bluestore assert
> > > > > >=20
> > > > > > I was running my tests for 2 hours and it happened within that =
time.
> > > > > > I will try to reproduce with 1/20.
> > > > > >=20
> > > > > > Thanks & Regards
> > > > > > Somnath
> > > > > >=20
> > > > > > -----Original Message-----
> > > > > > From: Sage Weil [mailto:sweil@redhat.com]
> > > > > > Sent: Tuesday, August 23, 2016 6:46 AM
> > > > > > To: Somnath Roy
> > > > > > Cc: Mark Nelson; ceph-devel
> > > > > > Subject: RE: Bluestore assert
> > > > > >=20
> > > > > > On Mon, 22 Aug 2016, Somnath Roy wrote:
> > > > > > > Sage,
> > > > > > > I think there are some bug introduced recently in the=20
> > > > > > > BlueFS and I am getting the corruption like this which I was =
not facing earlier.
> > > > > >=20
> > > > > > My guess is the async bluefs compaction.  You can set 'bluefs c=
ompact log sync =3D true' to disable it.
> > > > > >=20
> > > > > > Any idea how long do you have to run to reproduce?  I'd love to=
 see a bluefs log leading up to it.  If it eats too much disk space, you co=
uld do debug bluefs =3D 1/20 so that it only dumps recent history on crash.
> > > > > >=20
> > > > > > Thanks!
> > > > > > sage
> > > > > >=20
> > > > > > >=20
> > > > > > >    -5> 2016-08-22 15:55:21.248558 7fb68f7ff700  4 rocksdb: EV=
ENT_LOG_v1 {"time_micros": 1471906521248538, "job": 3, "event": "compaction=
_started", "files_L0": [2115, 2102, 2087, 2069, 2046], "files_L1": [], "fil=
es_L2": [], "files_L3": [], "files_L4": [], "files_L5": [], "files_L6": [19=
98, 2007, 2013, 2019, 2026, 2032, 2039, 2043, 2052, 2060], "score": 1.5, "i=
nput_data_size": 1648188401}
> > > > > > >     -4> 2016-08-22 15:55:27.209944 7fb6ba94d8c0  0 <cls> cls/=
hello/cls_hello.cc:305: loading cls_hello
> > > > > > >     -3> 2016-08-22 15:55:27.213612 7fb6ba94d8c0  0 <cls> cls/=
cephfs/cls_cephfs.cc:202: loading cephfs_size_scan
> > > > > > >     -2> 2016-08-22 15:55:27.213627 7fb6ba94d8c0  0 _get_class=
 not permitted to load kvs
> > > > > > >     -1> 2016-08-22 15:55:27.214620 7fb6ba94d8c0 -1 osd.0 0 fa=
iled to load OSD map for epoch 321, got 0 bytes
> > > > > > >      0> 2016-08-22 15:55:27.216111 7fb6ba94d8c0 -1 osd/OSD.h:=
=20
> > > > > > > In function 'OSDMapRef OSDService::get_map(epoch_t)'=20
> > > > > > > thread
> > > > > > > 7fb6ba94d8c0 time 2016-08-22 15:55:27.214638
> > > > > > > osd/OSD.h: 999: FAILED assert(ret)
> > > > > > >=20
> > > > > > >  ceph version 11.0.0-1688-g6f48ee6
> > > > > > > (6f48ee6bc5c85f44d7ca4c984f9bef1339c2bea4)
> > > > > > >  1: (ceph::__ceph_assert_fail(char const*, char const*,=20
> > > > > > > int, char
> > > > > > > const*)+0x80) [0x5617f2a99e80]
> > > > > > >  2: (OSDService::get_map(unsigned int)+0x5d)=20
> > > > > > > [0x5617f2395fdd]
> > > > > > >  3: (OSD::init()+0x1f7e) [0x5617f233d3ce]
> > > > > > >  4: (main()+0x2fe0) [0x5617f229d1f0]
> > > > > > >  5: (__libc_start_main()+0xf0) [0x7fb6b7196830]
> > > > > > >  6: (_start()+0x29) [0x5617f22eb909]
> > > > > > >=20
> > > > > > > OSDs are not coming up (after a restart) and eventually I had=
 to recreate the cluster.
> > > > > > >=20
> > > > > > > Thanks & Regards
> > > > > > > Somnath
> > > > > > >=20
> > > > > > > -----Original Message-----
> > > > > > > From: Somnath Roy
> > > > > > > Sent: Monday, August 22, 2016 3:01 PM
> > > > > > > To: 'Sage Weil'
> > > > > > > Cc: Mark Nelson; ceph-devel
> > > > > > > Subject: RE: Bluestore assert
> > > > > > >=20
> > > > > > > "compaction_style=3DkCompactionStyleUniversal"  in the bluest=
ore_rocksdb_options .
> > > > > > > Here is the option I am using..
> > > > > > >=20
> > > > > > >         bluestore_rocksdb_options =3D "max_write_buffer_numbe=
r=3D16,min_write_buffer_number_to_merge=3D2,recycle_log_file_num=3D16,compa=
ction_threads=3D32,flusher_threads=3D8,max_background_compactions=3D32,max_=
background_flushes=3D8,max_bytes_for_level_base=3D5368709120,write_buffer_s=
ize=3D83886080,level0_file_num_compaction_trigger=3D4,level0_slowdown_write=
s_trigger=3D400,level0_stop_writes_trigger=3D800,stats_dump_period_sec=3D10=
,compaction_style=3DkCompactionStyleUniversal"
> > > > > > >=20
> > > > > > > Here is another one after 4 hours of 4K RW :-)...Sorry to bom=
bard you with all these , I am adding more log for the next time if I hit i=
t..
> > > > > > >=20
> > > > > > >=20
> > > > > > >      0> 2016-08-22 17:37:24.730817 7f8e7afff700 -1
> > > > > > > os/bluestore/BlueFS.cc: In function 'int=20
> > > > > > > BlueFS::_read_random(BlueFS::FileReader*, uint64_t, size_t, c=
har*)'
> > > > > > > thread 7f8e7afff700 time 2016-08-22 17:37:24.722706
> > > > > > > os/bluestore/BlueFS.cc: 845: FAILED assert(r =3D=3D 0)
> > > > > > >=20
> > > > > > >  ceph version 11.0.0-1688-g3fcc89c
> > > > > > > (3fcc89c7ab4c92e6c4564e29f4e1a663db36acc0)
> > > > > > >  1: (ceph::__ceph_assert_fail(char const*, char const*,=20
> > > > > > > int, char
> > > > > > > const*)+0x80) [0x5581ed453cb0]
> > > > > > >  2: (BlueFS::_read_random(BlueFS::FileReader*, unsigned=20
> > > > > > > long, unsigned long, char*)+0x836) [0x5581ed11c1b6]
> > > > > > >  3: (BlueRocksRandomAccessFile::Read(unsigned long,=20
> > > > > > > unsigned long, rocksdb::Slice*, char*) const+0x20)=20
> > > > > > > [0x5581ed13f840]
> > > > > > >  4: (rocksdb::RandomAccessFileReader::Read(unsigned long,=20
> > > > > > > unsigned long, rocksdb::Slice*, char*) const+0x83f)=20
> > > > > > > [0x5581ed2c6f4f]
> > > > > > >  5:=20
> > > > > > > (rocksdb::ReadBlockContents(rocksdb::RandomAccessFileReade
> > > > > > > r* , rocksdb::Footer const&, rocksdb::ReadOptions const&,=20
> > > > > > > rocksdb::BlockHandle const&, rocksdb::BlockContents*,=20
> > > > > > > rocksdb::Env*, bool, rocksdb::Slice const&,=20
> > > > > > > rocksdb::PersistentCacheOptions const&,
> > > > > > > rocksdb::Logger*)+0x358) [0x5581ed291c18]
> > > > > > >  6: (()+0x94fd54) [0x5581ed282d54]
> > > > > > >  7:=20
> > > > > > > (rocksdb::BlockBasedTable::NewDataBlockIterator(rocksdb::B
> > > > > > > lo ck Ba se dT ab le::Rep*, rocksdb::ReadOptions const&,=20
> > > > > > > rocksdb::Slice const&,
> > > > > > > rocksdb::BlockIter*)+0x60c) [0x5581ed284b3c]
> > > > > > >  8: (rocksdb::BlockBasedTable::Get(rocksdb::ReadOptions
> > > > > > > const&, rocksdb::Slice const&, rocksdb::GetContext*,
> > > > > > > bool)+0x508) [0x5581ed28ba68]
> > > > > > >  9: (rocksdb::TableCache::Get(rocksdb::ReadOptions const&,=20
> > > > > > > rocksdb::InternalKeyComparator const&,=20
> > > > > > > rocksdb::FileDescriptor const&, rocksdb::Slice const&,=20
> > > > > > > rocksdb::GetContext*, rocksdb::HistogramImpl*, bool,
> > > > > > > int)+0x158) [0x5581ed252118]
> > > > > > >  10: (rocksdb::Version::Get(rocksdb::ReadOptions const&,=20
> > > > > > > rocksdb::LookupKey const&,=20
> > > > > > > std::__cxx11::basic_string<char, std::char_traits<char>,=20
> > > > > > > std::allocator<char> >*, rocksdb::Status*,=20
> > > > > > > rocksdb::MergeContext*, bool*, bool*, unsigned
> > > > > > > long*)+0x4f8) [0x5581ed25c458]
> > > > > > >  11: (rocksdb::DBImpl::GetImpl(rocksdb::ReadOptions=20
> > > > > > > const&, rocksdb::ColumnFamilyHandle*, rocksdb::Slice=20
> > > > > > > const&, std::__cxx11::basic_string<char,=20
> > > > > > > std::char_traits<char>, std::allocator<char> >*,=20
> > > > > > > bool*)+0x5fa) [0x5581ed1f3f7a]
> > > > > > >  12: (rocksdb::DBImpl::Get(rocksdb::ReadOptions const&,=20
> > > > > > > rocksdb::ColumnFamilyHandle*, rocksdb::Slice const&,=20
> > > > > > > std::__cxx11::basic_string<char, std::char_traits<char>,=20
> > > > > > > std::allocator<char> >*)+0x22) [0x5581ed1f4182]
> > > > > > >  13: (RocksDBStore::get(std::__cxx11::basic_string<char,
> > > > > > > std::char_traits<char>, std::allocator<char> > const&,=20
> > > > > > > std::__cxx11::basic_string<char, std::char_traits<char>,=20
> > > > > > > std::allocator<char> > const&, ceph::buffer::list*)+0x157)=20
> > > > > > > [0x5581ed1d21d7]
> > > > > > >  14: (BlueStore::Collection::get_onode(ghobject_t const&,
> > > > > > > bool)+0x55b) [0x5581ed02802b]
> > > > > > >  15:=20
> > > > > > > (BlueStore::_txc_add_transaction(BlueStore::TransContext*,
> > > > > > > ObjectStore::Transaction*)+0x1e49) [0x5581ed0318a9]
> > > > > > >  16:=20
> > > > > > > (BlueStore::queue_transactions(ObjectStore::Sequencer*,
> > > > > > > std::vector<ObjectStore::Transaction,
> > > > > > > std::allocator<ObjectStore::Transaction> >&,=20
> > > > > > > std::shared_ptr<TrackedOp>, ThreadPool::TPHandle*)+0x362)=20
> > > > > > > [0x5581ed032bc2]
> > > > > > >  17:=20
> > > > > > > (ReplicatedPG::queue_transactions(std::vector<ObjectStore:
> > > > > > > :T ra ns ac ti on ,=20
> > > > > > > std::allocator<ObjectStore::Transaction>
> > > > > > > >&,
> > > > > > > std::shared_ptr<OpRequest>)+0x81) [0x5581ecea5e51]
> > > > > > >  18:=20
> > > > > > > (ReplicatedBackend::sub_op_modify(std::shared_ptr<OpReques
> > > > > > > t>
> > > > > > > )+
> > > > > > > 0x
> > > > > > > d3
> > > > > > > 9)
> > > > > > > [0x5581ecef89e9]
> > > > > > >  19:=20
> > > > > > > (ReplicatedBackend::handle_message(std::shared_ptr<OpReque
> > > > > > > st
> > > > > > > >)
> > > > > > > +0
> > > > > > > x2
> > > > > > > fb
> > > > > > > )
> > > > > > > [0x5581ecefeb4b]
> > > > > > >  20:=20
> > > > > > > (ReplicatedPG::do_request(std::shared_ptr<OpRequest>&,
> > > > > > > ThreadPool::TPHandle&)+0xbd) [0x5581ece4c63d]
> > > > > > >  21: (OSD::dequeue_op(boost::intrusive_ptr<PG>,
> > > > > > > std::shared_ptr<OpRequest>, ThreadPool::TPHandle&)+0x409)=20
> > > > > > > [0x5581eccdd2e9]
> > > > > > >  22:=20
> > > > > > > (PGQueueable::RunVis::operator()(std::shared_ptr<OpRequest
> > > > > > > >
> > > > > > > const&)+0x52) [0x5581eccdd542]
> > > > > > >  23: (OSD::ShardedOpWQ::_process(unsigned int,
> > > > > > > ceph::heartbeat_handle_d*)+0x73f) [0x5581eccfd30f]
> > > > > > >  24: (ShardedThreadPool::shardedthreadpool_worker(unsigned
> > > > > > > int)+0x89f) [0x5581ed440b2f]
> > > > > > >  25: (ShardedThreadPool::WorkThreadSharded::entry()+0x10)
> > > > > > > [0x5581ed4441f0]
> > > > > > >  26: (Thread::entry_wrapper()+0x75) [0x5581ed4335c5]
> > > > > > >  27: (()+0x76fa) [0x7f8ed9e4e6fa]
> > > > > > >  28: (clone()+0x6d) [0x7f8ed7caeb5d]
> > > > > > >  NOTE: a copy of the executable, or `objdump -rdS <executable=
>` is needed to interpret this.
> > > > > > >=20
> > > > > > >=20
> > > > > > > Thanks & Regards
> > > > > > > Somnath
> > > > > > >=20
> > > > > > > -----Original Message-----
> > > > > > > From: Sage Weil [mailto:sweil@redhat.com]
> > > > > > > Sent: Monday, August 22, 2016 2:57 PM
> > > > > > > To: Somnath Roy
> > > > > > > Cc: Mark Nelson; ceph-devel
> > > > > > > Subject: RE: Bluestore assert
> > > > > > >=20
> > > > > > > On Mon, 22 Aug 2016, Somnath Roy wrote:
> > > > > > > > FYI, I was running rocksdb by enabling universal style=20
> > > > > > > > compaction during this time.
> > > > > > >=20
> > > > > > > How are you selecting universal compaction?
> > > > > > >=20
> > > > > > > sage
> > > > > > > PLEASE NOTE: The information contained in this electronic mai=
l message is intended only for the use of the designated recipient(s) named=
 above. If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that any=
 review, dissemination, distribution, or copying of this message is strictl=
y prohibited. If you have received this communication in error, please noti=
fy the sender by telephone or e-mail (as shown above) immediately and destr=
oy any and all copies of this message in your possession (whether hard copi=
es or electronically stored copies).
> > > > > > > --
> > > > > > > To unsubscribe from this list: send the line "unsubscribe cep=
h-devel"=20
> > > > > > > in the body of a message to majordomo@vger.kernel.org More=20
> > > > > > > majordomo info at=20
> > > > > > > http://vger.kernel.org/majordomo-info.html
> > > > > > >=20
> > > > > > >=20
> > > > > > --
> > > > > > To unsubscribe from this list: send the line "unsubscribe ceph-=
devel"=20
> > > > > > in the body of a message to majordomo@vger.kernel.org More=20
> > > > > > majordomo info at =20
> > > > > > http://vger.kernel.org/majordomo-info.html
> > > > > >=20
> > > > > >=20
> > > > > --
> > > > > To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel"=20
> > > > > in the body of a message to majordomo@vger.kernel.org More=20
> > > > > majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > >=20
> > > > >=20
> > > >=20
> > > >=20
> > >=20
> > >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"=20
> > in the body of a message to majordomo@vger.kernel.org More majordomo=20
> > info at  http://vger.kernel.org/majordomo-info.html
> >=20
> >=20
>=20
>=20
