From: Mark Kampe <mark.kampe@inktank.com>
Subject: Re: RBD fio Performance concerns
Date: Mon, 19 Nov 2012 08:54:47 -0800
Message-ID: <50AA6457.1060809@inktank.com>
References: <CAOLwVUknn4hH20P+iRbrqeNTQbFxcVFqWo=ZUM5-RQTNgqyWSQ@mail.gmail.com> <d4bdfae3-9a87-4815-994f-cfc20be355a7@mailpro> <CAOLwVU=ed5fdg96Nk7gvvJqdK5vpnweZ7zJTGYVWcYikqY_j1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44263 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136Ab2KSQyr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Nov 2012 11:54:47 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so3592605pbc.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Nov 2012 08:54:47 -0800 (PST)
In-Reply-To: <CAOLwVU=ed5fdg96Nk7gvvJqdK5vpnweZ7zJTGYVWcYikqY_j1Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel <ceph-devel@vger.kernel.org>

Recall:
    1. RBD volumes are striped (4M wide) across RADOS objects
    2. distinct writes to a single RADOS object are serialized

Your sequential 4K writes are direct, depth=256, so there are
(at all times) 256 writes queued to the same object.  All of
your writes are waiting through a very long line, which is adding
horrendous latency.

If you want to do sequential I/O, you should do it buffered
(so that the writes can be aggregated) or with a 4M block size
(very efficient and avoiding object serialization).

We do direct writes for benchmarking, not because it is a reasonable
way to do I/O, but because it bypasses the buffer cache and enables
us to directly measure cluster I/O throughput (which is what we are
trying to optimize).  Applications should usually do buffered I/O,
to get the (very significant) benefits of caching and write aggregation.

> That's correct for some of the benchmarks. However even with 4K for
> seq, I still get less IOPS. See below my last fio:
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
>    read : io=801892KB, bw=13353KB/s, iops=3338 , runt= 60053msec
>      slat (usec): min=8 , max=45921 , avg=296.69, stdev=1584.90
>      clat (msec): min=18 , max=133 , avg=76.37, stdev=16.63
>       lat (msec): min=18 , max=133 , avg=76.67, stdev=16.62
>      bw (KB/s) : min=    0, max=14406, per=31.89%, avg=4258.24, stdev=6239.06
>    cpu          : usr=0.87%, sys=5.57%, ctx=165281, majf=0, minf=279
>    IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
>       submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
>       complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.1%
>       issued r/w/d: total=200473/0/0, short=0/0/0
>
>       lat (msec): 20=0.01%, 50=9.46%, 100=90.45%, 250=0.10%
> rand-read: (groupid=1, jobs=1): err= 0: pid=16846
>    read : io=6376.4MB, bw=108814KB/s, iops=27203 , runt= 60005msec
>      slat (usec): min=8 , max=12723 , avg=33.54, stdev=59.87
>      clat (usec): min=4642 , max=55760 , avg=9374.10, stdev=970.40
>       lat (usec): min=4671 , max=55788 , avg=9408.00, stdev=971.21
>      bw (KB/s) : min=105496, max=109136, per=100.00%, avg=108815.48, stdev=648.62
>    cpu          : usr=8.26%, sys=49.11%, ctx=1486259, majf=0, minf=278
>    IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
>       submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
>       complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.1%
>       issued r/w/d: total=1632349/0/0, short=0/0/0
>
>       lat (msec): 10=83.39%, 20=16.56%, 50=0.04%, 100=0.01%
> seq-write: (groupid=2, jobs=1): err= 0: pid=18653
>    write: io=44684KB, bw=753502 B/s, iops=183 , runt= 60725msec
>      slat (usec): min=8 , max=1246.8K, avg=5402.76, stdev=40024.97
>      clat (msec): min=25 , max=4868 , avg=1384.22, stdev=470.19
>       lat (msec): min=25 , max=4868 , avg=1389.62, stdev=470.17
>      bw (KB/s) : min=    7, max= 2165, per=104.03%, avg=764.65, stdev=353.97
>    cpu          : usr=0.05%, sys=0.35%, ctx=5478, majf=0, minf=21
>    IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.3%, >=64=99.4%
>       submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
>       complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.1%
>       issued r/w/d: total=0/11171/0, short=0/0/0
>
>       lat (msec): 50=0.21%, 100=0.44%, 250=0.97%, 500=1.49%, 750=4.60%
>       lat (msec): 1000=12.73%, 2000=66.36%, >=2000=13.20%
> rand-write: (groupid=3, jobs=1): err= 0: pid=20446
>    write: io=208588KB, bw=3429.5KB/s, iops=857 , runt= 60822msec
>      slat (usec): min=10 , max=1693.9K, avg=1148.15, stdev=15210.37
>      clat (msec): min=22 , max=5639 , avg=297.37, stdev=430.27
>       lat (msec): min=22 , max=5639 , avg=298.52, stdev=430.84
>      bw (KB/s) : min=    0, max= 7728, per=31.44%, avg=1078.21, stdev=2000.45
>    cpu          : usr=0.34%, sys=1.61%, ctx=37183, majf=0, minf=19
>    IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=99.9%
>       submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
>       complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.1%
>       issued r/w/d: total=0/52147/0, short=0/0/0
>
>       lat (msec): 50=2.82%, 100=25.63%, 250=46.12%, 500=10.36%, 750=5.10%
>       lat (msec): 1000=2.91%, 2000=5.75%, >=2000=1.33%
>
> Run status group 0 (all jobs):
>     READ: io=801892KB, aggrb=13353KB/s, minb=13673KB/s, maxb=13673KB/s,
> mint=60053msec, maxt=60053msec
>
> Run status group 1 (all jobs):
>     READ: io=6376.4MB, aggrb=108814KB/s, minb=111425KB/s,
> maxb=111425KB/s, mint=60005msec, maxt=60005msec
>
> Run status group 2 (all jobs):
>    WRITE: io=44684KB, aggrb=735KB/s, minb=753KB/s, maxb=753KB/s,
> mint=60725msec, maxt=60725msec
>
> Run status group 3 (all jobs):
>    WRITE: io=208588KB, aggrb=3429KB/s, minb=3511KB/s, maxb=3511KB/s,
> mint=60822msec, maxt=60822msec
>
> Disk stats (read/write):
>    rbd1: ios=1832984/63270, merge=0/0, ticks=16374236/17012132,
> in_queue=33434120, util=99.79%
