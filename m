From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: RBD fio Performance concerns
Date: Mon, 19 Nov 2012 22:01:19 +0100
Message-ID: <CAOLwVU=DtgQLm8Gu_gTNaLSQGmNJStFWTA4FHpCm_91WBsXmJg@mail.gmail.com>
References: <CAOLwVUknn4hH20P+iRbrqeNTQbFxcVFqWo=ZUM5-RQTNgqyWSQ@mail.gmail.com>
 <d4bdfae3-9a87-4815-994f-cfc20be355a7@mailpro> <CAOLwVU=ed5fdg96Nk7gvvJqdK5vpnweZ7zJTGYVWcYikqY_j1Q@mail.gmail.com>
 <50AA6457.1060809@inktank.com> <CAOLwVUmJGZNaZsySsw8eQmLy1ZCha+AAGCp-5i42=mr0aKHMyA@mail.gmail.com>
 <50AA763A.1050709@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:34819 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756Ab2KSVBl convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Nov 2012 16:01:41 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so1442964lag.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Nov 2012 13:01:39 -0800 (PST)
In-Reply-To: <50AA763A.1050709@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kampe <mark.kampe@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hello Mark,

See below my benchmarks results:

-RADOS Bench with 4M block size write:

# rados -p bench bench 300 write -t 32 --no-cleanup
Maintaining 32 concurrent writes of 4194304 bytes for at least 300 seco=
nds.

2012-11-19 21:35:01.722143min lat: 0.255396 max lat: 8.40212 avg lat: 1=
=2E14076
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg =
lat
   300      32      8414      8382   111.737       104  0.502774   1.14=
076
 Total time run:         300.814954
Total writes made:      8414
Write size:             4194304
Bandwidth (MB/sec):     111.883

Stddev Bandwidth:       7.4274
Max bandwidth (MB/sec): 132
Min bandwidth (MB/sec): 56
Average Latency:        1.14352
Stddev Latency:         1.18344
Max latency:            8.40212
Min latency:            0.255396



-RADOS Bench with 4M block size seq:

# rados -p bench bench 300 seq -t 32 --no-cleanup

2012-11-19 21:40:35.128728min lat: 0.224415 max lat: 6.14781 avg lat: 1=
=2E1591
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg =
lat
   300      31      8284      8253   110.021       108   1.87698    1.1=
591
 Total time run:        300.931287
Total reads made:     8285
Read size:            4194304
Bandwidth (MB/sec):    110.125

Average Latency:       1.16177
Max latency:           6.14781
Min latency:           0.224415


-RBD FIO test, as you recommend I used 4M block size for seq tests for
the first test. See below the fio configuration file used:

[global]
ioengine=3Dlibaio
iodepth=3D4
size=3D1G
runtime=3D60
filename=3D/dev/rbd1

[seq-read]
rw=3Dread
bs=3D4M
stonewall
direct=3D1

[rand-read]
rw=3Drandread
bs=3D4K
stonewall
direct=3D1

[seq-write]
rw=3Dwrite
bs=3D4M
stonewall
direct=3D1

[rand-write]
rw=3Drandwrite
bs=3D4K
stonewall
direct=3D1


Results iodepth 4 and 1G file:

# fio rbd-bench.fio
seq-read: (g=3D0): rw=3Dread, bs=3D4M-4M/4M-4M, ioengine=3Dlibaio, iode=
pth=3D4
rand-read: (g=3D1): rw=3Drandread, bs=3D4K-4K/4K-4K, ioengine=3Dlibaio,=
 iodepth=3D4
seq-write: (g=3D2): rw=3Dwrite, bs=3D4M-4M/4M-4M, ioengine=3Dlibaio, io=
depth=3D4
rand-write: (g=3D3): rw=3Drandwrite, bs=3D4K-4K/4K-4K, ioengine=3Dlibai=
o, iodepth=3D4
fio 1.59
Starting 4 processes
Jobs: 1 (f=3D1): [___w] [64.2% done] [0K/2588K /s] [0 /632  iops] [eta =
01m:18s]
seq-read: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D10586
  read : io=3D1024.0MB, bw=3D110656KB/s, iops=3D27 , runt=3D  9476msec
    slat (usec): min=3D250 , max=3D1812 , avg=3D389.88, stdev=3D178.26
    clat (msec): min=3D37 , max=3D615 , avg=3D147.42, stdev=3D102.77
     lat (msec): min=3D38 , max=3D615 , avg=3D147.81, stdev=3D102.77
    bw (KB/s) : min=3D84216, max=3D122390, per=3D99.60%, avg=3D110208.5=
