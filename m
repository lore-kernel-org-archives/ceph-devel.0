From: Sage Weil <sage@inktank.com>
Subject: musings on cephfs fsck ...
Date: Wed, 6 Feb 2013 18:23:44 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302061822530.7269@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50825 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755409Ab3BGCXo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Feb 2013 21:23:44 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 5CA128044F
	for <ceph-devel@vger.kernel.org>; Wed,  6 Feb 2013 18:23:44 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 236DB8044F
	for <ceph-devel@vger.kernel.org>; Wed,  6 Feb 2013 18:23:44 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There are several issues we need to address.

0- Online scrub.  We should be able to do a (parallel) pass over the 
directory tree that verifies that metadata is consistent.  Forward dentry 
links agree with file and directory backtraces.  rstats and dirstats are 
correct.  While the fs is active.

1- Missing/corrupt/incompete mds journal.  If journal replay fails,
currently we just bomb out.  Instead, we need to do one or more of:

  - throw out journal(s) and current mds cluster members, and bring mds(s)
    up.
  - scour as much useful metadata out of the remaining bits of the journal
    first.
  - have a mode/flag (or not?) where we are in 'recovery' or 'unclean'
    mode and will do some sort of online namespace repair.

2- Missing directory.  This is the tricky one because a catastrophic rados 
failure like a loss of a PG would mean we lose a random subset of the 
directory objects.  This would effectively prune off random subtrees of 
the hierarchy, and we'd like to be able to find and reattach them.  This 
is what the backtrace stuff is there for.

3- Corrupt directory object, or corrupt inode metadata.  If a directory 
appears corrupt, we should salvage what we can and try to rebuild the 
rest.  This may just be similar to be above.

Our prevous discussions have focussed on how to handle #2, but I'm hoping 
we can distill this down to a few common recovery behaviors that cover 
entire classes of inconsistencies.

Handling a missing directory object is probably the hardest piece, so 
let's start there.  The basic idea we discussed before is to build a 
working list of missing directories, say M.  We then do a scan of the 
objects in the metadata pool for objects that are children of M accoring 
to their backtrace, and tentatively link them into place.  If we encounter 
some other forward link to one of those children with a newer versoin 
stamp, the newer link wins and the tentative link is removed.

Having complete confidence in the recovered links means we need to scan 
the full namespace.

Searching for children is current an O(n) operation for RADOS, 
unless/until we introduce some indexing of objects.  This may be feasible 
with leveldb, but it's not there yet.

We need to also identify lost grandchildren.  For /a/b/c, the a and b 
directory objects may have been lost, but we only know that a is lost from 
the broken /a link.  If we only search for / children, the rebuilt /a/ 
won't include b (which is also lost).  This means our tentative links may 
need to include multiple ancestors, or be a multiple-pass type of 
operation.  The possibility of directory renames makes this especially 
interesting.  It may be that we shoot not so much for perfectly relinking 
subtrees, but rather for exhaustively linking them, and just aggressively 
push out backtrace updates after renames so that files will reappear 
somewhere reasonably recent.  (This is disaster recovery, after all.)

At a high level, what we are trying to recover is a map of

 ino -> (version, parent ino, name)

for all parent inos in the missing set.

I'm pretty sure we had significantly more insight into what was involved 
here, but it was almost 2 years ago now since we discussed it and I'm 
having trouble dredging it up.  Hopefully this is enough to get people 
started...

sage
