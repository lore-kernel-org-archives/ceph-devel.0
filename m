From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: RBD fio Performance concerns
Date: Thu, 22 Nov 2012 08:34:29 -0600
Message-ID: <50AE37F5.8070102@inktank.com>
References: <CAOLwVUmJGZNaZsySsw8eQmLy1ZCha+AAGCp-5i42=mr0aKHMyA@mail.gmail.com> <3210b770-431e-44ed-8d86-4610de89dd92@mailpro> <CAOLwVUn5EAC4QaWgU+TkodcJea7ayKUANUpfzWUG+cTBunao5g@mail.gmail.com> <50ACF8C8.7020908@inktank.com> <50AD02AC.60802@inktank.com> <50ADFC23.2030208@profihost.ag> <CAOLwVUmp7wrfead8qX2BZPbyeN_JY_XBN+wkEWmbY6q1-5u0fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:42246 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755049Ab2KVSnq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 13:43:46 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so2372534iea.19
        for <ceph-devel@vger.kernel.org>; Thu, 22 Nov 2012 10:43:46 -0800 (PST)
In-Reply-To: <CAOLwVUmp7wrfead8qX2BZPbyeN_JY_XBN+wkEWmbY6q1-5u0fw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Cc: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel <ceph-devel@vger.kernel.org>, Mark Kampe <mark.kampe@inktank.com>

On 11/22/2012 04:49 AM, S=E9bastien Han wrote:
> @Alexandre: cool!
>
> @ Stefan: Full SSD cluster and 10G switches? Couple of weeks ago I sa=
w
> that you use journal aio, did you notice performance improvement with=
 it?
>
> @Mark Kampe
>
>  > If I read the above correctly, your random operations are 4K and y=
our
>  > sequential operations are 4M.
>
>
> As you recommend. (see below what you previously said):
>
>  > If you want to do sequential I/O, you should do it buffered
>  > (so that the writes can be aggregated) or with a 4M block size
>  > (very efficient and avoiding object serialization).
>
>
>
>  > The block-size difference makes the random and sequential
>  > results incomparable.
>
>
> Ok let's do it again then (short output that fits on a screen), with =
a
> single OSD and 4K blocks:
>
> seq-read: (g=3D0): rw=3Dread, bs=3D4K-4K/4K-4K, ioengine=3Dlibaio, io=
depth=3D42
> rand-read: (g=3D1): rw=3Drandread, bs=3D4K-4K/4K-4K, ioengine=3Dlibai=
o, iodepth=3D42
> seq-write: (g=3D2): rw=3Dwrite, bs=3D4K-4K/4K-4K, ioengine=3Dlibaio, =
iodepth=3D42
> rand-write: (g=3D3): rw=3Drandwrite, bs=3D4K-4K/4K-4K, ioengine=3Dlib=
aio, iodepth=3D42
>
> seq-read: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D7542
>    read : io=3D912716KB, bw=3D15210KB/s, iops=3D3802 , runt=3D 60009m=
sec
> rand-read: (groupid=3D1, jobs=3D1): err=3D 0: pid=3D7546
>    read : io=3D980504KB, bw=3D16339KB/s, iops=3D4084 , runt=3D 60009m=
sec
> seq-write: (groupid=3D2, jobs=3D1): err=3D 0: pid=3D7547
>    write: io=3D54216KB, bw=3D922718 B/s, iops=3D225 , runt=3D 60167ms=
ec
> rand-write: (groupid=3D3, jobs=3D1): err=3D 0: pid=3D7557
>    write: io=3D66116KB, bw=3D1098.5KB/s, iops=3D274 , runt=3D 60192ms=
ec
>
> Sequentials and random operations are getting closer to each others, =
but
> random operations remain higher.
>
>  > the more data you send me, the longer it takes me to find
>  > time to review your results.  If you send me a message that
>  > fits on a single screen, I will try to answer it immediately.
>
>
> I just don't want to miss any information that you may find useful.
>
> @ Mark Nelson
>
> See below the new blkparse trace with 4K block for all operations:
>
> Inline image 1

