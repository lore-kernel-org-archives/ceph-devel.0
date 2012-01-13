From: Sage Weil <sage@newdream.net>
Subject: Re: osd op tracking
Date: Fri, 13 Jan 2012 15:20:54 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1201131515320.16683@cobra.newdream.net>
References: <CAF3hT9DWH09W1HJytWytsDe_UQFs7N9XK_-BQKkPg_mrfzV2BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52384 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753535Ab2AMXU4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Jan 2012 18:20:56 -0500
In-Reply-To: <CAF3hT9DWH09W1HJytWytsDe_UQFs7N9XK_-BQKkPg_mrfzV2BA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 13 Jan 2012, Gregory Farnum wrote:
> I've been working on and off on
> http://tracker.newdream.net/issues/1879 for the last couple days, to
> track OSD operations and do some sort of logging about them when they
> get slow. The original plan was to rely on a few code hacks to track
> (and complain about) messages before they get into PGs, and to then
> tie the tracking into the ReplicatedPG's OpContext. It's a simple
> enough idea to put the OpContext on a linked list (by request receipt
> time), run through the front of the list on every tick and complain
> about any slow requests, and remove the OpContext from the list when
> it's completed.
> 
> But, we want the linked list to live in the OSD rather than in the PGs
> (the OSD already has a convenient tick function, we don't want to
> invoke every PG [most of which won't have requests] on every tick,
> etc), which means exporting the OpContext to the OSD. As I was making
> some of these changes I complained about a mechanical piece of it to
> Sam, who got pretty offended that I was planning to expose the
> OpContext to the OSD; it's a big piece of state that the OSD class
> shouldn't have to worry about and leakage across the interface like
> that tends to cause problems.
> 
> Which means I am going to have to generate a separate op-tracking
> structure and the mechanisms for watching them.
> 
> My current thoughts are that on receipt of an MOSDOp message, the OSD
> will generate a ref-counted tracking structure which references the
> MOSDOp and is tracked in a linked list. The current passing of MOSDOps
> will be converted to pass around this op-tracking structure. Once the
> MOSDOp goes into the PG, the OSD will gift its reference to the PG and
> the PG will be responsible for putting that reference away at the
> right time. This tracking structure will initially contain a few
> timestamps for the OSD to do bookkeeping with, perhaps a void pointer
> for the PG's use, and a flag stating the op's current status (or
> checkpoints it's passed).

I think this is the right approach.  We could solve this paticular problem 
by sticking everything in Message, but that's just lazy.

One question: do we need it to be ref counted?  I guess we're already 
taking multiple references on the MOSDOps?

> Meanwhile, the OSD will have the convenient linked list available for
> examination on every tick, so it can check for slow requests, and
> perhaps later do more interesting things. (With appropriate locking or
> lockless design; that's not an interesting problem right now.)
> 
> My question: since I'm implementing an actual operation tracker, is
> this sufficiently flexible or have I missed useful things that should
> be done in an initial implementation?

It should generalize to include (at least) MOSDSubOp?

Nothing else that would affect this initial switchover comes to mind...

sage




