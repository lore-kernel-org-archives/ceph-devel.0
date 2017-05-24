From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: RADOS: Deleting all objects in a namespace
Date: Wed, 24 May 2017 13:47:28 -0700
Message-ID: <CAJ4mKGbsiVgjHFxTZ6UGkOavV=oQG0PfjnBDaegHvS9jbqSSLw@mail.gmail.com>
References: <CALe9h7eQMGGB1K_W-qryVjYhfjr5jGBRKLkawUr8q=QD1rXTSw@mail.gmail.com>
 <CAJ4mKGZorBntpTQDBzqdLHamyprOUx_4Abcz_f1RX=afEp45jA@mail.gmail.com>
 <CALe9h7daCUq1j_t0rwd4iiUiinEehzPYKjhxuLE4bLzO-S=8iw@mail.gmail.com> <alpine.DEB.2.11.1705241328580.3646@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:33709 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032477AbdEXUra (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 May 2017 16:47:30 -0400
Received: by mail-it0-f48.google.com with SMTP id w68so13282134itc.0
        for <ceph-devel@vger.kernel.org>; Wed, 24 May 2017 13:47:30 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1705241328580.3646@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, May 24, 2017 at 6:32 AM Sage Weil <sweil@redhat.com> wrote:
>
> On Wed, 24 May 2017, John Spray wrote:
> > On Wed, May 24, 2017 at 6:12 AM, Gregory Farnum <gfarnum@redhat.com> wrote:
> > > On Tue, May 23, 2017 at 6:10 AM John Spray <jspray@redhat.com> wrote:
> > >>
> > >> Soon, we'll probably be letting multiple CephFS filesystems use the
> > >> same data and metadata pools, where the filesystems are separated by
> > >> rados namespace.
> > >>
> > >> When removing filesystems, in the interests of robustness and speed,
> > >> I'd like to be able to delete all objects in a namespace -- otherwise
> > >> we would have to rely on a "rm -rf" and then some new code to
> > >> explicitly enumerate and delete all metadata objects for that
> > >> filesystem.
> > >>
> > >> I'm pondering whether this should just be a process that happens via
> > >> normal client interfaces (where mon/mgr would be the client), or
> > >> whether it would be feasible/desirable to implement something inside
> > >> the OSD.  Obviously the OSD ultimately has to do the same underlying
> > >> enumeration, but at least it doesn't have to thrash through the whole
> > >> request/response cycle for deleting each object individually -- might
> > >> enable it to throttle internally in the OSD based on how busy it knows
> > >> itself to be, rather than having the client apply some arbitrary "only
> > >> issue N deletions at once" type limit that might make the deletion
> > >> process unecessarily slow.
> > >>
> > >> I have a feeling we must have talked about this at some point but my
> > >> memory is failing me...
> > >
> > >
> > > This is an interesting thought and I don't think it's been discussed
> > > before. Some random things:
> > > 1) We tend to suck at throttling stuff in the OSD (although we're
> > > getting close to having the right pattern)
> > > 2) Deleting objects is a *lot* more expensive than listing them;
> > > David's right it would probably look like pgnls, but it's definitely
> > > not analogous. For the listing we just go through omap keys but here
> > > we have to shove deletes into XFS (...for now. I suppose they're
> > > actually pretty similar in BlueStore, though I don't really know the
> > > cost of a delete)
> > > 3) If this happens inside the OSD it will be much harder to bill it
> > > against client IO. Not sure if that's relevant given it's removal,
> > > but...
> > > 4) I'm actually not sure how we could best do this internally if we
> > > wanted to. Deletes as noted would have to take a while, which means it
> > > would probably be a very long-lived operation — much more than eg 30
> > > seconds. Or else we'd need a whole internal queue of stuff to delete,
> > > where the client "op" is just queueing up the namespace and the actual
> > > deletes get spaced out much later...and then that would imply more new
> > > checks around whether something is logically deleted even though it
> > > still exists in our data store. (And what happens if a user starts
> > > putting new objects in the namespace while the delete is still going
> > > on? Is that blocked somehow? Or does the OSD need to handle it with a
> > > way of distinguishing between namespace "epoch" 1 and 2?)
> >
> > Yeah, all those things are why this is a "hmmm" mailing list thread
> > rather than a PR :-)
> >
> > > Overall I definitely see the appeal of wanting to do gross deletes
> > > like that, but it'll be at least a little trickier than I suspect
> > > people are considering. Given the semantic confusion and implied
> > > versus real costs I'm generally not really a fan of allowing stuff
> > > like this on units other than pools/PGs and I'm not sure when the
> > > bandwidth to implement it might come up. How important do you think it
> > > really is compared to doing "rm -rf"?
> >
> > The trouble with the literal rm -rf is that is requires e.g. the MDS
> > to be up and healthy, requires that the deletion code definitely has
> > no bugs, that there were definitely no stray objects in the
> > filesystem, etc.  Orchestrating it in a way that ensured it was done
> > before we permitted the filesystem to be removed would probably mean
> > adding a new "destroying" state to MDSs and having them do the work,
> > rather than accepting a client's promise that it had done it.
> >
> > The intermediate option where we're doing a pgnls and then sending a
> > delete for each object (probably from the mgr) is less evil, my
> > concerns with that one are just that we're sending a huge number of
> > ops to do one logical thing, and that it might be slower than
> > necessary from the user's point of view.  I suppose we could hide the
> > latency from the user by having a "trash" list in the FSMap but that
> > will cause confusion when they look at their df stats (which people
> > seem to do quite a lot).
> >
> > Doing the pgnls + O(N) deletes from the mgr is I suppose going to at
> > least have some commonality with what we would be doing in a nicely
> > orchestrated backward scrub, so it's not completely crazy.  People
> > would still appreciate how much faster it was than doing a rm -rf.
>
> I think the most reasonable way to do something like this would be to have
> a "trash ns queue" list broadcast to all OSDs, and have them do the
> cleanup during scrub (when they're already iterating over the namespace).
> OSDs would track a lower bound on a trash sequence number that has been
> scrubbed and applied (or similar) so that delete queue items get retired.
> (We need to do something similar with the snap trimming so that the delete
> list isn't publishes for all time in the OSDMap.)
>
> Scrub is already initiating updates for a couple different reasons
> (to update digests, and to convert legacy snapsets).  It's worked well so
> far, although deletion will be a bit more expensive than the current
> updates which are all xattr-only.


We discussed this a bit more in the RADOS standup. Sage remains
interested in the problem, but it sounded to me like the consensus was
we shouldn't move forward on this:
1) doing the delete *outside* of scrub is basically making the RADOS
cluster look at {M} data to do operations on {N} (where sizeof(N) <<<<
sizeof(M)). Scrub at least merges it in to work we're already doing,
but...
2) doing the delete during scrub makes the throttling/scheduling
dramatically harder
3) doing aysnchronous operations of any kind is a giant foot-gun for
our API users; obviously our in-tree systems are going to know they
can't write to a namespace after deleting it but you just *know* that
somebody is going to use it as a shortcut for "delete all my data" and
then start writing to it immediately after the acknowledgement commit
returns. So we probably need to introduce epoch versioning of
namespaces (nearly impossible?) and certainly need async operation
reporting. Lots of complexity.
4) There don't seem to be any other users and it seems like a lot more
work to do this in the OSD than to have the MDS or manager orchestrate
it somehow.

Of course, now it's written down so people can tell me my
understanding was wrong... ;)
-Greg