Thanks for doing this!  Unfortunately it's only showing writes so we=20
don't know what read behavior looks like in these graphs.  That might b=
e=20
important.  Also, do you know approximately how the tests line up with=20
timestamps on the seekwatcher results?  Seekwatcher only seems to be=20
going for 228 seconds, but the 4 tests should be lasting 240+ seconds?

If I just break this down into 60s chunks with seq-read, rand-read,=20
seq-write, rand-write in that order, my wildly speculative guess is tha=
t=20
there's a chunk of time missing at the beginning where the read tests=20
are happening that extend out to about second ~80-85 in the graph.=20
After that it's the write tests from ~85 out to ~205.  After that, I=20
guess that there are no more incoming writes, but existing writes are=20
being flushed and that with no incoming writes we see a bump in=20
performance (possibly due to a reduction in lock contention? What=20
version of ceph is this again?)

A couple of thoughts:

- You may want to pause between the tests for a while (or even reformat=
=20
between every test!)

- That spike in performance at the end is interesting.  I'd really like=
=20
to know if that happened during the rand-write test or after the test=20
completed (once the data hit the jouranl the writes would have been=20
acknowledged letting the test end while the data was still being flushe=
d=20
out to disk).

- If my interpretation is right, it looks like the typical seq-write=20
throughput is slightly higher according to blktrace but with regular=20
dips, while the random write performance is typically lower but with no=
=20
dips (and maybe a big increase at the end).  In both cases we have a=20
very high number of seeks! Do you have WB cache on your controller?=20
These are 10K RPM drives?

- Read behavior would be really useful!

- You can pretty clearly see the different AGs in XFS doing their thing=
=2E=20
  I wonder if 1 AG would be better here.  On the other hand, there's a=20
pretty long thread that discusses IOPs heavy workload on XFS here:

http://xfs.9218.n7.nabble.com/XFS-Abysmal-write-performance-because-of-=
excessive-seeking-allocation-groups-to-blame-td15501.html

- It would be very interesting to try this test on EXT4 or BTRFS and se=
e=20
if the results are the same.  I forget, did someone already do this?

Mark

> Thanks again everyone, for your help.
>
> Cheers!
>
> On Thu, Nov 22, 2012 at 11:19 AM, Stefan Priebe - Profihost AG
> <s.priebe@profihost.ag <mailto:s.priebe@profihost.ag>> wrote:
>  >
>  >
>  > Same to me:
>  > rand 4k: 23.000 iops
>  > seq 4k: 13.000 iops
>  >
>  > Even in writeback mode where normally seq 4k should be merged into
> bigger requests.
>  >
>  > Stefan
>  >
>  > Am 21.11.2012 17:34, schrieb Mark Nelson:
>  >
>  >> Responding to my own message. :)
>  >>
>  >> Talked to Sage a bit offline about this.  I think there are two o=
pposing
>  >> forces:
>  >>
>  >> On one hand, random IO may be spreading reads/writes out across m=
ore
>  >> OSDs than sequential IO that presumably would be hitting a single=
 OSD
