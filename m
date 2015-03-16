From: Sage Weil <sweil@redhat.com>
Subject: Re: ceph-fuse remount issues
Date: Sun, 15 Mar 2015 22:28:08 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1503152222480.28155@cobra.newdream.net>
References: <54E66259.9040501@redhat.com> <C2032CA0-61E4-430E-938F-C40D51BF8DDA@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59426 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750785AbbCPF2J (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 16 Mar 2015 01:28:09 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 8D5858EFC1
	for <ceph-devel@vger.kernel.org>; Mon, 16 Mar 2015 05:28:09 +0000 (UTC)
In-Reply-To: <C2032CA0-61E4-430E-938F-C40D51BF8DDA@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?GB2312?B?0c/V/Q==?= <zyan@redhat.com>
Cc: John Spray <john.spray@redhat.com>, ceph-devel@vger.kernel.org, Gregory Farnum <gfarnum@redhat.com>

Hi Zheng,

On Thu, 26 Feb 2015, ?? wrote:
> > ? 2015?2?20??06:23?John Spray <john.spray@redhat.com> ???
> > 
> > 
> > Background: a while ago, we found (#10277) that existing cache expiration mechanism wasn't working with latest kernels.  We used to invalidate the top level dentries, which caused fuse to invalidate everything, but an implementation detail in fuse caused it to start ignoring our repeated invalidate calls, so this doesn't work any more.  To persuade fuse to dirty its entire metadata cache, Zheng added in a system() call to "mount -o remount" after we expire things from our client side cache.
> 
> Change of d_invalidate() implementation breaks our old cache expiration 
> mechanism. When invalidating a denty, d_invalidate() also walks the 
> dentry subtree and try pruning any unused descendant dentries. Our old 
> cache expiration mechanism replies on this to prune unused dentries. We 
> invalidate the top level dentries, d_invalidate() try pruning unused 
> dentries underneath these top level dentries. Prior to 3.18 kernel, 
> d_invalidate() can fail if the dentry is used by some one. 
> Implementation of d_invalidate() change in 3.18 kernel, d_invalidate() 
> always successes and unhash the dentry even if it?s still in use. This 
> behavior changes make us not be able to use d_invalidate() at will. One 
> known bad consequence is getcwd() system call return -EINVAL after 
> process? working directory gets invalidated.

I took another look at this and it seems to me like we might need 
something more than a new call that does the pruning.  What we were doing 
before was also a bit of a hack, it seems.

What is really going on is that the MDS is telling us to reduce the number 
of inodes we have pinned.  We should ideally turn that into pressure on 
dcache.. but it's not per-superblock, so there's not a shrinker we can 
poke that that does what we want.

We *are* doing the dentry invalidations, so the dentries are unhashed.  
But they aren't getting destroyed... Zheng, this is what the previous hack 
was doing, right?  Forcing unhashed dentries to get trimmed from the LRU?

It seems like the most elegant solution would be to patch fs/fuse to make 
that happen in the general case when we do the invalidate upcall.  Does 
that sound right?

sage
