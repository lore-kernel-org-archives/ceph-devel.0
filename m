From: Ramesh Chander <Ramesh.Chander@sandisk.com>
Subject: RE: bluestore cache
Date: Sat, 28 May 2016 04:32:03 +0000
Message-ID: <CY1PR0201MB18209A064720853F49AAD87E85430@CY1PR0201MB1820.namprd02.prod.outlook.com>
References: <alpine.DEB.2.11.1605261503240.6221@cpach.fuggernut.com>
 <CAJ4mKGb3TaOggHMGJP+YScXesLE+zPomJQn6KEjgVf8Uh2d=RQ@mail.gmail.com>
 <alpine.DEB.2.11.1605272231540.4873@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0070.outbound.protection.outlook.com ([207.46.100.70]:11344
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750950AbcE1EcI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 28 May 2016 00:32:08 -0400
In-Reply-To: <alpine.DEB.2.11.1605272231540.4873@cpach.fuggernut.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I am not completely well versed with blue store terms yet. But overall this problem looks more generic.

IMHO  blob cache with all extents directly pointing to entries in cache where the reference it or take read write lock for specific operations is easy to control in terms
of total DRAM usage and shared content.

If we make our cache entries in some fixed size units. In order to make cache usage fair. We can make a global pool of such free units as free lists and as you mentioned
some counter to track per collection usage. The free pool can skew towards any collection until not completely exhausted. At a time when we need eviction, first target the oversized collection
cache and move those entries to wherever required. The eviction can start from own collection if it is oversized. The eviction may need to take lock on two collections at a time.
In order to trim an underutilized collection cache, we might need some other strategy.

BTW: I did not fully understand the fair usage of collection. Isn't it fair that whoever needs more gets more unless we have some QOS?
If we divide cache strictly among the collections, then underutilization is possible. So we may need dynamic size both sides +ve or -ve.

-Regards,
Ramesh Chander


-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
Sent: Saturday, May 28, 2016 8:05 AM
To: Gregory Farnum
Cc: ceph-devel
Subject: Re: bluestore cache

On Fri, 27 May 2016, Gregory Farnum wrote:
> On Thu, May 26, 2016 at 12:27 PM, Sage Weil <sweil@redhat.com> wrote:
> > Previously we were relying on the block device cache when
> > appropriate (when a rados hint indicated we should, usually), but
> > that is unreliable for annoying O_DIRECT reasons.  We also need an
> > explicit cache to cope with some of the read/modify/write cases with
> > compression and checksum block/chunk sizes.
> >
> > A basic cache is in place that is attached to each Onode, and maps
> > the logical object bytes to buffers.  We also have a per-collection
> > onode cache.  Currently the only trimming of data happens when
> > onodes are trimmed, and we control that using a coarse
> > per-collection num_onodes knob.
> >
> > There are two basic questions:
> >
> > 1. First, should we stick with a logical extent -> buffer mapping,
> > or move to a blob -> blob extent mapping.  The former is simpler and
> > attaches to the onode cache, which we also have to fix trimming for
> > anyway.  On the other hand, when we clone an object (usually a head
> > object to a snapshot), the cache doesn't follow.  Moving to a
> > blob-based scheme would work better in that regard, but probably
> > means that we have another object
> > (bluestore_blob_t) whose lifecycle we need to manage.
> >
> > I'm inclined to stick with the current scheme since reads from
> > just-cloned snaps probably aren't too frequent, at least until we
> > have a better idea how to do the lifecycle with the simpler (current) model.
> >
> > 2. Second, we need to trim the buffers.  The per-collection onode
> > cache is nice because the LRU is local to the collection and already
> > protected by existing locks, which avoids complicated locking in the
> > trim path that we'd get from a global LRU.  On the other hand, it's clearly suboptimal:
> > some pools will get more IO than others and we want to apportion our
> > cache resources more fairly.
> >
> > My hope is that we can do both using a scheme that has
> > collection-local LRU (or ARC or some other cache policy) for onodes
> > and buffers, and then have a global view of what proportion of the
> > cache a collection is entitled to and drive our trimming against
> > that.  This won't be super precise, but I wouldn't even if we fudge where the "perfect"
> > per-collection cache size is by say 30% I wouldn't expect to see a
> > huge cache hit range change over that range (unless your cache is
> > already pretty undersized).
> >
> > Anyway, a simple way to estimate a collections portion of the total
> > might be to have a periodic global epoch counter that increments
> > every, say, 10 seconds.  Then we could ops globally and per
> > collection.  When the epoch rolls over, we look at our previous
> > epoch count vs the global count and use that ratio to size our
> > per-collection cache.  Since this doesn't have to be super-precise
> > we can get clever with atomic and per-cpu variables if we need to on the global count.
>
>
> I'm a little concerned about this due to the nature of some of our IO
> patterns. Maybe it's not a problem within the levels you're talking
> about, but consider:
> 1) RGW cluster, in which the index pool gets a hugely disproportionate
> number of ops in comparison to its actual size (at least for writes)
> 2) RBD cluster, in which you can expect a golden master pool to get a
> lot of reads but have much less total data compared to the user block
> device pools.
>
> A system that naively allocates cache space based on proportion of ops
> is going to perform pretty badly.

Yeah.  We could count both (1) ops and (2) bytes, and use some function of the two.  There are actually 2 caches to size: the onode cache and the buffer cache.

What we don't really have good control over is the omap portion, though.
Since that goes through rocksdb and bluefs it'd have to be sized globally for the OSD.  So maybe we'd also count (3) omap keys or something.

What do you think?

I think the main alternative is a global LRU (or whatever), but trimming in that situations sucks, because for each victim you have to go take the collection lock to update the onode map or buffer cache maps...

sage
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
