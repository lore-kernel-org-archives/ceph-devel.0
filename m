From: Sage Weil <sage@inktank.com>
Subject: Re: cache pool user interfaces
Date: Fri, 28 Feb 2014 15:06:20 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1402281501500.17508@cobra.newdream.net>
References: <CAPYLRziGSJAjf3CvvOAy8euAr-0vCzM3GX8K6D_z214w-Nu4aw@mail.gmail.com> <alpine.DEB.2.00.1402280711240.17508@cobra.newdream.net> <CAPYLRzjkghBaEXzFbiqUqZt4_ABeM3Yt_gnZOgpcoCedeRjgBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58072 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723AbaB1XGV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Feb 2014 18:06:21 -0500
In-Reply-To: <CAPYLRzjkghBaEXzFbiqUqZt4_ABeM3Yt_gnZOgpcoCedeRjgBg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Neil Levine <neil.levine@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 28 Feb 2014, Gregory Farnum wrote:
> On Fri, Feb 28, 2014 at 7:21 AM, Sage Weil <sage@inktank.com> wrote:
> > On Wed, 26 Feb 2014, Gregory Farnum wrote:
> >> We/you/somebody need(s) to sit down and decide on what kind of
> >> interface we want to actually expose to users for working with caching
> >> pools. What we have right now is very flexible, but it's hard to test
> >> all the combinations and it's easy for users to get themselves into
> >> trouble.
> >> I know we've in the past discussed making all the configuration
> >> options into a single "create cache pool" command that accepts
> >> whatever we're interested in, and I think that's the model we want to
> >> go towards right now. But we're running out of time to make that
> >> change given the release deadline and the documentation that needs to
> >> be generated (eg http://tracker.ceph.com/issues/7547).
> >
> > Right now the sequence is:
> >
> >        ceph osd pool create cache $num_pgs
> >        ceph osd tier add base cache
> >        ceph osd tier cache-mode cache writeback
> >        ceph osd tier set-overlay base cache
> >        ceph osd pool set cache hit_set_type bloom
> >        ceph osd pool set cache hit_set_count 8
> >        ceph osd pool set cache hit_set_period 60
> >        ceph osd pool set cache target_max_objects 5000
> 
> So we set our size limits based on object counts rather than data
> size? I didn't think that was how we discussed eviction working.

You can specify a max objects and/or bytes and it will start 
flushing/evicting based on whichever happens first.

> > I mostly like the flexibility this presents and don't forsee any major
> > problems, but nevertheless I agree that a friendly interface is safer to
> > advertise and, well, friendlier.  How about:
> >
> >        ceph osd pool create cache $num_pgs
> >
> > (I think think this should be a separate step since users will want/need
> > to adjust the crush rule and so forth to put this on the right devices
> > *before* it gets set as an overlay and gets hammered by the existing
> > pool's workload.)  Then
> >
> >        ceph osd tier add-cache base cache
> >
> > which would do the other 3 tier steps and set some sane hit_set defaults.
> > What do you think?
> 
> I'd really like to be able to get it down to one step so we don't need
> to worry about users putting used pools in as a cache pool. Perhaps a
> create-cache step and an enable-cache step?

We can make it fail or warn if the pool is non-new (num_objects or 
wr_bytes > 0).  There's a ticket for that open for rc1.

> > Separately:
> >
> > 1- I'm not sure what the default target size should be set to; maybe a
> > default of 10000 objects or something?  I think it should be *something*.
> 
> Just require users to specify it to do the initial creation. Without
> our having something like the real df you discuss below we can't do
> anything sensible here.
> Unfortunately, here in particular users are going to want to talk in
> terms of data size rather than object count (and the same for us if
> we're deriving it from a df like below).

We can make max_bytes a required argumnent:

 ceph osd tier add-cache base cache 100000000

(At some point we should make a 'type' on the ceph cli that translates 
trailing k m g t p etc.)

sage