0, stdev=3D9149.98
  cpu          : usr=3D0.00%, sys=3D0.97%, ctx=3D1552, majf=3D0, minf=3D=
4119
  IO depths    : 1=3D0.4%, 2=3D0.8%, 4=3D98.8%, 8=3D0.0%, 16=3D0.0%, 32=
=3D0.0%, >=3D64=3D0.0%
     submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%, >=3D64=3D0.0%
     complete  : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%, >=3D64=3D0.0%
     issued r/w/d: total=3D256/0/0, short=3D0/0/0

     lat (msec): 50=3D4.69%, 100=3D31.64%, 250=3D50.78%, 500=3D11.72%, =
750=3D1.17%
rand-read: (groupid=3D1, jobs=3D1): err=3D 0: pid=3D10868
  read : io=3D161972KB, bw=3D2697.1KB/s, iops=3D674 , runt=3D 60036msec
    slat (usec): min=3D12 , max=3D346 , avg=3D39.89, stdev=3D10.04
    clat (usec): min=3D570 , max=3D50215 , avg=3D5885.64, stdev=3D12119=
=2E46
     lat (usec): min=3D601 , max=3D50258 , avg=3D5926.07, stdev=3D12117=
=2E44
    bw (KB/s) : min=3D 2015, max=3D 3356, per=3D100.15%, avg=3D2701.03,=
 stdev=3D276.41
  cpu          : usr=3D0.51%, sys=3D2.14%, ctx=3D66054, majf=3D0, minf=3D=
26
  IO depths    : 1=3D0.1%, 2=3D0.1%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 3=
2=3D0.0%, >=3D64=3D0.0%
     submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%, >=3D64=3D0.0%
     complete  : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%, >=3D64=3D0.0%
     issued r/w/d: total=3D40493/0/0, short=3D0/0/0
     lat (usec): 750=3D3.69%, 1000=3D60.21%
     lat (msec): 2=3D19.37%, 4=3D1.49%, 10=3D1.30%, 20=3D0.30%, 50=3D13=
=2E64%
     lat (msec): 100=3D0.01%
seq-write: (groupid=3D2, jobs=3D1): err=3D 0: pid=3D12619
  write: io=3D1024.0MB, bw=3D112412KB/s, iops=3D27 , runt=3D  9328msec
    slat (usec): min=3D510 , max=3D1683 , avg=3D820.63, stdev=3D150.32
    clat (msec): min=3D47 , max=3D744 , avg=3D144.21, stdev=3D73.99
     lat (msec): min=3D48 , max=3D744 , avg=3D145.03, stdev=3D74.00
    bw (KB/s) : min=3D103193, max=3D124830, per=3D100.87%, avg=3D113390=
=2E71,
stdev=3D6178.93
  cpu          : usr=3D1.46%, sys=3D0.81%, ctx=3D267, majf=3D0, minf=3D=
21
  IO depths    : 1=3D0.4%, 2=3D0.8%, 4=3D98.8%, 8=3D0.0%, 16=3D0.0%, 32=
=3D0.0%, >=3D64=3D0.0%
     submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%, >=3D64=3D0.0%
     complete  : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%, >=3D64=3D0.0%
     issued r/w/d: total=3D0/256/0, short=3D0/0/0

     lat (msec): 50=3D0.78%, 100=3D17.97%, 250=3D75.39%, 500=3D5.08%, 7=
50=3D0.78%
rand-write: (groupid=3D3, jobs=3D1): err=3D 0: pid=3D12934
  write: io=3D125352KB, bw=3D2088.1KB/s, iops=3D522 , runt=3D 60007msec
    slat (usec): min=3D13 , max=3D388 , avg=3D50.47, stdev=3D13.73
    clat (msec): min=3D1 , max=3D1271 , avg=3D 7.60, stdev=3D22.16
     lat (msec): min=3D1 , max=3D1271 , avg=3D 7.66, stdev=3D22.16
    bw (KB/s) : min=3D  155, max=3D 2944, per=3D102.13%, avg=3D2132.45,=
 stdev=3D563.22
  cpu          : usr=3D0.45%, sys=3D1.87%, ctx=3D51594, majf=3D0, minf=3D=
19
  IO depths    : 1=3D0.1%, 2=3D0.1%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 3=
2=3D0.0%, >=3D64=3D0.0%
     submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%, >=3D64=3D0.0%
     complete  : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%, >=3D64=3D0.0%
     issued r/w/d: total=3D0/31338/0, short=3D0/0/0

     lat (msec): 2=3D5.84%, 4=3D59.28%, 10=3D12.47%, 20=3D15.83%, 50=3D=
5.72%
     lat (msec): 100=3D0.30%, 250=3D0.44%, 500=3D0.07%, 750=3D0.02%, 10=
