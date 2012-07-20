From: Dieter Kasper <d.kasper@kabelmail.de>
Subject: Re: Ceph write performance on RAM-DISK
Date: Fri, 20 Jul 2012 22:36:46 +0200
Message-ID: <20120720203646.GA6587@oder.kd-bie.de>
References: <500931CF.9040407@selectel.ru>
 <20120720104150.GA16630@oder.kd-bie.de>
 <50093798.9020903@selectel.ru>
 <500945CA.8000406@inktank.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtpa1.mediabeam.com ([194.25.41.13]:50647 "EHLO
	smtpa2.mediabeam.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173Ab2GTWFs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jul 2012 18:05:48 -0400
Content-Disposition: inline
In-Reply-To: <500945CA.8000406@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: George Shuklin <shuklin@selectel.ru>, ceph-devel@vger.kernel.org, "Dieter Kasper (KD)" <d.kasper@kabelmail.de>


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mark, George,

I can observe a similar (poor) Performance on my system with fio on /dev/rbd1

#--- seq. write RBD
RX37-0:~ # dd if=/dev/zero of=/dev/rbd1 bs=1024k count=10000
10000+0 records in
10000+0 records out
10485760000 bytes (10 GB) copied, 41.1819 s, 255 MB/s

#--- seq. read RBD
RX37-0:~ # dd of=/dev/zero if=/dev/rbd1 bs=1024k count=10000
10000+0 records in
10000+0 records out
10485760000 bytes (10 GB) copied, 40.9595 s, 256 MB/s

#--- seq. read /dev/ramX
RX37-0:~ # dd of=/dev/zero if=/dev/ram0 bs=1024k count=10000
10000+0 records in
10000+0 records out
10485760000 bytes (10 GB) copied, 4.68389 s, 2.2 GB/s

Does ceph-osd/filestore 'eat' 90% of my resources/bandwidth/latency ?


RX37-0:~ # fio --filename=/dev/rbd1 --direct=1 --rw=randwrite --bs=4k --size=5G --numjobs=64 --runtime=30 --group_reporting --name=file1
(...)
  write: io=461592KB, bw=15371KB/s, iops=3842 , runt= 30030msec
  write: io=5120.0MB, bw=893927KB/s, iops=223481 , runt=  5865msec (on /dev/ram0)


RX37-0:~ # fio --filename=/dev/rbd1 --direct=1 --rw=randread --bs=4k --size=5G --numjobs=64 --runtime=30 --group_reporting --name=file1
(...)
  read : io=698356KB, bw=23240KB/s, iops=5809 , runt= 30050msec
  read : io=5120.0MB, bw=1631.1MB/s, iops=417559 , runt=  3139msec (on /dev/ram0)


RX37-0:~ # fio --filename=/dev/rbd1 --direct=1 --rw=randwrite --bs=1m --size=5G --numjobs=4 --runtime=10 --group_reporting --name=file1
(...)
  write: io=6377.0MB, bw=217125KB/s, iops=212 , runt= 30075msec
  write: io=5120.0MB, bw=2114.9MB/s, iops=2114 , runt=  2421msec (on /dev/ram0)


Where is the bottleneck ?
What is filestore doing ?
How can I disable the journal and write only to the btrfs OSDs ? (like as they would be SSDs)
How can I get better performance ?


Regards,
Dieter 

P.S. I will try to get the "test_filestore_workloadgen" 


On Fri, Jul 20, 2012 at 06:49:30AM -0500, Mark Nelson wrote:
> Hi George,
> 
> I think you may find that the limitation is in the the filestore.
> It's one of the things I've been working on trying to track down as
> I've seen low performance on SSDs with small request sizes as well.
> You can use the test_filestore_workloadgen to specifically test the
> filestore code with small requests if you'd like.  I'm not sure if
> it is included with the binary distribution but it can be compiled
> if you download the src.  I think it's "make
> test_filestore_workloadgen" in the src directory.
> 
> Mark
> 
> On 7/20/12 5:48 AM, George Shuklin wrote:
> >On 20.07.2012 14:41, Dieter Kasper (KD) wrote:
> >
> >Good day.
> >
> >Thank you for attention.
> >
> >ramdisk size ~70Gb (modprobe brd rd_size=70000000)
> >journal seems be on same device as storage
> >size of OSD was unchanged (... means I create it by manual and do not
> >make any specific changes)
> >
> >During test I watch IO load closely, IO on MDS/MON was insignificant
> >(most of the time zero, sometimes few very mild peaks).
> >
> >Just in case, configs:
> >
> >ceph.conf:
> >
> >[osd]
> >         osd journal size = 1000
> >         filestore xattr use omap = true
> >
> >[mon.a]
> >         host = srv1
> >         mon addr = 192.168.0.1:6789
> >
> >[osd.0]
> >         host = srv1
> >
> >[mds.a]
> >         host = srv1
> >
> >fio.ini:
> >[test]
> >blocksize=4k
> >filename=/media/test
> >size=16g
> >fallocate=posix
> >rw=randread
> >direct=1
> >buffered=0
> >ioengine=libaio
> >iodepth=32
> >
> >
> >Thanks for advising, I'll recheck with new settings.
> >
> >>George,
> >>
> >>please share more details of your config:
> >>- RAM size of your system
> >>- location of the journal
> >>- size of your OSD
> >>
> >>Can you try (just for the 1st test) to
> >>.. put the journal on RAM disk
> >>.. put the MDS on RAM disk
> >>.. put the MON on RAM disk
> >>.. use btrfs for OSD
> >>
> >>As an alternative to isolate the bottleneck you can try to
> >>- run without a journal
> >>- use RBD instead Ceph-FS
> >>   + create a File System on top of the /dev/rbd0
> >>
> >>Regards,
> >>Dieter Kasper
> >>
> >>
> >>On Fri, Jul 20, 2012 at 12:24:15PM +0200, George Shuklin wrote:
> >>>Good day.
> >>>
> >>>I've start to play with Ceph... And I found some kinda strange
> >>>performance issues. I'm not sure if this is due ceph limitation or my
> >>>bad setup.
> >>>
> >>>Setup:
> >>>
> >>>osd - xfs on ramdisk (only one osd)
> >>>mds - raid0 on 10 disks
> >>>mon - second raid0 on 10 disks
> >>>
> >>>I've mount ceph share at localhost and run FIO (randwrite, 4k,
> >>>iodepth=32)
> >>>
> >>>What I've got: 1900 IOPS on writing (4k block, 1Gb span).
> >>>
> >>>Normally fio shows about 200kIOPS writing on ramdisk.
> >>>
> >>>Why it was so slow? I've  done setup exactly like described here:
> >>>http://ceph.com/docs/master/start/quick-start/#start-the-ceph-cluster
> >>>(but one osd).
> >>>
> >>>Thanks.
> >>>--
> >>>To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>>the body of a message to majordomo@vger.kernel.org
> >>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >--
> >To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ceph.conf"

[global]
        pid file = /var/run/ceph/$name.pid
        debug ms = 0
        auth supported = cephx
        keyring = /etc/ceph/keyring.client
[mon]
        mon data = /tmp/mon$id
[mon.a]
	host = localhost
	mon addr = 127.0.0.1:6789

[osd]
        journal dio = false
        osd data = /data/$name
	osd journal = /mnt/osd.journal/$name/journal
        osd journal size = 1000

        keyring = /etc/ceph/keyring.$name
        # debug osd = 20
        # debug ms = 1         ; message traffic
        # debug filestore = 20 ; local object storage
        # debug journal = 20   ; local journaling
        # debug monc = 5      ; monitor interaction, startup

[osd.0]
	host = localhost
        btrfs devs = /dev/ram0

[osd.1]
	host = localhost
        btrfs devs = /dev/ram1

[osd.2]
	host = localhost
        btrfs devs = /dev/ram2

[mds.a]
	host = localhost

--zYM0uCDKw75PZbzx--

