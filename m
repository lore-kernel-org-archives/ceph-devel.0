From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: bluestore cache
Date: Fri, 27 May 2016 10:09:24 -0700
Message-ID: <CAJ4mKGb3TaOggHMGJP+YScXesLE+zPomJQn6KEjgVf8Uh2d=RQ@mail.gmail.com>
References: <alpine.DEB.2.11.1605261503240.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:35095 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753688AbcE0RJZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 May 2016 13:09:25 -0400
Received: by mail-vk0-f44.google.com with SMTP id f66so151673598vkh.2
        for <ceph-devel@vger.kernel.org>; Fri, 27 May 2016 10:09:25 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1605261503240.6221@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, May 26, 2016 at 12:27 PM, Sage Weil <sweil@redhat.com> wrote:
> Previously we were relying on the block device cache when appropriate
> (when a rados hint indicated we should, usually), but that is unreliable
> for annoying O_DIRECT reasons.  We also need an explicit cache to cope
> with some of the read/modify/write cases with compression and checksum
> block/chunk sizes.
>
> A basic cache is in place that is attached to each Onode, and maps the
> logical object bytes to buffers.  We also have a per-collection onode
> cache.  Currently the only trimming of data happens when onodes are
> trimmed, and we control that using a coarse per-collection num_onodes
> knob.
>
> There are two basic questions:
>
> 1. First, should we stick with a logical extent -> buffer mapping, or move
> to a blob -> blob extent mapping.  The former is simpler and attaches to
> the onode cache, which we also have to fix trimming for anyway.  On the
> other hand, when we clone an object (usually a head object to a snapshot),
> the cache doesn't follow.  Moving to a blob-based scheme would work better
> in that regard, but probably means that we have another object
> (bluestore_blob_t) whose lifecycle we need to manage.
>
> I'm inclined to stick with the current scheme since reads from just-cloned
> snaps probably aren't too frequent, at least until we have a better
> idea how to do the lifecycle with the simpler (current) model.
>
> 2. Second, we need to trim the buffers.  The per-collection onode cache is
> nice because the LRU is local to the collection and already protected by
> existing locks, which avoids complicated locking in the trim path that
> we'd get from a global LRU.  On the other hand, it's clearly suboptimal:
> some pools will get more IO than others and we want to apportion our cache
> resources more fairly.
>
> My hope is that we can do both using a scheme that has collection-local
> LRU (or ARC or some other cache policy) for onodes and buffers, and then
> have a global view of what proportion of the cache a collection is
> entitled to and drive our trimming against that.  This won't be super
> precise, but I wouldn't even if we fudge where the "perfect"
> per-collection cache size is by say 30% I wouldn't expect to see a huge
> cache hit range change over that range (unless your cache is already
> pretty undersized).
>
> Anyway, a simple way to estimate a collections portion of the total might
> be to have a periodic global epoch counter that increments every, say, 10
> seconds.  Then we could ops globally and per collection.  When the epoch
> rolls over, we look at our previous epoch count vs the global count and
> use that ratio to size our per-collection cache.  Since this doesn't have
> to be super-precise we can get clever with atomic and per-cpu variables if
> we need to on the global count.


I'm a little concerned about this due to the nature of some of our IO
patterns. Maybe it's not a problem within the levels you're talking
about, but consider:
1) RGW cluster, in which the index pool gets a hugely disproportionate
number of ops in comparison to its actual size (at least for writes)
2) RBD cluster, in which you can expect a golden master pool to get a
lot of reads but have much less total data compared to the user block
device pools.

A system that naively allocates cache space based on proportion of ops
is going to perform pretty badly.
-Greg

>
> Within a collection, we're under the same collection lock, so a simple lru
> or onodes and buffers ought to suffice.  I think we want something better
> than just a straight-LRU, though: some data is hinted WILLNEED, and
> buffers we hit in cache twice should get bumped up higher than stuff we
> just read off of disk.  The MDS uses a simple 2-level LRU list; I suspect
> something like MQ might be a better choice for us, but this is probably a
> secondary issue.. we can optimize this independently once we have the
> overall approach sorted out.
>
> Anyway, I guess what I'm looking for is feedback on (1) above, and whether
> per-collection caches with periodic size calibration (based on workload)
> sounds reasonable.
>
> Thanks!
> sage
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
