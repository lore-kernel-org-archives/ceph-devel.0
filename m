From: Sage Weil <sweil@redhat.com>
Subject: Re: Problem with slow operation on xattr
Date: Tue, 8 Jul 2014 08:54:26 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1407080847430.9196@cobra.newdream.net>
References: <20140708161717.95584lly2blerls0@intranet.cs.hku.hk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53648 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754398AbaGHPy1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jul 2014 11:54:27 -0400
In-Reply-To: <20140708161717.95584lly2blerls0@intranet.cs.hku.hk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: nyao@cs.hku.hk
Cc: ceph-devel@vger.kernel.org

Hi Neal,

On Tue, 8 Jul 2014, nyao@cs.hku.hk wrote:
> Dear all developers,
> 
> I use the rbd kernel module on the client-end, and when we test the random
> write performance. The throughput is quit poor and always drops to zero.
> 
> And I trace the development logs on the server-side and find that it is always
> blocked in the function: get_object_context, getattr() and _setattrs. The
> average time os about hundreds of milliseconds. Even bad, the maximum latency
> is up to 4-6 seconds, so the throughput observed on the client-side is always
> blocked several seconds. This is really ruining the performance of the
> cluster.
> 
> Therefore, I carefully analyze those functions mentioned above
> (get_object_context, getattr() and _setattrs). I cannot find any blocked code
> except for the system calls for xattr like (fgetattr, fsetattr, flistattr).
> 
> On the OSD node, I use the xfs file system as the underlying osd file system.
> And by default, it will use the extend attribute feature of the xfs to store
> ceph.user xattr (??_?? and ??snapset??). Since those system calls are
> synchronized function call, I set the io-scheduler of the disk to [Deadline]
> so that no reading meta-data will be blocked a long time before it will be
> served. However, even though, the performance is still quite poor and those
> functions mentioned above are still blocked, sometimes, up to several seconds.
> 
> Therefore, I wanna know that how to solve this problem, does ceph provide any
> user-space cache for xattr?
> 
> Does this problem caused by xfs file-system, its xattr system calls?
>
> Furthermore, I try to stop the feature of xfs xattr by setting
> ??filestore_max_inline_xattrs_xfs = 0?? &&
> ??filestore_max_inline_xattr_size_xfs = 0??. So the xattr key/value pair will
> be stored in omap implemented by LevelDB. It solves the problem a bit, the
> maximum blocked interval drops to about 1-2 second. But if the xattr read from
> the physical disk not the page cache, it still quite slow.
> So I wonder that is it a good idea to cache all xattr data in use_space cache
> as for xattr, ??_??, the length is just 242 bytes if we use xfs file-system?
> For hundred thousands of Objects, it will cost just less than 100MB.

I would have guessed that it is not actually the XFS xattrs that are slow, 
but leveldb, which may be used when there are objects that are too big to 
fit inside the file system's xattr.  Have you adjusted any of the 
filestore_max_incline_xattr* options from their defaults?  I don't think 
XFS's getxattr should be that slow.

Ideally the XFS inode size is 1k or more so that the xattrs are embedded 
there; this normally means there is only a single read needed to load 
them up (if they are not already in the cache).  Did your fs get created 
by the ceph-disk or ceph-deploy tools, or did you create those file 
systems manually when your cluster was created?  By default, those tools 
create 2 KB inodes.  Try running xfs_info <mountpiont> to see what the 
current file systems are using.

sage
