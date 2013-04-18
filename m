From: Sage Weil <sage@inktank.com>
Subject: fuse_lowlevel_notify_inval_inode deadlock
Date: Wed, 17 Apr 2013 17:43:18 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304171730380.23728@cobra.newdream.net>
References: <Pine.LNX.4.64.1108171208490.11873@cobra.newdream.net> <878vqpg7zq.fsf@tucsk.pomaz.szeredi.hu> <Pine.LNX.4.64.1108241218040.31664@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39688 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935595Ab3DRAnS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Apr 2013 20:43:18 -0400
In-Reply-To: <Pine.LNX.4.64.1108241218040.31664@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: fuse-devel@lists.sourceforge.net
Cc: ceph-devel@vger.kernel.org, greg.farnum@inktank.com

We've hit a new deadlock with fuse_lowlevel_notify_inval_inode, this time 
on the read side:

- ceph-fuse queues an invalidate (in a separate thread)
- kernel initiates a read
- invalidate blocks in kernel, waiting on a page lock
- the read blocks in ceph-fuse

Now, assuming we're reading the stack traces properly, this is more or 
less what we see with writes, except with reads, and the obvious "don't 
block the read" would resolve it.

But!  If that is the only way to avoid deadlock, I'm afraid it is 
difficult to implement reliable cache invalidation at all.  The reason we 
are invalidating is because the server told us to: we are no longer 
allowed to do reads and cached data is invalid.  The obvious approach is 
to 

1- stop processing new reads
2- let in-progress reads complete
3- invalidate the cache
4- ack to server

...but that will deadlock as above, as any new read will lock pages before 
blcoking.  If we don't block, then the read may repopulate pages we just 
invalidated.  We could

1- invalidate
2- if any reads happened while we were invalidating, goto 1
3- ack

but then we risk starvation and livelock.

How do other people solve this problem?  It seems like another upcall that 
would let you block new reads (and/or writes) from starting while the 
invalidate is in progress would do the trick, but I'm not convinced I'm 
not missing something much simpler.

sage
