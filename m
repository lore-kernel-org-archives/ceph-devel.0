From: Sage Weil <sage@inktank.com>
Subject: Re: RBD fio Performance concerns
Date: Mon, 19 Nov 2012 08:44:10 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211190842480.2485@cobra.newdream.net>
References: <CAOLwVUknn4hH20P+iRbrqeNTQbFxcVFqWo=ZUM5-RQTNgqyWSQ@mail.gmail.com> <d4bdfae3-9a87-4815-994f-cfc20be355a7@mailpro> <CAOLwVU=ed5fdg96Nk7gvvJqdK5vpnweZ7zJTGYVWcYikqY_j1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60400 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753830Ab2KSQoL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Nov 2012 11:44:11 -0500
In-Reply-To: <CAOLwVU=ed5fdg96Nk7gvvJqdK5vpnweZ7zJTGYVWcYikqY_j1Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-15?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel <ceph-devel@vger.kernel.org>, Mark Kampe <mark.kampe@inktank.com>

On Mon, 19 Nov 2012, S?bastien Han wrote:
> > If I remember, you use fio with 4MB block size for sequential.
> > So it's normal that you have less ios, but more bandwith.
> 
> That's correct for some of the benchmarks. However even with 4K for
> seq, I still get less IOPS. See below my last fio:

Small IOs striped over large objects tends to mean that many IOs may get 
piled up behind a single object at a time.  There is a new striping 
feature in RBD that lets you stripe small blocks over larger objects to 
mitigate this, but it means slower performance the rest of the time, and 
is only really useful for specific workloads (e.g., database journal 
file/device).

sage

