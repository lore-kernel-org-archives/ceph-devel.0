From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: speed decrease since firefly,giant,hammer the 2nd try
Date: Wed, 11 Feb 2015 06:42:21 +0100
Message-ID: <54DAEBBD.30409@profihost.ag>
References: <54DA541E.9000608@profihost.ag> <54DA578F.3000900@redhat.com> <54DA5853.3070504@profihost.ag> <54DA5E9F.3060305@redhat.com> <54DA6904.6000305@profihost.ag> <54DA6BB9.7000306@redhat.com> <54DA7404.4060201@profihost.ag> <54DA7A3F.6070009@redhat.com> <54DA83C8.9020207@profihost.ag> <54DADE52.2010604@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:54493 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbbBKFmU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Feb 2015 00:42:20 -0500
In-Reply-To: <54DADE52.2010604@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


Am 11.02.2015 um 05:45 schrieb Mark Nelson:
> On 02/10/2015 04:18 PM, Stefan Priebe wrote:
>>
>> Am 10.02.2015 um 22:38 schrieb Mark Nelson:
>>> On 02/10/2015 03:11 PM, Stefan Priebe wrote:
>>>>
>>>> mhm i installed librbd1-dbg and librados2-dbg - but the output still
>>>> looks useless to me. Should i upload it somewhere?
>>>
>>> Meh, if it's all just symbols it's probably not that helpful.
>>>
>>> I've summarized your results here:
>>>
>>> 1 concurrent 4k write (libaio, direct=1, iodepth=1)
>>>
>>>          IOPS        Latency
>>>          wb on    wb off    wb on    wb off
>>> dumpling    10870    536    ~100us    ~2ms
>>> firefly        10350    525    ~100us    ~2ms
>>>
>>> So in single op tests dumpling and firefly are far closer.  Now let's
>>> see each of these cases with iodepth=32 (still 1 thread for now).
>>
>>
>> dumpling:
>>
>> file1: (g=0): rw=randwrite, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=32
>> 2.0.8
>> Starting 1 thread
>> Jobs: 1 (f=1): [w] [100.0% done] [0K/72812K /s] [0 /18.3K iops] [eta
>> 00m:00s]
>> file1: (groupid=0, jobs=1): err= 0: pid=3011
>>    write: io=2060.6MB, bw=70329KB/s, iops=17582 , runt= 30001msec
>>      slat (usec): min=1 , max=3517 , avg= 3.42, stdev= 7.30
>>      clat (usec): min=93 , max=7475 , avg=1815.72, stdev=233.43
>>       lat (usec): min=219 , max=7477 , avg=1819.27, stdev=233.52
>>      clat percentiles (usec):
>>       |  1.00th=[ 1480],  5.00th=[ 1576], 10.00th=[ 1608], 20.00th=[
>> 1672],
>>       | 30.00th=[ 1704], 40.00th=[ 1752], 50.00th=[ 1800], 60.00th=[
>> 1832],
>>       | 70.00th=[ 1896], 80.00th=[ 1960], 90.00th=[ 2064], 95.00th=[
>> 2128],
>>       | 99.00th=[ 2352], 99.50th=[ 2448], 99.90th=[ 4704], 99.95th=[
>> 5344],
>>       | 99.99th=[ 7072]
>>      bw (KB/s)  : min=59696, max=77840, per=100.00%, avg=70351.27,
>> stdev=4783.25
>>      lat (usec) : 100=0.01%, 250=0.01%, 500=0.01%, 750=0.01%, 1000=0.53%
>>      lat (msec) : 2=85.02%, 4=14.31%, 10=0.13%
>>    cpu          : usr=1.96%, sys=6.71%, ctx=22791, majf=0, minf=133
>>    IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=100.0%,
>>  >=64=0.0%
>>       submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%,
>>  >=64=0.0%
>>       complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%,
>>  >=64=0.0%
>>       issued    : total=r=0/w=527487/d=0, short=r=0/w=0/d=0
>>
>> Run status group 0 (all jobs):
>>    WRITE: io=2060.6MB, aggrb=70329KB/s, minb=70329KB/s, maxb=70329KB/s,
>> mint=30001msec, maxt=30001msec
>>
>> Disk stats (read/write):
>>    sdb: ios=166/526079, merge=0/0, ticks=24/890120, in_queue=890064,
>> util=98.73%
>>
>> firefly:
>>
>> file1: (g=0): rw=randwrite, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=32
>> 2.0.8
>> Starting 1 thread
>> Jobs: 1 (f=1): [w] [100.0% done] [0K/69096K /s] [0 /17.3K iops] [eta
>> 00m:00s]
>> file1: (groupid=0, jobs=1): err= 0: pid=2982
>>    write: io=1784.9MB, bw=60918KB/s, iops=15229 , runt= 30002msec
>>      slat (usec): min=1 , max=1389 , avg= 3.43, stdev= 5.32
>>      clat (usec): min=117 , max=8235 , avg=2096.88, stdev=396.30
>>       lat (usec): min=540 , max=8258 , avg=2100.43, stdev=396.61
>>      clat percentiles (usec):
>>       |  1.00th=[ 1608],  5.00th=[ 1720], 10.00th=[ 1768], 20.00th=[
>> 1832],
>>       | 30.00th=[ 1896], 40.00th=[ 1944], 50.00th=[ 2008], 60.00th=[
>> 2064],
>>       | 70.00th=[ 2160], 80.00th=[ 2256], 90.00th=[ 2512], 95.00th=[
>> 2896],
>>       | 99.00th=[ 3600], 99.50th=[ 3792], 99.90th=[ 5088], 99.95th=[
>> 6304],
>>       | 99.99th=[ 6752]
>>      bw (KB/s)  : min=36717, max=73712, per=99.94%, avg=60879.92,
>> stdev=8302.27
>>      lat (usec) : 250=0.01%, 750=0.01%
>>      lat (msec) : 2=48.56%, 4=51.18%, 10=0.26%
>>    cpu          : usr=2.03%, sys=5.48%, ctx=20440, majf=0, minf=133
>>    IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=100.0%,
>>  >=64=0.0%
>>       submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%,
>>  >=64=0.0%
>>       complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%,
>>  >=64=0.0%
>>       issued    : total=r=0/w=456918/d=0, short=r=0/w=0/d=0
>>
>> Run status group 0 (all jobs):
>>    WRITE: io=1784.9MB, aggrb=60918KB/s, minb=60918KB/s, maxb=60918KB/s,
>> mint=30002msec, maxt=30002msec
>>
>> Disk stats (read/write):
>>    sdb: ios=166/455574, merge=0/0, ticks=12/897748, in_queue=897696,
>> util=98.96%
>>
>
> Ok, so it looks like as you increase concurrency the effect increases
> (ie contention?).  Does the same thing happen without cache enabled?

