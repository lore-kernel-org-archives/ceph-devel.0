From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: RBD Read performance
Date: Thu, 18 Apr 2013 02:04:11 -0500
Message-ID: <516F9AEB.7000706@inktank.com>
References: <516F77FF.4060401@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:46071 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754179Ab3DRHEP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Apr 2013 03:04:15 -0400
Received: by mail-pd0-f175.google.com with SMTP id g10so1338432pdj.20
        for <ceph-devel@vger.kernel.org>; Thu, 18 Apr 2013 00:04:15 -0700 (PDT)
In-Reply-To: <516F77FF.4060401@sgi.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Malcolm Haak <malcolm@sgi.com>
Cc: ceph-devel@vger.kernel.org

On 04/17/2013 11:35 PM, Malcolm Haak wrote:
> Hi all,

Hi Malcolm!

>
> I jumped into the IRC channel yesterday and they said to email
> ceph-devel. I have been having some read performance issues. With Reads
> being slower than writes by a factor of ~5-8.

I recently saw this kind of behaviour (writes were fine, but reads were 
terrible) on an IPoIB based cluster and it was caused by the same TCP 
auto tune issues that Jim Schutt saw last year. It's worth a try at 
least to see if it helps.

echo "0" > /proc/sys/net/ipv4/tcp_moderate_rcvbuf

on all of the clients and server nodes should be enough to test it out. 
  Sage added an option in more recent Ceph builds that lets you work 
around it too.

>
> First info:
> Server
> SLES 11 SP2
> Ceph 0.56.4.
> 12 OSD's  that are Hardware Raid 5 each of the twelve is made from 5
> NL-SAS disks for a total of 60 disks (Each lun can do around 320MB/s
> stream write and the same if not better read) Connected via 2xQDR IB
> OSD's/MDS and such all on same box (for testing)
> Box is a Quad AMD Opteron 6234
> Ram is 256Gb
> 10GB Journals
> osd_op_theads: 8
> osd_disk_threads:2
> Filestore_op_threads:4
> OSD's are all XFS

Interesting setup!  QUAD socket Opteron boxes have somewhat slow and 
slightly oversubscribed hypertransport links don't they?  I wonder if on 
a system with so many disks and QDR-IB if that could become a problem...

We typically like smaller nodes where we can reasonably do 1 OSD per 
drive, but we've tested on a couple of 60 drive chassis in RAID configs 
too.  Should be interesting to hear what kind of aggregate performance 
you can eventually get.

>
> All nodes are connected via QDR IB using IP_O_IB. We get 1.7GB/s on TCP
> performance tests between the nodes.
>
> Clients: One is FC17 the other us Ubuntu 12.10 they only have around
> 32GB-70GB ram.
>
> We ran into an odd issue were the OSD's would all start in the same NUMA
> node and pretty much on the same processor core. We fixed that up with
> some cpuset magic.

Strange!  Was that more due to cpuset or Ceph?  I can't imagine that we 
are doing anything that would cause that.

>
> Performance testing we have done: (Note oflag=direct was yielding
> results within 5% of cached results)
>
>
> root@ty3:~# dd if=/dev/zero of=/test-rbd-fs/DELETEME bs=10M count=3200
> 3200+0 records in
> 3200+0 records out
> 33554432000 bytes (34 GB) copied, 47.6685 s, 704 MB/s
> root@ty3:~#
> root@ty3:~# rm /test-rbd-fs/DELETEME
> root@ty3:~#
> root@ty3:~# dd if=/dev/zero of=/test-rbd-fs/DELETEME bs=10M count=4800
> 4800+0 records in
> 4800+0 records out
> 50331648000 bytes (50 GB) copied, 69.5527 s, 724 MB/s
>
> [root@dogbreath ~]# dd of=/test-rbd-fs/DELETEME if=/dev/zero bs=10M
> count=2400
> 2400+0 records in
> 2400+0 records out
> 25165824000 bytes (25 GB) copied, 26.3593 s, 955 MB/s
> [root@dogbreath ~]# rm -f /test-rbd-fs/DELETEME
> [root@dogbreath ~]# dd of=/test-rbd-fs/DELETEME if=/dev/zero bs=10M
> count=9600
> 9600+0 records in
> 9600+0 records out
> 100663296000 bytes (101 GB) copied, 145.212 s, 693 MB/s
>
> Both clients each doing a 140GB write (2x dogbreath's RAM) at the same
> time to two different rbds in the same pool.
>
> root@ty3:~# rm /test-rbd-fs/DELETEME
> root@ty3:~# dd if=/dev/zero of=/test-rbd-fs/DELETEME bs=10M count=14000
> 14000+0 records in
> 14000+0 records out
> 146800640000 bytes (147 GB) copied, 412.404 s, 356 MB/s
> root@ty3:~#
>
> [root@dogbreath ~]# rm -f /test-rbd-fs/DELETEME
> [root@dogbreath ~]# dd of=/test-rbd-fs/DELETEME if=/dev/zero bs=10M
> count=14000
> 14000+0 records in
> 14000+0 records out
> 146800640000 bytes (147 GB) copied, 433.351 s, 339 MB/s
> [root@dogbreath ~]#
>
> Onto reads...
> Also we found that doing iflag=direct increased read performance.
>
> [root@dogbreath ~]# dd of=/dev/null if=/test-rbd-fs/DELETEME bs=10M
> count=160
> 160+0 records in
> 160+0 records out
> 1677721600 bytes (1.7 GB) copied, 29.4242 s, 57.0 MB/s
> [root@dogbreath ~]#
> [root@dogbreath ~]# echo 1 > /proc/sys/vm/drop_caches
> [root@dogbreath ~]# dd if=/test-rbd-fs/DELETEME of=/dev/null bs=4M
> count=10000
> 10000+0 records in
> 10000+0 records out
> 41943040000 bytes (42 GB) copied, 382.334 s, 110 MB/s
> [root@dogbreath ~]#
> [root@dogbreath ~]# echo 1 > /proc/sys/vm/drop_caches
> [root@dogbreath ~]# dd if=/test-rbd-fs/DELETEME of=/dev/null bs=4M
> count=10000 iflag=direct
> 10000+0 records in
> 10000+0 records out
> 41943040000 bytes (42 GB) copied, 150.774 s, 278 MB/s
> [root@dogbreath ~]#
>
>
> So what info do you want/where do I start hunting for my wumpus?

might also be worth looking at the size of the reads to see if there's a 
lot of fragmentation.  Also, is this kernel rbd or qemu-kvm?

>
> Regards
>
> Malcolm Haak
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

