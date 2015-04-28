From: Mark Nelson <mnelson@redhat.com>
Subject: Re: async messenger small benchmark result
Date: Tue, 28 Apr 2015 08:48:51 -0500
Message-ID: <553F8FC3.5050502@redhat.com>
References: <1034248732.735373173.1430210204922.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34313 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965805AbbD1Ns6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Apr 2015 09:48:58 -0400
In-Reply-To: <1034248732.735373173.1430210204922.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Alex,

Thanks!  So far we've gotten a report that asyncmesseneger was a little 
slower than simple messenger, but not this bad!  I imagine Greg will 
have lots of questions. :)

Mark

On 04/28/2015 03:36 AM, Alexandre DERUMIER wrote:
> Hi,
>
> here a small bench 4k randread of simple messenger vs async messenger
>
> This is with 2 osd, and 15 fio jobs on a single rbd volume
>
> simple messager : 345kiops
> async messenger : 139kiops
>
> Regards,
>
> Alexandre
>
>
>
>
> simple messenger
> ---------------
>
> ^Cbs: 15 (f=15): [r(15)] [0.0% done] [1346MB/0KB/0KB /s] [345K/0/0 iops] [eta 59d:13h:32m:43s]
> fio: terminating on signal 2
>
> rbd_iodepth32-test: (groupid=0, jobs=15): err= 0: pid=44713: Tue Apr 28 10:26:21 2015
>    read : io=15794MB, bw=1321.4MB/s, iops=338255, runt= 11953msec
>      slat (usec): min=5, max=17316, avg=33.81, stdev=63.77
>      clat (usec): min=4, max=60848, avg=1011.22, stdev=1026.16
>       lat (usec): min=110, max=60857, avg=1045.03, stdev=1031.56
>      clat percentiles (usec):
>       |  1.00th=[  219],  5.00th=[  298], 10.00th=[  362], 20.00th=[  466],
>       | 30.00th=[  572], 40.00th=[  676], 50.00th=[  796], 60.00th=[  940],
>       | 70.00th=[ 1112], 80.00th=[ 1336], 90.00th=[ 1784], 95.00th=[ 2288],
>       | 99.00th=[ 4128], 99.50th=[ 5536], 99.90th=[13376], 99.95th=[17536],
>       | 99.99th=[28544]
>      bw (KB  /s): min=31386, max=122224, per=6.67%, avg=90244.35, stdev=17571.24
>      lat (usec) : 10=0.01%, 20=0.01%, 50=0.01%, 100=0.01%, 250=2.21%
>      lat (usec) : 500=21.02%, 750=22.82%, 1000=17.99%
>      lat (msec) : 2=28.62%, 4=6.26%, 10=0.88%, 20=0.15%, 50=0.03%
>      lat (msec) : 100=0.01%
>    cpu          : usr=36.30%, sys=10.85%, ctx=2323657, majf=0, minf=5736
>    IO depths    : 1=0.2%, 2=0.8%, 4=3.4%, 8=16.3%, 16=72.0%, 32=7.3%, >=64=0.0%
>       submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
>       complete  : 0=0.0%, 4=94.8%, 8=1.0%, 16=1.5%, 32=2.6%, 64=0.0%, >=64=0.0%
>       issued    : total=r=4043164/w=0/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
>       latency   : target=0, window=0, percentile=100.00%, depth=32
>
> Run status group 0 (all jobs):
>     READ: io=15794MB, aggrb=1321.4MB/s, minb=1321.4MB/s, maxb=1321.4MB/s, mint=11953msec, maxt=11953msec
>
>
> async messenger (ms_async_op_threads=10)
> -----------------------------------------
> ^Cbs: 15 (f=15): [r(15)] [0.0% done] [544.6MB/0KB/0KB /s] [139K/0/0 iops] [eta 301d:09h:10m:03s]
> fio: terminating on signal 2
>
> rbd_iodepth32-test: (groupid=0, jobs=15): err= 0: pid=42935: Tue Apr 28 10:24:29 2015
>    read : io=6389.8MB, bw=547856KB/s, iops=136963, runt= 11943msec
>      slat (usec): min=7, max=23454, avg=39.33, stdev=226.05
>      clat (usec): min=58, max=107304, avg=3002.03, stdev=6270.44
>       lat (usec): min=91, max=107327, avg=3041.36, stdev=6279.32
>      clat percentiles (usec):
>       |  1.00th=[  129],  5.00th=[  177], 10.00th=[  229], 20.00th=[  334],
>       | 30.00th=[  446], 40.00th=[  564], 50.00th=[  692], 60.00th=[  836],
>       | 70.00th=[ 1032], 80.00th=[ 1576], 90.00th=[10816], 95.00th=[17792],
>       | 99.00th=[29824], 99.50th=[34048], 99.90th=[42240], 99.95th=[45824],
>       | 99.99th=[50432]
>      bw (KB  /s): min=13359, max=128824, per=6.67%, avg=36544.92, stdev=37000.58
>      lat (usec) : 100=0.04%, 250=12.05%, 500=22.51%, 750=19.70%, 1000=14.66%
>      lat (msec) : 2=12.32%, 4=2.66%, 10=5.34%, 20=6.81%, 50=3.91%
>      lat (msec) : 100=0.01%, 250=0.01%
>    cpu          : usr=19.03%, sys=6.33%, ctx=370760, majf=0, minf=11335
>    IO depths    : 1=0.4%, 2=0.9%, 4=5.3%, 8=20.2%, 16=66.0%, 32=7.3%, >=64=0.0%
>       submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
>       complete  : 0=0.0%, 4=95.5%, 8=0.9%, 16=0.9%, 32=2.8%, 64=0.0%, >=64=0.0%
>       issued    : total=r=1635761/w=0/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
>       latency   : target=0, window=0, percentile=100.00%, depth=32
>
> Run status group 0 (all jobs):
>     READ: io=6389.8MB, aggrb=547855KB/s, minb=547855KB/s, maxb=547855KB/s, mint=11943msec, maxt=11943msec
>
>
>
