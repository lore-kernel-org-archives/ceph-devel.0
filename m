From: Sage Weil <sage@inktank.com>
Subject: Re: cache tier blueprint (part 2)
Date: Fri, 8 Nov 2013 22:25:22 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1311082219130.4750@cobra.newdream.net>
References: <alpine.DEB.2.00.1311070653290.17943@cobra.newdream.net> <CAPYLRzgmhso21XgOM8ZAvfr6Hcsuvbu0yd6g6NeNZcCOr_9Umw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58258 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752928Ab3KIGZW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Nov 2013 01:25:22 -0500
In-Reply-To: <CAPYLRzgmhso21XgOM8ZAvfr6Hcsuvbu0yd6g6NeNZcCOr_9Umw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 8 Nov 2013, Gregory Farnum wrote:
> On Thu, Nov 7, 2013 at 6:56 AM, Sage Weil <sage@inktank.com> wrote:
> > I typed up what I think is remaining for the cache tier work for firefly.
> > Greg, can you take a look?  I'm most likely missing a bunch of stuff here.
> >
> >  http://wiki.ceph.com/01Planning/02Blueprints/Emperor/rados_cache_pool_(part_2)
> >
> > This will be one of the meatier sessions at the upcoming CDS.  There will
> > be a fair bit of work not just on the OSD side but also in building
> > testing tools that exercise and validate the functionality, here, that
> > may be a great way for a new contributer to get involved and help out.
> 
> This looks reasonably complete to me as an enumeration of areas, but
> is definitely targeted at the cache pool use case rather than demoting
> to cold storage. I'm not sure yet if we're going to want to use the
> same agent/process/whatever in both use cases; do you want a separate
> blueprint for that, or should we broaden this one?

I think they are going to be quite similar, so it seems simplest to just 
start with this use-case and keep in mind that it may need to generalize 
slightly.  To a first approximation, both are making some decision about 
when to flush/evict or demote based on how old the object is and/or how 
full the pool is.  It will probably be a pretty compact bit of logic, so 
I'm not too worried.

The other question for me is where we want to implement the agent.  The 
logic is pretty simple, and it can operate entirely using the new librados 
calls.  I may be simpler to drive it from a thread inside ceph-osd 
(simpler than managing a separate external daemon).  It might also be easy 
(and slightly more efficient) to plug into the scrub process.  It is 
possible/likely that in the future we (or others) will want to construct 
more sophisticated policies using an external agent, but at this point the 
logic is simple enough that we can probably pick something simple and 
still be able to easily change it up down the line...

sage
