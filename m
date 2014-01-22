From: Sage Weil <sage@inktank.com>
Subject: Re: rados io hints
Date: Wed, 22 Jan 2014 11:11:30 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1401221058450.18304@cobra.newdream.net>
References: <alpine.DEB.2.00.1401171022030.6273@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:32807 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720AbaAVTLa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Jan 2014 14:11:30 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 5BDFC81336
	for <ceph-devel@vger.kernel.org>; Wed, 22 Jan 2014 11:11:30 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 30F9481336
	for <ceph-devel@vger.kernel.org>; Wed, 22 Jan 2014 11:11:30 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1401171022030.6273@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Fri, 17 Jan 2014, Sage Weil wrote:
> I think we need to add rados operations that provide hints to rados about 
> what the expected object sizes, alignment, and cacheability is.  In 
> particularly, I see two main wins:
> 
>  - knowing that rbd images have a 4m size, librbd can pass a hint that 
> will let the osd do the xfs allocation size ioctl on new files so that 
> they are allocated in 1m or 4m chunks.  We've seen cases where users with 
> rbd workloads have very high levels of fragmentation in xfs and this would 
> mitigate that and probably have a pretty nice performance benefit.
> 
>  - If the rbd (or other client) cache is enabled, we can pass a hint that 
> indicates that the OSD shouldn't keep the object pages around in cache.  
> This would just translate into an fadvise DONTNEED or similar.
> 
> I think the challenge is to keep this as generic as possible from the 
> client's perspetive, but make sure that there is enough information to 
> translate it into a good set of low-level hints to the underlying backend 
> (like alignment size and fadvise).  For example, intuitively the 1m 
> allocation unit sounds about right to me, but rbd would probably 
> communicate to rados that the objects are expected to be 4m each (or 
> whatever the striping strategy is).  I'm thinking the "we shouldn't do an 
> allocation unit more than 1m" logic should live in the FileStore, tunable 
> via a config option?

Offline feedback is, "yes we should do this," so let me propose some 
specifics.

* For cache hints, let's just mirror what fadvise is doing.  That makes it 
easy to just translate it down to the lower layers as is without being 
clever.  Also, I think it's a reasonable complete set of hints.  We can 
add a bitfield indicating whether it applies to data or omap or both, and 
we can make the default both.  (Not sure we can plumb it into leveldb, but 
maybe in the future or with another backend.)

CEPH_OSD_OP_FADVISE
 flags
  normal
  sequential
  random
  noreuse
  willneed
  dontneed
 what
  data
  k/v

* The flash people tell us that it would be very useful to know what the 
expected temperature or lifetime of a block/key/object/whatever will be.  
Maybe a 'shortlived' and 'longlived' flag added to the above?

* Allocation hint: I think the biggest immediate win we can get is poking 
XFS's allocation unit to ~1M or similar for rbd images to avoid excessive 
fragmentation.  How about:

CEPH_OSD_OP_ALLOCHINT
 expected_size         -- expected size of the object
 expected_write_size   -- what kinds of writes we expect to see from the client

This is harder because these don't translate directly into what we want 
(XFS to alloc in larger units), but I don't think it's a good idea to 
expose that level of detail to, say, librbd.  Instead, librbd should say 
"the objects will max out at 4MB" and "my writes are usually this big".  
Maybe we could add in an "expected sparseness", or 
"expected_size_probability" so that we can indicate whether we expect 
things to be less than 4MB or not?  Then for cephfs, for example, we would 
say the object will be 4MB but we *wouldn't* assume that they are all 
going to be that big (because there are many small files).

Thoughts?

sage