>  >> more regularly.
>  >>
>  >> On the other hand, you'd expect that sequential writes would be g=
etting
>  >> coalesced either at the RBD layer or on the OSD, and that the
>  >> drive/controller/filesystem underneath the OSD would be doing som=
e kind
>  >> of readahead or prefetching.
>  >>
>  >> On the third hand, maybe coalescing/prefetching is in fact happen=
ing but
>  >> we are IOP limited by some per-osd limitation.
>  >>
>  >> It could be interesting to do the test with a single OSD and see =
what
>  >> happens.
>  >>
>  >> Mark
>  >>
>  >> On 11/21/2012 09:52 AM, Mark Nelson wrote:
>  >>>
>  >>> Hi Guys,
>  >>>
>  >>> I'm late to this thread but thought I'd chime in.  Crazy that yo=
u are
>  >>> getting higher performance with random reads/writes vs sequentia=
l!  It
>  >>> would be interesting to see what kind of throughput smalliobench
> reports
>  >>> (should be packaged in bobtail) and also see if this behavior ha=
ppens
>  >>> with cephfs.  It's still too early in the morning for me right n=
ow to
>  >>> come up with a reasonable explanation for what's going on.  It m=
ight be
>  >>> worth running blktrace and seekwatcher to see what the io patter=
ns on
>  >>> the underlying disk look like in each case.  Maybe something une=
xpected
>  >>> is going on.
>  >>>
>  >>> Mark
>  >>>
>  >>> On 11/19/2012 02:57 PM, S=E9bastien Han wrote:
>  >>>>
>  >>>> Which iodepth did you use for those benchs?
>  >>>>
>  >>>>
>  >>>>> I really don't understand why I can't get more rand read iops =
with 4K
>  >>>>> block ...
>  >>>>
>  >>>>
>  >>>> Me neither, hope to get some clarification from the Inktank guy=
s. It
>  >>>> doesn't make any sense to me...
>  >>>> --
>  >>>> Bien cordialement.
>  >>>> S=E9bastien HAN.
>  >>>>
>  >>>>
>  >>>> On Mon, Nov 19, 2012 at 8:11 PM, Alexandre DERUMIER
>  >>>> <aderumier@odiso.com <mailto:aderumier@odiso.com>> wrote:
>  >>>>>>>
>  >>>>>>> @Alexandre: is it the same for you? or do you always get mor=
e IOPS
>  >>>>>>> with seq?
>  >>>>>
>  >>>>>
>  >>>>> rand read 4K : 6000 iops
>  >>>>> seq read 4K : 3500 iops
>  >>>>> seq read 4M : 31iops (1gigabit client bandwith limit)
>  >>>>>
>  >>>>> rand write 4k: 6000iops  (tmpfs journal)
>  >>>>> seq write 4k: 1600iops
>  >>>>> seq write 4M : 31iops (1gigabit client bandwith limit)
>  >>>>>
>  >>>>>
>  >>>>> I really don't understand why I can't get more rand read iops =
with 4K
>  >>>>> block ...
>  >>>>>
>  >>>>> I try with high end cpu for client, it doesn't change nothing.
>  >>>>> But test cluster use  old 8 cores E5420  @ 2.50GHZ (But cpu is=
 around
>  >>>>> 15% on cluster during read bench)
>  >>>>>
>  >>>>>
>  >>>>> ----- Mail original -----
>  >>>>>
>  >>>>> De: "S=E9bastien Han" <han.sebastien@gmail.com
> <mailto:han.sebastien@gmail.com>>
>  >>>>> =C0: "Mark Kampe" <mark.kampe@inktank.com
> <mailto:mark.kampe@inktank.com>>
>  >>>>> Cc: "Alexandre DERUMIER" <aderumier@odiso.com
> <mailto:aderumier@odiso.com>>, "ceph-devel"
>  >>>>> <ceph-devel@vger.kernel.org <mailto:ceph-devel@vger.kernel.org=
>>
>  >>>>> Envoy=E9: Lundi 19 Novembre 2012 19:03:40
>  >>>>> Objet: Re: RBD fio Performance concerns
>  >>>>>
>  >>>>> @Sage, thanks for the info :)
>  >>>>> @Mark:
>  >>>>>
>  >>>>>> If you want to do sequential I/O, you should do it buffered
>  >>>>>> (so that the writes can be aggregated) or with a 4M block siz=
e
>  >>>>>> (very efficient and avoiding object serialization).
>  >>>>>
>  >>>>>
>  >>>>> The original benchmark has been performed with 4M block size. =
And as
>  >>>>> you can see I still get more IOPS with rand than seq... I just=
 tried
>  >>>>> with 4M without direct I/O, still the same. I can print fio
> results if
>  >>>>> it's needed.
>  >>>>>
>  >>>>>> We do direct writes for benchmarking, not because it is a rea=
sonable
>  >>>>>> way to do I/O, but because it bypasses the buffer cache and e=
nables
>  >>>>>> us to directly measure cluster I/O throughput (which is what =
we are
>  >>>>>> trying to optimize). Applications should usually do buffered =
I/O,
>  >>>>>> to get the (very significant) benefits of caching and write
>  >>>>>> aggregation.
>  >>>>>
>  >>>>>
>  >>>>> I know why I use direct I/O. It's synthetic benchmarks, it's f=
ar away
>  >>>>> from a real life scenario and how common applications works. I=
 just
