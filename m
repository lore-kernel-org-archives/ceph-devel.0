From: Sage Weil <sweil@redhat.com>
Subject: Re: snapshot implementation problems/options
Date: Fri, 5 Aug 2016 09:23:43 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1608050923140.1098@piezo.us.to>
References: <CAJ4mKGbf-zvTkZaqqsZDOA=ZrCsq=WRP80DM3wQpXcOWxYX-hg@mail.gmail.com> <alpine.DEB.2.11.1607281928430.1098@piezo.us.to> <CAJ4mKGbPhW_QefWtUCr-c8j5MM1Th6pvncybo+iyoj1Rd5mSJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51710 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934069AbcHEJXt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 5 Aug 2016 05:23:49 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B7603C04D2BD
	for <ceph-devel@vger.kernel.org>; Fri,  5 Aug 2016 09:23:45 +0000 (UTC)
In-Reply-To: <CAJ4mKGbPhW_QefWtUCr-c8j5MM1Th6pvncybo+iyoj1Rd5mSJw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: John Spray <jspray@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Zheng Yan <zyan@redhat.com>

On Mon, 1 Aug 2016, Gregory Farnum wrote:
> >> The other big source of bugs in our system is more diffuse, but also
> >> all for one big feature: we asynchronously flush snapshot data (both
> >> file data to the OSDs and metadata caps to the MDS). If we were trying
> >> to ruthlessly simplify things, I'd want to eliminate all that code in
> >> favor of simply forcing synchronous writeback when taking a snapshot.
> >> I haven't worked through all the consequences of it yet (probably it
> >> would involve a freeze on the tree and revoking all caps?) but I'd
> >> expect it to reduce the amount of code and complication by a
> >> significant amount. I'm inclined to attempt this but it depends on
> >> what snapshot behavior we consider acceptable.
> >
> > I would be inclined to keep the async behavior here despite the
> > complexity.  Unless there are fundamental issues we can't fix I think the
> > complexity is worth it.
> 
> Ha. We talked about this in standup last week and came to the
> conclusion that we actually prefer synchronous flushes, because they
> make the data loss semantics easier for users to understand. Sync
> snaps seem similarly necessary if an HPC machine were using them for
> checkpoints. Can you talk about the advantages of async snaps?

Maybe we're just confusing terms.  I think it would be fine (and good) to 
make the 'mkdir .snap/foo' block until data is flushed.  (It might be a 
bit more precise to require a fsync to do the waiting part, but users 
won't ever do that.)

What I meant though was that we should keep the extra cap messages that 
flush snapped state, and not make a simplification of the protocol that 
revokes caps from clients (stops all writers) in order to do the snap.  
That would make taking snaps much more expensive in that it would 
interrupt current IO.

On the other hand, it would "fix" the design choice that the snap point 
in time isn't coherent across clients.  But if that is the goal, I think 
we can do that in a less expensive way that revoking all caps... e.g. with 
a single snap prepare/commit message per client, vs a cap msg per inode.

> >> =============
> >>
> >> The last big idea I'd like to explore is changing the way we store
> >> metadata. I'm not sure about this one yet, but I find the idea of
> >> taking actual RADOS snapshots of directory objects, instead of copying
> >> the dentries. If we force clients to flush out all data during a
> >> snapshot, this becomes pretty simple; it's much harder if we try and
> >> maintain async flushing.
> >>
> >> Upsides: we don't "pollute" normal file IO with the snapshotted
> >> entries. Clean up of removed snapshots happens OSD-side with less MDS
> >> work. The best part: we can treat snapshot trees and read activity as
> >> happening on entirely separate but normal pieces of the metadata
> >> hierarchy, instead of on weird special-rule snapshot IO (by just
> >> attaching a SnapContext to all the associated IO, instead of tracking
> >> which dentry the snapid applies to, which past version we should be
> >> reading, etc).
> >>
> >> Downsides: when actually reading snapshot data, there's more
> >> duplication in the cache. The OSDs make some attempt at efficient
> >> copy-on-write of omap data, but it doesn't work very well on backfill,
> >> so we should expect it to take more disk space. And as I mentioned, if
> >> we don't do synchronous snapshots, then it would take some extra
> >> machinery to make sure we flush data out in the right order to make
> >> this work.
> >
> > What if we keep async snap flushes, but separate out snapped metadata in a
> > different dirfrag.. either a snap of the same object or a different
> > object.  We would need to wait until all the snap cap flushes came in
> > before writing it out, so the simplest approach would probably be to
> > create all of the dentries/inodes in the cache and mark it dirty, and
> > defer writing the dirfrag until the last cap flush comes in.  If we do a
> > snap of the same dirfrag, we additionally need to defer any writes to
> > newer dirfrags too (bc we have to write to rados is chronological order
> > for that object).  That's annoying, but possibly worth it to avoid having
> > to do cleanup.
> >
> > All of the complicated 'follows' stuff isn't going to go away,
> > though--it'll just switch change from a dentry to a dirfrag property.
> >
> >> =============
> >>
> >> Side point: hard links are really unpleasant with our snapshots in
> >> general. Right now snapshots apply to the primary link, but not to
> >> others. I can't think of any good solutions: the best one so far
> >> involves moving the inode (either logically or physically) out of the
> >> dentry, and then setting up logic similar to that used for
> >> past_parents and open_snap_parents() whenever you open it from
> >> anywhere. :( I've about convinced myself that's just a flat
> >> requirement (unless we want to go back to having a global lookup table
> >> for all hard links!), but if anybody has alternatives I'd love to hear
> >> them...
> >
> > IMO the current "sloppy" semantics (snapshot applies to first/primary
> > link) are good enough.  Hard links are pretty rare, and often in the same
> > directory anyway.  I agree that to solve it properly the file needs its
> > own snaprealm, which is pretty annoying.
> 
> Mmm. It's true that they're rare, but it's also a very surprising
> behavior for users that's hard to explain. Maybe as an interim measure
> we could disallow creating snapshots at directories which have a
> traversing hard link? I think I've worked out how to do that
> reasonably efficiently.

When this came up a while back the thinking was that we would go down the 
path of explicitly promoting directories to subvolume roots, and only 
allow snapshots on that.  And prevent hard links across those boundaries.  
This was largely in response to the past_parents issues, though, which we 
can solve in another way.  And it never really addressed the issue of 
deciding if you *can* promote a given directory to a subvolume (because 
we'd have to know if there were any hard links that are both inside and 
outside of it).

So... meh.  I'd say the way to deal with this is to either (1) do nothing 
and live with the sloppy semantics (for now), and later (2) do the "right" 
think and turn any hardlinked inode we encounter into it's own snaprealm 
and dup the parents into it.  This would require having the backpointers 
on the hard linked inode so that we can find both parents... which might 
be good, but also re-introduces some complexity that is similar to past 
parents (we can't issues caps on or generate a snapc for a hard linked 
inode until we do this slow process of figuring out it's other hard link 
roots).

sage
