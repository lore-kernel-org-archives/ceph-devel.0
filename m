From: <Eric_YH_Chen@wiwynn.com>
Subject: RE: Performance benchmark of rbd
Date: Tue, 19 Jun 2012 09:12:28 +0800
Message-ID: <8512670932FB654F81AF0FEF1BE6D49D01885BDB@WHQBEMAIL1.whq.wistron>
References: <8512670932FB654F81AF0FEF1BE6D49D01838FC3@WHQBEMAIL1.whq.wistron> <4FD887B1.2070202@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from twnhumsw5.wistron.com ([220.128.89.25]:61989 "EHLO
	TWNHUMSW5.wistron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753511Ab2FSBMa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 21:12:30 -0400
Content-class: urn:content-classes:message
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: mark.nelson@inktank.com, ceph-devel@vger.kernel.org
Cc: Chris_YT_Huang@wiwynn.com, Victor_CY_Chang@wiwynn.com

Hi, Mark and all:

I think you may miss this mail before, so I send it again. 

======

I forget to mention one thing, I create the rbd at the same machine and
test it. That means the network latency may be lower than normal case.

1. 
I use ext4 as the backend filesystem and with following attribute.
data=writeback,noatime,nodiratime,user_xattr

2. 
I use the default replication number, I think it is 2, right?

3. 
On my platform, I have 192GB memory

4. Sorry about the column name is left-right reversal. Here is the
correct one
                    Seq-write		 Seq-read
          32 KB		23 MB/s			 690 MB/s
         512 KB		26 MB/s			 960 MB/s
           4 MB   	27 MB/s			1290 MB/s
          32 MB		36 MB/s			1435 MB/s

5. If I put all the journal data on a SSD device (Intel 520). 
  The sequence write performance would reach 135MB/s instead of
  27MB/s in original. (object size = 4MB). And others are no different,
  including random-write. I am curious why the SSD device doesn't 
  help the performance of random-write.

6. For the random read write, the data I provided before was correct.
  But I can give you the detail. Is it too high than what you expected?
  
rand-write-4k		rand-write-16k
bw		iops		bw		iops
3,524 	881 	9,032 	564

mix-4k (50/50)		
r:bw		r:iops	w:bw	w:iops
2,925 	731 	2,924 	731

mix-8k (50/50)		
r:bw		r:iops	w:bw	w:iops
4,509 	563 	4,509 	563

mix-16k (50/50)		
r:bw		r:iops	w:bw	w:iops
8,366 	522 	8,345 	521


7. 
Here is the hw raid cache policy we used now.
Write Policy	Write Back with BBU
Read Policy	ReadAhead

If you are interested in how HW raid help the performance, I can do for
little help, since we also want to know what is the best configuration
on our platform. Any test you want to know?


Furthermore, is there any suggestion for our platform that can improve
the performance? Thanks!



-----Original Message-----
From: Mark Nelson [mailto:mark.nelson@inktank.com] 
Sent: Wednesday, June 13, 2012 8:30 PM
To: Eric YH Chen/WYHQ/Wiwynn
Cc: ceph-devel@vger.kernel.org
Subject: Re: Performance benchmark of rbd

Hi Eric!

On 6/13/12 5:06 AM, Eric_YH_Chen@wiwynn.com wrote:
> Hi, all:
>
>      I am doing some benchmark of rbd.
>      The platform is on a NAS storage.
>
>      CPU: Intel E5640 2.67GHz
>      Memory: 192 GB
>      Hard Disk: SATA 250G * 1, 7200 rpm (H0) + SATA 1T * 12 , 7200rpm
> (H1~ H12)
>      RAID Card: LSI 9260-4i
>      OS: Ubuntu12.04 with Kernel 3.2.0-24
>      Network:  1 Gb/s
>
>      We create 12 OSD on H1 ~ H12 with the journal is put on H0.

Just to make sure I understand, you have a single node with 12 OSDs and 
3 mons, and all 12 OSDs are using the H0 disk for their journals?  What 
filesystem are you using for the OSDs?  How much replication?

>      We also create 3 MON in the cluster.
>      In briefly, we setup a ceph cluster all-in-one, with 3 monitors
and
> 12 OSD.
>
>      The benchmark tool we used is fio 2.0.3. We had 7 basic test case
>      1)  sequence write with bs=64k
>      2)  sequence read with bs=64k
>      3)  random write with bs=4k
>      4)  random write with bs=16k
>      5)  mix read/write with bs=4k
>      6)  mix read/write with bs=8k
>      7)  mix read/write with bs=16k
>
>      We create several rbd with different object size for the
benchmark.
>
>      1.  size = 20G, object size =  32KB
>      2.  size = 20G, object size = 512KB
>      3.  size = 20G, object size =  4MB
>      4.  size = 20G, object size = 32MB