>  >>>>> try to see the maximum I/O throughput that I can get from my R=
BD. All
>  >>>>> my applications use buffered I/O.
>  >>>>>
>  >>>>> @Alexandre: is it the same for you? or do you always get more =
IOPS
>  >>>>> with seq?
>  >>>>>
>  >>>>> Thanks to all of you..
>  >>>>>
>  >>>>>
>  >>>>> On Mon, Nov 19, 2012 at 5:54 PM, Mark Kampe
> <mark.kampe@inktank.com <mailto:mark.kampe@inktank.com>>
>  >>>>> wrote:
>  >>>>>>
>  >>>>>> Recall:
>  >>>>>> 1. RBD volumes are striped (4M wide) across RADOS objects
>  >>>>>> 2. distinct writes to a single RADOS object are serialized
>  >>>>>>
>  >>>>>> Your sequential 4K writes are direct, depth=3D256, so there a=
re
>  >>>>>> (at all times) 256 writes queued to the same object. All of
>  >>>>>> your writes are waiting through a very long line, which is ad=
ding
>  >>>>>> horrendous latency.
>  >>>>>>
>  >>>>>> If you want to do sequential I/O, you should do it buffered
>  >>>>>> (so that the writes can be aggregated) or with a 4M block siz=
e
>  >>>>>> (very efficient and avoiding object serialization).
>  >>>>>>
>  >>>>>> We do direct writes for benchmarking, not because it is a rea=
sonable
>  >>>>>> way to do I/O, but because it bypasses the buffer cache and e=
nables
>  >>>>>> us to directly measure cluster I/O throughput (which is what =
we are
>  >>>>>> trying to optimize). Applications should usually do buffered =
I/O,
>  >>>>>> to get the (very significant) benefits of caching and write
>  >>>>>> aggregation.
>  >>>>>>
>  >>>>>>
>  >>>>>>> That's correct for some of the benchmarks. However even with=
 4K for
>  >>>>>>> seq, I still get less IOPS. See below my last fio:
>  >>>>>>>
>  >>>>>>> # fio rbd-bench.fio
>  >>>>>>> seq-read: (g=3D0): rw=3Dread, bs=3D4K-4K/4K-4K, ioengine=3Dl=
ibaio,
>  >>>>>>> iodepth=3D256
>  >>>>>>> rand-read: (g=3D1): rw=3Drandread, bs=3D4K-4K/4K-4K, ioengin=
e=3Dlibaio,
>  >>>>>>> iodepth=3D256
>  >>>>>>> seq-write: (g=3D2): rw=3Dwrite, bs=3D4K-4K/4K-4K, ioengine=3D=
libaio,
>  >>>>>>> iodepth=3D256
>  >>>>>>> rand-write: (g=3D3): rw=3Drandwrite, bs=3D4K-4K/4K-4K, ioeng=
ine=3Dlibaio,
>  >>>>>>> iodepth=3D256
>  >>>>>>> fio 1.59
>  >>>>>>> Starting 4 processes
>  >>>>>>> Jobs: 1 (f=3D1): [___w] [57.6% done] [0K/405K /s] [0 /99 iop=
s] [eta
>  >>>>>>> 02m:59s]
>  >>>>>>> seq-read: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D15096
>  >>>>>>> read : io=3D801892KB, bw=3D13353KB/s, iops=3D3338 , runt=3D =
60053msec
>  >>>>>>> slat (usec): min=3D8 , max=3D45921 , avg=3D296.69, stdev=3D1=
584.90
>  >>>>>>> clat (msec): min=3D18 , max=3D133 , avg=3D76.37, stdev=3D16.=
63
>  >>>>>>> lat (msec): min=3D18 , max=3D133 , avg=3D76.67, stdev=3D16.6=
2
>  >>>>>>> bw (KB/s) : min=3D 0, max=3D14406, per=3D31.89%, avg=3D4258.=
24,
>  >>>>>>> stdev=3D6239.06
>  >>>>>>> cpu : usr=3D0.87%, sys=3D5.57%, ctx=3D165281, majf=3D0, minf=
=3D279
>  >>>>>>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1=
%, 32=3D0.1%,
>  >>>>>>>>
>  >>>>>>>> =3D64=3D100.0%
>  >>>>>>>
>  >>>>>>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0=
%, 64=3D0.0%,
>  >>>>>>>>
>  >>>>>>>> =3D64=3D0.0%
>  >>>>>>>
>  >>>>>>> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0=
=2E0%, 64=3D0.0%,
>  >>>>>>>>
>  >>>>>>>> =3D64=3D0.1%
>  >>>>>>>
>  >>>>>>> issued r/w/d: total=3D200473/0/0, short=3D0/0/0
>  >>>>>>>
>  >>>>>>> lat (msec): 20=3D0.01%, 50=3D9.46%, 100=3D90.45%, 250=3D0.10=
%
>  >>>>>>> rand-read: (groupid=3D1, jobs=3D1): err=3D 0: pid=3D16846
>  >>>>>>> read : io=3D6376.4MB, bw=3D108814KB/s, iops=3D27203 , runt=3D=
 60005msec
