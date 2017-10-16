From: Sage Weil <sweil@redhat.com>
Subject: Re: Work update related to rocksdb
Date: Mon, 16 Oct 2017 13:28:11 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1710161314220.26702@piezo.us.to>
References: <AEE495BD65FC0144A24ECB647C8270EF384559B2@shsmsx102.ccr.corp.intel.com> <alpine.DEB.2.11.1708240228380.3491@piezo.novalocal> <AEE495BD65FC0144A24ECB647C8270EF384559F1@shsmsx102.ccr.corp.intel.com> <fd7b00ef-66e4-cfae-fc76-6300b86a3b86@redhat.com>
 <AEE495BD65FC0144A24ECB647C8270EF38455A21@shsmsx102.ccr.corp.intel.com> <3ae1878e-9b70-669a-6596-e8480ae14537@redhat.com> <AEE495BD65FC0144A24ECB647C8270EF3846073B@shsmsx102.ccr.corp.intel.com> <AEE495BD65FC0144A24ECB647C8270EF38475E4A@shsmsx102.ccr.corp.intel.com>
 <416b7e16-6422-f572-7a2b-b7db7eabcb20@redhat.com> <AEE495BD65FC0144A24ECB647C8270EF384825EC@shsmsx102.ccr.corp.intel.com> <cfebf4b4-67ec-8826-997e-6b6b1faa605d@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52670 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752379AbdJPN2P (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 16 Oct 2017 09:28:15 -0400
In-Reply-To: <cfebf4b4-67ec-8826-997e-6b6b1faa605d@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: "Li, Xiaoyan" <xiaoyan.li@intel.com>, "Gohad, Tushar" <tushar.gohad@intel.com>, ceph-devel@vger.kernel.org

[adding ceph-devel]

On Mon, 16 Oct 2017, Mark Nelson wrote:
> Hi Lisa,
> 
> Excellent testing!   This is exactly what we were trying to understand.
> 
> On 10/16/2017 12:55 AM, Li, Xiaoyan wrote:
> > Hi Mark,
> > 
> > Based on my testing, when setting min_write_buffer_number_to_merge as 2, the
> > onodes and deferred data written into L0 SST can decreased a lot with my
> > rocksdb dedup package.
> > 
> > But for omap data, it needs to span more memtables. I tested omap data in
> > separate column family. From the data, you can see when
> > min_write_buffer_number_to_merge is set to 4, the data written into L0 SST
> > is good. That means it has to compare current memTable to flush with later 3
> > memtables recursively.
> > kFlushStyleDedup is to new flush style in my rocksdb dedup package.
> > kFlushStyleMerge is current flush style in master branch.
> > 
> > But this is just considered from data written into L0. With more memtables
> > to compare, it sacrifices CPU and computing time.
> > 
> > Memtable size: 256MB
> > max_write_buffer_number	min_write_buffer_number_to_merge
> > flush_style	Omap data written into L0 SST(unit: MB)
> > 16	8	kFlushStyleMerge	7665
> > 16	8	kFlushStyleDedup	3770
> > 8	4	kFlushStyleMerge	11470
> > 8	4	kFlushStyleDedup	3922
> > 6	3	kFlushStyleMerge	14059
> > 6	3	kFlushStyleDedup	5001
> > 4	2	kFlushStyleMerge	18683
> > 4	2	kFlushStyleDedup	15394
> 
> Is this only omap data or all data?  It looks like the 6/3 or 8/4 is still
> probably the optimal point (And the improvements are quite noticeable!).
> Sadly we were hoping we might be able to get away with smaller memtables (say
> 64MB) with KFlushStyleDedup.  It looks like that might not be the case unless
> we increase the number very high.
> 
> Sage, this is going to be even worse if we try to keep more pglog entries
> around on flash OSD backends?

I think there are three or more factors at play here:

1- If we reduce the memtable size, the CPU cost of insertion (baseline) 
and the dedup cost will go down.

2- If we switch to a small min pg log entries, then most pg log keys 
*will* fall into the smaller window (of small memtables * small 
min_write_buffer_to_merge).  The dup op keys probably won't, though... 
except maybe they will because the values are small and more of them will 
fit into the memtables.  But then

3- If we have more keys and smaller values, then the CPU overhead will be 
higher again.

For PG logs, I didn't really expect that the dedup style would help; I was 
only thinking about the deferred keys.  I wonder if it would make sense to 
specify a handful of key prefixes to attempt dedup on, and not bother on 
the others?

Also, there is the question of where the CPU time is spent.

1- Big memtables means we spend more time in submit_transaction, called by 
the kv_sync_thread, which is a bottleneck.

2- Higher dedup style flush CPU usage is spent in the compaction thread(s) 
(I think?), which are asynchronous.

At the end of the day I think we need to use less CPU total, so the 
optimization of the above factors is a bit complicated.  OTOH if the goal 
is IOPS at whatever cost it'll probably mean a slightly different choice.

I would *expect* that if we go from, say, 256mb tables to 64mb tables and 
dedup of <= 4 of them, then we'll see a modest net reduction of total CPU 
*and* a shift to the compaction threads.

And changing the pg log min entries will counterintuitively increase the 
costs of insertion and dedup flush because more keys will fit in the same 
amount of memtable... but if we reduce the memtable size at the same time 
we might get a win there too?  Maybe?

Lisa, do you think limiting the dedup check during flush to specific 
prefixes would make sense as a general capability?  If so, we could target 
this *just* at the high-value keys (e.g., deferred writes) and avoid 
incurring very much additional overhead for the key ranges that aren't 
sure bets.

sage


> > The above KV operation sequences come from 4k random writes in 30mins.
> > Overall, the Rocksdb dedup package can decrease the data written into L0
> > SST, but it needs more comparison. In my opinion, whether to use dedup, it
> > depends on the configuration of the OSD host: whether disk is over busy or
> > CPU is over busy.
> 
> Do you have any insight into how much CPU overhead it adds?
> 
> > 
> > Best wishes
> > Lisa
