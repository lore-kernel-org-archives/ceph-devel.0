From: Haomai Wang <haomai@xsky.com>
Subject: Re: bluestore blobs
Date: Wed, 17 Aug 2016 23:00:15 +0800
Message-ID: <CACJqLyZeE7zH-TFX_e5N7x1drWheyUQ08SVeeAEYBK=Yau4OkA@mail.gmail.com>
References: <alpine.DEB.2.11.1608171407220.17762@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pu1apc01on0101.outbound.protection.outlook.com ([104.47.126.101]:57910
	"EHLO APC01-PU1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752148AbcHQPPq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 17 Aug 2016 11:15:46 -0400
Received: by mail-ua0-f175.google.com with SMTP id n59so175597809uan.2
        for <ceph-devel@vger.kernel.org>; Wed, 17 Aug 2016 08:00:23 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1608171407220.17762@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

another latency perf problem:

rocksdb log is on bluefs and mainly uses append and fsync interface to
complete WAL.

I found the latency between kv transaction submitting isn't negligible
and limit the transaction throughput.

So what if we implement a async transaction submit in rocksdb side
using callback way? It will decrease kv in queue latency. It would
help rocksdb WAL performance close to FileJournal. And async interface
will help control each kv transaction size and make transaction
complete smoothly instead of tps spike with us precious.


On Wed, Aug 17, 2016 at 10:26 PM, Sage Weil <sweil@redhat.com> wrote:
> I think we need to look at other changes in addition to the encoding
> performance improvements.  Even if they end up being good enough, these
> changes are somewhat orthogonal and at least one of them should give us
> something that is even faster.
>
> 1. I mentioned this before, but we should keep the encoding
> bluestore_blob_t around when we load the blob map.  If it's not changed,
> don't reencode it.  There are no blockers for implementing this currently.
> It may be difficult to ensure the blobs are properly marked dirty... I'll
> see if we can use proper accessors for the blob to enforce this at compile
> time.  We should do that anyway.
>
> 2. This turns the blob Put into rocksdb into two memcpy stages: one to
> assemble the bufferlist (lots of bufferptrs to each untouched blob)
> into a single rocksdb::Slice, and another memcpy somewhere inside
> rocksdb to copy this into the write buffer.  We could extend the
> rocksdb interface to take an iovec so that the first memcpy isn't needed
> (and rocksdb will instead iterate over our buffers and copy them directly
> into its write buffer).  This is probably a pretty small piece of the
> overall time... should verify with a profiler before investing too much
> effort here.
>
> 3. Even if we do the above, we're still setting a big (~4k or more?) key
> into rocksdb every time we touch an object, even when a tiny amount of
> metadata is getting changed.  This is a consequence of embedding all of
> the blobs into the onode (or bnode).  That seemed like a good idea early
> on when they were tiny (i.e., just an extent), but now I'm not so sure.  I
> see a couple of different options:
>
> a) Store each blob as ($onode_key+$blobid).  When we load the onode, load
> the blobs too.  They will hopefully be sequential in rocksdb (or
> definitely sequential in zs).  Probably go back to using an iterator.
>
> b) Go all in on the "bnode" like concept.  Assign blob ids so that they
> are unique for any given hash value.  Then store the blobs as
> $shard.$poolid.$hash.$blobid (i.e., where the bnode is now).  Then when
> clone happens there is no onode->bnode migration magic happening--we've
> already committed to storing blobs in separate keys.  When we load the
> onode, keep the conditional bnode loading we already have.. but when the
> bnode is loaded load up all the blobs for the hash key.  (Okay, we could
> fault in blobs individually, but that code will be more complicated.)
>
> In both these cases, a write will dirty the onode (which is back to being
> pretty small.. just xattrs and the lextent map) and 1-3 blobs (also now
> small keys).  Updates will generate much lower metadata write traffic,
> which'll reduce media wear and compaction overhead.  The cost is that
> operations (e.g., reads) that have to fault in an onode are now fetching
> several nearby keys instead of a single key.
>
>
> #1 and #2 are completely orthogonal to any encoding efficiency
> improvements we make.  And #1 is simple... I plan to implement this
> shortly.
>
> #3 is balancing (re)encoding efficiency against the cost of separate keys,
> and that tradeoff will change as encoding efficiency changes, so it'll be
> difficult to properly evaluate without knowing where we'll land with the
> (re)encode times.  I think it's a design decision made early on that is
> worth revisiting, though!
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
