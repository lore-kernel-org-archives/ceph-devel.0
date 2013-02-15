From: Gregory Farnum <greg@inktank.com>
Subject: Further thoughts on fsck for CephFS
Date: Thu, 14 Feb 2013 17:12:37 -0800
Message-ID: <CAPYLRzi8dTVG+G0NOO0N8zk1itAStwj3B501A0sZGCgQOUyv6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:47850 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759811Ab3BOBMi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Feb 2013 20:12:38 -0500
Received: by mail-qa0-f47.google.com with SMTP id j8so230328qah.13
        for <ceph-devel@vger.kernel.org>; Thu, 14 Feb 2013 17:12:38 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sam Lang <sam.lang@inktank.com>, Sage Weil <sage@inktank.com>

Sage sent out an early draft of what we were thinking about doing for
fsck on CephFS at the beginning of the week, but it was a bit
incomplete and still very much a work in progress. I spent a good
chunk of today thinking about it more so that we can start planning
ticket-level chunks of work. The following is similar to where Sage's
email ended up, but incorporates a bit more thought about memory
scaling and is hopefully a bit more organized. :)

=46irst, we are breaking up development and running of fsck into two
distinct phases. The first phase will consist of a "forward scrub",
which simply starts with the root directory inode and follows links
forward to check that it can find everything that's linked, and that
the forward- and backward-links are consistent. (Backward links are
under development right now; see http://tracker.ceph.com/issues/3540,
or the CephFS backlog at
http://tracker.ceph.com/rb/master_backlogs/cephfs, which is only
groomed for the first several items on the list but might be of
interest.) The intention for this phase is that it can be used both as
part of a requested full-system fsck, and separately can be used to do
background scrubbing during normal operation.
I've tried to think through this forward scrub phase enough to do real
development planning over the next couple of days, and have included
my description below. Please comment if you see issues or have
questions.

The second phase we're referring to as the "backward scan". This mode
is currently intended to be used as part of the fsck you would run
after somehow losing data in RADOS, and is exclusively an offline
operation =97 no client access to the data is permitted, etc and it
involves scanning through every object in the CephFS metadata and data
storage pools. We haven't thought this one through in quite as much
detail, but I wanted to figure out a mechanism (that scales to large
directories and hierarchies) enough to see how it might impact the
design of our forward scrub. I've got the details I came up with
below, but this is a much more complicated problem and not one we need
to start work on right way so it doesn't go into nearly as much depth.
Again though, please comment if you see any issues, have questions, or
think there's something in the backward scan that impacts the forward
scrub in a way I haven't accounted for!
Thanks,
Greg

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
MDS Forward Scrub
-----------------------------------------------------------------------=
-----
We maintain a stack of inodes to scrub. When a new scrub is requested,
the inode in question goes into this stack at a position depending on
how it's inserted.

We have a separate scrubbing thread in every MDS. This thread begins
in the scrub_node(inode) function, passing in the inode on the top of
the scrub stack.
scrub_node() starts by setting a new scrub_start_stamp and
scrub_start_version on the inode (where the scrub_start_version is the
version of the *parent* of the inode). If the node is a file:
the thread optionally spins off an async check of the backtrace (and
in the future, optionally checks other metadata we might be able to
add or pick up), then sleeps until finish_scrub(inode) is called. (If
it doesn't do the backtrace check, it calls finish_scrub() directly).
If the node is a dirfrag:
put the dirfrag's first child on the top of the stack, and call
scrub_node(child). Note that this might involve reading the dirfrag
off disk, etc.

finish_scrub(inode) is pretty simple. If the inode is a dirfrag:
It verifies that the parent's data matches the aggregate data of the
children, then does the same stuff as to a file:
1) sets last_scrubbed_stamp to scrub_start_stamp, and
last_scrubbed_version to scrub_start_version.
2) Pops the inode off of the scrub queue, and checks if the next thing
up is the inode's parent.
3) If so, calls scrub_node() on the dentry following this one in the
parent dirfrag.
3b) if there are no remaining nodes in the parent dirfrag, it checks
that all the children were scrubbed following the parent's
scrub_start_version (or modified =97 we don't want to scrub hierarchies
that were renamed into the tree following a scrub start), then calls
finish_scrub() on the dirfrag.

