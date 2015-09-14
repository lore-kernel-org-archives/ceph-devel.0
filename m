From: Sage Weil <sweil@redhat.com>
Subject: RE: [NewStore]About PGLog Workload With RocksDB
Date: Mon, 14 Sep 2015 05:31:02 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509140523320.23022@cobra.newdream.net>
References: <CACJqLybUOPaj3kFrn6b3-1O7fEd0zom2KR5ETC+DiPpid4HQew@mail.gmail.com> <CACJqLyanf82a60YrLmYio80ff+-xkdWUiSqhiiu3v8TqSa0K_w@mail.gmail.com> <alpine.DEB.2.00.1509081209250.29438@cobra.newdream.net> <55EF3639.3060108@redhat.com>
 <alpine.DEB.2.00.1509081227090.29438@cobra.newdream.net> <6F3FA899187F0043BA1827A69DA2F7CC0361ED99@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41088 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751329AbbINMbF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 14 Sep 2015 08:31:05 -0400
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC0361ED99@shsmsx102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: Mark Nelson <mnelson@redhat.com>, ceph-devel@vger.kernel.org

On Mon, 14 Sep 2015, Chen, Xiaoxi wrote:
> >What I'd like to do is make it so that we take N + M logs, and we 
> >flush/dedup the N log segments into SST's... but skip any keys present 
> >in the M log buffers that follow.
> >That way we have M logs' worth of time to hide overwrites and 
> >short-lived keys.  The problem is that it will break the snapshot and 
> >replication stuff in rocksdb.  We don't need that.
> 
> It looks to me these can be partially done by the option 
> "min_write_buffer_number_to_merge" . min_write_buffer_number_to_merge is 
> the minimum number of memtables to be merged before flushing to storage. 
> For example, if this option is set to 2, immutable memtables are only 
> flushed when there are two of them - a single immutable memtable will 
> never be flushed.

Yes, and the write/delete/update pairs in those 2 tables will be 
consolidated, but we'll still write out any keys that were 'alive' when 
the most recent of the N memtables was completed.  So it'll reduce the 
writeout of ephemeral keys by a factor of N, but not completely.  And 
there'll still be some ephemeral items in L0 that will have to get 
compacted out later (not sure how expensive that is).

> What if we set it to N+M so the short-lived keys whose lifetime < N+M 
> will not be flushed to L0? The downside might be the compaction/flush 
> load will be more spiky than the way you proposed.

You mean just set min_write_buffer_number_to_merge to a larger number?  
It'll reduce it further but never completely eliminate it.  I think it'll 
also end up generated large L0 SST's if the number of ephemeral keys is 
low..

> These two approach are depending on the size, so on default the WAL 
> items(which is relatively much bigger than PGLog) will likely to make 
> PGLog flush more frequently. Not sure whether keys belongs to different 
> column families have separate buffer, seems yes, then that would be 
> great.

All the column families share the same WAL/write buffers.

I think it's hard to tell how much we are losing relative to a largish 
min_write_buffer_number_to_merge value.  Clearly it's less optimal, but 
maybe it's close enough for now.  It would be great to prototype the N+M 
dedup and see.  I forget if I mentioned it on the list, but on the rocksdb 
page Siying Dong says:

"I can't think of a way that you can config it as you like for now. It's 
possible to add a new feature to fulfill that. My idea would be similar to 
Dhruba Borthakur's. We only start flushing when we have two immutable 
memtables M1 and M2 and we only flush the older one M1. When flushing M1, 
we use M2 as a reference. We can iterate the two mem tables at the same 
time, while M2 is only used to check whether there is a new valus 
overwriting the values in M1. This is a feature of perhaps 1-2 weeks. If 
someone from the community is interested in helping in implementing it, we 
can provide help to you."

Also, apparently hbase is working on doing something similar.

If anyone is interested in hacking on this, let me know!

sage

