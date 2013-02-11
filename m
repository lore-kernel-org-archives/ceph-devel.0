From: Sage Weil <sage@inktank.com>
Subject: Re: musings on cephfs fsck ...
Date: Sun, 10 Feb 2013 21:32:09 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302092150440.11665@cobra.newdream.net>
References: <alpine.DEB.2.00.1302061822530.7269@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60855 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810Ab3BKFcK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Feb 2013 00:32:10 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 25BAE80068
	for <ceph-devel@vger.kernel.org>; Sun, 10 Feb 2013 21:32:10 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id EEB8D80068
	for <ceph-devel@vger.kernel.org>; Sun, 10 Feb 2013 21:32:09 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1302061822530.7269@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We had a hangout on Friday and made some progress.  The problem can be 
roughly decomposed into two types of checks: a forward, depth-first check 
that scans the namespace and verifies everything is valid and reachable, 
and a (slow) reverse iteration over all directory (or even file) objects 
that verifies that everything is reachable via its backtrace.


Forward scan:

 - depth-first search of the namespace.
 - run by the mds
 - mds can be online
 - mds can efficiently verify the rstats as it goes
   - we can propagate any 'dirty' rstats up the tree as we find them.
 - optionally verify the backtrace values on directories and/or files as 
   we go
   - this can be efficient to: a single backtrace update op can be guarded 
     by a check that the backtrace is valid/up to date.
 - if we encounter a bad forward link (a primary dentry that references a 
   directory whose object does not exist), we add it to the set M
 - we can store M as a key/value object somewhere.
 - we complete the scan and M is empty, and the rstats/dirstats were all 
   clean/correct, we are happy.
 - this can presumably be made a parallel operation without too much 
   trouble
 - we could put a last_scrubbed_subtree stamp in the dirstat struct, but 
   it would mean dirtying directories as we go, which may not be what we 
   want in all cases.  maybe make it optional.
 - i don't think there is any reason why the fs couldn't online and in use 
   while this is going on.  and that is what we want, anyway: online 
   namespace scrubbing for healthy file systems.

This would probably be the first piece we implement.  There would be a 
fast mode and a slow mode, depending on whether we verify 
backtraces.


Backward scan:

The forward scan doesn't help us find lost/orphan directories, and it only 
detects lost directories near the root.  If M is non-empty, we need to do 
the slow part.  A backward scan would:

 - iterate over directory objects in the metadata pool
   - note that these are stored in hash(ino) order, so we get them in 
     random order.
 - for each directory object, we look at the backtrace and traverse 
   forward in the tree to verify it is reachable.
   - if it is not, we recreate the missing directory and add in the 
     forward link from our backtrace.
   - we can mark that link as 'tentative' or 'recovered' or something, 
     along with the (now) partially repopulated directory (which is in M)

Note that doing the above for *all* items would be sufficient, but 
horribly slow... basically, O(n * log^2(n)) or something (assuming some 
caching).  But if M is smallish:

 - only verify backtrace for directories that are descendents of an item 
   in M
   - and only verify the portion of the backtrace that is rooted above the 
     item from M; ignore the child portion.
   - queue a forward scrub starting from that point to see if the 
     reattached subtree is complete.

Note that this is probably not so inefficient, even when that includes a 
lot of directories, because the cache hit rate will be good.  Say we 
have/had /a/b/c/(1..10000000), and b was lost/in M.  For the first c child 
we hit, we would recreate an empty b and link it to c.  Every subsequent 
child would hit the cached c (with a single in-memory ino lookup) and/or 
verify the a/b/c forward dentry/link and we'd move on.

The grand-child of an item in M could be missing to.  So if b and c are 
both lost, and we encounter /a/b/c/1, we add the c link and requeue the 
forward scan, but immediately find that c is missing too and add it to M. 
At that point, we would need to restart the scan.  That is probably not 
ideal.  Instead, each item in M could have a range or interval_set over 
which it has been scanned.  The initial items would be [], but if we add 
in c part-way through the pool, we could just continue our forward scan 
and keep track of which parts of the namespace are checked for that 
ancestor.  

After a full pass over the metadata pool (all dir objects) and/or data 
pool(s) (file objects), items in M that were present for the full pass can 
be marked 'complete' in the fs, and their ancestors adjusted with the new 
summation/stat/last_clean values.

The scan could be optimized in a couple of ways (maybe):

 - push the O(n) search to the OSD
   - a class 'filter' thing would examine each object and determine if it 
     is a match.  it could
   - it could parse the backtrace and pull out just the b and ancestors 
     part, and uniq it over a bunch of objects.
 - maintain an actual index on the OSD
   - add some new rados functionality to maintain a real index over select 
     object xattrs, such as backtraces (or more likely individual 
     backtrace components), so that the search is O(log n) instead of 
     O(n).  or something along those lines.

The trick in pushing filtering to the OSD is that it needs to know what M 
is.  We can do that easily for small M, otherwise we'd need to use a bloom 
filter or something.


The implementation tricks will be:

 - making the forward scan parallel/distributed.  handing off subtrees to
   scan when they are delegated across nodes is the main thing, i think.  
   if there are actual repairs, those would probably appear to be normal 
   updates/mutations.  the existing cache coherency should make the 
   parent's summation/check on a dir after the children complete not much 
   different than a normal filelock scatter/gather type operation.
 - making the forward scan recoverable if an mds restarts.  periodically 
   journal our current 'iterator' position(s)?  or, if we actually write 
   out a last_clean stamp, we would just restart at the beginning and skip
   any recently-scrubbed subtrees.
 - allowing forward and backward work to be going on at the same time.  a 
   backward scan will periodically requeue subtrees for forward scanning.  
   and a forward scan may add to M.

On that last point, I think deconstructing the depth-first search into 
discrete pre- and post- steps (and not recursion) will simplify things, 
and make it more easily parallel.  For example:

scan(dir):
 - add dir to Q

worker():
 - pop X from front of Q
 - if X is a dir:
   - enumerate children
     - push a "done with X" item to Q
     - then push all children on the front of Q
 - if X is a missing dir:
   - add to M
 - if X is a completion:
   - do post(X)

post(dir):
 - enumerate children
 - recalculation summation (rstat, dirstat, whatever)
 - verify that dir inode summation value is correct

...with something else in there to make us defer the post step for 
any items or ancestors of items in M.  And once repaired items are removed 
from M, somehow requeue the post step so they and their ancestors can 
validate the summations.