>  >>>>>>> slat (usec): min=3D8 , max=3D12723 , avg=3D33.54, stdev=3D59=
=2E87
>  >>>>>>> clat (usec): min=3D4642 , max=3D55760 , avg=3D9374.10, stdev=
=3D970.40
>  >>>>>>> lat (usec): min=3D4671 , max=3D55788 , avg=3D9408.00, stdev=3D=
971.21
>  >>>>>>> bw (KB/s) : min=3D105496, max=3D109136, per=3D100.00%, avg=3D=
108815.48,
>  >>>>>>> stdev=3D648.62
>  >>>>>>> cpu : usr=3D8.26%, sys=3D49.11%, ctx=3D1486259, majf=3D0, mi=
nf=3D278
>  >>>>>>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1=
%, 32=3D0.1%,
>  >>>>>>>>
>  >>>>>>>> =3D64=3D100.0%
>  >>>>>>>
>  >>>>>>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0=
%, 64=3D0.0%,
>  >>>>>>>>
>  >>>>>>>> =3D64=3D0.0%
>  >>>>>>>
>  >>>>>>> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0=
=2E0%, 64=3D0.0%,
>  >>>>>>>>
>  >>>>>>>> =3D64=3D0.1%
>  >>>>>>>
>  >>>>>>> issued r/w/d: total=3D1632349/0/0, short=3D0/0/0
>  >>>>>>>
>  >>>>>>> lat (msec): 10=3D83.39%, 20=3D16.56%, 50=3D0.04%, 100=3D0.01=
%
>  >>>>>>> seq-write: (groupid=3D2, jobs=3D1): err=3D 0: pid=3D18653
>  >>>>>>> write: io=3D44684KB, bw=3D753502 B/s, iops=3D183 , runt=3D 6=
0725msec
>  >>>>>>> slat (usec): min=3D8 , max=3D1246.8K, avg=3D5402.76, stdev=3D=
40024.97
>  >>>>>>> clat (msec): min=3D25 , max=3D4868 , avg=3D1384.22, stdev=3D=
470.19
>  >>>>>>> lat (msec): min=3D25 , max=3D4868 , avg=3D1389.62, stdev=3D4=
70.17
>  >>>>>>> bw (KB/s) : min=3D 7, max=3D 2165, per=3D104.03%, avg=3D764.=
65,
>  >>>>>>> stdev=3D353.97
>  >>>>>>> cpu : usr=3D0.05%, sys=3D0.35%, ctx=3D5478, majf=3D0, minf=3D=
21
>  >>>>>>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1=
%, 32=3D0.3%,
>  >>>>>>>>
>  >>>>>>>> =3D64=3D99.4%
>  >>>>>>>
>  >>>>>>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0=
%, 64=3D0.0%,
>  >>>>>>>>
>  >>>>>>>> =3D64=3D0.0%
>  >>>>>>>
>  >>>>>>> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0=
=2E0%, 64=3D0.0%,
>  >>>>>>>>
>  >>>>>>>> =3D64=3D0.1%
>  >>>>>>>
>  >>>>>>> issued r/w/d: total=3D0/11171/0, short=3D0/0/0
>  >>>>>>>
>  >>>>>>> lat (msec): 50=3D0.21%, 100=3D0.44%, 250=3D0.97%, 500=3D1.49=
%, 750=3D4.60%
>  >>>>>>> lat (msec): 1000=3D12.73%, 2000=3D66.36%, >=3D2000=3D13.20%
>  >>>>>>> rand-write: (groupid=3D3, jobs=3D1): err=3D 0: pid=3D20446
>  >>>>>>> write: io=3D208588KB, bw=3D3429.5KB/s, iops=3D857 , runt=3D =
60822msec
>  >>>>>>> slat (usec): min=3D10 , max=3D1693.9K, avg=3D1148.15, stdev=3D=
15210.37
>  >>>>>>> clat (msec): min=3D22 , max=3D5639 , avg=3D297.37, stdev=3D4=
30.27
>  >>>>>>> lat (msec): min=3D22 , max=3D5639 , avg=3D298.52, stdev=3D43=
0.84
>  >>>>>>> bw (KB/s) : min=3D 0, max=3D 7728, per=3D31.44%, avg=3D1078.=
21,
>  >>>>>>> stdev=3D2000.45
>  >>>>>>> cpu : usr=3D0.34%, sys=3D1.61%, ctx=3D37183, majf=3D0, minf=3D=
19
>  >>>>>>> IO depths : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1=
%, 32=3D0.1%,
>  >>>>>>>>
>  >>>>>>>> =3D64=3D99.9%
>  >>>>>>>
>  >>>>>>> submit : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0=
%, 64=3D0.0%,
>  >>>>>>>>
>  >>>>>>>> =3D64=3D0.0%
>  >>>>>>>
>  >>>>>>> complete : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0=
=2E0%, 64=3D0.0%,
>  >>>>>>>>
>  >>>>>>>> =3D64=3D0.1%
>  >>>>>>>
>  >>>>>>> issued r/w/d: total=3D0/52147/0, short=3D0/0/0
>  >>>>>>>
>  >>>>>>> lat (msec): 50=3D2.82%, 100=3D25.63%, 250=3D46.12%, 500=3D10=
=2E36%, 750=3D5.10%
>  >>>>>>> lat (msec): 1000=3D2.91%, 2000=3D5.75%, >=3D2000=3D1.33%
>  >>>>>>>
>  >>>>>>> Run status group 0 (all jobs):
>  >>>>>>> READ: io=3D801892KB, aggrb=3D13353KB/s, minb=3D13673KB/s, ma=
xb=3D13673KB/s,
>  >>>>>>> mint=3D60053msec, maxt=3D60053msec
>  >>>>>>>
>  >>>>>>> Run status group 1 (all jobs):
>  >>>>>>> READ: io=3D6376.4MB, aggrb=3D108814KB/s, minb=3D111425KB/s,
>  >>>>>>> maxb=3D111425KB/s, mint=3D60005msec, maxt=3D60005msec
>  >>>>>>>
>  >>>>>>> Run status group 2 (all jobs):
>  >>>>>>> WRITE: io=3D44684KB, aggrb=3D735KB/s, minb=3D753KB/s, maxb=3D=
753KB/s,
>  >>>>>>> mint=3D60725msec, maxt=3D60725msec
>  >>>>>>>
>  >>>>>>> Run status group 3 (all jobs):
>  >>>>>>> WRITE: io=3D208588KB, aggrb=3D3429KB/s, minb=3D3511KB/s, max=
b=3D3511KB/s,
>  >>>>>>> mint=3D60822msec, maxt=3D60822msec
>  >>>>>>>
>  >>>>>>> Disk stats (read/write):
>  >>>>>>> rbd1: ios=3D1832984/63270, merge=3D0/0, ticks=3D16374236/170=
12132,
>  >>>>>>> in_queue=3D33434120, util=3D99.79%
>  >>>>
>  >>>> --
>  >>>> To unsubscribe from this list: send the line "unsubscribe
> ceph-devel" in
>  >>>> the body of a message to majordomo@vger.kernel.org
> <mailto:majordomo@vger.kernel.org>
>  >>>> More majordomo info at http://vger.kernel.org/majordomo-info.ht=
ml
>  >>>>
>  >>>
>  >>
>  >> --
>  >> To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
>  >> the body of a message to majordomo@vger.kernel.org
> <mailto:majordomo@vger.kernel.org>
>  >> More majordomo info at http://vger.kernel.org/majordomo-info.html


--=20
Mark Nelson
Performance Engineer
Inktank
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