here again without rbd cache:

dumpling:
file1: (g=0): rw=randwrite, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=32
2.0.8
Starting 1 thread
Jobs: 1 (f=1): [w] [100.0% done] [0K/83488K /s] [0 /20.9K iops] [eta 
00m:00s]
file1: (groupid=0, jobs=1): err= 0: pid=3000
   write: io=2449.2MB, bw=83583KB/s, iops=20895 , runt= 30005msec
     slat (usec): min=1 , max=975 , avg= 4.50, stdev= 5.25
     clat (usec): min=364 , max=80566 , avg=1525.87, stdev=1194.57
      lat (usec): min=519 , max=80568 , avg=1530.51, stdev=1194.44
     clat percentiles (usec):
      |  1.00th=[  660],  5.00th=[  780], 10.00th=[  876], 20.00th=[ 1032],
      | 30.00th=[ 1144], 40.00th=[ 1240], 50.00th=[ 1304], 60.00th=[ 1384],
      | 70.00th=[ 1480], 80.00th=[ 1640], 90.00th=[ 2096], 95.00th=[ 2960],
      | 99.00th=[ 6816], 99.50th=[ 7840], 99.90th=[11712], 99.95th=[13888],
      | 99.99th=[18816]
     bw (KB/s)  : min=47184, max=95432, per=100.00%, avg=83639.19, 