00=3D0.02%
     lat (msec): 2000=3D0.01%

Run status group 0 (all jobs):
   READ: io=3D1024.0MB, aggrb=3D110655KB/s, minb=3D113311KB/s,
maxb=3D113311KB/s, mint=3D9476msec, maxt=3D9476msec

Run status group 1 (all jobs):
   READ: io=3D161972KB, aggrb=3D2697KB/s, minb=3D2762KB/s, maxb=3D2762K=
B/s,
mint=3D60036msec, maxt=3D60036msec

Run status group 2 (all jobs):
  WRITE: io=3D1024.0MB, aggrb=3D112411KB/s, minb=3D115109KB/s,
maxb=3D115109KB/s, mint=3D9328msec, maxt=3D9328msec

Run status group 3 (all jobs):
  WRITE: io=3D125352KB, aggrb=3D2088KB/s, minb=3D2139KB/s, maxb=3D2139K=
B/s,
mint=3D60007msec, maxt=3D60007msec

Disk stats (read/write):
  rbd1: ios=3D42707/33325, merge=3D0/0, ticks=3D439568/438892,
in_queue=3D878724, util=3D99.57%

With an iodepth of 64 and 10G file:

seq-read: (g=3D0): rw=3Dread, bs=3D4M-4M/4M-4M, ioengine=3Dlibaio, iode=
pth=3D64
rand-read: (g=3D1): rw=3Drandread, bs=3D4K-4K/4K-4K, ioengine=3Dlibaio,=
 iodepth=3D64
seq-write: (g=3D2): rw=3Dwrite, bs=3D4M-4M/4M-4M, ioengine=3Dlibaio, io=
depth=3D64
rand-write: (g=3D3): rw=3Drandwrite, bs=3D4K-4K/4K-4K, ioengine=3Dlibai=
o, iodepth=3D64
fio 1.59
Starting 4 processes
Jobs: 1 (f=3D1): [___w] [58.1% done] [0K/0K /s] [0 /0  iops] [eta 02m:5=
7s]
seq-read: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D25257
  read : io=3D6564.0MB, bw=3D110816KB/s, iops=3D27 , runt=3D 60655msec
    slat (usec): min=3D204 , max=3D287661 , avg=3D36605.14, stdev=3D639=
84.12
    clat (msec): min=3D573 , max=3D5910 , avg=3D2305.13, stdev=3D715.03
     lat (msec): min=3D712 , max=3D5938 , avg=3D2341.74, stdev=3D716.44
    bw (KB/s) : min=3D    0, max=3D116819, per=3D61.34%, avg=3D67975.54=
, stdev=3D54174.75
  cpu          : usr=3D0.00%, sys=3D1.08%, ctx=3D10644, majf=3D0, minf=3D=
65559
  IO depths    : 1=3D0.1%, 2=3D0.1%, 4=3D0.2%, 8=3D0.5%, 16=3D1.0%, 32=3D=
2.0%, >=3D64=3D96.2%
     submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%, >=3D64=3D0.0%
     complete  : 0=3D0.0%, 4=3D99.9%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 6=
4=3D0.1%, >=3D64=3D0.0%
     issued r/w/d: total=3D1641/0/0, short=3D0/0/0

     lat (msec): 750=3D0.30%, 1000=3D0.37%, 2000=3D41.13%, >=3D2000=3D5=
8.20%
rand-read: (groupid=3D1, jobs=3D1): err=3D 0: pid=3D27045
  read : io=3D6170.6MB, bw=3D105242KB/s, iops=3D26310 , runt=3D 60039ms=
ec
    slat (usec): min=3D9 , max=3D2456 , avg=3D26.68, stdev=3D 9.23
    clat (usec): min=3D501 , max=3D42630 , avg=3D2403.11, stdev=3D1136.=
11
     lat (usec): min=3D544 , max=3D42654 , avg=3D2430.20, stdev=3D1135.=
87
    bw (KB/s) : min=3D    0, max=3D107376, per=3D65.94%, avg=3D69395.09=
, stdev=3D50034.68
  cpu          : usr=3D9.62%, sys=3D53.77%, ctx=3D1804080, majf=3D0, mi=
nf=3D86
  IO depths    : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D=
0.1%, >=3D64=3D100.0%
     submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%, >=3D64=3D0.0%
     complete  : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.1%, >=3D64=3D0.0%
     issued r/w/d: total=3D1579662/0/0, short=3D0/0/0
     lat (usec): 750=3D0.34%, 1000=3D2.07%
     lat (msec): 2=3D38.96%, 4=3D51.17%, 10=3D7.37%, 20=3D0.08%, 50=3D0=
