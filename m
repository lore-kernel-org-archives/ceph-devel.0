From: "Duan, Jiangang" <jiangang.duan@intel.com>
Subject: RE: Cache Tiering Performance Ideas
Date: Thu, 28 Aug 2014 15:20:18 +0000
Message-ID: <A9F57F2ABA6BB2469F01E127557C6C9B110847BB@SHSMSX104.ccr.corp.intel.com>
References: <53FE215F.8010300@redhat.com>
 <75674D092A819E4189E91166C74CB90D014281D1@shsmsx102.ccr.corp.intel.com>
 <51FC7A40FB29414D88A121A7FFEF9A4710F41EA8@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11394 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823AbaH1PUo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Aug 2014 11:20:44 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Zhang, Jian" <jian.zhang@intel.com>, "Duan, Jiangang" <jiangang.duan@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Mark, 

We also have some similar  discussion when review the cache tier performance recently.
One thing is maybe we can just take a different object size for the cache tier - e.g. 512k or even less comparing to the back end capacity pool 4MB.
So in this case, we can do a small read promotion from capacity to performance tier.  Thus don't waste BW and cache tier space. 
Or instead of file store as the cache tier, we can also consider to use K/V store for the cache tier. More aggressively, I am thnking why we can't just convert the cache tier into the API/pluggable framework - thus we can use every existing cache tier technology. 

-jiangang

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Mark Nelson
Sent: Thursday, August 28, 2014 2:20 AM
To: ceph-devel@vger.kernel.org
Subject: Cache Tiering Performance Ideas

Hi All,

Earlier today I had a great conversation with some of the Gluster developers about cache tiering.  They want to implement something similar to what we've done and wanted to know what kinds of performance problems we've run into and brainstorm ideas to avoid similar issues for Gluster.

One of the big problems we've had occurs when using RBD, default 4MB block sizes, a cache pool, and 4k reads.  A single 4K read miss will currently cause a full-object promotion into the cache.  When you factor that journals will also receive a copy of the data and that you will want some level of replication (in our case 3x), that actually results in 24MB of data to be written the the cache pool. (With 12MB of it happening over the network!)

In Gluster they will be caching files rather than objects, and that is both good and bad.  A 40GB file promotion is going to be extremely expensive, so they will want to be very careful about accounting for the size of the files when making promotion decisions.  That will make it very tough for them to balance promoting large files when small IO is happening agains them.  They have an advantage though that file metadata is stored on the same server that makes the promotion decision.  They can use things like the file name (higher/lower promotion thresholds based on file type) and potentially the file size (except for initial writes), to influence when things go to cache.

In Ceph, with something like RBD, I don't think we can easily use file information to improve cache tier behaviour.  We may be able to do something else.  I wonder if perhaps at the RBD level, we could inspect the kind of writes being made to blocks and potentially whether or not that write is part of larger sequential write stream.  If so, set a flag that would persist with those objects indicating that these objects may be part of a large file.  The idea being that the objects are more likely to be read back sequentially where we can use read ahead and writing to the cache has more disadvantages than advantages.

General Assumptions:

1) Large writes and reads should come from the base pool rather than cache.  Big promotions to the cache tier are expensive (network consumption, write amplification) and spinning disks are already good at doing this kind of thing.

2) Writes to a full cache tier causes other hot or semi-hot data to be evicted.  For new writes, even if they are smallish, it might not be worth writing to the cache tier if it's full.

3) The best thing the cache tier can provide for us is caching small objects, or larger objects with small IO being performed against them. 
For larger objects, the cost of promotion is more expensive than smaller objects.


Questions:

1) If RBD is seeing a stream of large writes to consecutive blocks, should we set a persistent flag for those objects so that the promotion threshold is higher than normal?  The assumption being that until we see random small reads/writes being made to them (when we can unset the flag), the reads are assumed to also be large.

2) If RBD reads/writes are smaller than some threshold and the cache isn't full, should we just promote to cache?  If the cache is full, should we be more selective?  Should the threshold be different for promotions for reads vs initial writes?

3) Do we have other data available that we can use to guess when a promotion won't provide a lot of benefit?

Mark
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
