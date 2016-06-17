From: Sage Weil <sweil@redhat.com>
Subject: RE: encoding
Date: Fri, 17 Jun 2016 17:54:54 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1606171749150.22717@piezo.us.to>
References: <BLUPR0201MB1524E3853169E4292D16F710E8570@BLUPR0201MB1524.namprd02.prod.outlook.com> <alpine.DEB.2.11.1606171657530.21827@piezo.us.to> <BLUPR0201MB15247981D954A0180454544CE8570@BLUPR0201MB1524.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1272759565-1466186096=:22717"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44311 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751807AbcFQRy5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 17 Jun 2016 13:54:57 -0400
In-Reply-To: <BLUPR0201MB15247981D954A0180454544CE8570@BLUPR0201MB1524.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1272759565-1466186096=:22717
Content-Type: TEXT/PLAIN; charset=iso-8859-7
Content-Transfer-Encoding: 8BIT

On Fri, 17 Jun 2016, Allen Samuels wrote:
> I'm just trying to work the encoding size.
> 
> Igor has point out that unused could be replaced by a bitmap and 
> suggested that it could be quite small (4 or 8 bytes) -- though he cites 
> some particular examples about it being "small".
> 
> Do we actually need a full bitmap? Might not a simple left-off pointer 
> be almost as good?

He's right that it's only useful for a min_alloc_size'd blob, where we 
expect teh bitmap to be about 16 bits.  We could have a left/right 
boundary that encodes into 8 bits (two 0..15 values) that would probably 
capture 70% of the performance benefit and save one byte.  I'm inclined to 
go for a bitmap for now, though...

> w.r.t. ref_map. The comment in the code suggests that it will always be 
> empty for a non-shared blob. If that's correct perhaps it's not a big 
> deal.

That was the original thought, but it didn't end up being the case.  We 
could write a non-trivial chunk of code to rebuild that info at runtime 
from the lextent map, but I'd put that pretty far down on the list too.  
Instead, we can probably take advantage of the fact that most of the ref 
counts will be 1 or 0 and combine those ~2 bits into a more 
efficent record_t encoding.  This should be sequenced after the first pass 
of varint encodings, though, which I'm partway through stabilizing.  
Should have a PR by Monday.

sage

> 
> Allen Samuels
> SanDisk |a Western Digital brand
> 2880 Junction Avenue, Milpitas, CA 95134
> T: +1 408 801 7030| M: +1 408 780 6416
> allen.samuels@SanDisk.com
> 
> 
> > -----Original Message-----
> > From: Sage Weil [mailto:sweil@redhat.com]
> > Sent: Friday, June 17, 2016 10:03 AM
> > To: Allen Samuels <Allen.Samuels@sandisk.com>
> > Cc: ceph-devel@vger.kernel.org
> > Subject: Re: encoding
> > 
> > On Fri, 17 Jun 2016, Allen Samuels wrote:
> > > I don¢t understand the ref_map and unused stuff. What is their purpose?
> > 
> > ref_map:
> > 
> > We allocate blobs and write uncompressed data in.  Later, we logically
> > overwrite part of that reference, such that our big 1MB allocation only has
> > part of it referenced.  When that happens we want to release the
> > unreferenced part back to the allocator for use by something else.
> > ref_map lets us do that, which some additional complexity that counts
> > references (from multiple clones).
> > 
> > unused:
> > 
> > We might allocate a full min_alloc_size but only write one block into it.
> > If we do another small write in an adjacent block, we want to write into the
> > existing blob.  In order to do that without with a WAL event, we need to
> > know that the block isn't currently referenced by anything.
> > ref_map isn't quite sufficient for this because we don't have a complicated
> > commit/persist lifecycle sequence on update, and we need to make sure the
> > *committed* state has no references before we can safely overwrite a
> > block.
> > 
> > After pondering this a while I decided that would be very complex to
> > implement that, with marginal benefit, and in reality this mostly matters for
> > newly-allocated but never-written blobs... hence unused.  I decided we
> > don't care the case when you partially occlude part of a blob (but less that
> > min_alloc_size so it wasn't released back to the allocator) and
> > *then* also do a small overwrite such that the space could be reused.
> > 
> > sage
> 
> 
--8323329-1272759565-1466186096=:22717--
