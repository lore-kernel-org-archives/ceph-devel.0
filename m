From: Sage Weil <sage@newdream.net>
Subject: ceph on non-btrfs file systems
Date: Sun, 23 Oct 2011 18:54:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1110231739380.25255@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44751 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541Ab1JXByu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 23 Oct 2011 21:54:50 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 248B3BC957
	for <ceph-devel@vger.kernel.org>; Sun, 23 Oct 2011 18:54:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id EB588BC957
	for <ceph-devel@vger.kernel.org>; Sun, 23 Oct 2011 18:54:49 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Although running on ext4, xfs, or whatever other non-btrfs you want mostly 
works, there are a few important remaining issues:

1- ext4 limits total xattrs for 4KB.  This can cause problems in some 
cases, as Ceph uses xattrs extensively.  Most of the time we don't hit 
this.  We do hit the limit with radosgw pretty easily, though, and may 
also hit it in exceptional cases where the OSD cluster is very unhealthy.

There is a large xattr patch for ext4 from the Lustre folks that has been 
floating around for (I think) years.  Maybe as interest grows in running 
Ceph on ext4 this can move upstream.

Previously we were being forgiving about large setxattr failures on ext3, 
but we found that was leading to corruption in certain cases (because we 
couldn't set our internal metadata), so the next release will assert/crash 
in that case (fail-stop instead of fail-maybe-eventually-corrupt). 

XFS does not have an xattr size limit and thus does have this problem.

2- The other problem is with OSD journal replay of non-idempotent 
transactions.  On non-btrfs backends, the Ceph OSDs use a write-ahead 
journal.  After restart, the OSD does not know exactly which transactions 
in the journal may have already been committed to disk, and may reapply a 
transaction again during replay.  For most operations (write, delete, 
truncate) this is fine.

Some operations, though, are non-idempotent.  The simplest example is 
CLONE, which copies (efficiently, on btrfs) data from one object to 
another.  If the source object is modified, the osd restarts, and then 
the clone is replayed, the target will get incorrect (newer) data.  For 
example,

1- clone A -> B
2- modify A
   <osd crash, replay from 1>

B will get new instead of old contents.  

(This doesn't happen on btrfs because the snapshots allow us to replay 
from a known consistent point in time.)

For things like clone, skipping the operation of the target exists almost 
works, except for cases like

1- clone A -> B
2- modify A
...
3- delete B
   <osd crash, replay from 1>

(Although in that example who cares if B had bad data; it was removed 
anyway.)  The larger problem, though, is that that doesn't always work; 
CLONERANGE copies a range of a file from A to B, where B may already 
exist.  

In practice, the higher level interfaces don't make full use of the 
low-level interface, so it's possible some solution exists that careful 
avoids the problem with a partial solution in the lower layer.  This makes 
me nervous, though, as it is easy to break.

Another possibility:

 - on non-btrfs, we set a xattr on every modified object with the 
   op_seq, the unique sequence number for the transaction.
 - for any (potentially) non-idempotent operation, we fsync() before 
   continuing to the next transaction, to ensure that xattr hits disk.
 - on replay, we skip a transaction if the xattr indicates we already 
   performed this transaction.

Because every 'transaction' only modifies on a single object (file), 
this ought to work.  It'll make things like clone slow, but let's face it: 
they're already slow on non-btrfs file systems because they actually copy 
the data (instead of duplicating the extent refs in btrfs).  And it should 
make the full ObjectStore iterface safe, without upper layers having to 
worry about the kinds and orders of transactions they perform.

Other ideas?

This issue is tracked at http://tracker.newdream.net/issues/213.

sage


