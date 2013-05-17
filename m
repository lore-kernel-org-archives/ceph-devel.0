From: Sage Weil <sage@inktank.com>
Subject: Re: fscache support
Date: Fri, 17 May 2013 11:37:15 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1305171134450.16140@cobra.newdream.net>
References: <CANP1eJEKUErEYiNaPd=bsHF4Mz5hvyhFTDUkOhWbypDFmrnGPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48258 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755921Ab3EQShQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 May 2013 14:37:16 -0400
In-Reply-To: <CANP1eJEKUErEYiNaPd=bsHF4Mz5hvyhFTDUkOhWbypDFmrnGPg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: ceph-devel@vger.kernel.org

Hi Milosz,
On Fri, 17 May 2013, Milosz Tanski wrote:
> Hello there,
> 
> I'm working on netfs-fscache support to the kernel ceph filesystem
> client. The other filesystems in the kernel that have implemented it
> are NFS and AFS.

Awesome!
 
> In the cache of a inode, how do I tell that's I'm the only person that
> has this file open. So I can tell that I can safely cache the file.
> After reading the code I imagine it has something to do with the
> CEPH_CAP_FILE_SHARED, CEPH_CAP_FILE_EXCL and CEPH_CAP_FILE_CACHE. But
> I wasn't able to find enough info to know that I've implemented my
> cache invalidation correctly.

FILE_CACHE means that we are allowed to cache what we read.  The way to 
invalidate is to look at the rdcache_gen field in the ceph inode struct; 
if it has increased, that FILE_CACHE cap has been revoked and reissued, 
and what we had from before is stale.

Does the cache persist across restarts/remounts?  That is a bit more 
difficult, although it's possible we have a version field we can use for 
that as well...

sage

> To give you a little background. I'm doing this work because I think
> it has great potential for our workload. We're using cephfs as a
> backing store for our distributed  database. Our frontend nodes (the
> ones that perform the querying) contain decent size SSD drives. With
> our primarily read workload and having a high rate of cachability for
> file pages that contain indexes, data extents, ISAM trees. It would be
> nice performance improvement.
> 
> Thanks,
> - Milosz
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
