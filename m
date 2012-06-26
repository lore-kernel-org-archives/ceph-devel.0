From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: FS / Kernel question choosing the correct kernel version
Date: Tue, 26 Jun 2012 10:26:25 +0200
Message-ID: <4FE97231.4070106@profihost.ag>
References: <4FE60A65.2030800@profihost.ag> <Pine.LNX.4.64.1206251506070.22491@cobra.newdream.net> <20120626081442.GA12789@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:60785 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756324Ab2FZI02 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jun 2012 04:26:28 -0400
In-Reply-To: <20120626081442.GA12789@infradead.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 26.06.2012 10:14, schrieb Christoph Hellwig:
> On Mon, Jun 25, 2012 at 03:11:17PM -0700, Sage Weil wrote:
>> On Sat, 23 Jun 2012, Stefan Priebe wrote:
>>> Hi,
>>>
>>> i got stuck while selecting the right FS for ceph / RBD.
>>>
>>> XFS:
>>> - deadlock / hung task under 3.0.34 in xfs_ilock / xfs_buf_lock while syncfs
>>
>> There was an ilock fix that went into 3.4, IIRC.  Have you tried vanilla
>> 3.4?  We are seeing some lockdep noise currently, but no deadlocks yet.
>
> Stefan, which deadlock is this, did you report it to the XFS list?

Yes i did. You are in CC ;-)

http://oss.sgi.com/archives/xfs/2012-05/msg00307.html

But i did not send a sysrq trigger as i then started to work with btrfs. 
As i archieve more than two times better performance with ceph and btrfs.

Stefan

PS: i have this one laying around which is NOT in 3.0.X not sure whether 
this is relevant:

From: Christoph Hellwig <hch@lst.de>
Subject: xfs: don't wait for all pending I/O in ->write_inode

If we wait for all pending I/O in ->write_inode we can starve the caller,
which sine recent changes can also be the flusher thread in kupdate mode.

Fortunately there is no good reason to do the wait, as a blocking caller
already waited for buffered I/O using filemap_write_and_wait_range, and thus
we don't have to rely on this, and kupdated doesn't care for us to finish
the write first, but just wants to snapshot the inode metadata to disk.

Upstream this was fixed in a much more intrusive way by

         xfs: remove i_iocount

and the various patches leading towards it, including changes to the core
AIO code.  I think this simpler patch is the better version for 3.0-stable.

Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/fs/xfs/linux-2.6/xfs_super.c
===================================================================
--- linux-2.6.orig/fs/xfs/linux-2.6/xfs_super.c 2012-03-18 
09:03:27.583397799 +0100
+++ linux-2.6/fs/xfs/linux-2.6/xfs_super.c      2012-03-18 
09:03:45.083398125 +0100
@@ -892,7 +892,6 @@ xfs_fs_write_inode(
                  * ->sync_fs call do that for thus, which reduces the 
number
                  * of synchronous log foces dramatically.
                  */
-               xfs_ioend_wait(ip);
                 error = xfs_log_dirty_inode(ip, NULL, 0);
                 if (error)
                         goto out;
