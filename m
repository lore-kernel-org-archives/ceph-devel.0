From: Sage Weil <sweil@redhat.com>
Subject: RE: encoding
Date: Fri, 17 Jun 2016 20:16:55 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1606172013230.22717@piezo.us.to>
References: <BLUPR0201MB1524E3853169E4292D16F710E8570@BLUPR0201MB1524.namprd02.prod.outlook.com> <alpine.DEB.2.11.1606171657530.21827@piezo.us.to> <BLUPR0201MB15247981D954A0180454544CE8570@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1606171749150.22717@piezo.us.to> <BLUPR0201MB152438F87027D1C1496930F4E8570@BLUPR0201MB1524.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39778 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753302AbcFQUQ5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 17 Jun 2016 16:16:57 -0400
In-Reply-To: <BLUPR0201MB152438F87027D1C1496930F4E8570@BLUPR0201MB1524.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 17 Jun 2016, Allen Samuels wrote:
> > -----Original Message-----
> > From: Sage Weil [mailto:sweil@redhat.com]
> > Sent: Friday, June 17, 2016 10:55 AM
> > To: Allen Samuels <Allen.Samuels@sandisk.com>
> > Cc: ceph-devel@vger.kernel.org
> > Subject: RE: encoding
> > 
> > On Fri, 17 Jun 2016, Allen Samuels wrote:
> > > I'm just trying to work the encoding size.
> > >
> > > Igor has point out that unused could be replaced by a bitmap and
> > > suggested that it could be quite small (4 or 8 bytes) -- though he
> > > cites some particular examples about it being "small".
> > >
> > > Do we actually need a full bitmap? Might not a simple left-off pointer
> > > be almost as good?
> > 
> > He's right that it's only useful for a min_alloc_size'd blob, where we expect
> > teh bitmap to be about 16 bits.  We could have a left/right boundary that
> > encodes into 8 bits (two 0..15 values) that would probably capture 70% of the
> > performance benefit and save one byte.  I'm inclined to go for a bitmap for
> > now, though...
> > 
> > > w.r.t. ref_map. The comment in the code suggests that it will always
> > > be empty for a non-shared blob. If that's correct perhaps it's not a
> > > big deal.
> > 
> > That was the original thought, but it didn't end up being the case.  We could
> > write a non-trivial chunk of code to rebuild that info at runtime from the
> > lextent map, but I'd put that pretty far down on the list too.
> > Instead, we can probably take advantage of the fact that most of the ref
> > counts will be 1 or 0 and combine those ~2 bits into a more efficent record_t
> > encoding.  This should be sequenced after the first pass of varint encodings,
> > though, which I'm partway through stabilizing.
> > Should have a PR by Monday.
> 
> With some deeper thinking, it seems to me that the 
> rebuild-ref-map-on-deserialize is pretty trivial. Isn't it just a walk 
> of the lextent map and for each entry a corresponding call to add_ref 
> for that referenced blob (assuming add_ref correctly combines 
> overlapping references)????

You're exactly right.

We encode the "blob map" and append it to the encoded onode or put it in 
the bnode key.  I think we just need to make 2 variations of encode (to 
elide the ref_map), and to make the onode decode case rebuild it as you 
say.

sage
