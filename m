From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/2] fs: fix dentry_lru_prune()
Date: Sat, 9 Mar 2013 20:35:09 +1100
Message-ID: <20130309093509.GI23616@dastard>
References: <1362656256-4397-1-git-send-email-zheng.z.yan@intel.com>
 <20130308020445.GB23616@dastard>
 <51395034.40709@intel.com>
 <20130308062705.GD23616@dastard>
 <513987EE.4030407@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:49057 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756052Ab3CIJfN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Mar 2013 04:35:13 -0500
Content-Disposition: inline
In-Reply-To: <513987EE.4030407@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, sage@inktank.com, viro@zeniv.linux.org.uk

On Fri, Mar 08, 2013 at 02:40:46PM +0800, Yan, Zheng wrote:
> On 03/08/2013 02:27 PM, Dave Chinner wrote:
> > On Fri, Mar 08, 2013 at 10:43:00AM +0800, Yan, Zheng wrote:
> >> On 03/08/2013 10:04 AM, Dave Chinner wrote:
> >>> On Thu, Mar 07, 2013 at 07:37:36PM +0800, Yan, Zheng wrote:
> >>>> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> >>>>
> >>>> dentry_lru_prune() should always call file system's d_prune callback.
> >>>
> >>> Why? What bug does this fix?
> >>>
> >>
> >> Ceph uses a flag to track if the dcache contents for a directory are complete,
> >> and it relies on d_prune() to clear the flag when some dentries are trimmed.
> >> We noticed that dentry_lru_prune() sometimes does not call ceph_d_prune().
> >> It seems the dentry in question is ancestor trimmed by try_prune_one_dentry().
> > 
> > That doesn't sound right to me. Any dentry that goes through
> > try_prune_one_dentry() is on a LRU list, and will end up in
> > dentry_kill() if the reference count drops to zero and hence calls
> > dentry_lru_prune() with a non-emtpy LRU pointer.
> > 
> > If it has a non-zero reference count, it gets removed from the LRU,
> > and the next call to dput() that drops the reference count to zero
> > will add it back to the LRU and it will go around again. So it
> > sounds to me like there is something else going on here.
> > 
> > FWIW, if the dentry is not on the LRU, why would it need pruning?
> > If it needs pruning regardless of it's status on the LRU, then
> > dentry_lru_prune() should go away entirely and pruning be done
> > explicity where it is needed rather than wrapped up in an unrelated
> > LRU operation....
> > 
> 
> I didn't described it clearly
> 
> static void try_prune_one_dentry(struct dentry *dentry)
> 	__releases(dentry->d_lock)
> {
> 	.....
> 	/* Prune ancestors. */
> 	dentry = parent;
> 	while (dentry) {
> 		spin_lock(&dentry->d_lock);
> 		if (dentry->d_count > 1) {
> 			dentry->d_count--;
> 			spin_unlock(&dentry->d_lock);
> 			return;
> 		}
> 		dentry = dentry_kill(dentry, 1);
>               ~~~~I mean dentries that are pruned here~~~~

IOWs, what we have is a situation where the ancestor dentry never
goes through dput(), and so never gets put on the LRU when it's
reference count goes to zero. Hence associating d_prune with
removing the dentry from the LRU is the wrong thing to be doing
here.

What about the other places that use dentry_lru_prune() - do they
have the same problem? Oh, there's only one -
shrink_dcache_for_umount_subtree() - and it looks to have the same
problem as ancestors have their d_count decremented to zero in the
loop rather than by dput() and so won't be on the LRU.

IOWs, as I mentioned above, dentry_lru_prune should die as .d_prune
is not related to the dentry LRU state at all and needs to be done
unconditionally...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