stdev=7973.92
     lat (usec) : 500=0.01%, 750=3.82%, 1000=14.40%
     lat (msec) : 2=70.57%, 4=7.91%, 10=3.11%, 20=0.17%, 50=0.01%
     lat (msec) : 100=0.01%
   cpu          : usr=3.12%, sys=11.49%, ctx=74951, majf=0, minf=133
   IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=100.0%, 
 >=64=0.0%
      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, 
 >=64=0.0%
      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, 
 >=64=0.0%
      issued    : total=r=0/w=626979/d=0, short=r=0/w=0/d=0

Run status group 0 (all jobs):
   WRITE: io=2449.2MB, aggrb=83583KB/s, minb=83583KB/s, maxb=83583KB/s, 
mint=30005msec, maxt=30005msec

Disk stats (read/write):
   sdb: ios=168/625292, merge=0/0, ticks=144/916096, in_queue=916128, 
util=99.93%


firefly:

  fio --filename=/dev/sdb --direct=1 --rw=randwrite --bs=4k --numjobs=1 
--thread --iodepth=32 --ioengine=libaio --runtime=30 --group_reporting 
--name=file1
file1: (g=0): rw=randwrite, bs=4K-4K/4K-4K, ioengine=libaio, iodepth=32
2.0.8
Starting 1 thread
Jobs: 1 (f=1): [w] [100.0% done] [0K/90044K /s] [0 /22.6K iops] [eta 
00m:00s]
file1: (groupid=0, jobs=1): err= 0: pid=2970
   write: io=2372.9MB, bw=80976KB/s, iops=20244 , runt= 30006msec
     slat (usec): min=1 , max=4047 , avg= 4.36, stdev= 7.17
     clat (usec): min=197 , max=76656 , avg=1575.29, stdev=1165.74
      lat (usec): min=523 , max=76660 , avg=1579.79, stdev=1165.59
     clat percentiles (usec):
      |  1.00th=[  676],  5.00th=[  804], 10.00th=[  916], 20.00th=[ 1096],
      | 30.00th=[ 1224], 40.00th=[ 1304], 50.00th=[ 1384], 60.00th=[ 1448],
      | 70.00th=[ 1544], 80.00th=[ 1704], 90.00th=[ 2128], 95.00th=[ 2736],
      | 99.00th=[ 6752], 99.50th=[ 7904], 99.90th=[12096], 99.95th=[14656],
      | 99.99th=[18560]
     bw (KB/s)  : min=47800, max=91952, per=99.91%, avg=80900.88, 
stdev=7234.98
     lat (usec) : 250=0.01%, 500=0.01%, 750=2.95%, 1000=11.38%
     lat (msec) : 2=73.81%, 4=8.81%, 10=2.85%, 20=0.19%, 50=0.01%
     lat (msec) : 100=0.01%
   cpu          : usr=2.99%, sys=10.60%, ctx=66549, majf=0, minf=133
   IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=100.0%, 
 >=64=0.0%
      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, 
 >=64=0.0%
      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.1%, 64=0.0%, 
 >=64=0.0%
      issued    : total=r=0/w=607445/d=0, short=r=0/w=0/d=0

Run status group 0 (all jobs):
   WRITE: io=2372.9MB, aggrb=80976KB/s, minb=80976KB/s, maxb=80976KB/s, 
mint=30006msec, maxt=30006msec

Disk stats (read/write):
   sdb: ios=170/605440, merge=0/0, ticks=156/916492, in_queue=916560, 
util=99.93%

Stefan

