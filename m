From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: Bluestore different allocator performance Vs FileStore
Date: Wed, 10 Aug 2016 16:55:46 +0000
Message-ID: <BL2PR02MB211554DBEC8F344E465BAFE5F41D0@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sn1nam01on0044.outbound.protection.outlook.com ([104.47.32.44]:37231
	"EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S934988AbcHJS2k convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Aug 2016 14:28:40 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,
I spent some time on evaluating different Bluestore allocator and freelist performance. Also, tried to gaze the performance difference of Bluestore and filestore on the similar setup.

Setup:
--------

16 OSDs (8TB Flash) across 2 OSD nodes

Single pool and single rbd image of 4TB. 2X replication.

Disabled the exclusive lock feature so that I can run multiple write  jobs in parallel.
rbd_cache is disabled in the client side.
Each test ran for 15 mins.

Result :
---------

Here is the detailed report on this.

https://github.com/somnathr/ceph/blob/6e03a5a41fe2c9b213a610200b2e8a250cb05986/Bluestore_allocator_comp.xlsx

Each profile I named based on <allocator>-<freelist> , so in the graph for example "stupid-extent" meaning stupid allocator and extent freelist.

I ran the test for each of the profile in the following order after creating a fresh rbd image for all the Bluestore test.

1. 4K RW for 15 min with 16QD and 10 jobs.

2. 16K RW for 15 min with 16QD and 10 jobs.

3. 64K RW for 15 min with 16QD and 10 jobs.

4. 256K RW for 15 min with 16QD and 10 jobs.

The above are non-preconditioned case i.e ran before filling up the entire image. The reason is I don't see any reason of filling up the rbd image before like filestore case where it will give stable performance if we fill up the rbd images first. Filling up rbd images in case of filestore will create the files in the filesystem.

5. Next, I did precondition the 4TB image with 1M seq write. This is primarily because I want to load BlueStore with more data.

6. Ran 4K RW test again (this is called out preconditioned in the profile) for 15 min

7. Ran 4K Seq test for similar QD for 15 min

8. Ran 16K RW test again for 15min

For filestore test, I ran tests after preconditioning the entire image first.

Each sheet on the xls have different block size result , I often miss to navigate through the xls sheets , so, thought of mentioning here :-)

I have also captured the mkfs time , OSD startup time and the memory usage after the entire run.

Observation:
---------------

1. First of all, in case of bitmap allocator mkfs time (and thus cluster creation time for 16 OSDs) are ~16X slower than stupid allocator and filestore. Each OSD creation is taking ~2min or so sometimes and I nailed down the insert_free() function call (marked ****) in the Bitmap allocator is causing that.

2016-08-05 16:12:40.587148 7f4024d258c0 10 freelist enumerate_next start
2016-08-05 16:12:40.975539 7f4024d258c0 10 freelist enumerate_next 0x4663d00000~69959451000
2016-08-05 16:12:40.975555 7f4024d258c0 10 bitmapalloc:init_add_free instance 139913322803328 offset 0x4663d00000 length 0x69959451000
****2016-08-05 16:12:40.975557 7f4024d258c0 20 bitmapalloc:insert_free instance 139913322803328 off 0x4663d00000 len 0x69959451000****
****2016-08-05 16:13:20.748934 7f4024d258c0 10 freelist enumerate_next end****
2016-08-05 16:13:20.748978 7f4024d258c0 10 bluestore(/var/lib/ceph/osd/ceph-0) _open_alloc loaded 6757 G in 1 extents

2016-08-05 16:13:23.438511 7f4024d258c0 20 bluefs _read_random read buffered 0x4a14eb~265 of ^A:5242880+5242880
2016-08-05 16:13:23.438587 7f4024d258c0 20 bluefs _read_random got 613
2016-08-05 16:13:23.438658 7f4024d258c0 10 freelist enumerate_next 0x4663d00000~69959451000
2016-08-05 16:13:23.438664 7f4024d258c0 10 bitmapalloc:init_add_free instance 139913306273920 offset 0x4663d00000 length 0x69959451000
*****2016-08-05 16:13:23.438666 7f4024d258c0 20 bitmapalloc:insert_free instance 139913306273920 off 0x4663d00000 len 0x69959451000*****
*****2016-08-05 16:14:03.132914 7f4024d258c0 10 freelist enumerate_next end

2. The same function call is causing delay during OSD start time and it is ~4X slower than stupid/filestore.

3. As you can see in the result, bitmap allocator is performing a bit poorly for all the block sizes and has some significant 99th latency in some cases. This could be because of the above call as well since it is been called in IO path from kv_sync_thread.

4. In the end of each sheet, the graph for entire 15min run is shown and the performance looks stable for Bluestore but filestore for small block is kind od spiky as expected.

5. In my environment, filestore still outperforming narrowly for small blocks RW (4K/16K) but  for bigger blocks RW (64K/256K) Bluestore performance is ~2X than filestore.

6. 4K sequential performance is ~2X lower for Bluestore than Filestore. If you see the graph, it is starting very low and eventually it is stabilizing ~10K number.

7. 1M seq run for the entire image precondition is ~2X gain for Bluestore.

8. The small block performance (didn't measure bigblock) for Bluestore after precondition is getting slower and this is mainly because of onode size is growing (thus metadata size is growing). I will do some test with bigger rbd sizes to see how it behaves at scale.

9. I have adjusted the Bluestore cache to use most of my 64GB system memory and I found the amount of memory growth for each of the allocator test is more or less similar. Filestore of course is taking way less memory for OSD but it has kernel level cache that we need to consider as well. But, advantage for filestore is these kernel cache (buffer cache, dentries/dcaches/inode caches) can be reused..

10. One challenge for Bluestore as of today is to keep track of onode sizes and thus I think the BlueStore onode cache should be based on size and *not* based on number of onode entries otherwise memory growth for the long run will be unmanageable, Sage ?


Next, I will do some benchmarking on bigger setup and much larger data set.

Any feedback is much appreciated,

Thanks & Regards
Somnath

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
