From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: Bluestore performance bottleneck REVISITED
Date: Tue, 27 Dec 2016 18:55:50 +0000
Message-ID: <EB02EE10422E4A40A1EE787A4AC27FBE048B75@ULS-OP-MBXIP02.sdcorp.global.sandisk.com>
References: <EB02EE10422E4A40A1EE787A4AC27FBE047516@ULS-OP-MBXIP02.sdcorp.global.sandisk.com>
 <5E3E05AED7F0F044904275810D0CB46504D793@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
 <EB02EE10422E4A40A1EE787A4AC27FBE047880@ULS-OP-MBXIP02.sdcorp.global.sandisk.com>
 <5E3E05AED7F0F044904275810D0CB46504D7B4@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-cys01nam02on0078.outbound.protection.outlook.com ([104.47.37.78]:55008
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750889AbcL0S4A (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 27 Dec 2016 13:56:00 -0500
In-Reply-To: <5E3E05AED7F0F044904275810D0CB46504D7B4@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, Mark Nelson <mnelson@redhat.com>, Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Interesting that the inlined extent tables increases the total metadata wri=
te traffic sufficient to cause the compaction overhead to be about the same=
.

If we reduced the shard values so that a 16K MinAlloc is NOT inlined, that =
should reduce the compaction traffic significantly, that might or might-not=
 improve overall performance.


Allen Samuels
SanDisk |a Western Digital brand
2880 Junction Avenue, San Jose, CA 95134
T: +1 408 801 7030| M: +1 408 780 6416
allen.samuels@SanDisk.com


> -----Original Message-----
> From: Somnath Roy
> Sent: Sunday, December 25, 2016 12:30 PM
> To: Allen Samuels <Allen.Samuels@sandisk.com>; Mark Nelson
> <mnelson@redhat.com>; Sage Weil <sweil@redhat.com>
> Cc: ceph-devel <ceph-devel@vger.kernel.org>
> Subject: RE: Bluestore performance bottleneck REVISITED
>=20
> Yes, all are fitting into inline_bl (no shard) in case of 16K min alloc i=
f I can
> remember and that's why decode_some() overhead is less. Also, 4 times les=
s
> extent and that makes overhead less. I will generate some stats on this a=
nd
> share.
>=20
> -----Original Message-----
> From: Allen Samuels
> Sent: Sunday, December 25, 2016 12:08 PM
> To: Somnath Roy; Mark Nelson; Sage Weil
> Cc: ceph-devel
> Subject: RE: Bluestore performance bottleneck REVISITED
>=20
> Decode_some won't care how many shards there are, it will only care about
> the size of a shard. But if the number of shards is small enough to be in=
lined
> in the oNode that will definitely explain what we're seeing.
>=20
> Do we know what the shard-counts are for 16KMinAlloc?
>=20
>=20
> Allen Samuels
> SanDisk |a Western Digital brand
> 2880 Junction Avenue, San Jose, CA 95134
> T: +1 408 801 7030| M: +1 408 780 6416
> allen.samuels@SanDisk.com
>=20
>=20
> > -----Original Message-----
> > From: Somnath Roy
> > Sent: Sunday, December 25, 2016 10:38 AM
> > To: Allen Samuels <Allen.Samuels@sandisk.com>; Mark Nelson
> > <mnelson@redhat.com>; Sage Weil <sweil@redhat.com>
> > Cc: ceph-devel <ceph-devel@vger.kernel.org>
> > Subject: RE: Bluestore performance bottleneck REVISITED
> >
> > I think one of the reason 16K is doing better is the very less
> > decode_some() overhead in case of 16K because in case of 16K min_alloc
> > there is hardly any shard.
> > Also, what I am seeing (and digging more) that read overhead (onode,
> > shard) during write is now having an impact and it is even more while
> > compaction is on. For 16K, there will be one read (only onode) vs 4K
> > min_alloc where there will be two reads (onode, shard).
> >
> > Thanks & Regards
> > Somnath
> >
> >
> > -----Original Message-----
> > From: Allen Samuels
> > Sent: Saturday, December 24, 2016 11:45 PM
> > To: Mark Nelson; Sage Weil
> > Cc: Somnath Roy; ceph-devel
> > Subject: RE: Bluestore performance bottleneck REVISITED
> >
> > (This is the first time, I've dug into the details of the RocksDB
> > stats, so it's possible I'm misinterpreting)
> >
> > Even more interesting.
> >
> > The 4K and 16K runs both have the same total amount of compaction
> > traffic. I look at the "sum" row and the Read(GB) and Write(GB)
> > columns and I note that they're almost exactly the same for the 4K and =
16K
> runs.
> >
> > If this is correct, then the hypothesis that the 16K Minalloc is
> > faster due to the reduced cost of the compaction because of smaller
> > metadata size is simply false.
> >
> > It is true that the static size of the metadata is much smaller for
> > the 4K run
> > (8.3 GB vs. 2.5GB), but this simply doesn't explain the observed result=
s.
> >
> > When you factor into the equation the higher ingest for the 16K case
> > [ingesting the data and the extra transaction to undo it]  (91GB vs
> > 190GB) with the same amount of compaction (~145GB) traffic, then we
> > need to start thinking about another explanation for the observed data.
> >
> > I'm still digging into the numbers, but I do notice that the # of
> > writes / sync are radically different (4.5 writes/sync vs. 31.2
> > writes/sync), I assume this is effectively the same as the I/O size. I
> > believe that somehow the system is doing a much better job of batching
> > the transactions for 16K vs 4K and what we're really seeing as the
> performance delta between them is related to this.
> >
> > Mark --> Can we look at the Linux iostat data for this, in particular
> > can you look at the average write I/O size? And the # of interrupts /
> > front-end I/O operation?
> >
> >
> > Allen Samuels
> > SanDisk |a Western Digital brand
> > 2880 Junction Avenue, San Jose, CA 95134
> > T: +1 408 801 7030| M: +1 408 780 6416 allen.samuels@SanDisk.com
> >
> >
> > > -----Original Message-----
> > > From: Mark Nelson [mailto:mnelson@redhat.com]
> > > Sent: Friday, December 23, 2016 12:05 PM
> > > To: Allen Samuels <Allen.Samuels@sandisk.com>; Sage Weil
> > > <sweil@redhat.com>
> > > Cc: Somnath Roy <Somnath.Roy@sandisk.com>; ceph-devel <ceph-
> > > devel@vger.kernel.org>
> > > Subject: Re: Bluestore performance bottleneck
> > >
> > >
> > >
> > > On 12/23/2016 01:33 PM, Allen Samuels wrote:
> > > > The two data points you mention (4K / 16K MinAlloc) yield
> > > > interesting
> > > numbers. For 4K, you're seeing 22.5K IOPS at 1300% CPU or 1.7K IOPS
> > > /
> > core.
> > > Yet for 16K you're seeing 25K IOPS at 1000% CPU or 2.5 K IOPS/Core.
> > > Yet, we know that in the main I/O path that the 16K is doing more
> > > work (since it's double-writing the data), but is yielding better
> > > CPU usage overall. We do know that there will be a reduction of
> > > compaction for the 16K case which will save SOME CPU, but I wouldn't
> > > have thought that this would be substantial since the data is all
> > > processed sequentially in rather large blocks (i.e., the CPU cost of
> > > compaction seems
> > to be larger than expected).
> > > >
> > > > Do we know that you're actually capturing a few compaction cycles
> > > > with the
> > > 16K test? If not, that might explain some of the difference.
> > >
> > > I believe so.  Here is a comparison of the 25/50 tests for example.
> > > Interesting that there's so much more data compacted in the 4K
> > > min_alloc tests.
> > >
> > > 4k min_alloc:
> > >
> > > > 2016-12-22 19:33:49.722025 7fb188f21700  3 rocksdb: -------
> > > > DUMPING STATS -------
> > > > 2016-12-22 19:33:49.722029 7fb188f21700  3 rocksdb:
> > > > ** Compaction Stats [default] **
> > > > Level    Files   Size(MB} Score Read(GB}  Rn(GB} Rnp1(GB} Write(GB}
> > > Wnew(GB} Moved(GB} W-Amp Rd(MB/s} Wr(MB/s} Comp(sec}
> Comp(cnt}
> > > Avg(sec} KeyIn KeyDrop
> > > > ------------------------------------------------------------------
> > > > --
> > > > -----------------------
> > > ---------------------------------------------------------------
> > > >   L0      8/0    1440.37   2.0      0.0     0.0      0.0      63.1 =
    63.1       0.0   0.0      0.0
> > > 183.8       352       400    0.880       0      0
> > > >   L1     15/0     881.27   3.4     82.2    61.7     20.5      30.8 =
    10.4       0.0   0.5
> > 128.5
> > > 48.2       655        38   17.235    462M    25M
> > > >   L2     95/0    5538.28   2.2     55.4     9.0     46.4      51.8 =
     5.3       0.5   5.8
> 54.3
> > > 50.7      1045       136    7.683   1238M    33M
> > > >   L3      7/0     458.47   0.0      0.5     0.4      0.1       0.5 =
     0.4       0.0   1.1     59.5
> > > 59.5         9         7    1.259     12M      1
> > > >  Sum    125/0    8318.40   0.0    138.1    71.2     67.0     146.3 =
    79.3       0.5   2.3
> > > 68.6     72.7      2061       581    3.547   1712M    58M
> > > >  Int      0/0       0.00   0.0     66.2    38.5     27.6      65.6 =
    38.0       0.0   1.9     87.5
> > > 86.8       774       257    3.013    556M    39M
> > > > Uptime(secs): 1953.4 total, 1953.4 interval
> > > > Flush(GB): cumulative 63.137, interval 35.154
> > > > AddFile(GB): cumulative 0.000, interval 0.000 AddFile(Total Files):
> > > > cumulative 0, interval 0
> > > > AddFile(L0 Files): cumulative 0, interval 0
> > > > AddFile(Keys): cumulative 0, interval 0 Cumulative compaction:
> > > > 146.26 GB write, 76.67 MB/s write, 138.13 GB read, 72.41 MB/s
> > > > read,
> > > > 2060.5 seconds Interval compaction: 65.64 GB write, 34.41 MB/s
> > > > write, 66.16 GB read, 34.68 MB/s read, 774.4 seconds
> > > > Stalls(count): 11 level0_slowdown, 11
> > > > level0_slowdown_with_compaction,
> > > > 0 level0_numfiles, 0 level0_numfiles_with_compaction, 0 stop for
> > > > pending_compaction_bytes, 0 slowdown for
> > pending_compaction_bytes,
> > > 0
> > > > memtable_compaction, 0 memtable_slowdown, interval 7 total count
> > > >
> > > > ** DB Stats **
> > > > Uptime(secs): 1953.4 total, 603.3 interval Cumulative writes: 18M
> > > > writes, 251M keys, 18M commit groups, 1.0 writes per commit group,
> > > > ingest: 91.83 GB, 48.14 MB/s Cumulative WAL: 18M writes, 4111K
> > > > syncs,
> > > > 4.52 writes per sync, written: 91.83 GB, 48.14 MB/s Cumulative stal=
l:
> > > > 00:01:7.797 H:M:S, 3.5 percent Interval writes: 10M writes, 69M
> > > > keys, 10M commit groups, 1.0 writes per commit group, ingest:
> > > > 48121.62 MB,
> > > > 79.77 MB/s Interval WAL: 10M writes, 2170K syncs, 4.99 writes per
> > > > sync, written: 46.99 MB, 79.77 MB/s Interval stall: 00:00:20.024
> > > > H:M:S, 3.3 percent
> > >
> > >
> > > 16k min_alloc:
> > >
> > > > 2016-12-23 10:20:03.926747 7fef2993d700  3 rocksdb: -------
> > > > DUMPING STATS -------
> > > > 2016-12-23 10:20:03.926754 7fef2993d700  3 rocksdb:
> > > > ** Compaction Stats [default] **
> > > > Level    Files   Size(MB} Score Read(GB}  Rn(GB} Rnp1(GB} Write(GB}
> > > Wnew(GB} Moved(GB} W-Amp Rd(MB/s} Wr(MB/s} Comp(sec}
> Comp(cnt}
> > > Avg(sec} KeyIn KeyDrop
> > > > ------------------------------------------------------------------
> > > > --
> > > > -----------------------
> > > ---------------------------------------------------------------
> > > >   L0      3/0     186.38   0.8      0.0     0.0      0.0      49.4 =
    49.4       0.0   0.0      0.0
> > > 179.0       283       805    0.351       0      0
> > > >   L1     13/0     336.75   1.4     80.5    49.2     31.3      41.4 =
    10.2       0.0   0.8
> > 139.7
> > > 71.9       590       135    4.371    399M    53M
> > > >   L2     33/0    1933.96   0.8     62.4     9.4     53.0      54.5 =
     1.4       0.4   5.8
> 72.0
> > > 62.8       887       145    6.120   1039M    70M
> > > >  Sum     49/0    2457.09   0.0    142.9    58.6     84.3     145.3 =
    61.0       0.4   2.9
> > > 83.1     84.5      1760      1085    1.622   1438M   123M
> > > >  Int      0/0       0.00   0.0     61.6    25.1     36.5      61.5 =
    25.0       0.0   2.9     87.6
> > > 87.4       720       466    1.545    586M    56M
> > > > Uptime(secs): 1951.3 total, 1951.3 interval
> > > > Flush(GB): cumulative 49.411, interval 21.131
> > > > AddFile(GB): cumulative 0.000, interval 0.000 AddFile(Total Files):
> > > > cumulative 0, interval 0
> > > > AddFile(L0 Files): cumulative 0, interval 0
> > > > AddFile(Keys): cumulative 0, interval 0 Cumulative compaction:
> > > > 145.30 GB write, 76.25 MB/s write, 142.90 GB read, 74.99 MB/s
> > > > read,
> > > > 1760.2 seconds Interval compaction: 61.47 GB write, 32.26 MB/s
> > > > write, 61.59 GB read, 32.32 MB/s read, 720.0 seconds
> > > > Stalls(count): 0 level0_slowdown, 0
> > > > level0_slowdown_with_compaction,
> > > > 0 level0_numfiles, 0 level0_numfiles_with_compaction, 0 stop for
> > > > pending_compaction_bytes, 0 slowdown for
> > pending_compaction_bytes,
> > > 0
> > > > memtable_compaction, 0 memtable_slowdown, interval 0 total count
> > > >
> > > > ** DB Stats **
> > > > Uptime(secs): 1951.3 total, 604.4 interval Cumulative writes: 32M
> > > > writes, 260M keys, 32M commit groups, 1.0 writes per commit group,
> > > > ingest: 190.02 GB, 99.72 MB/s Cumulative WAL: 32M writes, 1032K
> > > > syncs,
> > > > 31.20 writes per sync, written: 190.02 GB, 99.72 MB/s Cumulative
> > > > stall: 00:00:0.000 H:M:S, 0.0 percent Interval writes: 14M writes,
> > > > 99M keys, 14M commit groups, 1.0 writes per commit group, ingest:
> > > > 84136.97 MB, 139.20 MB/s Interval WAL: 14M writes, 268K syncs,
> > > > 52.14 writes per sync, written: 82.17 MB, 139.20 MB/s Interval stal=
l:
> > > > 00:00:0.000 H:M:S, 0.0 percent
> > >
> > > Mark
> > >
> > > >
> > > >
> > > > Allen Samuels
> > > > SanDisk |a Western Digital brand
> > > > 2880 Junction Avenue, San Jose, CA 95134
> > > > T: +1 408 801 7030| M: +1 408 780 6416 allen.samuels@SanDisk.com
> > > >
> > > >
> > > >> -----Original Message-----
> > > >> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> > > >> owner@vger.kernel.org] On Behalf Of Mark Nelson
> > > >> Sent: Friday, December 23, 2016 9:09 AM
> > > >> To: Sage Weil <sweil@redhat.com>
> > > >> Cc: Somnath Roy <Somnath.Roy@sandisk.com>; ceph-devel <ceph-
> > > >> devel@vger.kernel.org>
> > > >> Subject: Re: Bluestore performance bottleneck
> > > >>
> > > >>>> Try this?
> > > >>>>     https://github.com/ceph/ceph/pull/12634
> > > >>>
> > > >>> Looks like this is most likely reducing the memory usage and
> > > >>> increasing performance quite a bit with smaller shard target/max
> > > >>> values.  With
> > > >>> 25/50 I'm seeing more like 2.6GB RSS memory usage and around 13K
> > > >>> iops typically with some (likely rocksdb) stalls.  I'll run
> > > >>> through the tests again.
> > > >>>
> > > >>> Mark
> > > >>>
> > > >>
> > > >> Ok, Ran through tests with both 4k and 16k
> > > >> min_alloc/max_alloc/blob
> > > sizes
> > > >> using master+12629+12634:
> > > >>
> > > >>
> > >
> >
> https://drive.google.com/uc?export=3Ddownload&id=3D0B2gTBZrkrnpZQzdRU3B
> > > >> 1SGZUbDQ
> > > >>
> > > >> Performance is up in all tests and memory consumption is down
> > > (especially in
> > > >> the smaller target/max tests).  It looks like 100/200 is probably
> > > >> the current optimal configuration on my test setup.  4K min_alloc
> > > >> tests hover around 22.5K IOPS with ~1300% CPU usage, and 16K
> > > >> min_alloc tests hover around 25K IOPs with ~1000% CPU usage.  I
> > > >> think it will be worth spending some
> > > time
> > > >> looking at locking in the bitmap allocator given the perf traces.
> > > >> Beyond
> > > that,
> > > >> I'm seeing rocksdb show up quite a bit in the top CPU consuming
> > > functions
> > > >> now, especially CRC32.
> > > >>
> > > >> Mark
> > > >>
> > > >>
> > > >> --
> > > >> To unsubscribe from this list: send the line "unsubscribe
> > > >> ceph-devel" in
> > > the
> > > >> body of a message to majordomo@vger.kernel.org More majordomo
> > info
> > > at
> > > >> http://vger.kernel.org/majordomo-info.html
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe
> > > > ceph-devel" in the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > >
