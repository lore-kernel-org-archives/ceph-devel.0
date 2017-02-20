From: Christian Balzer <chibi@gol.com>
Subject: Re: [ceph-users] Jewel + kernel 4.4 Massive performance regression
 (-50%)
Date: Tue, 21 Feb 2017 08:54:55 +0900
Message-ID: <20170221085455.56a19d84@batzmaru.gol.ad.jp>
References: <14aea50c-f708-1d99-8d61-c79bec2029e0@epfl.ch>
        <CAFonxSwyGOC9OGjEwBOmewhvtH_vBRKxT4eyoTkdFAxJmg6jZw@mail.gmail.com>
        <29443c6d-1a13-477a-6844-6f1b31e86d2d@epfl.ch>
        <CAFonxSzvPTpPsxLvcWame4vLwnJMcbxqsYHXXuO3--Dibt2t-Q@mail.gmail.com>
        <48d7fe00-88cd-4187-e56b-aea73ce6aaf1@epfl.ch>
        <CAN3wisVj7BAjJtDd4mEa4XOOcViz-qs5j71na2e=2c3SCO_HeA@mail.gmail.com>
        <20170220131038.1e8cbb1c@batzmaru.gol.ad.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp11.dentaku.gol.com ([203.216.5.73]:41400 "EHLO
        smtp11.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751238AbdBTXzB (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Feb 2017 18:55:01 -0500
In-Reply-To: <20170220131038.1e8cbb1c@batzmaru.gol.ad.jp>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>
Cc: Kostis Fardelas <dante1234@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>


Hello,


Just a quick update since I didn't have time for this yesterday.

I did a similar test as below with only the XFS node active and as expected
results are opposite:

3937 IOPS 3.16
3595 IOPS 4.9

As opposed to what I found out yesterday:
---
Thus I turned off the XFS node and ran the test again with just the EXT4
node active. And this time 4.9 came out (slightly) ahead:

3645 IOPS 3.16
3970 IOPS 4.9

---

Christian

On Mon, 20 Feb 2017 13:10:38 +0900 Christian Balzer wrote:

> Hello,
> 
> On Thu, 16 Feb 2017 17:51:18 +0200 Kostis Fardelas wrote:
> 
> > Hello,
> > we are on Debian Jessie and Hammer 0.94.9 and recently we decided to
> > upgrade our kernel from 3.16 to 4.9 (jessie-backports). We experience
> > the same regression but with some shiny points  
> 
> Same OS, kernels and Ceph version here, but I can't reproduce this for
> the most part, probably because of other differences.
> 
> 4 nodes, 
> 2 with 4 HDD based and SSD journal OSDs,
> 2 with 4 SSD based OSDs (cache-tier),
> replication 2.
> Half of the nodes/OSDs are using XFS, the other half EXT4.
> 
> > -- ceph tell osd average across the cluster --
> > 3.16.39-1: 204MB/s
> > 4.9.0-0    : 158MB/s
> >   
> The "ceph osd tell bench" is really way too imprecise and all over the
> place for me, but the average of the HDD based OSDs doesn't differ
> noticeably.
> 
> > -- 1 rados bench client 4K 2048 threads avg IOPS --
> > 3.16.39-1: 1604
> > 4.9.0-0    : 451
> >   
> I'd think 32-64 threads will do nicely.
> As discussed on the ML before, this test is also not particular realistic
> when it comes to actual client performance, but still, a data point is a
> data point. 
> 
> And incidentally this is the only test where I can clearly see something
> similar, with 64 threads and 4K:
> 
> 3400 IOPS 3.16
> 2600 IOPS 4.9
> 
> So where you are seeing a 70% reduction, I'm seeing "only" 25% less.
> 
> Which is of course a perfect match for my XFS vs. EXT4 OSD ratio.
> 
> Thus I turned off the XFS node and ran the test again with just the EXT4
> node active. And this time 4.9 came out (slightly) ahead:
> 
> 3645 IOPS 3.16
> 3970 IOPS 4.9
> 
> So this looks like a regression when it comes to CEPH interacting with XFS.
> Probably aggravated by how the "bench" tests work (lots of object
> creation), as opposed to normal usage with existing objects as tested
> below.
> 
> > -- 1 rados bench client 64K 512 threads avg BW MB/s--
> > 3.16.39-1: 78
> > 4.9.0-0    : 31
> >  
> With the default 4MB block size, no relevant difference here again.
> But then again, this creates only a few objects compared to 4KB.
>  
> I've run fio (4M write, 4K write, 4k randwrite) from within a VM against
> the cluster with both kernel versions, no noticeable difference there
> either.
> 
> Just to compare this to the rados bench tests above:
> ---
> root@tvm-01:~# fio --size=18G --ioengine=libaio --invalidate=1 --direct=1 --numjobs=1 --rw=write --name=fiojob --blocksize=4M --iodepth=64
> 
> fiojob: (g=0): rw=write, bs=4M-4M/4M-4M/4M-4M, ioengine=libaio, iodepth=64
> fio-2.1.11
>   write: io=18432MB, bw=359772KB/s, iops=87, runt= 52462msec
> ---
> OSD processes are at about 35% CPU usage (100% = 1 core), SSDs are at about
> 85% utilization. 
> 
> ---
> root@tvm-01:~# fio --size=4G --ioengine=libaio --invalidate=1 --direct=1 --numjobs=1 --rw=write --name=fiojob --blocksize=4K --iodepth=64
> 
> fiojob: (g=0): rw=write, bs=4K-4K/4K-4K/4K-4K, ioengine=libaio, iodepth=64
> fio-2.1.11
>   write: io=4096.0MB, bw=241984KB/s, iops=60495, runt= 17333msec
> ---
> OSD processes are at about 20% CPU  usage, SSDs are at 50%
> utilization.
> 
> ---
> root@tvm-01:~# fio --size=2G --ioengine=libaio --invalidate=1 --direct=1 --numjobs=1 --rw=randwrite --name=fiojob --blocksize=4K --iodepth=64
> 
> fiojob: (g=0): rw=randwrite, bs=4K-4K/4K-4K/4K-4K, ioengine=libaio, iodepth=64
> fio-2.1.11
>   write: io=2048.0MB, bw=36086KB/s, iops=9021, runt= 58115msec
> ---
> OSD processes are at 300% (and likely wanting more) CPU usage, SSDs at
> about 25% utilization
> 
> Christian
> 
> > The shiny points are on the following tests:
> > 1 rados bench client 4K 512 threads avg IOPS
> > 1 rados bench client 64K 2048 threads avg BW MB/s
> > 
> > where machines with kernel 4.9 seem to perform slightly better. The
> > overall impression though is that there is a serious regression or
> > something that should be tuned to get the same performance out of the
> > cluster.
> > 
> > Our demo cluster is 4 nodes X 12 OSDs, separate journal on SSD,
> > firefly tunables and everything else default considering our Ceph
> > installation and Debian OS. Each rados bench run 5 times to get an
> > average and caches were dropped before each test.
> > 
> > I wonder if anyone has discovered the culprit so far? Any hints from
> > others to focus our investigation on?
> > 
> > Best regards,
> > Kostis
> > 
> > On 19 December 2016 at 17:17, Yoann Moulin <yoann.moulin@epfl.ch> wrote:  
> > > Hello,
> > >
> > > Finally, I found time to do some new benchmarks with the latest jewel release (10.2.5) on 4 nodes. Each node has 10 OSDs.
> > >
> > > I ran 2 times "ceph tell osd.* bench" over 40 OSDs, here the average speed :
> > >
> > > 4.2.0-42-generic      97.45 MB/s
> > > 4.4.0-53-generic      55.73 MB/s
> > > 4.8.15-040815-generic 62.41 MB/s
> > > 4.9.0-040900-generic  60.88 MB/s
> > >
> > > I have the same behaviour with at least 35 to 40% performance drop between kernel 4.2 and kernel > 4.4
> > >
> > > I can do further benches if needed.
> > >
> > > Yoann
> > >
> > > Le 26/07/2016 à 09:09, Lomayani S. Laizer a écrit :    
> > >> Hello,
> > >> do you have journal on disk too ?
> > >>
> > >> Yes am having journal on same hard disk.
> > >>
> > >> ok and could you do bench with kernel 4.2 ? just to see if you have better
> > >> throughput. Thanks
> > >>
> > >> In ubuntu 14 I was running 4.2 kernel. the throughput was the same around 80-90MB/s per osd. I cant tell the difference because each test gives
> > >> the speeds on same range. I did not test kernel 4.4 in ubuntu 14
> > >>
> > >>
> > >> --
> > >> Lomayani
> > >>
> > >> On Tue, Jul 26, 2016 at 9:39 AM, Yoann Moulin <yoann.moulin@epfl.ch <mailto:yoann.moulin@epfl.ch>> wrote:
> > >>
> > >>     Hello,
> > >>    
> > >>     > Am running ubuntu 16 with kernel 4.4-0.31-generic and my speed are similar.    
> > >>
> > >>     do you have journal on disk too ?
> > >>    
> > >>     > I did tests on ubuntu 14 and Ubuntu 16 and the speed is similar. I have around
> > >>     > 80-90MB/s of OSD speeds in both operating systems    
> > >>
> > >>     ok and could you do bench with kernel 4.2 ? just to see if you have better
> > >>     throughput. Thanks
> > >>    
> > >>     > Only issue am observing now with ubuntu 16 is sometime osd fails on rebooting
> > >>     > until i start them manually or adding starting commands in rc.local.    
> > >>
> > >>     in my case, it's a test environment, so I don't have notice those behaviours
> > >>
> > >>     --
> > >>     Yoann
> > >>    
> > >>     > On Mon, Jul 25, 2016 at 6:45 PM, Yoann Moulin <yoann.moulin@epfl.ch <mailto:yoann.moulin@epfl.ch>
> > >>     > <mailto:yoann.moulin@epfl.ch <mailto:yoann.moulin@epfl.ch>>> wrote:
> > >>     >
> > >>     >     Hello,
> > >>     >
> > >>     >     (this is a repost, my previous message seems to be slipping under the radar)
> > >>     >
> > >>     >     Does anyone get a similar behaviour to the one described below ?
> > >>     >
> > >>     >     I found a big performance drop between kernel 3.13.0-88 (default kernel on
> > >>     >     Ubuntu Trusty 14.04) or kernel 4.2.0 and kernel 4.4.0.24.14 (default kernel on
> > >>     >     Ubuntu Xenial 16.04)
> > >>     >
> > >>     >     - ceph version is Jewel (10.2.2).
> > >>     >     - All tests have been done under Ubuntu 14.04 on
> > >>     >     - Each cluster has 5 nodes strictly identical.
> > >>     >     - Each node has 10 OSDs.
> > >>     >     - Journals are on the disk.
> > >>     >
> > >>     >     Kernel 4.4 has a drop of more than 50% compared to 4.2
> > >>     >     Kernel 4.4 has a drop of 40% compared to 3.13
> > >>     >
> > >>     >     details below :
> > >>     >
> > >>     >     With the 3 kernel I have the same performance on disks :
> > >>     >
> > >>     >     Raw benchmark:
> > >>     >     dd if=/dev/zero of=/dev/sdX bs=1M count=1024 oflag=direct    => average ~230MB/s
> > >>     >     dd if=/dev/zero of=/dev/sdX bs=1G count=1 oflag=direct       => average ~220MB/s
> > >>     >
> > >>     >     Filesystem mounted benchmark:
> > >>     >     dd if=/dev/zero of=/sdX1/test.img bs=1G count=1              => average ~205MB/s
> > >>     >     dd if=/dev/zero of=/sdX1/test.img bs=1G count=1 oflag=direct => average ~214MB/s
> > >>     >     dd if=/dev/zero of=/sdX1/test.img bs=1G count=1 oflag=sync   => average ~190MB/s
> > >>     >
> > >>     >     Ceph osd Benchmark:
> > >>     >     Kernel 3.13.0-88-generic : ceph tell osd.ID bench => average  ~81MB/s
> > >>     >     Kernel 4.2.0-38-generic  : ceph tell osd.ID bench => average ~109MB/s
> > >>     >     Kernel 4.4.0-24-generic  : ceph tell osd.ID bench => average  ~50MB/s
> > >>     >
> > >>     >     I did new benchmarks then on 3 new fresh clusters.
> > >>     >
> > >>     >     - Each cluster has 3 nodes strictly identical.
> > >>     >     - Each node has 10 OSDs.
> > >>     >     - Journals are on the disk.
> > >>     >
> > >>     >     bench5 : Ubuntu 14.04 / Ceph Infernalis
> > >>     >     bench6 : Ubuntu 14.04 / Ceph Jewel
> > >>     >     bench7 : Ubuntu 16.04 / Ceph jewel
> > >>     >
> > >>     >     this is the average of 2 runs of "ceph tell osd.* bench" on each cluster (2 x 30
> > >>     >     OSDs)
> > >>     >
> > >>     >     bench5 / 14.04 / Infernalis / kernel 3.13 :  54.35 MB/s
> > >>     >     bench6 / 14.04 / Jewel      / kernel 3.13 :  86.47 MB/s
> > >>     >
> > >>     >     bench5 / 14.04 / Infernalis / kernel 4.2  :  63.38 MB/s
> > >>     >     bench6 / 14.04 / Jewel      / kernel 4.2  : 107.75 MB/s
> > >>     >     bench7 / 16.04 / Jewel      / kernel 4.2  : 101.54 MB/s
> > >>     >
> > >>     >     bench5 / 14.04 / Infernalis / kernel 4.4  :  53.61 MB/s
> > >>     >     bench6 / 14.04 / Jewel      / kernel 4.4  :  65.82 MB/s
> > >>     >     bench7 / 16.04 / Jewel      / kernel 4.4  :  61.57 MB/s
> > >>     >
> > >>     >     If needed, I have the raw output of "ceph tell osd.* bench"
> > >>     >
> > >>     >     Best regards    
> > >>
> > >>    
> > >
> > >
> > > --
> > > Yoann Moulin
> > > EPFL IC-IT
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html    
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users@lists.ceph.com
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com  
> 
> 


-- 
Christian Balzer        Network/Systems Engineer                
chibi@gol.com   	Global OnLine Japan/Rakuten Communications
http://www.gol.com/
