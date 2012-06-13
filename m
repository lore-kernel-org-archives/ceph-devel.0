From: <Eric_YH_Chen@wiwynn.com>
Subject: Performance benchmark of rbd
Date: Wed, 13 Jun 2012 18:06:11 +0800
Message-ID: <8512670932FB654F81AF0FEF1BE6D49D01838FC3@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from twnhumsw4.wistron.com ([220.128.89.24]:52745 "EHLO
	TWNHUMSW4.wistron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab2FMKGR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jun 2012 06:06:17 -0400
Received: from twnhufe3.whq.wistron (unverified [10.37.31.103]) by TWNHUMSW4.wistron.com
 (Clearswift SMTPRS 5.4.0) with ESMTP id <Ta4f3734590c0a81672fe8@TWNHUMSW4.wistron.com> for <ceph-devel@vger.kernel.org>;
 Wed, 13 Jun 2012 18:10:54 +0800
Content-class: urn:content-classes:message
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi, all:

    I am doing some benchmark of rbd.  
    The platform is on a NAS storage.
 
    CPU: Intel E5640 2.67GHz
    Memory: 192 GB
    Hard Disk: SATA 250G * 1, 7200 rpm (H0) + SATA 1T * 12 , 7200rpm
(H1~ H12)
    RAID Card: LSI 9260-4i
    OS: Ubuntu12.04 with Kernel 3.2.0-24
    Network:  1 Gb/s

    We create 12 OSD on H1 ~ H12 with the journal is put on H0.
    We also create 3 MON in the cluster.
    In briefly, we setup a ceph cluster all-in-one, with 3 monitors and
12 OSD.
    
    The benchmark tool we used is fio 2.0.3. We had 7 basic test case
    1)  sequence write with bs=64k
    2)  sequence read with bs=64k
    3)  random write with bs=4k
    4)  random write with bs=16k
    5)  mix read/write with bs=4k
    6)  mix read/write with bs=8k
    7)  mix read/write with bs=16k

    We create several rbd with different object size for the benchmark.

    1.  size = 20G, object size =  32KB
    2.  size = 20G, object size = 512KB
    3.  size = 20G, object size =  4MB
    4.  size = 20G, object size = 32MB

    We have some conclusion after the benchmark.

    a.  We can get better performance of sequence read/write when the
object size is bigger.
                   Seq-read			Seq-write
        32 KB		23 MB/s			 690 MB/s
       512 KB		26 MB/s			 960 MB/s
         4 MB   	27 MB/s			1290 MB/s
        32 MB		36 MB/s			1435 MB/s

    b. There is no obvious influence for random read/write when the
object size is different. 
      All the result are in a range not more than 10%.

       rand-write-4K		rand-write-16K		mix-4K
mix-8k		mix-16k
       881 iops			564 iops
1462 iops	1127 iops	1044 iops
    
    c. It we change the environment, for every 3 hard drive, we bind
them together by RAID0. (LSI 9260-4i RAID card)
       So the ceph cluster becomes 3 MONs and 4 OSD (3T for each)
       We can get better performance on all items, around 10% ~ 20%
enhancement. 
    
	d. If we change H0 to a SSD device, and we also put all journal
on it. We can get better performance on sequence-write.
      It would reach 135MB/s. However, there are no different for other
test items.

    We want to check with you, if all the conclusion are reasonable for
you? Or any seems strange? Thanks!

    ====

    Here is some data if I use command provided by rados.
	rados -p rbd bench 120 write -t 8

	Total time run:        120.751713
	Total writes made:     930
	Write size:            4194304
	Bandwidth (MB/sec):    30.807

	Average Latency:       1.03807
	Max latency:           2.63197
	Min latency:           0.205726

	[INF] bench: wrote 1024 MB in blocks of 4096 KB in 13.219819 sec
at 79318 KB/sec

