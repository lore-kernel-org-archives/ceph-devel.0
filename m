From: Sage Weil <sage@inktank.com>
Subject: Re: cache tier blueprint (part 2)
Date: Sat, 9 Nov 2013 14:06:04 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1311091403060.20233@cobra.newdream.net>
References: <alpine.DEB.2.00.1311070653290.17943@cobra.newdream.net> <CAPYLRzgmhso21XgOM8ZAvfr6Hcsuvbu0yd6g6NeNZcCOr_9Umw@mail.gmail.com> <alpine.DEB.2.00.1311082219130.4750@cobra.newdream.net>
 <CAPYLRzgw3BGFEy9GdJGMzXrmHGjssa-KEah4w1U5zK96oWpBSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35686 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757346Ab3KIWGF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Nov 2013 17:06:05 -0500
In-Reply-To: <CAPYLRzgw3BGFEy9GdJGMzXrmHGjssa-KEah4w1U5zK96oWpBSg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, 9 Nov 2013, Gregory Farnum wrote:
> On Fri, Nov 8, 2013 at 10:25 PM, Sage Weil <sage@inktank.com> wrote:
> > On Fri, 8 Nov 2013, Gregory Farnum wrote:
> >> On Thu, Nov 7, 2013 at 6:56 AM, Sage Weil <sage@inktank.com> wrote:
> >> > I typed up what I think is remaining for the cache tier work for firefly.
> >> > Greg, can you take a look?  I'm most likely missing a bunch of stuff here.
> >> >
> >> >  http://wiki.ceph.com/01Planning/02Blueprints/Emperor/rados_cache_pool_(part_2)
> >> >
> >> > This will be one of the meatier sessions at the upcoming CDS.  There will
> >> > be a fair bit of work not just on the OSD side but also in building
> >> > testing tools that exercise and validate the functionality, here, that
> >> > may be a great way for a new contributer to get involved and help out.
> >>
> >> This looks reasonably complete to me as an enumeration of areas, but
> >> is definitely targeted at the cache pool use case rather than demoting
> >> to cold storage. I'm not sure yet if we're going to want to use the
> >> same agent/process/whatever in both use cases; do you want a separate
> >> blueprint for that, or should we broaden this one?
> >
> > I think they are going to be quite similar, so it seems simplest to just
> > start with this use-case and keep in mind that it may need to generalize
> > slightly.  To a first approximation, both are making some decision about
> > when to flush/evict or demote based on how old the object is and/or how
> > full the pool is.  It will probably be a pretty compact bit of logic, so
> > I'm not too worried.
> >
> > The other question for me is where we want to implement the agent.  The
> > logic is pretty simple, and it can operate entirely using the new librados
> > calls.  I may be simpler to drive it from a thread inside ceph-osd
> > (simpler than managing a separate external daemon).  It might also be easy
> > (and slightly more efficient) to plug into the scrub process.  It is
> > possible/likely that in the future we (or others) will want to construct
> > more sophisticated policies using an external agent, but at this point the
> > logic is simple enough that we can probably pick something simple and
> > still be able to easily change it up down the line...
> 
> This is the big thing that worries me. I think that doing cold storage
> demotion as part of scrub is the natural way to go since we're already
> examining the objects, but a cache pool needs to be able to evict
> stuff on-demand, and certainly on a faster cycle than every day or two
> ? so it needs to have a separate internal process.
> Maybe that means we do a heavier-weight cache pool eviction process
> first and use that for both, but I'm not sure we want to sandbox
> ourselves that way?
> 
> We may also want to avoid giving external users access for the first
> implementation just so we can learn a little more about it before
> providing an API that we need to keep stable, although that thought
> just popped into my head.

This all makes me think we launch a standalone thread inside ceph-osd that 
runs for any pool with (cache) tier properties.  We give it a bit of funky 
logic to make it confine itself to pgs that are stored locally, and keep 
the logic as modular and simple as possible.  It can use librados (well, 
Objecter), but since it's part of the process we avoid boxing ourselves in 
on the API.

If we ar ereally paranoid we could disable the librados wrappers, but i 
think they are useful in their own right for testing and such.

Once we have more experience we can contemplate moving some parts of it 
into scrub for efficiency.

sage

