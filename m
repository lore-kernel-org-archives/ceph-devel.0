From: Jianjian Huo <jianjian.huo@samsung.com>
Subject: RE: bluestore cache
Date: Fri, 27 May 2016 03:38:43 +0000
Message-ID: <3F3468645DC82146857A5E1C91E23F4B1B2A3A33@SSIEXCH-MB3.ssi.samsung.com>
References: <alpine.DEB.2.11.1605261503240.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailout2.w2.samsung.com ([211.189.100.12]:24714 "EHLO
	usmailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932168AbcE0Dir convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 May 2016 23:38:47 -0400
Received: from uscpsbgex4.samsung.com
 (u125.gpu85.samsung.co.kr [203.254.195.125]) by mailout2.w2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O7T009WGGSKOW40@mailout2.w2.samsung.com> for
 ceph-devel@vger.kernel.org; Thu, 26 May 2016 23:38:44 -0400 (EDT)
In-reply-to: <alpine.DEB.2.11.1605261503240.6221@cpach.fuggernut.com>
Content-language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



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

Very good design, sharded cache without additional locks, adapts to different workloads. One benefit this logical extent caching doesn't have but blob caching has, if data set compression rate is high, then blob caching will use less RAM? also users tend to use more PGs on SSD deployment, will per collection cache use more CPU cycles with too many PGs?

Jianjian
>
> Thanks!
> sage
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