If at any point the scrub thread finishes scrubbing a node which does
not start up another one immediately (implying that another scrub got
injected into the middle of one that was already running), it looks at
the node in question. If it's a file, it calls scrub_node() on it. If
it's a dirfrag, it finds the first dentry in the dirfrag with a
last_scrubbed_version less than the dirfrag's last_scrubbed_version,
puts that dentry on the scrub_stack, and calls scrub_node() on that
dentry.

This is simple enough in concept (although functionally it will need
to be broken up quite a bit more in order to do all the locking in a
reasonably efficient fashion). To expand this to a multi-MDS system,
modify it slightly according to the following rules:
1) Only the authoritative MDS for an inode can scrub that inode.
2) If you are scrubbing a tree and reach an inode for which you are
not authoritative, you pass that scrub off to the authoritative node
until you get a result, and place the next inode in the tree on the
top of the stack and start scrubbing it.

But of course you'll note this doesn't include what to do if the
scrubbing turns up an issue. In the initial forward scrub
implementation, this is lame: add the bad object to a designated
key-value object in the RADOS metadata pool, and set an "inconsistent"
flag on it that is propagated up through its ancestors (via a separate
"inconsistent descendant" flag) and triggers admin notifications.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
MDS Backwards Scrub
-----------------------------------------------------------------------=
-----

A reverse scan fsck will only be started at admin request, or if a
forward scrub detects inconsistencies. It disables client writes on
the cluster.

Very broadly:
One MDS is the scrub leader, responsible for maintaining the scrub
list. It might initially contain the list of problem inodes found in a
forward scrub, but it is in general populated by iterating through all
the objects in the metadata (and then data) pools.

=46or each directory or file head object, if it is not marked as alread=
y
scrubbed into place, the scrub leader attempts to find that item
within the already-known tree, using the (coming very shortly!)
lookup-by-ino functionality. If it can't place the inode, it chooses
to temporarily believe the backtrace on the inode and creates the
necessary directories and links, marking them as tentative and
including the version of the backtrace they came from. It then starts
a forward scrub on the dirfrag closest to the root that it was able to
retrieve off disk (that might be nothing, if it can't find any). (This
forward scrub will also be marked as based on a tentative backtrace,
with the version it came from.) Any inconsistencies the forward scrub
finds are marked and written to reference objects for later review.
(This would include things like "I'm sure the backtrace this inode has
which points to me is wrong, because I have a higher version and lack
a dentry for it"). Similarly, if the forward scrub finds objects on
disk with outdated data, it updates their data and marks the reference
objects to note that the object was fixed (and the version it was
fixed up to). If it finds newer data on disk, it incorporates that
into the current tree (with the tentative markings and the versions
that are associated). If the newer data points to a dirfrag that isn't
yet in the tree, it inserts a fake entry and puts it at the bottom of
the scrub queue. It then continues the forward scrub from the node it
was on.
If we find an on-disk version in either a forward or reverse scrub
which places authority for a subtree we're accessing, we stop any
on-going activity and ship it to the authoritative node. If we
discover that we should have authority over a node that somebody else
is currently holding, we send them a message and they stop working on
it and ship it over to us.
An object which does not contain a backpointer and that has no forward
referrents gets placed into a lost+found directory. :(
Once we've completely traversed the CephFS pools, we take the existing
tentative metadata as correct, toss out the pre-fsck versions, and
clean up.

This obviously elides a lot of important details, but I think it
describes an object-listing-based fsck that we can use to recover all
the data the cluster has into the filesystem hierarchy in a way that
scales. I believe the most difficult parts which aren't described here
will be a mechanism that allows maintaining both the original
un-changed data, and the in-progress fsck versions of the inodes, in a
way that allows us to maintain our standard hierarchy migration
mechanisms, journaling (or perhaps not, in this mode), and directory
object management tools. Assuming we can do that (I think we can!),
then this won't be fast, but it will be robust and hopefully not many
times slower than an optimal algorithm would be.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
