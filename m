From: Sage Weil <sweil@redhat.com>
Subject: Re: [NewStore]About PGLog Workload With RocksDB
Date: Tue, 8 Sep 2015 12:32:40 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509081227090.29438@cobra.newdream.net>
References: <CACJqLybUOPaj3kFrn6b3-1O7fEd0zom2KR5ETC+DiPpid4HQew@mail.gmail.com> <CACJqLyanf82a60YrLmYio80ff+-xkdWUiSqhiiu3v8TqSa0K_w@mail.gmail.com> <alpine.DEB.2.00.1509081209250.29438@cobra.newdream.net> <55EF3639.3060108@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40387 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbbIHTz7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Sep 2015 15:55:59 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 169BA8002D
	for <ceph-devel@vger.kernel.org>; Tue,  8 Sep 2015 12:55:59 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id EC0F88002D
	for <ceph-devel@vger.kernel.org>; Tue,  8 Sep 2015 12:55:58 -0700 (PDT)
In-Reply-To: <55EF3639.3060108@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>

On Tue, 8 Sep 2015, Mark Nelson wrote:
> On 09/08/2015 02:19 PM, Sage Weil wrote:
> > > On Tue, Sep 8, 2015 at 9:58 PM, Haomai Wang <haomaiwang@gmail.com> wrote:
> > > > Hi Sage,
> > > > 
> > > > I notice your post in rocksdb page about make rocksdb aware of short
> > > > alive key/value pairs.
> > > > 
> > > > I think it would be great if one keyvalue db impl could support
> > > > different key types with different store behaviors. But it looks like
> > > > difficult for me to add this feature to an existing db.
> > 
> > WiredTiger comes to mind.. it supports a few different backing
> > strategies (both btree and lsm, iirc).  Also, rocksdb has column families.
> > That doesn't help with the write log piece (the log is shared, as I
> > understand it) but it does mean that we can segregate the log events or
> > other bits of the namespace off into regions that have different
> > compaction policies (e.g., rarely/ever compact so that we avoid
> > amplification and but suffer on reads during startup).
> > 
> > > > So combine my experience with filestore, I just think let
> > > > NewStore/FileStore aware of this short-alive keys(Or just PGLog keys)
> > > > could be easy and effective. PGLog owned by PG and maintain the
> > > > history of ops. It's alike Journal Data but only have several hundreds
> > > > bytes. Actually we only need to have several hundreds MB at most to
> > > > store all pgs pglog. For FileStore, we already have FileJournal have a
> > > > copy of PGLog, previously I always think about reduce another copy in
> > > > leveldb to reduce leveldb calls which consumes lots of cpu cycles. But
> > > > it need a lot of works to be done in FileJournal to aware of pglog
> > > > things. NewStore doesn't use FileJournal and it should be easier to
> > > > settle down my idea(?).
> > > > 
> > > > Actually I think a rados write op in current objectstore impl that
> > > > omap key/value pairs hurts performance hugely. Lots of cpu cycles are
> > > > consumed and contributes to short-alive keys(pglog). It should be a
> > > > obvious optimization point. In the other hands, pglog is dull and
> > > > doesn't need rich keyvalue api supports. Maybe a lightweight
> > > > filejournal to settle down pglogs keys is also worth to try.
> > > > 
> > > > In short, I think it would be cleaner and easier than improving
> > > > rocksdb to impl a pglog-optimization structure to store this.
> > 
> > I've given some thought to adding a FileJournal to newstore to do the wal
> > events (which are the main thing we're putting in rocksdb that is *always*
> > shortlived and can be reasonably big--and thus cost a lot when it gets
> > flushed to L0).  But it just makes things a lot more complex.  We would
> > have two synchronization (fsync) targets, or we would want to be smart
> > about putting entire transactions in one journal and not the other.
> > Still thinking about it, but it makes me a bit sad--it really feels like
> > this is a common, simple workload that the KeyValueDB implementation
> > should be able to handle.  What I'd really like is a hint on they key, or
> > a predetermined key range that we use, so that the backend knows our
> > lifecycle expectations and can optimize accordingly.
> 
> That sure seems like the right way to go to me too.
> 
> > 
> > I'm hoping I can sell the rocksdb folks on a log rotation and flush
> > strategy that prevents these keys from every making it into L0... that,
> > combined with the overwrite change, will give us both low latency and no
> > amplification for these writes (and any other keys that get rewritten,
> > like hot object metadata).
> 
> Am I correct that the above is assuming we can't convince the rocksdb guys
> that we should be able to explicitly hint that the key should never go to L0
> anyway?

The 'flush strategy' part would make overwritten or deleted keys skip L0, 
without any hint needed.  The rest (compaction policy, I guess) I 
think can be accomplished with column families... so I don't think hints 
are actually needed in the rocksdb case.

Basically, the issue is that some number of log files/buffers are 
compacted together and then written to a new L0 sst.  That means that any 
keys alive at the end of that time period are amplified.  What I'd like to 
do is make it so that we take N + M logs, and we flush/dedup the N log 
segments into SST's... but skip any keys present in the M log buffers 
that follow.  That way we have M logs' worth of time to hide overwrites 
and short-lived keys.  The problem is that it will break the snapshot and 
replication stuff in rocksdb.   We don't need that, so I'm hoping we can 
have an upstream feature that's incompatible with those bits... otherwise, 
we'd need to carry our changes downstream, which would suck, or just 
accept that some of the WAL events will get rewritten (making N very large 
would make it more infrequent, but never eliminate it entirely).

Anyway, what I meant to say before but forgot was that the other 
reason I like putting this in the kv backend is that it gives us a 
single commit transaction log to reason about.  That will keep 
things simpler and while still keeping latency low.

sage


> 
> > 
> > On Tue, 8 Sep 2015, Haomai Wang wrote:
> > > Hit "Send" by accident for previous mail. :-(
> > > 
> > > some points about pglog:
> > > 1. short-alive but frequency(HIGH)
> > > 2. small and related to the number of pgs
> > > 3. typical seq read/write scene
> > > 4. doesn't need rich structure like LSM or B-tree to support apis, has
> > > obvious different to user-side/other omap keys.
> > > 5. a simple loopback impl is efficient and simple
> > 
> > It simpler.. though not quite as simple as it could be.  The pg log
> > lengths may vary widely (10000 events could be any time span,
> > depending on how active the pg is).  And we want to pix all the pg log
> > events into a single append stream for write efficiency.  So we still need
> > some complex tracking and eventual compaction ... which is part of
> > what the LSM is doing for us.
> > 
> > > > PS(off topic): a keyvaluedb benchmark http://sphia.org/benchmarks.html
> > 
> > This looks pretty interested!  Anyone interested in giving it a spin?  It
> > should be pretty easy to write it into the KeyValueDB interface.
> > 
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> 

