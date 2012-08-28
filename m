From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: RBD performance with Xen
Date: Tue, 28 Aug 2012 16:47:28 +0200
Message-ID: <CAF6-1L7GyfWFDosavP1=ch8+h=05P0+toJpFZ7OTeSuqQ5cEHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:64907 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807Ab2H1Or3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Aug 2012 10:47:29 -0400
Received: by vcbfk26 with SMTP id fk26so5918036vcb.19
        for <ceph-devel@vger.kernel.org>; Tue, 28 Aug 2012 07:47:28 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,


I'm doing a few tests of using RBD devices as backend for various Xen VMs.

What I'm seeing is a pretty severe performance hit when exposing a
kernel RBD device from the dom0 to a domU.

seq fio in dom0: 74872KB/s
seq fio in domU: 32320KB/s
(raw results below)

This kind of degradation doesn't happen for physical devices. If I
expose a physical disk of the dom0 to the domU, I get pretty much the
same bandwidth results in both.


So something weird is going on in the interactions between the dom0 and ceph ...
Has anyone noticed that as well ?


FYI I'm running a 3.6-rc3 currently in the dom0 for these tests.


Cheers,

    Sylvain



Dom0
---------

root@dom0:~ # fio --filename=/dev/rbd6 --direct=1 --rw=write --bs=4M
--size=1G --iodepth=100 --runtime=120 --group_reporting --name=file1
--ioengine=libaio
file1: (g=0): rw=write, bs=4M-4M/4M-4M, ioengine=libaio, iodepth=100
2.0.8
Starting 1 process
Jobs: 1 (f=0): [W] [100.0% done] [0K/424.0M /s] [0 /106  iops] [eta 00m:00s]
file1: (groupid=0, jobs=1): err= 0: pid=4703
  write: io=1024.0MB, bw=74872KB/s, iops=18 , runt= 14005msec
    slat (usec): min=862 , max=802231 , avg=52528.59, stdev=113945.70
    clat (msec): min=553 , max=7783 , avg=4769.92, stdev=1401.57
     lat (msec): min=555 , max=8115 , avg=4822.45, stdev=1392.79
    clat percentiles (msec):
     |  1.00th=[  562],  5.00th=[ 2057], 10.00th=[ 2802], 20.00th=[ 4146],
     | 30.00th=[ 4424], 40.00th=[ 4621], 50.00th=[ 4817], 60.00th=[ 5080],
     | 70.00th=[ 5473], 80.00th=[ 5735], 90.00th=[ 6456], 95.00th=[ 6849],
     | 99.00th=[ 7767], 99.50th=[ 7767], 99.90th=[ 7767], 99.95th=[ 7767],
     | 99.99th=[ 7767]
    bw (KB/s)  : min= 1014, max=121588, per=83.89%, avg=62808.50, stdev=30786.53
    lat (msec) : 750=2.73%, 2000=1.56%, >=2000=95.70%
  cpu          : usr=0.00%, sys=2.48%, ctx=339, majf=0, minf=22
  IO depths    : 1=0.4%, 2=0.8%, 4=1.6%, 8=3.1%, 16=6.2%, 32=12.5%, >=64=75.4%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.4%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.6%
     issued    : total=r=0/w=256/d=0, short=r=0/w=0/d=0

Run status group 0 (all jobs):
  WRITE: io=1024.0MB, aggrb=74871KB/s, minb=74871KB/s, maxb=74871KB/s,
mint=14005msec, maxt=14005msec

Disk stats (read/write):
  rbd6: ios=83/1857, merge=0/0, ticks=53/1633473, in_queue=1903847, util=95.63%



DomU
---------

root@domU:~ # fio --filename=/dev/xvdb1 --direct=1 --rw=write --bs=4M
--size=1G --iodepth=100 --runtime=120 --group_reporting --name=file1
--ioengine=libaio
file1: (g=0): rw=write, bs=4M-4M/4M-4M, ioengine=libaio, iodepth=100
fio 1.59
Starting 1 process
Jobs: 1 (f=1): [W] [61.1% done] [0K/25140K /s] [0 /5  iops] [eta 00m:21s]
file1: (groupid=0, jobs=1): err= 0: pid=2272
  write: io=1024.0MB, bw=32320KB/s, iops=7 , runt= 32444msec
    slat (usec): min=836 , max=1862.5K, avg=125899.43, stdev=134106.61
    clat (msec): min=208 , max=14294 , avg=10398.79, stdev=3710.14
     lat (msec): min=350 , max=14413 , avg=10524.69, stdev=3706.05
    bw (KB/s) : min=  351, max=47080, per=99.75%, avg=32237.26, stdev=11644.28
  cpu          : usr=0.90%, sys=0.44%, ctx=875, majf=0, minf=21
  IO depths    : 1=0.4%, 2=0.8%, 4=1.6%, 8=3.1%, 16=6.2%, 32=12.5%, >=64=75.4%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.4%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.6%
     issued r/w/d: total=0/256/0, short=0/0/0

     lat (msec): 250=0.39%, 500=0.78%, 750=0.39%, 1000=1.17%, 2000=1.56%
     lat (msec): >=2000=95.70%

Run status group 0 (all jobs):
  WRITE: io=1024.0MB, aggrb=32319KB/s, minb=33095KB/s, maxb=33095KB/s,
mint=32444msec, maxt=32444msec

Disk stats (read/write):
  xvdb1: ios=68/23721, merge=0/0, ticks=52/4563716, in_queue=4589712,
util=97.92%
