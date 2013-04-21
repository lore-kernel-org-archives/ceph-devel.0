From: Sage Weil <sage@inktank.com>
Subject: Re: [RESEND][PATCH] fs: remove dentry_lru_prune()
Date: Sun, 21 Apr 2013 13:34:02 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304191343110.13036@cobra.newdream.net>
References: <1366006401-3933-1-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1304160755100.23181@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1304160755100.23181@cobra.newdream.net>
Sender: linux-fsdevel-owner@vger.kernel.org
To: viro@zeniv.linux.org.uk
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>, linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, david@fromorbit.com, greg@inktank.com
List-Id: ceph-devel.vger.kernel.org

Al-

As I mentioned LSF, since there are no other users except for ceph, it's 
probably easiest if this goes through my tree.  Unless you expect 
conflicts with other vfs bits or want this to go through the vfs tree... 
Either way!

Thanks-
sage


On Tue, 16 Apr 2013, Sage Weil wrote:

> On Mon, 15 Apr 2013, Yan, Zheng wrote:
> > From: "Yan, Zheng" <zheng.z.yan@intel.com>
> > 
> > When pruning a dentry, its ancestor dentry can also be pruned. But
> > the ancestor dentry does not go through dput(), so it does not get
> > put on the dentry LRU. Hence associating d_prune with removing the
> > dentry from the LRU is the wrong.
> > 
> > The fix is remove dentry_lru_prune(). Call file system's d_prune()
> > callback directly when pruning dentries.
> > 
> > Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> 
> Reviewed-by: Sage Weil <sage@inktank.com>
> 
> Thanks, Yan!  Sorry for the slow review turnaround; just got back from 
> vacation.
> 
> Al, Ceph is still the only user here.  It should go in during the next 
> merge window along with other ceph fixes in this area.  Should I just pull 
> it into my tree?
> 
> sage
> 
> 
> 
> > ---
> >  fs/dcache.c | 31 +++++++++----------------------
> >  1 file changed, 9 insertions(+), 22 deletions(-)
> > 
> > diff --git a/fs/dcache.c b/fs/dcache.c
> > index e8bc342..3f957c7 100644
> > --- a/fs/dcache.c
> > +++ b/fs/dcache.c
> > @@ -337,23 +337,6 @@ static void dentry_lru_del(struct dentry *dentry)
> >  	}
> >  }
> >  
> > -/*
> > - * Remove a dentry that is unreferenced and about to be pruned
> > - * (unhashed and destroyed) from the LRU, and inform the file system.
> > - * This wrapper should be called _prior_ to unhashing a victim dentry.
> > - */
> > -static void dentry_lru_prune(struct dentry *dentry)
> > -{
> > -	if (!list_empty(&dentry->d_lru)) {
> > -		if (dentry->d_flags & DCACHE_OP_PRUNE)
> > -			dentry->d_op->d_prune(dentry);
> > -
> > -		spin_lock(&dcache_lru_lock);
> > -		__dentry_lru_del(dentry);
> > -		spin_unlock(&dcache_lru_lock);
> > -	}
> > -}
> > -
> >  static void dentry_lru_move_list(struct dentry *dentry, struct list_head *list)
> >  {
> >  	spin_lock(&dcache_lru_lock);
> > @@ -486,11 +469,13 @@ relock:
> >  	if (ref)
> >  		dentry->d_count--;
> >  	/*
> > -	 * if dentry was on the d_lru list delete it from there.
> >  	 * inform the fs via d_prune that this dentry is about to be
> >  	 * unhashed and destroyed.
> >  	 */
> > -	dentry_lru_prune(dentry);
> > +	if (dentry->d_flags & DCACHE_OP_PRUNE)
> > +		dentry->d_op->d_prune(dentry);
> > +
> > +	dentry_lru_del(dentry);
> >  	/* if it was on the hash then remove it */
> >  	__d_drop(dentry);
> >  	return d_kill(dentry, parent);
> > @@ -919,11 +904,13 @@ static void shrink_dcache_for_umount_subtree(struct dentry *dentry)
> >  			struct inode *inode;
> >  
> >  			/*
> > -			 * remove the dentry from the lru, and inform
> > -			 * the fs that this dentry is about to be
> > +			 * inform the fs that this dentry is about to be
> >  			 * unhashed and destroyed.
> >  			 */
> > -			dentry_lru_prune(dentry);
> > +			if (dentry->d_flags & DCACHE_OP_PRUNE)
> > +				dentry->d_op->d_prune(dentry);
> > +
> > +			dentry_lru_del(dentry);
> >  			__d_shrink(dentry);
> >  
> >  			if (dentry->d_count != 0) {
> > -- 
> > 1.7.11.7
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