=2E01%
seq-write: (groupid=3D2, jobs=3D1): err=3D 0: pid=3D28845
  write: io=3D6776.0MB, bw=3D114538KB/s, iops=3D27 , runt=3D 60579msec
    slat (usec): min=3D419 , max=3D237721 , avg=3D35415.33, stdev=3D606=
35.70
    clat (msec): min=3D572 , max=3D6468 , avg=3D2229.49, stdev=3D935.01
     lat (msec): min=3D695 , max=3D6469 , avg=3D2264.91, stdev=3D931.13
    bw (KB/s) : min=3D    0, max=3D136533, per=3D61.73%, avg=3D70705.08=
, stdev=3D56037.47
  cpu          : usr=3D1.96%, sys=3D0.75%, ctx=3D623, majf=3D0, minf=3D=
21
  IO depths    : 1=3D0.1%, 2=3D0.1%, 4=3D0.2%, 8=3D0.5%, 16=3D0.9%, 32=3D=
1.9%, >=3D64=3D96.3%
     submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%, >=3D64=3D0.0%
     complete  : 0=3D0.0%, 4=3D99.9%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 6=
4=3D0.1%, >=3D64=3D0.0%
     issued r/w/d: total=3D0/1694/0, short=3D0/0/0

     lat (msec): 750=3D0.30%, 1000=3D0.47%, 2000=3D63.64%, >=3D2000=3D3=
5.60%
rand-write: (groupid=3D3, jobs=3D1): err=3D 0: pid=3D30722
  write: io=3D203724KB, bw=3D3250.5KB/s, iops=3D812 , runt=3D 62675msec
    slat (usec): min=3D12 , max=3D589 , avg=3D50.66, stdev=3D12.44
    clat (msec): min=3D1 , max=3D3603 , avg=3D78.65, stdev=3D242.01
     lat (msec): min=3D1 , max=3D3603 , avg=3D78.70, stdev=3D242.01
    bw (KB/s) : min=3D    0, max=3D 7001, per=3D70.93%, avg=3D2305.36, =
stdev=3D2413.85
  cpu          : usr=3D0.59%, sys=3D2.66%, ctx=3D81900, majf=3D0, minf=3D=
19
  IO depths    : 1=3D0.1%, 2=3D0.1%, 4=3D0.1%, 8=3D0.1%, 16=3D0.1%, 32=3D=
0.1%, >=3D64=3D99.9%
     submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%, >=3D64=3D0.0%
     complete  : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.1%, >=3D64=3D0.0%
     issued r/w/d: total=3D0/50931/0, short=3D0/0/0

     lat (msec): 2=3D9.94%, 4=3D34.46%, 10=3D6.95%, 20=3D11.34%, 50=3D1=
4.86%
     lat (msec): 100=3D7.69%, 250=3D7.06%, 500=3D3.90%, 750=3D1.59%, 10=
00=3D0.73%
     lat (msec): 2000=3D1.15%, >=3D2000=3D0.33%

Run status group 0 (all jobs):
   READ: io=3D6564.0MB, aggrb=3D110815KB/s, minb=3D113475KB/s,
maxb=3D113475KB/s, mint=3D60655msec, maxt=3D60655msec

Run status group 1 (all jobs):
   READ: io=3D6170.6MB, aggrb=3D105242KB/s, minb=3D107768KB/s,
maxb=3D107768KB/s, mint=3D60039msec, maxt=3D60039msec

Run status group 2 (all jobs):
  WRITE: io=3D6776.0MB, aggrb=3D114538KB/s, minb=3D117287KB/s,
maxb=3D117287KB/s, mint=3D60579msec, maxt=3D60579msec

Run status group 3 (all jobs):
  WRITE: io=3D203724KB, aggrb=3D3250KB/s, minb=3D3328KB/s, maxb=3D3328K=
B/s,
mint=3D62675msec, maxt=3D62675msec

Disk stats (read/write):
  rbd1: ios=3D1592951/64482, merge=3D0/0, ticks=3D12415028/12528984,
in_queue=3D24945216, util=3D99.68%


Thank you in advance.


On Mon, Nov 19, 2012 at 7:11 PM, Mark Kampe <mark.kampe@inktank.com> wr=
ote:
>
>
> On 11/19/2012 10:03 AM, S=E9bastien Han wrote:
>
>> The original benchmark has been performed with 4M block size. And as
>> you can see I still get more IOPS with rand than seq... I just tried
>> with 4M without direct I/O, still the same. I can print fio results =
if
>> it's needed.
>
>
> Yes, please send me your 4M random and sequential write results
> both radosbench (or better smalliobench, which is more directly
> comparable) and fio to an RBD.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
