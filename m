From: Gregory Farnum <gfarnum@redhat.com>
Subject: snapshot implementation problems/options
Date: Mon, 25 Jul 2016 19:41:53 -0700
Message-ID: <CAJ4mKGbf-zvTkZaqqsZDOA=ZrCsq=WRP80DM3wQpXcOWxYX-hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f179.google.com ([209.85.217.179]:36389 "EHLO
	mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922AbcGZClz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jul 2016 22:41:55 -0400
Received: by mail-ua0-f179.google.com with SMTP id j59so1215930uaj.3
        for <ceph-devel@vger.kernel.org>; Mon, 25 Jul 2016 19:41:54 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Zheng Yan <zyan@redhat.com>, Sage Weil <sweil@redhat.com>

Now that we've got a stable base filesystem, we're thinking about how
to enable and support long-term the "add-on" features. I've lately
been diving into our snapshot code and thinking about alternatives
that might be easier to implement and debug (we've had snapshots
"basically working" for a long time, and Zheng has made them a lot
more reliable, but they still have some issues especially with
multi-mds stuff).

I sent in a PR (https://github.com/ceph/ceph/pull/10436) with some
basic snapshot documentation, and you may have seen my email on
ceph-users about the expected semantics. This is to discuss in a
little more detail some of the pieces I've run into that are hard, and
the alternatives.

Perhaps the most immediately fixable problem is the "past_parents"
links I reference there. When generating the snapids for a SnapContext
we look at our local SnapRealm *and* all of its past_parents to
generate the complete list. As a consequence, you need to have *all*
of the past_parents loaded in memory when doing writes. :( We've had a
lot of bugs, at least one remains, and I don't know how much are
unfound.
Luckily, this is fairly simple to solve: when we create a new
SnapRealm, or move it or anything, we can merge its ancestral snapids
into the local SnapRealm's list (ie, into the list of snaps in the
associated sr_t on-disk). It looks to be so easy a change that tfter
going through the code, I'm a little baffled that wasn't the design to
begin with! (The trade-off is that on-disk inode structures which
frequently move through SnapRealms will get a little larger. I can't
imagine it being a big deal, especially in comparison to forcing all
the snap parent inodes to be pinned in the cache.)

The other big source of bugs in our system is more diffuse, but also
all for one big feature: we asynchronously flush snapshot data (both
file data to the OSDs and metadata caps to the MDS). If we were trying
to ruthlessly simplify things, I'd want to eliminate all that code in
favor of simply forcing synchronous writeback when taking a snapshot.
I haven't worked through all the consequences of it yet (probably it
would involve a freeze on the tree and revoking all caps?) but I'd
expect it to reduce the amount of code and complication by a
significant amount. I'm inclined to attempt this but it depends on
what snapshot behavior we consider acceptable.

=============

The last big idea I'd like to explore is changing the way we store
metadata. I'm not sure about this one yet, but I find the idea of
taking actual RADOS snapshots of directory objects, instead of copying
the dentries. If we force clients to flush out all data during a
snapshot, this becomes pretty simple; it's much harder if we try and
maintain async flushing.

Upsides: we don't "pollute" normal file IO with the snapshotted
entries. Clean up of removed snapshots happens OSD-side with less MDS
work. The best part: we can treat snapshot trees and read activity as
happening on entirely separate but normal pieces of the metadata
hierarchy, instead of on weird special-rule snapshot IO (by just
attaching a SnapContext to all the associated IO, instead of tracking
which dentry the snapid applies to, which past version we should be
reading, etc).

Downsides: when actually reading snapshot data, there's more
duplication in the cache. The OSDs make some attempt at efficient
copy-on-write of omap data, but it doesn't work very well on backfill,
so we should expect it to take more disk space. And as I mentioned, if
we don't do synchronous snapshots, then it would take some extra
machinery to make sure we flush data out in the right order to make
this work.

=============

Side point: hard links are really unpleasant with our snapshots in
general. Right now snapshots apply to the primary link, but not to
others. I can't think of any good solutions: the best one so far
involves moving the inode (either logically or physically) out of the
dentry, and then setting up logic similar to that used for
past_parents and open_snap_parents() whenever you open it from
anywhere. :( I've about convinced myself that's just a flat
requirement (unless we want to go back to having a global lookup table
for all hard links!), but if anybody has alternatives I'd love to hear
them...

Anyway, these are the things I'm thinking about right now and that
we'll want to consider as we evaluate moving forward on snapshots and
other features. If you have thoughts or design ideas, please speak up!
Thanks,
-Greg
