From: Sage Weil <sweil@redhat.com>
Subject: Re: RADOS: Deleting all objects in a namespace
Date: Wed, 24 May 2017 13:32:36 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1705241328580.3646@piezo.novalocal>
References: <CALe9h7eQMGGB1K_W-qryVjYhfjr5jGBRKLkawUr8q=QD1rXTSw@mail.gmail.com> <CAJ4mKGZorBntpTQDBzqdLHamyprOUx_4Abcz_f1RX=afEp45jA@mail.gmail.com> <CALe9h7daCUq1j_t0rwd4iiUiinEehzPYKjhxuLE4bLzO-S=8iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1904825304-1495632758=:3646"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49332 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967189AbdEXNcj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 24 May 2017 09:32:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A31E7C04B93B
        for <ceph-devel@vger.kernel.org>; Wed, 24 May 2017 13:32:38 +0000 (UTC)
In-Reply-To: <CALe9h7daCUq1j_t0rwd4iiUiinEehzPYKjhxuLE4bLzO-S=8iw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1904825304-1495632758=:3646
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 24 May 2017, John Spray wrote:
> On Wed, May 24, 2017 at 6:12 AM, Gregory Farnum <gfarnum@redhat.com> wrote:
> > On Tue, May 23, 2017 at 6:10 AM John Spray <jspray@redhat.com> wrote:
> >>
> >> Soon, we'll probably be letting multiple CephFS filesystems use the
> >> same data and metadata pools, where the filesystems are separated by
> >> rados namespace.
> >>
> >> When removing filesystems, in the interests of robustness and speed,
> >> I'd like to be able to delete all objects in a namespace -- otherwise
> >> we would have to rely on a "rm -rf" and then some new code to
> >> explicitly enumerate and delete all metadata objects for that
> >> filesystem.
> >>
> >> I'm pondering whether this should just be a process that happens via
> >> normal client interfaces (where mon/mgr would be the client), or
> >> whether it would be feasible/desirable to implement something inside
> >> the OSD.  Obviously the OSD ultimately has to do the same underlying
> >> enumeration, but at least it doesn't have to thrash through the whole
> >> request/response cycle for deleting each object individually -- might
> >> enable it to throttle internally in the OSD based on how busy it knows
> >> itself to be, rather than having the client apply some arbitrary "only
> >> issue N deletions at once" type limit that might make the deletion
> >> process unecessarily slow.
> >>
> >> I have a feeling we must have talked about this at some point but my
> >> memory is failing me...
> >
> >
> > This is an interesting thought and I don't think it's been discussed
> > before. Some random things:
> > 1) We tend to suck at throttling stuff in the OSD (although we're
> > getting close to having the right pattern)
> > 2) Deleting objects is a *lot* more expensive than listing them;
> > David's right it would probably look like pgnls, but it's definitely
> > not analogous. For the listing we just go through omap keys but here
> > we have to shove deletes into XFS (...for now. I suppose they're
> > actually pretty similar in BlueStore, though I don't really know the
> > cost of a delete)
> > 3) If this happens inside the OSD it will be much harder to bill it
> > against client IO. Not sure if that's relevant given it's removal,
> > but...
> > 4) I'm actually not sure how we could best do this internally if we
> > wanted to. Deletes as noted would have to take a while, which means it
> > would probably be a very long-lived operation — much more than eg 30
> > seconds. Or else we'd need a whole internal queue of stuff to delete,
> > where the client "op" is just queueing up the namespace and the actual
> > deletes get spaced out much later...and then that would imply more new
> > checks around whether something is logically deleted even though it
> > still exists in our data store. (And what happens if a user starts
> > putting new objects in the namespace while the delete is still going
> > on? Is that blocked somehow? Or does the OSD need to handle it with a
> > way of distinguishing between namespace "epoch" 1 and 2?)
> 
> Yeah, all those things are why this is a "hmmm" mailing list thread
> rather than a PR :-)
> 
> > Overall I definitely see the appeal of wanting to do gross deletes
> > like that, but it'll be at least a little trickier than I suspect
> > people are considering. Given the semantic confusion and implied
> > versus real costs I'm generally not really a fan of allowing stuff
> > like this on units other than pools/PGs and I'm not sure when the
> > bandwidth to implement it might come up. How important do you think it
> > really is compared to doing "rm -rf"?
> 
> The trouble with the literal rm -rf is that is requires e.g. the MDS
> to be up and healthy, requires that the deletion code definitely has
> no bugs, that there were definitely no stray objects in the
> filesystem, etc.  Orchestrating it in a way that ensured it was done
> before we permitted the filesystem to be removed would probably mean
> adding a new "destroying" state to MDSs and having them do the work,
> rather than accepting a client's promise that it had done it.
> 
> The intermediate option where we're doing a pgnls and then sending a
> delete for each object (probably from the mgr) is less evil, my
> concerns with that one are just that we're sending a huge number of
> ops to do one logical thing, and that it might be slower than
> necessary from the user's point of view.  I suppose we could hide the
> latency from the user by having a "trash" list in the FSMap but that
> will cause confusion when they look at their df stats (which people
> seem to do quite a lot).
> 
> Doing the pgnls + O(N) deletes from the mgr is I suppose going to at
> least have some commonality with what we would be doing in a nicely
> orchestrated backward scrub, so it's not completely crazy.  People
> would still appreciate how much faster it was than doing a rm -rf.

I think the most reasonable way to do something like this would be to have 
a "trash ns queue" list broadcast to all OSDs, and have them do the 
cleanup during scrub (when they're already iterating over the namespace).  
OSDs would track a lower bound on a trash sequence number that has been 
scrubbed and applied (or similar) so that delete queue items get retired.
(We need to do something similar with the snap trimming so that the delete 
list isn't publishes for all time in the OSDMap.)

Scrub is already initiating updates for a couple different reasons 
(to update digests, and to convert legacy snapsets).  It's worked well so 
far, although deletion will be a bit more expensive than the current 
updates which are all xattr-only.

sage
--8323329-1904825304-1495632758=:3646--