Given how much memory you have, you may want to increase the amount of 
data you are writing during each test to rule out caching.

>
>      We have some conclusion after the benchmark.
>
>      a.  We can get better performance of sequence read/write when the
> object size is bigger.
>                     Seq-read			Seq-write
>          32 KB		23 MB/s			 690 MB/s
>         512 KB		26 MB/s			 960 MB/s
>           4 MB   	27 MB/s			1290 MB/s
>          32 MB		36 MB/s			1435 MB/s

Which test are these results from?  I'm suspicious that the write 
numbers are so high.  Figure that even with a local client and 1X 
replication, your journals and data partitions are each writing out a 
copy of the data.  You don't have enough disk in that box to sustain 
1.4GB/s to both even under perfectly ideal conditions.  Given that it 
sounds like you are using a single 7200rpm disk for 12 journals, I would

expect far lower numbers...

>
>      b. There is no obvious influence for random read/write when the
> object size is different.
>        All the result are in a range not more than 10%.
>
>         rand-write-4K		rand-write-16K		mix-4K
> mix-8k		mix-16k
>         881 iops			564 iops
> 1462 iops	1127 iops	1044 iops
>
>      c. It we change the environment, for every 3 hard drive, we bind
> them together by RAID0. (LSI 9260-4i RAID card)
>         So the ceph cluster becomes 3 MONs and 4 OSD (3T for each)
>         We can get better performance on all items, around 10% ~ 20%
> enhancement.

Those IOPs numbers are more what I would expect.  Using HW raid0 may 
provide some benefit depending on the number of OSDs per node.  It's 
something we haven't had time to look at yet in detail, but is on our
list.

>
> 	d. If we change H0 to a SSD device, and we also put all journal
> on it. We can get better performance on sequence-write.
>        It would reach 135MB/s. However, there are no different for
other
> test items.
>
>      We want to check with you, if all the conclusion are reasonable
for
> you? Or any seems strange? Thanks!

When you say that using an SSD device increases the sequence-write 
speeds to 135MB/s, what are you comparing that to?  Incidentally that 
level of performance is entirely believable with 12 OSDs sharing a 
single SSD for journals.

The write results with the 7200rpm journal disk do look strange to me, 
but it's tough to say what's going on.  If the numbers are accurate, I'd

say writes aren't getting to the disks.  If they are mislabeled (IE 
1.435MB/s or 1435Mb/s instead 1435MB/s), then things are more believable

and I'd try putting your journals on a small partition on each disk 
(causes some extra seek behavior and lower OSD throughput, but better 
than stacking the journals up on a single slow disk).

>
>      ====
>
>      Here is some data if I use command provided by rados.
> 	rados -p rbd bench 120 write -t 8
>
> 	Total time run:        120.751713
> 	Total writes made:     930
> 	Write size:            4194304
> 	Bandwidth (MB/sec):    30.807
>
> 	Average Latency:       1.03807
> 	Max latency:           2.63197
> 	Min latency:           0.205726
>
> 	[INF] bench: wrote 1024 MB in blocks of 4096 KB in 13.219819 sec
> at 79318 KB/sec

That looks much closer to what I would expect if you have 12 journals 
all sharing a single 7200rpm drive.

>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Mark