> 
> 
> -xiaoxi
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
> Sent: Wednesday, September 9, 2015 3:33 AM
> To: Mark Nelson
> Subject: Re: [NewStore]About PGLog Workload With RocksDB
> 
> On Tue, 8 Sep 2015, Mark Nelson wrote:
> > On 09/08/2015 02:19 PM, Sage Weil wrote:
> > > > On Tue, Sep 8, 2015 at 9:58 PM, Haomai Wang <haomaiwang@gmail.com> wrote:
> > > > > Hi Sage,
> > > > > 
> > > > > I notice your post in rocksdb page about make rocksdb aware of 
> > > > > short alive key/value pairs.
> > > > > 
> > > > > I think it would be great if one keyvalue db impl could support 
> > > > > different key types with different store behaviors. But it looks 
> > > > > like difficult for me to add this feature to an existing db.
> > > 
> > > WiredTiger comes to mind.. it supports a few different backing 
> > > strategies (both btree and lsm, iirc).  Also, rocksdb has column families.
> > > That doesn't help with the write log piece (the log is shared, as I 
> > > understand it) but it does mean that we can segregate the log events 
> > > or other bits of the namespace off into regions that have different 
> > > compaction policies (e.g., rarely/ever compact so that we avoid 
> > > amplification and but suffer on reads during startup).
> > > 
> > > > > So combine my experience with filestore, I just think let 
> > > > > NewStore/FileStore aware of this short-alive keys(Or just PGLog 
> > > > > keys) could be easy and effective. PGLog owned by PG and 
> > > > > maintain the history of ops. It's alike Journal Data but only 
> > > > > have several hundreds bytes. Actually we only need to have 
> > > > > several hundreds MB at most to store all pgs pglog. For 
> > > > > FileStore, we already have FileJournal have a copy of PGLog, 
> > > > > previously I always think about reduce another copy in leveldb 
> > > > > to reduce leveldb calls which consumes lots of cpu cycles. But 
> > > > > it need a lot of works to be done in FileJournal to aware of 
> > > > > pglog things. NewStore doesn't use FileJournal and it should be easier to settle down my idea(?).
> > > > > 
> > > > > Actually I think a rados write op in current objectstore impl 
> > > > > that omap key/value pairs hurts performance hugely. Lots of cpu 
> > > > > cycles are consumed and contributes to short-alive keys(pglog). 
> > > > > It should be a obvious optimization point. In the other hands, 
> > > > > pglog is dull and doesn't need rich keyvalue api supports. Maybe 
> > > > > a lightweight filejournal to settle down pglogs keys is also worth to try.
> > > > > 
> > > > > In short, I think it would be cleaner and easier than improving 
> > > > > rocksdb to impl a pglog-optimization structure to store this.
> > > 
> > > I've given some thought to adding a FileJournal to newstore to do 
> > > the wal events (which are the main thing we're putting in rocksdb 
> > > that is *always* shortlived and can be reasonably big--and thus cost 
> > > a lot when it gets flushed to L0).  But it just makes things a lot 
> > > more complex.  We would have two synchronization (fsync) targets, or 
> > > we would want to be smart about putting entire transactions in one journal and not the other.
> > > Still thinking about it, but it makes me a bit sad--it really feels 
> > > like this is a common, simple workload that the KeyValueDB 
> > > implementation should be able to handle.  What I'd really like is a 
> > > hint on they key, or a predetermined key range that we use, so that 
> > > the backend knows our lifecycle expectations and can optimize accordingly.
> > 
> > That sure seems like the right way to go to me too.
> > 
> > > 
> > > I'm hoping I can sell the rocksdb folks on a log rotation and flush 
> > > strategy that prevents these keys from every making it into L0... 
> > > that, combined with the overwrite change, will give us both low 
> > > latency and no amplification for these writes (and any other keys 
> > > that get rewritten, like hot object metadata).
> > 
> > Am I correct that the above is assuming we can't convince the rocksdb 
> > guys that we should be able to explicitly hint that the key should 
> > never go to L0 anyway?
> 
> The 'flush strategy' part would make overwritten or deleted keys skip L0, without any hint needed.  The rest (compaction policy, I guess) I think can be accomplished with column families... so I don't think hints are actually needed in the rocksdb case.
> 
> Basically, the issue is that some number of log files/buffers are compacted together and then written to a new L0 sst.  That means that any keys alive at the end of that time period are amplified.  What I'd like to do is make it so that we take N + M logs, and we flush/dedup the N log segments into SST's... but skip any keys present in the M log buffers that follow.  That way we have M logs' worth of time to hide overwrites and short-lived keys.  The problem is that it will break the snapshot and 
> replication stuff in rocksdb.   We don't need that, so I'm hoping we can 
> have an upstream feature that's incompatible with those bits... otherwise, we'd need to carry our changes downstream, which would suck, or just accept that some of the WAL events will get rewritten (making N very large would make it more infrequent, but never eliminate it entirely).
> 
> Anyway, what I meant to say before but forgot was that the other reason I like putting this in the kv backend is that it gives us a single commit transaction log to reason about.  That will keep things simpler and while still keeping latency low.
> 
> sage
> 
> 
> > 
> > > 
> > > On Tue, 8 Sep 2015, Haomai Wang wrote:
> > > > Hit "Send" by accident for previous mail. :-(
> > > > 
> > > > some points about pglog:
> > > > 1. short-alive but frequency(HIGH) 2. small and related to the 
> > > > number of pgs 3. typical seq read/write scene 4. doesn't need rich 
> > > > structure like LSM or B-tree to support apis, has obvious 
> > > > different to user-side/other omap keys.
> > > > 5. a simple loopback impl is efficient and simple
> > > 
> > > It simpler.. though not quite as simple as it could be.  The pg log 
> > > lengths may vary widely (10000 events could be any time span, 
> > > depending on how active the pg is).  And we want to pix all the pg 
> > > log events into a single append stream for write efficiency.  So we 
> > > still need some complex tracking and eventual compaction ... which 
> > > is part of what the LSM is doing for us.
> > > 
> > > > > PS(off topic): a keyvaluedb benchmark 
> > > > > http://sphia.org/benchmarks.html
> > > 
> > > This looks pretty interested!  Anyone interested in giving it a 
> > > spin?  It should be pretty easy to write it into the KeyValueDB interface.
> > > 
> > > sage
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe 
> > > ceph-devel" in the body of a message to majordomo@vger.kernel.org 
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> > 
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
