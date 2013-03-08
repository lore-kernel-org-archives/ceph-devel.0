From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/2] fs: fix dentry_lru_prune()
Date: Fri, 8 Mar 2013 17:27:05 +1100
Message-ID: <20130308062705.GD23616@dastard>
References: <1362656256-4397-1-git-send-email-zheng.z.yan@intel.com>
 <20130308020445.GB23616@dastard>
 <51395034.40709@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:22372 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750880Ab3CHG1I (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Mar 2013 01:27:08 -0500
Content-Disposition: inline
In-Reply-To: <51395034.40709@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, sage@inktank.com, viro@zeniv.linux.org.uk

On Fri, Mar 08, 2013 at 10:43:00AM +0800, Yan, Zheng wrote:
> On 03/08/2013 10:04 AM, Dave Chinner wrote:
> > On Thu, Mar 07, 2013 at 07:37:36PM +0800, Yan, Zheng wrote:
> >> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> >>
> >> dentry_lru_prune() should always call file system's d_prune callback.
> > 
> > Why? What bug does this fix?
> > 
> 
> Ceph uses a flag to track if the dcache contents for a directory are complete,
> and it relies on d_prune() to clear the flag when some dentries are trimmed.
> We noticed that dentry_lru_prune() sometimes does not call ceph_d_prune().
> It seems the dentry in question is ancestor trimmed by try_prune_one_dentry().

That doesn't sound right to me. Any dentry that goes through
try_prune_one_dentry() is on a LRU list, and will end up in
dentry_kill() if the reference count drops to zero and hence calls
dentry_lru_prune() with a non-emtpy LRU pointer.

If it has a non-zero reference count, it gets removed from the LRU,
and the next call to dput() that drops the reference count to zero
will add it back to the LRU and it will go around again. So it
sounds to me like there is something else going on here.

FWIW, if the dentry is not on the LRU, why would it need pruning?
If it needs pruning regardless of it's status on the LRU, then
dentry_lru_prune() should go away entirely and pruning be done
explicity where it is needed rather than wrapped up in an unrelated
LRU operation....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