> 
> # fio rbd-bench.fio
> seq-read: (g=0): rw=read, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=256
> rand-read: (g=1): rw=randread, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=256
> seq-write: (g=2): rw=write, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=256
> rand-write: (g=3): rw=randwrite, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=256
> fio 1.59
> Starting 4 processes
> Jobs: 1 (f=1): [___w] [57.6% done] [0K/405K /s] [0 /99  iops] [eta 02m:59s]
> seq-read: (groupid=0, jobs=1): err= 0: pid=15096
>   read : io=801892KB, bw=13353KB/s, iops=3338 , runt= 60053msec
>     slat (usec): min=8 , max=45921 , avg=296.69, stdev=1584.90
>     clat (msec): min=18 , max=133 , avg=76.37, stdev=16.63
>      lat (msec): min=18 , max=133 , avg=76.67, stdev=16.62
>     bw (KB/s) : min=    0, max=14406, per=31.89%, avg=4258.24, stdev=6239.06
>   cpu          : usr=0.87%, sys=5.57%, ctx=165281, majf=0, minf=279
>   IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
>      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
>      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.1%
>      issued r/w/d: total=200473/0/0, short=0/0/0
> 
>      lat (msec): 20=0.01%, 50=9.46%, 100=90.45%, 250=0.10%
> rand-read: (groupid=1, jobs=1): err= 0: pid=16846
>   read : io=6376.4MB, bw=108814KB/s, iops=27203 , runt= 60005msec
>     slat (usec): min=8 , max=12723 , avg=33.54, stdev=59.87
>     clat (usec): min=4642 , max=55760 , avg=9374.10, stdev=970.40
>      lat (usec): min=4671 , max=55788 , avg=9408.00, stdev=971.21
>     bw (KB/s) : min=105496, max=109136, per=100.00%, avg=108815.48, stdev=648.62
>   cpu          : usr=8.26%, sys=49.11%, ctx=1486259, majf=0, minf=278
>   IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
>      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
>      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.1%
>      issued r/w/d: total=1632349/0/0, short=0/0/0
> 
>      lat (msec): 10=83.39%, 20=16.56%, 50=0.04%, 100=0.01%
> seq-write: (groupid=2, jobs=1): err= 0: pid=18653
>   write: io=44684KB, bw=753502 B/s, iops=183 , runt= 60725msec
>     slat (usec): min=8 , max=1246.8K, avg=5402.76, stdev=40024.97
>     clat (msec): min=25 , max=4868 , avg=1384.22, stdev=470.19
>      lat (msec): min=25 , max=4868 , avg=1389.62, stdev=470.17
>     bw (KB/s) : min=    7, max= 2165, per=104.03%, avg=764.65, stdev=353.97
>   cpu          : usr=0.05%, sys=0.35%, ctx=5478, majf=0, minf=21
>   IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.3%, >=64=99.4%
>      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
>      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.1%
>      issued r/w/d: total=0/11171/0, short=0/0/0
> 
>      lat (msec): 50=0.21%, 100=0.44%, 250=0.97%, 500=1.49%, 750=4.60%
>      lat (msec): 1000=12.73%, 2000=66.36%, >=2000=13.20%
> rand-write: (groupid=3, jobs=1): err= 0: pid=20446
>   write: io=208588KB, bw=3429.5KB/s, iops=857 , runt= 60822msec
>     slat (usec): min=10 , max=1693.9K, avg=1148.15, stdev=15210.37
>     clat (msec): min=22 , max=5639 , avg=297.37, stdev=430.27
>      lat (msec): min=22 , max=5639 , avg=298.52, stdev=430.84
>     bw (KB/s) : min=    0, max= 7728, per=31.44%, avg=1078.21, stdev=2000.45
>   cpu          : usr=0.34%, sys=1.61%, ctx=37183, majf=0, minf=19
>   IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=99.9%
>      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
>      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.1%
>      issued r/w/d: total=0/52147/0, short=0/0/0
> 
>      lat (msec): 50=2.82%, 100=25.63%, 250=46.12%, 500=10.36%, 750=5.10%
>      lat (msec): 1000=2.91%, 2000=5.75%, >=2000=1.33%
> 
> Run status group 0 (all jobs):
>    READ: io=801892KB, aggrb=13353KB/s, minb=13673KB/s, maxb=13673KB/s,
> mint=60053msec, maxt=60053msec
> 
> Run status group 1 (all jobs):
>    READ: io=6376.4MB, aggrb=108814KB/s, minb=111425KB/s,
> maxb=111425KB/s, mint=60005msec, maxt=60005msec
> 
> Run status group 2 (all jobs):
>   WRITE: io=44684KB, aggrb=735KB/s, minb=753KB/s, maxb=753KB/s,
> mint=60725msec, maxt=60725msec
> 
> Run status group 3 (all jobs):
>   WRITE: io=208588KB, aggrb=3429KB/s, minb=3511KB/s, maxb=3511KB/s,
> mint=60822msec, maxt=60822msec
> 
> Disk stats (read/write):
>   rbd1: ios=1832984/63270, merge=0/0, ticks=16374236/17012132,
> in_queue=33434120, util=99.79%
> 
> Cheers!
> --
> Bien cordialement.
> S?bastien HAN.
> 
> 
> On Mon, Nov 19, 2012 at 4:28 PM, Alexandre DERUMIER <aderumier@odiso.com> wrote:
> >>>why the
> >>>sequential read/writes are lower than the randoms onces? Or maybe do I
> >>>just need to care about the bandwidth for those values?
> >
> > If I remember, you use fio with 4MB block size for sequential.
> > So it's normal that you have less ios, but more bandwith.
> >
> >
> >
> > ----- Mail original -----
> >
> > De: "S?bastien Han" <han.sebastien@gmail.com>
> > ?: "Mark Kampe" <mark.kampe@inktank.com>
> > Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
> > Envoy?: Lundi 19 Novembre 2012 15:56:35
> > Objet: Re: RBD fio Performance concerns
> >
> > Hello Mark,
> >
> > First of all, thank you again for another accurate answer :-).
> >
> >> I would have expected write aggregation and cylinder affinity to
> >> have eliminated some seeks and improved rotational latency resulting
> >> in better than theoretical random write throughput. Against those
> >> expectations 763/850 IOPS is not so impressive. But, it looks to
> >> me like you were running fio in a 1G file with 100 parallel requests.
> >> The default RBD stripe width is 4M. This means that those 100
> >> parallel requests were being spread across 256 (1G/4M) objects.
> >> People in the know tell me that writes to a single object are
> >> serialized, which means that many of those (potentially) parallel
> >> writes were to the same object, and hence serialized. This would
> >> increase the average request time for the colliding operations,
> >> and reduce the aggregate throughput correspondingly. Use a
> >> bigger file (or a narrower stripe) and this will get better.
> >
> >
> > I followed your advice and used a bigger file (10G) and an iodepth of
> > 128 and I've been able to reach ~27k iops for rand reads but I
> > couldn't reach more than 870 iops in randwrites... It's kind of
> > expected. But the thing a still don't understand is: why the
> > sequential read/writes are lower than the randoms onces? Or maybe do I
> > just need to care about the bandwidth for those values?
> >
> > Thank you.
> >
> > Regards.
> > --
> > Bien cordialement.
> > S?bastien HAN.
> >
> >
> > On Fri, Nov 16, 2012 at 11:59 PM, Mark Kampe <mark.kampe@inktank.com> wrote:
> >> On 11/15/2012 12:23 PM, S?bastien Han wrote:
> >>
> >>> First of all, I would like to thank you for this well explained,
> >>> structured and clear answer. I guess I got better IOPS thanks to the 10K
> >>> disks.
> >>
> >>
> >> 10K RPM would bring your per-drive throughput (for 4K random writes)
> >> up to 142 IOPS and your aggregate cluster throughput up to 1700.
> >> This would predict a corresponding RADOSbench throughput somewhere
> >> above 425 (how much better depending on write aggregation and cylinder
> >> affinity). Your RADOSbench 708 now seems even more reasonable.
> >>
> >>> To be really honest I wasn't so concerned about the RADOS benchmarks
> >>> but more about the RBD fio benchmarks and the amont of IOPS that comes
> >>> out of it, which I found ? bit to low.
> >>
> >>
> >> Sticking with 4K random writes, it looks to me like you were running
> >> fio with libaio (which means direct, no buffer cache). Because it
> >> is direct, every I/O operation is really happening and the best
> >> sustained throughput you should expect from this cluster is
> >> the aggregate raw fio 4K write throughput (1700 IOPS) divided
> >> by two copies = 850 random 4K writes per second. If I read the
> >> output correctly you got 763 or about 90% of back-of-envelope.
> >>
> >> BUT, there are some footnotes (there always are with performance)
> >>
> >> If you had been doing buffered I/O you would have seen a lot more
> >> (up front) benefit from page caching ... but you wouldn't have been
> >> measuring real (and hence sustainable) I/O throughput ... which is
> >> ultimately limited by the heads on those twelve disk drives, where
> >> all of those writes ultimately wind up. It is easy to be fast
> >> if you aren't really doing the writes :-)
> >>
> >> I would have expected write aggregation and cylinder affinity to
> >> have eliminated some seeks and improved rotational latency resulting
> >> in better than theoretical random write throughput. Against those
> >> expectations 763/850 IOPS is not so impressive. But, it looks to
> >> me like you were running fio in a 1G file with 100 parallel requests.
> >> The default RBD stripe width is 4M. This means that those 100
> >> parallel requests were being spread across 256 (1G/4M) objects.
> >> People in the know tell me that writes to a single object are
> >> serialized, which means that many of those (potentially) parallel
> >> writes were to the same object, and hence serialized. This would
> >> increase the average request time for the colliding operations,
> >> and reduce the aggregate throughput correspondingly. Use a
> >> bigger file (or a narrower stripe) and this will get better.
> >>
> >> Thus, getting 763 random 4K write IOPs out of those 12 drives
> >> still sounds about right to me.
> >>
> >>
> >>> On 15 nov. 2012, at 19:43, Mark Kampe <mark.kampe@inktank.com> wrote:
> >>>
> >>>> Dear Sebastien,
> >>>>
> >>>> Ross Turn forwarded me your e-mail. You sent a great deal
> >>>> of information, but it was not immediately obvious to me
> >>>> what your specific concern was.
> >>>>
> >>>> You have 4 servers, 3 OSDs per, 2 copy, and you measured a
> >>>> radosbench (4K object creation) throughput of 2.9MB/s
> >>>> (or 708 IOPS). I infer that you were disappointed by
> >>>> this number, but it looks right to me.
> >>>>
> >>>> Assuming typical 7200 RPM drives, I would guess that each
> >>>> of them would deliver a sustained direct 4K random write
> >>>> performance in the general neighborhood of:
> >>>> 4ms seek (short seeks with write-settle-downs)
> >>>> 4ms latency (1/2 rotation)
> >>>> 0ms write (4K/144MB/s ~ 30us)
> >>>> -----
> >>>> 8ms or about 125 IOPS
> >>>>
> >>>> Your twelve drives should therefore have a sustainable
> >>>> aggregate direct 4K random write throughput of 1500 IOPS.
> >>>>
> >>>> Each 4K object create involves four writes (two copies,
> >>>> each getting one data write and one data update). Thus
> >>>> I would expect a (crude) 4K create rate of 375 IOPS (1500/4).
> >>>>
> >>>> You are getting almost twice the expected raw IOPS ...
> >>>> and we should expect that a large number of parallel
> >>>> operations would realize some write/seek aggregation
> >>>> benefits ... so these numbers look right to me.
> >>>>
> >>>> Is this the number you were concerned about, or have I
> >>>> misunderstood?
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
