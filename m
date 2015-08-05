From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: FileStore should not use syncfs(2)
Date: Wed, 5 Aug 2015 21:38:10 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CDFBE42@SACMBXIP01.sdcorp.global.sandisk.com>
References: <alpine.DEB.2.00.1508051415070.26854@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0071.outbound.protection.outlook.com ([207.46.100.71]:12514
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750968AbbHEViO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Aug 2015 17:38:14 -0400
In-Reply-To: <alpine.DEB.2.00.1508051415070.26854@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "sjust@redhat.com" <sjust@redhat.com>

Thanks Sage for digging down..I was suspecting something similar.. As I mentioned in today's call, in idle time also syncfs is taking ~60ms. I have 64 GB of RAM in the system.
The workaround I was talking about today  is working pretty good so far. In this implementation, I am not giving much work to syncfs as each worker thread is writing with o_dsync mode. I am issuing syncfs before trimming the journal and most of the time I saw it is taking < 100 ms.
I have to wake up the sync_thread now after each worker thread finished writing. I will benchmark both the approaches. As we discussed earlier, in case of only fsync approach, we still need to do a db sync to make sure the leveldb stuff persisted, right ?

Thanks & Regards
Somnath

-----Original Message-----
From: Sage Weil [mailto:sweil@redhat.com]
Sent: Wednesday, August 05, 2015 2:27 PM
To: Somnath Roy
Cc: ceph-devel@vger.kernel.org; sjust@redhat.com
Subject: FileStore should not use syncfs(2)

Today I learned that syncfs(2) does an O(n) search of the superblock's inode list searching for dirty items.  I've always assumed that it was only traversing dirty inodes (e.g., a list of dirty inodes), but that appears not to be the case, even on the latest kernels.

That means that the more RAM in the box, the larger (generally) the inode cache, the longer syncfs(2) will take, and the more CPU you'll waste doing it.  The box I was looking at had 256GB of RAM, 36 OSDs, and a load of ~40 servicing a very light workload, and each syncfs(2) call was taking ~7 seconds (usually to write out a single inode).

A possible workaround for such boxes is to turn /proc/sys/vm/vfs_cache_pressure way up (so that the kernel favors caching pages instead of inodes/dentries)...

I think the take-away though is that we do need to bite the bullet and make FileStore f[data]sync all the right things so that the syncfs call can be avoided.  This is the path you were originally headed down, Somnath, and I think it's the right one.

The main thing to watch out for is that according to POSIX you really need to fsync directories.  With XFS that isn't the case since all metadata operations are going into the journal and that's fully ordered, but we don't want to allow data loss on e.g. ext4 (we need to check what the metadata ordering behavior is there) or other file systems.

:(

sage

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

