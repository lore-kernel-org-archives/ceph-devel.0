From: Sage Weil <sweil@redhat.com>
Subject: FileStore should not use syncfs(2)
Date: Wed, 5 Aug 2015 14:26:30 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508051415070.26854@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58293 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282AbbHEV0d (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 5 Aug 2015 17:26:33 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath.Roy@sandisk.com
Cc: ceph-devel@vger.kernel.org, sjust@redhat.com

Today I learned that syncfs(2) does an O(n) search of the superblock's 
inode list searching for dirty items.  I've always assumed that it was 
only traversing dirty inodes (e.g., a list of dirty inodes), but that 
appears not to be the case, even on the latest kernels.

That means that the more RAM in the box, the larger (generally) the inode 
cache, the longer syncfs(2) will take, and the more CPU you'll waste doing 
it.  The box I was looking at had 256GB of RAM, 36 OSDs, and a load of ~40 
servicing a very light workload, and each syncfs(2) call was taking ~7 
seconds (usually to write out a single inode).

A possible workaround for such boxes is to turn 
/proc/sys/vm/vfs_cache_pressure way up (so that the kernel favors caching 
pages instead of inodes/dentries)...

I think the take-away though is that we do need to bite the bullet and 
make FileStore f[data]sync all the right things so that the syncfs call 
can be avoided.  This is the path you were originally headed down, 
Somnath, and I think it's the right one.

The main thing to watch out for is that according to POSIX you really need 
to fsync directories.  With XFS that isn't the case since all metadata 
operations are going into the journal and that's fully ordered, but we 
don't want to allow data loss on e.g. ext4 (we need to check what the 
metadata ordering behavior is there) or other file systems.

:(

sage
