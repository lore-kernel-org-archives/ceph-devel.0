From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: Flexible placement
Date: Mon, 18 Apr 2016 14:47:56 -0400
Message-ID: <20160418184755.GB22875@ultraspiritum.redhat.com>
References: <alpine.DEB.2.11.1604172057000.4797@cpach.fuggernut.com>
 <20160418170836.GB20078@ultraspiritum.redhat.com>
 <alpine.DEB.2.11.1604181355330.4797@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52691 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751200AbcDRSr7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 18 Apr 2016 14:47:59 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1604181355330.4797@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 18/04/2016, Sage Weil wrote:
> How could it not be client-driven?  If the client doesn't know the
> placement, it can't read or write the object.  Unless you have
> proxy/redirect at the OSD level, but I think then you're talking
> about tiering v2.

Let me rephrase that. The client has to explicitly set locality. I was
imagining a case like CephFS that uses "INODE.BLOCK" as the object
name getting a rule that might probabilistically stick blocks with a
the same inode in the same place, say with a parameter that lets you
trade off the hit to uniformity that would involve.

> I think I'm still confused.  If we're not moving PG's or hash
> *ranges* in large chunks, that means we have to individually
> consider each object in the event of any topology change (a new osd
> came up, or the placement policy changed, please wait while I
> iterate over my 13 million object to see what has moved).  One of
> the primary functions of PGs is the bound the amount of map change
> checking I have to do--recalculating a crush mapping 100x is cheap.
> Swapping out crush for a more gneeral NaCl thing would be the same.
> Moving away from placement *groups* makes it all fall apart.
>
> In your example above, you're talking abuot using the placement
> policy to manage fine-grained changes.. do you mean using that to
> move individual objects around?  This feels like entirely the wrong
> layer for that sort of thing--we lose the ability for the client to
> know where things.
>
> If it's policy driven, the policy is published as a pool property
> and has to be compact and fast.  If it's fine-grained, then we need
> something that is totally different (e.g., a metadata index).

I wasn't thinking that fine grained, I was thinking of a
classification function that would sort objects by name into groups
each of which would then get their own movement. The hard part would
be reclassifying objects when the function changes. I don't have an
immediate solution right now, I have a few ideas for making it more
tractable, I just don't want to build a system that would be unable to
do some version where we have the kinks ironed out, if that makes
sense.

> FWIW I'm thinking PG == hash range == shard of the pool.  The
> ordering is a pool property; I think we can mostly ignore the
> current entangled interface and implementation.

All right.

> I guess my point is that a direct object -> device mapping is
> fundamentally flawed, because
>
> 1) a mapping or policy change means recalculationg O(num objects)
>    mappings
> 2) all-to-all connectivity between OSDs
> 3) guaranteed data loss on any n- or (m+1)-failure.

There are certainly things that make it a bad idea in a lot of cases,
I agree.

>
> and if we can't/won't actually go there, is there anything we should
> do beyond more generalized object -> pg and pg -> device list
> mappings.

I'll take a look at her paper and see what all it requires.

> I think that in those cases, we let them use a wacky object -> PG
> mapping, and then have a linear/flat PG -> device mapping so they
> can still get some uniformity.
>
> This isn't completely general, but I'd want to see an example of
> something it can't express.  Maybe those entanglement erasure codes
> that Veronica was talking about at FAST?
>
> Or maybe the key step is to not assume the PG is a hash range, but
> instead consider it an arbitrary bucket in the pool.

Would the idea basically be in that case that we go from OID =>
WHATEVER => DEVICE LIST without putting too many constraints on what
'WHATEVER' is?

> Okay, I think this makes sense.  It means that the pg split becomes
> somewhat specific to the current hash range approach.

That would be a big part of it, I definitely wouldn't want to commit
to everything using the same idea of 'split'.

> Hmm, I think Veronica's helical entanglement codes might actually be
> a good example application to look at here to see if we're making
> something flexible enough.
>
>	http://dl.acm.org/citation.cfm?id=2718696

I shall take a look at her work, I've heard good things about it.  I
can certainly see opposing viewpoints, both from the side of not
wanting to do extra work without use and not wanting to build
foot-guns. I think my main point is that when we're implementing
something, if we can make something more flexible without breaking our
backs, it's probably better to err on the side of that than to err on
the side of keeping users from doing something dangerous.


-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
