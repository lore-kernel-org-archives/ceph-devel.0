From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Bluestore tuning
Date: Thu, 28 Jul 2016 19:05:17 +0000
Message-ID: <BL2PR02MB211544AAF7B65509EB7684D4F4000@BL2PR02MB2115.namprd02.prod.outlook.com>
References: <BL2PR02MB21154CABD62BAD59D1E8CD5FF40F0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <4D529B90-D7F5-4651-91B1-879F480D932B@Teradata.com>
 <BL2PR02MB21155CC9B2F21BE7B6ED1567F4000@BL2PR02MB2115.namprd02.prod.outlook.com>
 <D3BF0C2C.1135C%evgeniy.firsov@sandisk.com>
 <BLUPR0201MB15246365F78D92D45BBF66C5E8000@BLUPR0201MB1524.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-dm3nam03on0057.outbound.protection.outlook.com ([104.47.41.57]:34860
	"EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754969AbcG1TFY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jul 2016 15:05:24 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>, Evgeniy Firsov <Evgeniy.Firsov@sandisk.com>, "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>
Cc: "Mark Nelson (mnelson@redhat.com)" <mnelson@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

My bad , Allen/EF correctly pointed out that we have onode cache as wel=
l (along with buffer cache) within TwoQ cache which is based on number =
of onodes.
But, EF,  the cache is not per collection it is per shard and it is has=
hed into collection, still it is bad and since I am running with high n=
umber of shards , this is what I am seeing may be..Will verify..

Thanks & Regards
Somnath
-----Original Message-----
=46rom: Somnath Roy
Sent: Thursday, July 28, 2016 8:17 AM
To: Allen Samuels; Evgeniy Firsov; Kamble, Nitin A
Cc: Mark Nelson (mnelson@redhat.com); ceph-devel@vger.kernel.org
Subject: RE: Bluestore tuning

I don't think the cache is based on count, it is based on size and numb=
er of shards you are running with.
If you see in my ceph.conf , I have limited cache size to 100MB (bluest=
ore_buffer_cache_size =3D 104857600) and I have 25 shards. So, each OSD=
 will be using 2.5GB of memory as cache at max and I have 8 OSDs runnin=
g , so, total OSD RSS for cache could be ~20GB. Anything above that wil=
l be trimmed. This is what I am seeing in read path and after limiting =
this in write path also I am seeing less growth. But, this is a small l=
eak that is still happening in the write path it seems (unless we are n=
ot doing a cache->trim() somewhere in the path).

Thanks & Regards
Somnath

-----Original Message-----
=46rom: Allen Samuels
Sent: Thursday, July 28, 2016 7:11 AM
To: Evgeniy Firsov; Somnath Roy; Kamble, Nitin A
Cc: Mark Nelson (mnelson@redhat.com); ceph-devel@vger.kernel.org
Subject: RE: Bluestore tuning

If the oNode cache is based on oNode count, then we might want to rethi=
nk the accounting as the oNode size is likely to be highly variable mea=
ning that the memory consumption of the cache will be highly variable t=
oo. This means that users will have to set the cache for the worst-case=
 oNode size, meaning that most of the time the actual oNode cache will =
be much smaller than desired -- for the resources (DRAM) that's involve=
d.

Allen Samuels
SanDisk |a Western Digital brand
2880 Junction Avenue, Milpitas, CA 95134
T: +1 408 801 7030| M: +1 408 780 6416
allen.samuels@SanDisk.com

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Evgeniy Firsov
> Sent: Thursday, July 28, 2016 1:35 AM
> To: Somnath Roy <Somnath.Roy@sandisk.com>; Kamble, Nitin A
> <Nitin.Kamble@Teradata.com>
> Cc: Mark Nelson (mnelson@redhat.com) <mnelson@redhat.com>; ceph-
> devel@vger.kernel.org
> Subject: Re: Bluestore tuning
>
> Somnath,
>
> In my opinion, =B3memory leak=B2 may be just onode cache size grows.
> By default its 16K entries per PG (8 by default), onode size is ~38K
> for 4M RBD object, so its 5.1G by default.
> Likely you use much more Pgs.
> Disabling checksums, reducing RBD object size will reduce the cache s=
ize.
>
> On 7/27/16, 10:26 PM, "ceph-devel-owner@vger.kernel.org on behalf of
> Somnath Roy" <ceph-devel-owner@vger.kernel.org on behalf of
> Somnath.Roy@sandisk.com> wrote:
>
> >My ceph version is 11.0.0-811-g278ea12, it is ~3-4 days old master.
> >Regarding stability , it is getting there , no more easy crashes see=
n
> >:-) I am getting a memory leak though in the write path and after 1
> >hour of continuous run (4K RW) memory is started swapping for me..I
> >am trying to nail it down..
> >
> >Thanks & Regards
> >Somnath
> >
> >
> >-----Original Message-----
> >From: Kamble, Nitin A [mailto:Nitin.Kamble@Teradata.com]
> >Sent: Wednesday, July 27, 2016 10:19 PM
> >To: Somnath Roy
> >Cc: Mark Nelson (mnelson@redhat.com); ceph-devel@vger.kernel.org
> >Subject: Re: Bluestore tuning
> >
> >Hi Somnath,
> >  Thanks for sharing this information. And great to see bluestore
> >with improved stability and performance. Which version of ceph were
> >you running in this environment, latest master?
> >Also it would be good to know the level of stability of the environm=
ent.
> >Did ceph cluster broke after collection of this data?
> >
> >Thanks,
> >Nitin
> >
> >> On Jul 27, 2016, at 8:40 AM, Somnath Roy <Somnath.Roy@sandisk.com>
> >>wrote:
> >>
> >> As discussed in performance meeting, I am sharing the latest
> >>Bluestore tuning findings that is giving me better and most
> >>importantly stable result in my environment.
> >>
> >> Setup :
> >> -------
> >>
> >> 2 OSD nodes with 8 OSDs (on 8 TB SSD) each.
> >> Single 4TB image (with exclusive lock disabled) from single client
> >>running 10 fio jobs and each job is with 128 QD.
> >> Replication =3D 2.
> >> Fio rbd ran for 30 min.
> >>
> >> Ceph.conf
> >> ------------
> >>        osd_op_num_threads_per_shard =3D 2
> >>        osd_op_num_shards =3D 25
> >>
> >>        bluestore_rocksdb_options =3D
> >>"max_write_buffer_number=3D16,min_write_buffer_number_to_merge=3D2
> ,recycle
> >>_lo
> >>g_file_num=3D16,compaction_threads=3D32,flusher_threads=3D8,max_bac=
kgro
> und_c
> >>omp
> >>actions=3D32,max_background_flushes=3D8,max_bytes_for_level_base=3D=
5368
> 70912
> >>0,w
> >>rite_buffer_size=3D83886080,level0_file_num_compaction_trigger=3D4,=
level
> >>0
> _
> >>slo wdown_writes_trigger=3D400,level0_stop_writes_trigger=3D800"
> >>
> >>        rocksdb_cache_size =3D 4294967296
> >>        bluestore_csum =3D false
> >>        bluestore_csum_type =3D none
> >>        bluestore_bluefs_buffered_io =3D false
> >>        bluestore_max_ops =3D 30000
> >>        bluestore_max_bytes =3D 629145600
> >>        bluestore_buffer_cache_size =3D 104857600
> >>        bluestore_block_wal_size =3D 0
> >>
> >> [osd.0]
> >>       host =3D emsnode12
> >>       devs =3D /dev/sdb1
> >>       #osd_journal =3D /dev/sdb1
> >>       bluestore_block_db_path =3D /dev/sdb2
> >>       #bluestore_block_wal_path =3D /dev/nvme0n1p1
> >>       bluestore_block_wal_path =3D /dev/sdb3
> >>       bluestore_block_path =3D /dev/sdb4
> >>
> >> I have separate partition for block/db/wal..
> >>
> >> Result:
> >> --------
> >> No preconditioning of rbd images , started writing 4K RW from the
> >>beginning.
> >>
> >> Jobs: 10 (f=3D10): [w(10)] [100.0% done] [0KB/150.3MB/0KB /s]
> >>[0/38.5K/0  iops] [eta 00m:00s]
> >> rbd_iodepth32: (groupid=3D0, jobs=3D10): err=3D 0: pid=3D883598: F=
ri Jul 22
> >> 19:43:41 2016
> >>  write: io=3D282082MB, bw=3D160473KB/s, iops=3D40118, runt=3D18000=
07msec
> >>    slat (usec): min=3D25, max=3D2578, avg=3D51.73, stdev=3D15.99
> >>    clat (usec): min=3D585, max=3D2096.7K, avg=3D3913.59, stdev=3D9=
871.73
> >>     lat (usec): min=3D806, max=3D2096.7K, avg=3D3965.32, stdev=3D9=
871.71
> >>    clat percentiles (usec):
> >>     |  1.00th=3D[ 1208],  5.00th=3D[ 1480], 10.00th=3D[ 1672], 20.=
00th=3D[
> >>1992],
> >>     | 30.00th=3D[ 2288], 40.00th=3D[ 2608], 50.00th=3D[ 2992], 60.=
00th=3D[
> >>3440],
> >>     | 70.00th=3D[ 4048], 80.00th=3D[ 4960], 90.00th=3D[ 6624], 95.=
00th=3D[
> >>8384],
> >>     | 99.00th=3D[15680], 99.50th=3D[25984], 99.90th=3D[55552],
> >>99.95th=3D[64256],
> >>     | 99.99th=3D[87552]
> >>    bw (KB  /s): min=3D    7, max=3D33864, per=3D10.08%, avg=3D1618=
3.08,
> >>stdev=3D1401.82
> >>    lat (usec) : 750=3D0.01%, 1000=3D0.10%
> >>    lat (msec) : 2=3D20.39%, 4=3D48.81%, 10=3D27.70%, 20=3D2.30%, 5=
0=3D0.55%
> >>    lat (msec) : 100=3D0.14%, 250=3D0.01%, 2000=3D0.01%, >=3D2000=3D=
0.01%
> >>  cpu          : usr=3D20.18%, sys=3D3.67%, ctx=3D96626924, majf=3D=
0, minf=3D166692
> >>  IO depths    : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D27.0%, 16=3D73.0=
%, 32=3D0.0%,
> >>>=3D64=3D0.0%
> >>     submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.=
0%, 64=3D0.0%,
> >>>=3D64=3D0.0%
> >>     complete  : 0=3D0.0%, 4=3D99.9%, 8=3D0.1%, 16=3D0.1%, 32=3D0.0=
%, 64=3D0.0%,
> >>>=3D64=3D0.0%
> >>     issued    : total=3Dr=3D0/w=3D72213031/d=3D0, short=3Dr=3D0/w=3D=
0/d=3D0
> >>     latency   : target=3D0, window=3D0, percentile=3D100.00%, dept=
h=3D16
> >>
> >> *Significantly better latency/throughput than similar setup filest=
ore*.
> >>
> >>
> >> This is based on my experiment on all SSD , HDD case will be diffe=
rent.
> >> Tuning also depends on your cpu complex/memory, I am running with
> >>48 core (HT enabled) dual socket Xeon on each node with 64GB of mem=
ory..
> >>
> >> Thanks & Regards
> >> Somnath
> >>
> >> -----Original Message-----
> >> From: Somnath Roy
> >> Sent: Monday, July 11, 2016 8:04 AM
> >> To: Mark Nelson (mnelson@redhat.com)
> >> Cc: 'ceph-devel@vger.kernel.org'
> >> Subject: Rocksdb tuning on Bluestore
> >>
> >> Mark,
> >> With the following tuning it seems rocksdb is performing better in
> >>my environment. Basically, doing aggressive compaction to reduce th=
e
> >>write stalls.
> >>
> >> bluestore_rocksdb_options =3D
> >>"max_write_buffer_number=3D16,min_write_buffer_number_to_merge=3D1
> 6,recycl
> >>e_l
> >>og_file_num=3D16,compaction_threads=3D32,flusher_threads=3D4,max_ba=
ckgr
> ound_
> >>com
> >>pactions=3D32,max_background_flushes=3D8,max_bytes_for_level_base=3D=
536
> 87091
> >>20,
> >>write_buffer_size=3D83886080,level0_file_num_compaction_trigger=3D4=
,leve
> >>l
> 0
> >>_sl owdown_writes_trigger=3D400,level0_stop_writes_trigger=3D800"
> >>
> >>
> >> BTW, I am not able to run BlueStore more than 2 hour at a stretch
> >>due to memory issues. It is filling up my system memory (2 node of
> >>64 G memory , running 8 OSDS on each) fast.
> >> The following operation I did and it started swapping.
> >>
> >> 1. Created a 4TB image and did 1M sequential preconditioning (took
> >> ~1
> >> hour)
> >>
> >> 2. Followed by two 30 min 4k RW with QD 128 (numjob =3D 10) and in
> >>the 2nd run memory started swapping.
> >>
> >> Let me know how this rocksdb option works for you.
> >>
> >> Thanks & Regards
> >> Somnath
> >>
> >> PLEASE NOTE: The information contained in this electronic mail
> >>message is intended only for the use of the designated recipient(s)
> >>named
> above.
> >>If the reader of this message is not the intended recipient, you ar=
e
> >>hereby notified that you have received this message in error and
> >>that any review, dissemination, distribution, or copying of this
> >>message is strictly prohibited. If you have received this
> >>communication in error, please notify the sender by telephone or
> >>e-mail (as shown above) immediately and destroy any and all copies
> >>of this message in your possession (whether hard copies or electron=
ically stored copies).
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el"
> >> in the body of a message to majordomo@vger.kernel.org More
> majordomo
> >>info at  http://vger.kernel.org/majordomo-info.html
> >
> >--
> >To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"
> >in the body of a message to majordomo@vger.kernel.org More majordomo
> >info at  http://vger.kernel.org/majordomo-info.html
>
> PLEASE NOTE: The information contained in this electronic mail messag=
e
> is intended only for the use of the designated recipient(s) named
> above. If the reader of this message is not the intended recipient,
> you are hereby notified that you have received this message in error
> and that any review, dissemination, distribution, or copying of this
> message is strictly prohibited. If you have received this
> communication in error, please notify the sender by telephone or
> e-mail (as shown above) immediately and destroy any and all copies of
> this message in your possession (whether hard copies or electronicall=
y stored copies).
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> in the body of a message to majordomo@vger.kernel.org More majordomo
> info at http://vger.kernel.org/majordomo-info.html
PLEASE NOTE: The information contained in this electronic mail message =
is intended only for the use of the designated recipient(s) named above=
=2E If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
