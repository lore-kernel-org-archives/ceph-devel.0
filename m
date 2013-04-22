From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: RBD Read performance
Date: Mon, 22 Apr 2013 07:40:59 +0200
Message-ID: <610A9782-9E51-47DB-AA07-E0FF9CFD8F91@profihost.ag>
References: <516F77FF.4060401@sgi.com> <516F9AEB.7000706@inktank.com> <516F9F35.1030507@sgi.com> <51708F80.8090803@sgi.com> <51709278.8050602@inktank.com> <5170AA1E.10506@sgi.com> <517473AC.6070302@sgi.com> <51747C57.50909@inktank.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:45569 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867Ab3DVFlF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 01:41:05 -0400
In-Reply-To: <51747C57.50909@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Malcolm Haak <malcolm@sgi.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Kernel 3.8 supports automatic numa balancing maybe this helps. 

Am 22.04.2013 um 01:55 schrieb Mark Nelson <mark.nelson@inktank.com>:

> On 04/21/2013 06:18 PM, Malcolm Haak wrote:
>> Hi all,
>> 
>> We switched to a, now free, Sandy Bridge based server.
>> 
>> This has resolved our read issues. So something about the Quad AMD box
>> was very bad for reads...
>> 
>> I've got numbers if people are interested.. but I would say that AMD is
>> not a great idea for OSD's.
> 
> This is very good to know!  It makes me nervous that the slower and not-fully-connected nature of the hypertransport interconnect on quad socket AMD setups is causing issues.  With so many threads flying around potentially accessing remote memory and having to communicate with PCIE slots on remote IO hubs, it could be a recipe for disaster.  Your findings may indicate this could be the case.
> 
> With proper thread pinning and local disk and network controllers on each node, there is a chance that this could be dramatically improved. It'd be a lot of work to test it though.
> 
>> 
>> Thanks for all the pointers!
>> 
>> Regards
>> 
>> Malcolm Haak
> 
> <snip>
> 
>>> So.. we just started reading from the block device. And the numbers were
>>> well.. Faster than the QDR IB can do TCP/IP. So we figured local
>>> caching. So we dropped caches and ramped up to bigger than ram. (ram is
>>> 24GB) and it got faster. So we went to 3x ram.. and it was a bit slower..
>>> 
>>> Oh also the whole time we were doing these tests, the back-end disk was
>>> seeing no I/O at all.. We were dropping caches on the OSD's as well, but
>>> even if it was caching at the OSD end, the IB link is only QDR and we
>>> aren't doing RDMA so. Yeah..No idea what is going on here...
> 
> I've seen similar things with fio on a kernel rbd block device.  We suspect that because the blocks are a non-standard size it's screwing up the numbers being reported.  The issue wasn't apparent when tests were done against a file on a file system instead of directly against the block device.
> 
>>> 
>>> 
>>> On 19/04/13 10:40, Mark Nelson wrote:
>>>> On 04/18/2013 07:27 PM, Malcolm Haak wrote:
>>>>> Morning all,
>>>>> 
>>>>> Did the echos on all boxes involved... and the results are in..
>>>>> 
>>>>> [root@dogbreath ~]#
>>>>> [root@dogbreath ~]# dd if=/test-rbd-fs/DELETEME of=/dev/null bs=4M
>>>>> count=10000 iflag=direct
>>>>> 10000+0 records in
>>>>> 10000+0 records out
>>>>> 41943040000 bytes (42 GB) copied, 144.083 s, 291 MB/s
>>>>> [root@dogbreath ~]# dd if=/test-rbd-fs/DELETEME of=/dev/null bs=4M
>>>>> count=10000
>>>>> 10000+0 records in
>>>>> 10000+0 records out
>>>>> 41943040000 bytes (42 GB) copied, 316.025 s, 133 MB/s
>>>>> [root@dogbreath ~]#
>>>> 
>>>> Boo!
>>>> 
>>>>> 
>>>>> No change which is a shame. What other information or testing should I
>>>>> start?
>>>> 
>>>> Any chance you can try out a quick rados bench test from the client
>>>> against the pool for writes and reads and see how that works?
>>>> 
>>>> rados -p <pool> bench 300 write --no-cleanup
>>>> rados -p <pool> bench 300 seq
>>>> 
>>>>> 
>>>>> Regards
>>>>> 
>>>>> Malcolm Haak
>>>>> 
>>>>> On 18/04/13 17:22, Malcolm Haak wrote:
>>>>>> Hi Mark!
>>>>>> 
>>>>>> Thanks for the quick reply!
>>>>>> 
>>>>>> I'll reply inline below.
>>>>>> 
>>>>>> On 18/04/13 17:04, Mark Nelson wrote:
>>>>>>> On 04/17/2013 11:35 PM, Malcolm Haak wrote:
>>>>>>>> Hi all,
>>>>>>> 
>>>>>>> Hi Malcolm!
>>>>>>> 
>>>>>>>> 
>>>>>>>> I jumped into the IRC channel yesterday and they said to email
>>>>>>>> ceph-devel. I have been having some read performance issues. With
>>>>>>>> Reads
>>>>>>>> being slower than writes by a factor of ~5-8.
>>>>>>> 
>>>>>>> I recently saw this kind of behaviour (writes were fine, but reads
>>>>>>> were
>>>>>>> terrible) on an IPoIB based cluster and it was caused by the same TCP
>>>>>>> auto tune issues that Jim Schutt saw last year. It's worth a try at
>>>>>>> least to see if it helps.
>>>>>>> 
>>>>>>> echo "0" > /proc/sys/net/ipv4/tcp_moderate_rcvbuf
>>>>>>> 
>>>>>>> on all of the clients and server nodes should be enough to test it
>>>>>>> out.
>>>>>>>  Sage added an option in more recent Ceph builds that lets you work
>>>>>>> around it too.
>>>>>> Awesome I will test this first up tomorrow.
>>>>>>>> 
>>>>>>>> First info:
>>>>>>>> Server
>>>>>>>> SLES 11 SP2
>>>>>>>> Ceph 0.56.4.
>>>>>>>> 12 OSD's  that are Hardware Raid 5 each of the twelve is made from 5
>>>>>>>> NL-SAS disks for a total of 60 disks (Each lun can do around 320MB/s
>>>>>>>> stream write and the same if not better read) Connected via 2xQDR IB
>>>>>>>> OSD's/MDS and such all on same box (for testing)
>>>>>>>> Box is a Quad AMD Opteron 6234
>>>>>>>> Ram is 256Gb
>>>>>>>> 10GB Journals
>>>>>>>> osd_op_theads: 8
>>>>>>>> osd_disk_threads:2
>>>>>>>> Filestore_op_threads:4
>>>>>>>> OSD's are all XFS
>>>>>>> 
>>>>>>> Interesting setup!  QUAD socket Opteron boxes have somewhat slow and
>>>>>>> slightly oversubscribed hypertransport links don't they?  I wonder
>>>>>>> if on
>>>>>>> a system with so many disks and QDR-IB if that could become a
>>>>>>> problem...
>>>>>>> 
>>>>>>> We typically like smaller nodes where we can reasonably do 1 OSD per
>>>>>>> drive, but we've tested on a couple of 60 drive chassis in RAID
>>>>>>> configs
>>>>>>> too.  Should be interesting to hear what kind of aggregate
>>>>>>> performance
>>>>>>> you can eventually get.
>>>>>> 
>>>>>> We are also going to try this out with 6 luns on a dual xeon box. The
>>>>>> Opteron box was the biggest scariest thing we had that was doing
>>>>>> nothing.
>>>>>> 
>>>>>>> 
>>>>>>>> 
>>>>>>>> All nodes are connected via QDR IB using IP_O_IB. We get 1.7GB/s on
>>>>>>>> TCP
>>>>>>>> performance tests between the nodes.
>>>>>>>> 
>>>>>>>> Clients: One is FC17 the other us Ubuntu 12.10 they only have around
>>>>>>>> 32GB-70GB ram.
>>>>>>>> 
>>>>>>>> We ran into an odd issue were the OSD's would all start in the same
>>>>>>>> NUMA
>>>>>>>> node and pretty much on the same processor core. We fixed that up
>>>>>>>> with
>>>>>>>> some cpuset magic.
>>>>>>> 
>>>>>>> Strange!  Was that more due to cpuset or Ceph?  I can't imagine
>>>>>>> that we
>>>>>>> are doing anything that would cause that.
>>>>>> 
>>>>>> More than likely it is an odd quirk in the SLES kernel.. but when I
>>>>>> have
>>>>>> time I'll do some more poking. We were seeing insane CPU usage on some
>>>>>> cores because all the OSD's were piled up in one place.
>>>>>> 
>>>>>>>> 
>>>>>>>> Performance testing we have done: (Note oflag=direct was yielding
>>>>>>>> results within 5% of cached results)
>>>>>>>> 
>>>>>>>> 
>>>>>>>> root@ty3:~# dd if=/dev/zero of=/test-rbd-fs/DELETEME bs=10M
>>>>>>>> count=3200
>>>>>>>> 3200+0 records in
>>>>>>>> 3200+0 records out
>>>>>>>> 33554432000 bytes (34 GB) copied, 47.6685 s, 704 MB/s
>>>>>>>> root@ty3:~#
>>>>>>>> root@ty3:~# rm /test-rbd-fs/DELETEME
>>>>>>>> root@ty3:~#
>>>>>>>> root@ty3:~# dd if=/dev/zero of=/test-rbd-fs/DELETEME bs=10M
>>>>>>>> count=4800
>>>>>>>> 4800+0 records in
>>>>>>>> 4800+0 records out
>>>>>>>> 50331648000 bytes (50 GB) copied, 69.5527 s, 724 MB/s
>>>>>>>> 
>>>>>>>> [root@dogbreath ~]# dd of=/test-rbd-fs/DELETEME if=/dev/zero bs=10M
>>>>>>>> count=2400
>>>>>>>> 2400+0 records in
>>>>>>>> 2400+0 records out
>>>>>>>> 25165824000 bytes (25 GB) copied, 26.3593 s, 955 MB/s
>>>>>>>> [root@dogbreath ~]# rm -f /test-rbd-fs/DELETEME
>>>>>>>> [root@dogbreath ~]# dd of=/test-rbd-fs/DELETEME if=/dev/zero bs=10M
>>>>>>>> count=9600
>>>>>>>> 9600+0 records in
>>>>>>>> 9600+0 records out
>>>>>>>> 100663296000 bytes (101 GB) copied, 145.212 s, 693 MB/s
>>>>>>>> 
>>>>>>>> Both clients each doing a 140GB write (2x dogbreath's RAM) at the
>>>>>>>> same
>>>>>>>> time to two different rbds in the same pool.
>>>>>>>> 
>>>>>>>> root@ty3:~# rm /test-rbd-fs/DELETEME
>>>>>>>> root@ty3:~# dd if=/dev/zero of=/test-rbd-fs/DELETEME bs=10M
>>>>>>>> count=14000
>>>>>>>> 14000+0 records in
>>>>>>>> 14000+0 records out
>>>>>>>> 146800640000 bytes (147 GB) copied, 412.404 s, 356 MB/s
>>>>>>>> root@ty3:~#
>>>>>>>> 
>>>>>>>> [root@dogbreath ~]# rm -f /test-rbd-fs/DELETEME
>>>>>>>> [root@dogbreath ~]# dd of=/test-rbd-fs/DELETEME if=/dev/zero bs=10M
>>>>>>>> count=14000
>>>>>>>> 14000+0 records in
>>>>>>>> 14000+0 records out
>>>>>>>> 146800640000 bytes (147 GB) copied, 433.351 s, 339 MB/s
>>>>>>>> [root@dogbreath ~]#
>>>>>>>> 
>>>>>>>> Onto reads...
>>>>>>>> Also we found that doing iflag=direct increased read performance.
>>>>>>>> 
>>>>>>>> [root@dogbreath ~]# dd of=/dev/null if=/test-rbd-fs/DELETEME bs=10M
>>>>>>>> count=160
>>>>>>>> 160+0 records in
>>>>>>>> 160+0 records out
>>>>>>>> 1677721600 bytes (1.7 GB) copied, 29.4242 s, 57.0 MB/s
>>>>>>>> [root@dogbreath ~]#
>>>>>>>> [root@dogbreath ~]# echo 1 > /proc/sys/vm/drop_caches
>>>>>>>> [root@dogbreath ~]# dd if=/test-rbd-fs/DELETEME of=/dev/null bs=4M
>>>>>>>> count=10000
>>>>>>>> 10000+0 records in
>>>>>>>> 10000+0 records out
>>>>>>>> 41943040000 bytes (42 GB) copied, 382.334 s, 110 MB/s
>>>>>>>> [root@dogbreath ~]#
>>>>>>>> [root@dogbreath ~]# echo 1 > /proc/sys/vm/drop_caches
>>>>>>>> [root@dogbreath ~]# dd if=/test-rbd-fs/DELETEME of=/dev/null bs=4M
>>>>>>>> count=10000 iflag=direct
>>>>>>>> 10000+0 records in
>>>>>>>> 10000+0 records out
>>>>>>>> 41943040000 bytes (42 GB) copied, 150.774 s, 278 MB/s
>>>>>>>> [root@dogbreath ~]#
>>>>>>>> 
>>>>>>>> 
>>>>>>>> So what info do you want/where do I start hunting for my wumpus?
>>>>>>> 
>>>>>>> might also be worth looking at the size of the reads to see if
>>>>>>> there's a
>>>>>>> lot of fragmentation.  Also, is this kernel rbd or qemu-kvm?
>>>>>> 
>>>>>> Thing that got us was the back-end storage was showing very low read
>>>>>> rates. Where as when writing we could see almost a 2xWrite rate
>>>>>> back to
>>>>>> physical disk (we assume that is Journal+data as the 2x is not from
>>>>>> the
>>>>>> word go but ramps up around the 3-5 second mark)
>>>>>> 
>>>>>> It is kernel rbd at the moment, we will be testing qemu-kvm after
>>>>>> things
>>>>>> make sense.
>>>>>> 
>>>>>>>> 
>>>>>>>> Regards
>>>>>>>> 
>>>>>>>> Malcolm Haak
>>>>>>>> 
>>>>>>>> 
>>>>>>>> --
>>>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>>>> ceph-devel" in
>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>> ceph-devel" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
