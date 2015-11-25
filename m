From: Sage Weil <sage@newdream.net>
Subject: RE: Cache Tiering Investigation and Potential Patch
Date: Wed, 25 Nov 2015 11:41:22 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511251137390.11017@cobra.newdream.net>
References: <3196669f.9Ro.9Gf.11.jZLaYO@mailjet.com> <alpine.DEB.2.00.1511250936470.11017@cobra.newdream.net> <2f99090c.9Ro.9Gf.24.jZU57B@mailjet.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48355 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbbKYTlX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Nov 2015 14:41:23 -0500
In-Reply-To: <2f99090c.9Ro.9Gf.24.jZU57B@mailjet.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Fisk <nick@fisk.me.uk>
Cc: 'ceph-users' <ceph-users@lists.ceph.com>, ceph-devel@vger.kernel.org, 'Mark Nelson' <mnelson@redhat.com>

On Wed, 25 Nov 2015, Nick Fisk wrote:
> Hi Sage
> 
> > -----Original Message-----
> > From: Sage Weil [mailto:sage@newdream.net]
> > Sent: 25 November 2015 17:38
> > To: Nick Fisk <nick@fisk.me.uk>
> > Cc: 'ceph-users' <ceph-users@lists.ceph.com>; ceph-devel@vger.kernel.org;
> > 'Mark Nelson' <mnelson@redhat.com>
> > Subject: Re: Cache Tiering Investigation and Potential Patch
> > 
> > On Wed, 25 Nov 2015, Nick Fisk wrote:
> > > Presentation from the performance meeting.
> > >
> > > I seem to be unable to post to Ceph-devel, so can someone please
> > > repost there if useful.
> > 
> > Copying ceph-devel.  The problem is just that your email is HTML-formatted.
> > If you send it in plaintext vger won't reject it.
> 
> Right ok, let's see if this gets through. 
> 
> > 
> > > I will try and get a PR sorted, I realise that this change modifies
> > > the way the cache was originally designed but I think it provides a
> > > quick win for the performance increase involved. If there are plans
> > > for a better solution in time for the next release, then I would be
> > > really interested in working to that goal instead.
> > 
> > It's how it was intended/documented to work, so I think this falls in the 'bug
> > fix' category.  I did a quick PR here:
> > 
> > 	https://github.com/ceph/ceph/pull/6702
> > 
> > Does that look right?
> 
> Yes I think that should definitely be an improvement. I can't quite get 
> my head around how it will perform in instances where you miss 1 hitset 
> but all others are a hit. Like this:
> 
> H H H M H H H H H H H H
> 
> And recency is set to 8 for example. It maybe that it doesn't have much 
> effect on the overall performance. It might be that there is a strong 
> separation of really hot blocks and hot blocks, but this could turn out 
> to be a good thing.

Yeah... In the above case recency 3 would be enough (or 9, depending on 
whether that's chronological or reverse chronological order).  Doing an N 
out of M or similar is a bit more flexible and probably something we 
should add on top.  (Or, we could change recency to be N/M instead of just 
N.)
 
> Would it be useful for me to run all 3 versions (Old, this and mine) 
> through the same performance test I did before?

If you have time, sure!  At the very least it'd be great to see the new 
version go through the same test.

> Also I saw pull request 6623, is it still relevant to get the list order 
> right?

Oh right, I forgot about that one.  I'll incorporate that fix and then you 
can test that version.

Thanks!
sage
