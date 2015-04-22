From: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Subject: RE: newstore and rocksdb column families
Date: Wed, 22 Apr 2015 16:16:06 +0000
Message-ID: <6F3FA899187F0043BA1827A69DA2F7CC021DDC93@shsmsx102.ccr.corp.intel.com>
References: <alpine.DEB.2.00.1504211350460.18547@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:56556 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965708AbbDVQQL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Apr 2015 12:16:11 -0400
In-Reply-To: <alpine.DEB.2.00.1504211350460.18547@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I think this is great since when we trying to optimize WAL, we set the write_buffer and memtable very aggressive, which will case read amplification. I was worring about it but now we can have separate column family :
	Write optimized for big stuff(WAL, and overlay)-----trying to minimized the WA
	Read optimized for small stuff(onode,omap)--------trying to minimize the RA.
And also, we can have different cache policy here, which help us prevent WAL and overlay flush the ondes out of the cache.
	For WAL,  NO CACHE
	For onode, MAX_CACHE
	For overlay, medium? No?


But since the transaction TPS is the main bottleneck now , maybe we can delay this a bit while? 

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
Sent: Wednesday, April 22, 2015 4:56 AM
To: ceph-devel@vger.kernel.org
Subject: newstore and rocksdb column families

Dhruba (rocksdb dev) asked if column families might be a good fit for controlling the WAL behavior.  I'm not certain it addresses specifically the WAL behavior, but it creates a bunch of opportunities for segregating the overlay and/or wal records out from the regular metadata (onodes, omap).  The short version is that each column family has it's own memtable and sstable files, but everything shares the same WAL, so you still get the atomicity.

I suspect this would be most helpful for the overlay records, where we'll have reasonably large key/value pairs with medium to long lifespans.  I'm not sure how helpful it will be with our wal records since if they make it out of the log at all we are already losing.  :/

Anyway, something to consider!

https://github.com/facebook/rocksdb/wiki/Column-Families

sage

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
