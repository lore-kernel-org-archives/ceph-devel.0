From: Mark Nelson <mark.nelson@inktank.com>
Subject: Cache Tiering Performance Ideas
Date: Wed, 27 Aug 2014 13:20:15 -0500
Message-ID: <53FE215F.8010300@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:37412 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932413AbaH0SUR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Aug 2014 14:20:17 -0400
Received: by mail-qg0-f44.google.com with SMTP id e89so663498qgf.31
        for <ceph-devel@vger.kernel.org>; Wed, 27 Aug 2014 11:20:17 -0700 (PDT)
Received: from [10.193.21.145] (nat-pool-bos-u.redhat.com. [66.187.233.207])
        by mx.google.com with ESMTPSA id d62sm1753699qgd.13.2014.08.27.11.20.15
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 27 Aug 2014 11:20:16 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi All,

Earlier today I had a great conversation with some of the Gluster 
developers about cache tiering.  They want to implement something 
similar to what we've done and wanted to know what kinds of performance 
problems we've run into and brainstorm ideas to avoid similar issues for 
Gluster.

One of the big problems we've had occurs when using RBD, default 4MB 
block sizes, a cache pool, and 4k reads.  A single 4K read miss will 
currently cause a full-object promotion into the cache.  When you factor 
that journals will also receive a copy of the data and that you will 
want some level of replication (in our case 3x), that actually results 
in 24MB of data to be written the the cache pool. (With 12MB of it 
happening over the network!)

In Gluster they will be caching files rather than objects, and that is 
both good and bad.  A 40GB file promotion is going to be extremely 
expensive, so they will want to be very careful about accounting for the 
size of the files when making promotion decisions.  That will make it 
very tough for them to balance promoting large files when small IO is 
happening agains them.  They have an advantage though that file metadata 
is stored on the same server that makes the promotion decision.  They 
can use things like the file name (higher/lower promotion thresholds 
based on file type) and potentially the file size (except for initial 
writes), to influence when things go to cache.

In Ceph, with something like RBD, I don't think we can easily use file 
information to improve cache tier behaviour.  We may be able to do 
something else.  I wonder if perhaps at the RBD level, we could inspect 
the kind of writes being made to blocks and potentially whether or not 
that write is part of larger sequential write stream.  If so, set a flag 
that would persist with those objects indicating that these objects may 
be part of a large file.  The idea being that the objects are more 
likely to be read back sequentially where we can use read ahead and 
writing to the cache has more disadvantages than advantages.

General Assumptions:

1) Large writes and reads should come from the base pool rather than 
cache.  Big promotions to the cache tier are expensive (network 
consumption, write amplification) and spinning disks are already good at 
doing this kind of thing.

2) Writes to a full cache tier causes other hot or semi-hot data to be 
evicted.  For new writes, even if they are smallish, it might not be 
worth writing to the cache tier if it's full.

3) The best thing the cache tier can provide for us is caching small 
objects, or larger objects with small IO being performed against them. 
For larger objects, the cost of promotion is more expensive than smaller 
objects.


Questions:

1) If RBD is seeing a stream of large writes to consecutive blocks, 
should we set a persistent flag for those objects so that the promotion 
threshold is higher than normal?  The assumption being that until we see 
random small reads/writes being made to them (when we can unset the 
flag), the reads are assumed to also be large.

2) If RBD reads/writes are smaller than some threshold and the cache 
isn't full, should we just promote to cache?  If the cache is full, 
should we be more selective?  Should the threshold be different for 
promotions for reads vs initial writes?

3) Do we have other data available that we can use to guess when a 
promotion won't provide a lot of benefit?

Mark
