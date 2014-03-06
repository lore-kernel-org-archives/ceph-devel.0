From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] ceph: add get_name() NFS export callback
Date: Thu, 6 Mar 2014 10:15:18 -0800
Message-ID: <20140306181518.GA17748@infradead.org>
References: <1394111946-13754-1-git-send-email-zheng.z.yan@intel.com>
 <alpine.DEB.2.00.1403060832170.316@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:37111 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbaCFSPZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Mar 2014 13:15:25 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1403060832170.316@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>, ceph-devel@vger.kernel.org

On Thu, Mar 06, 2014 at 08:45:28AM -0800, Sage Weil wrote:
> This one also worries me.  If the r_locked_dir isn't the current parent 
> anymore, then below in ceph_fill_trace we will be doing a d_alloc etc in 
> the wrong directory... at least with the current version of LOOKUPINO.  Is 
> there an MDS patch that is verifying ino2 is correct?  Otherwise, we might 
> be creating a dentry and setting up a lease etc in a different directory  
> than what the MDS has.
> 
> Sigh... the nfsd's behavior when trying to reconnect things is clearly 
> confusing to me.  Even reading through 
> Documentation/filesystems/nfs/Exporting it isn't obvious what nfsd is 
> actually doing with these methods, or what happens if the filesystem isn't 
> in the state it expects it to be.

After the last round of refactoring by Bruce the code should be fairly
readable now.

Anyway, the basic problem is that a directory dentry must always be
connected up to the filesystem root for proper operation, and for
each level of the diretory hierachy nfsd (or rather exportfs) does the
following:

1) call ->get_parent to get the parent.  fail unless this returns a
   parent dentry.

2) call ->get_name for the parent, dentry pair
   assume already connected by other ways if it returns -ENOENT, fail
   for any other error return

3) call lookup_one_len on parent, name return from ->get_name to
   connect the dentry into parent.  If this returns a different dentry
   assume a rename race which should have connected dentry.  Although
   we ensure it really is connected and return -ESTALE otherwise.
