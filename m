From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: snapshot implementation problems/options
Date: Fri, 5 Aug 2016 15:57:01 -0700
Message-ID: <CAJ4mKGYbyxOy7S6sRVnMhfXvPS-X+P1YimQQV+jp_1P4z_KP_g@mail.gmail.com>
References: <CAJ4mKGbf-zvTkZaqqsZDOA=ZrCsq=WRP80DM3wQpXcOWxYX-hg@mail.gmail.com>
 <alpine.DEB.2.11.1607281928430.1098@piezo.us.to> <CAJ4mKGbPhW_QefWtUCr-c8j5MM1Th6pvncybo+iyoj1Rd5mSJw@mail.gmail.com>
 <alpine.DEB.2.11.1608050923140.1098@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f176.google.com ([209.85.217.176]:34904 "EHLO
	mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbcHGAiO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 6 Aug 2016 20:38:14 -0400
Received: by mail-ua0-f176.google.com with SMTP id i31so76967009uai.2
        for <ceph-devel@vger.kernel.org>; Sat, 06 Aug 2016 17:38:14 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1608050923140.1098@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: John Spray <jspray@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Zheng Yan <zyan@redhat.com>

On Fri, Aug 5, 2016 at 2:23 AM, Sage Weil <sweil@redhat.com> wrote:
> On Mon, 1 Aug 2016, Gregory Farnum wrote:
>> >> The other big source of bugs in our system is more diffuse, but also
>> >> all for one big feature: we asynchronously flush snapshot data (both
>> >> file data to the OSDs and metadata caps to the MDS). If we were trying
>> >> to ruthlessly simplify things, I'd want to eliminate all that code in
>> >> favor of simply forcing synchronous writeback when taking a snapshot.
>> >> I haven't worked through all the consequences of it yet (probably it
>> >> would involve a freeze on the tree and revoking all caps?) but I'd
>> >> expect it to reduce the amount of code and complication by a
>> >> significant amount. I'm inclined to attempt this but it depends on
>> >> what snapshot behavior we consider acceptable.
>> >
>> > I would be inclined to keep the async behavior here despite the
>> > complexity.  Unless there are fundamental issues we can't fix I think the
>> > complexity is worth it.
>>
>> Ha. We talked about this in standup last week and came to the
>> conclusion that we actually prefer synchronous flushes, because they
>> make the data loss semantics easier for users to understand. Sync
>> snaps seem similarly necessary if an HPC machine were using them for
>> checkpoints. Can you talk about the advantages of async snaps?
>
> Maybe we're just confusing terms.  I think it would be fine (and good) to
> make the 'mkdir .snap/foo' block until data is flushed.  (It might be a
> bit more precise to require a fsync to do the waiting part, but users
> won't ever do that.)
>
> What I meant though was that we should keep the extra cap messages that
> flush snapped state, and not make a simplification of the protocol that
> revokes caps from clients (stops all writers) in order to do the snap.
> That would make taking snaps much more expensive in that it would
> interrupt current IO.
>
> On the other hand, it would "fix" the design choice that the snap point
> in time isn't coherent across clients.  But if that is the goal, I think
> we can do that in a less expensive way that revoking all caps... e.g. with
> a single snap prepare/commit message per client, vs a cap msg per inode.

Ah, I see. We definitely have choices about the exact implementation;
I just noticed a lot of bugs and a lot of code around having the
special snapcap stuff. Even if we maintain some of that to avoid
dropping caps, it's a lot simpler if we can assume that it comes in
ordered with respect to other updates on a per-client basis. I'm
planning to dig into that and do some prototyping (with an eye to it
escaping) when I get back from vacation on the 22 and will definitely
keep the performance implications of dropping caps in mind.

(Although I think we'll need cap revocation as a fallback option for
older clients; I don't think we can get away with ignoring now-new
kernel clients if we want to turn snaps on any time soon.)

>
>> >> =============
>> >>
>> >> The last big idea I'd like to explore is changing the way we store
>> >> metadata. I'm not sure about this one yet, but I find the idea of
>> >> taking actual RADOS snapshots of directory objects, instead of copying
>> >> the dentries. If we force clients to flush out all data during a
>> >> snapshot, this becomes pretty simple; it's much harder if we try and
>> >> maintain async flushing.
>> >>
>> >> Upsides: we don't "pollute" normal file IO with the snapshotted
>> >> entries. Clean up of removed snapshots happens OSD-side with less MDS
>> >> work. The best part: we can treat snapshot trees and read activity as
>> >> happening on entirely separate but normal pieces of the metadata
>> >> hierarchy, instead of on weird special-rule snapshot IO (by just
>> >> attaching a SnapContext to all the associated IO, instead of tracking
>> >> which dentry the snapid applies to, which past version we should be
>> >> reading, etc).
>> >>
>> >> Downsides: when actually reading snapshot data, there's more
>> >> duplication in the cache. The OSDs make some attempt at efficient
>> >> copy-on-write of omap data, but it doesn't work very well on backfill,
>> >> so we should expect it to take more disk space. And as I mentioned, if
>> >> we don't do synchronous snapshots, then it would take some extra
>> >> machinery to make sure we flush data out in the right order to make
>> >> this work.
>> >
>> > What if we keep async snap flushes, but separate out snapped metadata in a
>> > different dirfrag.. either a snap of the same object or a different
>> > object.  We would need to wait until all the snap cap flushes came in
>> > before writing it out, so the simplest approach would probably be to
>> > create all of the dentries/inodes in the cache and mark it dirty, and
>> > defer writing the dirfrag until the last cap flush comes in.  If we do a
>> > snap of the same dirfrag, we additionally need to defer any writes to
>> > newer dirfrags too (bc we have to write to rados is chronological order
>> > for that object).  That's annoying, but possibly worth it to avoid having
>> > to do cleanup.
>> >
>> > All of the complicated 'follows' stuff isn't going to go away,
>> > though--it'll just switch change from a dentry to a dirfrag property.
>> >
>> >> =============
>> >>
>> >> Side point: hard links are really unpleasant with our snapshots in
>> >> general. Right now snapshots apply to the primary link, but not to
>> >> others. I can't think of any good solutions: the best one so far
>> >> involves moving the inode (either logically or physically) out of the
>> >> dentry, and then setting up logic similar to that used for
>> >> past_parents and open_snap_parents() whenever you open it from
>> >> anywhere. :( I've about convinced myself that's just a flat
>> >> requirement (unless we want to go back to having a global lookup table
>> >> for all hard links!), but if anybody has alternatives I'd love to hear
>> >> them...
>> >
>> > IMO the current "sloppy" semantics (snapshot applies to first/primary
>> > link) are good enough.  Hard links are pretty rare, and often in the same
>> > directory anyway.  I agree that to solve it properly the file needs its
>> > own snaprealm, which is pretty annoying.
>>
>> Mmm. It's true that they're rare, but it's also a very surprising
>> behavior for users that's hard to explain. Maybe as an interim measure
>> we could disallow creating snapshots at directories which have a
>> traversing hard link? I think I've worked out how to do that
>> reasonably efficiently.
>
> When this came up a while back the thinking was that we would go down the
> path of explicitly promoting directories to subvolume roots, and only
> allow snapshots on that.  And prevent hard links across those boundaries.
> This was largely in response to the past_parents issues, though, which we
> can solve in another way.  And it never really addressed the issue of
> deciding if you *can* promote a given directory to a subvolume (because
> we'd have to know if there were any hard links that are both inside and
> outside of it).
>
> So... meh.  I'd say the way to deal with this is to either (1) do nothing
> and live with the sloppy semantics (for now), and later (2) do the "right"
> think and turn any hardlinked inode we encounter into it's own snaprealm
> and dup the parents into it.  This would require having the backpointers
> on the hard linked inode so that we can find both parents... which might
> be good, but also re-introduces some complexity that is similar to past
> parents (we can't issues caps on or generate a snapc for a hard linked
> inode until we do this slow process of figuring out it's other hard link
> roots).

Well, there are some other options if we can provide enough tracking
data efficiently. I've been idly thinking through what happens if we
try and maintain descendant hard link counts on directories and I
think it might be feasible and let us track *when* we're crossing a
link, even if we don't have the link itself in-memory.

Quick sketch:

primary /a/b/c
remote hard link /a/1/2 pointing at /a/b/c
/a/b/c says "I have a hard link /a/1/2 whose lowest common parent is /a"
/a/b says "one of my descendants has a hard link whose lowest common
ancestor is /a"
/a says "I have a hard link coming in from children b and 1"
/a/1 says "one of my descendants has a hard link whose lowest common
ancestor is /a"
/a/1/2 says "I reference /a/b/c with lowest common ancestor /a"

That takes up space linear in the depth of the tree for each link,
which isn't great, but isn't totally infeasible. The interesting bit
is that now we can detect when we cross links, by moving part of the
tree or creating a snapshot, and we can put "notifications" about that
at the lowest common ancestor (since obviously it's in memory). And we
can push those notifications down the tree whenever it's convenient;
possibly even without having any descendants in-memory (by sending off
log ops to the child directories). I haven't worked through all
movement cases but I think with the appropriate pointers (both up and
down) it should be workable. Not certain yet if it's worth the cost
and haven't done any real work though.
-Greg
