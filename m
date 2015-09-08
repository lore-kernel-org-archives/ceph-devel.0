From: Mark Nelson <mnelson@redhat.com>
Subject: Re: [NewStore]About PGLog Workload With RocksDB
Date: Tue, 08 Sep 2015 14:27:30 -0500
Message-ID: <55EF36A2.4040704@redhat.com>
References: <CACJqLybUOPaj3kFrn6b3-1O7fEd0zom2KR5ETC+DiPpid4HQew@mail.gmail.com> <CACJqLyanf82a60YrLmYio80ff+-xkdWUiSqhiiu3v8TqSa0K_w@mail.gmail.com> <alpine.DEB.2.00.1509081209250.29438@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37744 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751464AbbIHT1d (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 8 Sep 2015 15:27:33 -0400
In-Reply-To: <alpine.DEB.2.00.1509081209250.29438@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Haomai Wang <haomaiwang@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 09/08/2015 02:19 PM, Sage Weil wrote:
>> On Tue, Sep 8, 2015 at 9:58 PM, Haomai Wang <haomaiwang@gmail.com> wrote:
>>> Hi Sage,
>>>
>>> I notice your post in rocksdb page about make rocksdb aware of short
>>> alive key/value pairs.
>>>
>>> I think it would be great if one keyvalue db impl could support
>>> different key types with different store behaviors. But it looks like
>>> difficult for me to add this feature to an existing db.
>
> WiredTiger comes to mind.. it supports a few different backing
> strategies (both btree and lsm, iirc).  Also, rocksdb has column families.
> That doesn't help with the write log piece (the log is shared, as I
> understand it) but it does mean that we can segregate the log events or
> other bits of the namespace off into regions that have different
> compaction policies (e.g., rarely/ever compact so that we avoid
> amplification and but suffer on reads during startup).
>
>>> So combine my experience with filestore, I just think let
>>> NewStore/FileStore aware of this short-alive keys(Or just PGLog keys)
>>> could be easy and effective. PGLog owned by PG and maintain the
>>> history of ops. It's alike Journal Data but only have several hundreds
>>> bytes. Actually we only need to have several hundreds MB at most to
>>> store all pgs pglog. For FileStore, we already have FileJournal have a
>>> copy of PGLog, previously I always think about reduce another copy in
>>> leveldb to reduce leveldb calls which consumes lots of cpu cycles. But
>>> it need a lot of works to be done in FileJournal to aware of pglog
>>> things. NewStore doesn't use FileJournal and it should be easier to
>>> settle down my idea(?).
>>>
>>> Actually I think a rados write op in current objectstore impl that
>>> omap key/value pairs hurts performance hugely. Lots of cpu cycles are
>>> consumed and contributes to short-alive keys(pglog). It should be a
>>> obvious optimization point. In the other hands, pglog is dull and
>>> doesn't need rich keyvalue api supports. Maybe a lightweight
>>> filejournal to settle down pglogs keys is also worth to try.
>>>
>>> In short, I think it would be cleaner and easier than improving
>>> rocksdb to impl a pglog-optimization structure to store this.
>
> I've given some thought to adding a FileJournal to newstore to do the wal
> events (which are the main thing we're putting in rocksdb that is *always*
> shortlived and can be reasonably big--and thus cost a lot when it gets
> flushed to L0).  But it just makes things a lot more complex.  We would
> have two synchronization (fsync) targets, or we would want to be smart
> about putting entire transactions in one journal and not the other.
> Still thinking about it, but it makes me a bit sad--it really feels like
> this is a common, simple workload that the KeyValueDB implementation
> should be able to handle.  What I'd really like is a hint on they key, or
> a predetermined key range that we use, so that the backend knows our
> lifecycle expectations and can optimize accordingly.

That sure seems like the right way to go to me too.

>
> I'm hoping I can sell the rocksdb folks on a log rotation and flush
> strategy that prevents these keys from every making it into L0... that,
> combined with the overwrite change, will give us both low latency and no
> amplification for these writes (and any other keys that get rewritten,
> like hot object metadata).

Am I correct that the above is assuming we can't convince the rocksdb 
guys that we should be able to explicitly hint that the key should never 
go to L0 anyway?  IE, it seems to me like most of our problems are fixed 
by your new log file creation strategy and if we could do the hinting?

>
> On Tue, 8 Sep 2015, Haomai Wang wrote:
>> Hit "Send" by accident for previous mail. :-(
>>
>> some points about pglog:
>> 1. short-alive but frequency(HIGH)
>> 2. small and related to the number of pgs
>> 3. typical seq read/write scene
>> 4. doesn't need rich structure like LSM or B-tree to support apis, has
>> obvious different to user-side/other omap keys.
>> 5. a simple loopback impl is efficient and simple
>
> It simpler.. though not quite as simple as it could be.  The pg log
> lengths may vary widely (10000 events could be any time span,
> depending on how active the pg is).  And we want to pix all the pg log
> events into a single append stream for write efficiency.  So we still need
> some complex tracking and eventual compaction ... which is part of
> what the LSM is doing for us.
>
>>> PS(off topic): a keyvaluedb benchmark http://sphia.org/benchmarks.html
>
> This looks pretty interested!  Anyone interested in giving it a spin?  It
> should be pretty easy to write it into the KeyValueDB interface.
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
