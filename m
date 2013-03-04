From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 4/7] ceph: use I_COMPLETE inode flag instead of D_COMPLETE
 flag
Date: Mon, 4 Mar 2013 10:19:28 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1303041018400.14723@cobra.newdream.net>
References: <1362120384-5188-1-git-send-email-zheng.z.yan@intel.com> <1362120384-5188-5-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52264 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758435Ab3CDST2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 13:19:28 -0500
In-Reply-To: <1362120384-5188-5-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 1 Mar 2013, Yan, Zheng wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> commit c6ffe10015 moved the flag that tracks if the dcache contents
> for a directory are complete to dentry. The problem is there are
> lots of places that use ceph_dir_{set,clear,test}_complete() while
> holding i_ceph_lock. but ceph_dir_{set,clear,test}_complete() may
> sleep because they call dput().
> 
> This patch basically reverts that commit. For ceph_d_prune(), it's
> called with both the dentry to prune and the parent dentry are
> locked. So it's safe to access the parent dentry's d_inode and
> clear I_COMPLETE flag.

I'm trying to remember why I thought the D_COMPETE flag was necessary.  
Maybe I didn't think that i_ceph_lock could safely nest inside of d_lock?  
Or that the parent was locked?

Anyway, assuming both of those things are in fact true, this looks good 
(and simpler :).

sage


> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  fs/ceph/caps.c       |  8 ++++---
>  fs/ceph/dir.c        | 62 ++++++++++------------------------------------------
>  fs/ceph/inode.c      | 30 +++++++++++--------------
>  fs/ceph/mds_client.c |  6 ++---
>  fs/ceph/super.h      | 23 ++-----------------
>  5 files changed, 34 insertions(+), 95 deletions(-)
> 
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 61f3833..76634f4 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -490,15 +490,17 @@ static void __check_cap_issue(struct ceph_inode_info *ci, struct ceph_cap *cap,
>  		ci->i_rdcache_gen++;
>  
>  	/*
> -	 * if we are newly issued FILE_SHARED, clear D_COMPLETE; we
> +	 * if we are newly issued FILE_SHARED, clear I_COMPLETE; we
>  	 * don't know what happened to this directory while we didn't
>  	 * have the cap.
>  	 */
>  	if ((issued & CEPH_CAP_FILE_SHARED) &&
>  	    (had & CEPH_CAP_FILE_SHARED) == 0) {
>  		ci->i_shared_gen++;
> -		if (S_ISDIR(ci->vfs_inode.i_mode))
> -			ceph_dir_clear_complete(&ci->vfs_inode);
> +		if (S_ISDIR(ci->vfs_inode.i_mode)) {
> +			dout(" marking %p NOT complete\n", &ci->vfs_inode);
> +			ci->i_ceph_flags &= ~CEPH_I_COMPLETE;
> +		}
>  	}
>  }
>  
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 8c1aabe..76821be 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -107,7 +107,7 @@ static unsigned fpos_off(loff_t p)
>   * falling back to a "normal" sync readdir if any dentries in the dir
>   * are dropped.
>   *
> - * D_COMPLETE tells indicates we have all dentries in the dir.  It is
> + * I_COMPLETE tells indicates we have all dentries in the dir.  It is
>   * defined IFF we hold CEPH_CAP_FILE_SHARED (which will be revoked by
>   * the MDS if/when the directory is modified).
>   */
> @@ -198,8 +198,8 @@ more:
>  	filp->f_pos++;
>  
>  	/* make sure a dentry wasn't dropped while we didn't have parent lock */
> -	if (!ceph_dir_test_complete(dir)) {
> -		dout(" lost D_COMPLETE on %p; falling back to mds\n", dir);
> +	if (!ceph_i_test(dir, CEPH_I_COMPLETE)) {
> +		dout(" lost I_COMPLETE on %p; falling back to mds\n", dir);
>  		err = -EAGAIN;
>  		goto out;
>  	}
> @@ -284,7 +284,7 @@ static int ceph_readdir(struct file *filp, void *dirent, filldir_t filldir)
>  	if ((filp->f_pos == 2 || fi->dentry) &&
>  	    !ceph_test_mount_opt(fsc, NOASYNCREADDIR) &&
>  	    ceph_snap(inode) != CEPH_SNAPDIR &&
> -	    ceph_dir_test_complete(inode) &&
> +	    (ci->i_ceph_flags & CEPH_I_COMPLETE) &&
>  	    __ceph_caps_issued_mask(ci, CEPH_CAP_FILE_SHARED, 1)) {
>  		spin_unlock(&ci->i_ceph_lock);
>  		err = __dcache_readdir(filp, dirent, filldir);
> @@ -350,7 +350,7 @@ more:
>  
>  		if (!req->r_did_prepopulate) {
>  			dout("readdir !did_prepopulate");
> -			fi->dir_release_count--;    /* preclude D_COMPLETE */
> +			fi->dir_release_count--;    /* preclude I_COMPLETE */
>  		}
>  
>  		/* note next offset and last dentry name */
> @@ -429,7 +429,8 @@ more:
>  	 */
>  	spin_lock(&ci->i_ceph_lock);
>  	if (ci->i_release_count == fi->dir_release_count) {
> -		ceph_dir_set_complete(inode);
> +		dout(" marking %p complete\n", inode);
> +		ci->i_ceph_flags |= CEPH_I_COMPLETE;
>  		ci->i_max_offset = filp->f_pos;
>  	}
>  	spin_unlock(&ci->i_ceph_lock);
> @@ -604,7 +605,7 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
>  			    fsc->mount_options->snapdir_name,
>  			    dentry->d_name.len) &&
>  		    !is_root_ceph_dentry(dir, dentry) &&
> -		    ceph_dir_test_complete(dir) &&
> +		    (ci->i_ceph_flags & CEPH_I_COMPLETE) &&
>  		    (__ceph_caps_issued_mask(ci, CEPH_CAP_FILE_SHARED, 1))) {
>  			spin_unlock(&ci->i_ceph_lock);
>  			dout(" dir %p complete, -ENOENT\n", dir);
> @@ -908,7 +909,7 @@ static int ceph_rename(struct inode *old_dir, struct dentry *old_dentry,
>  		 */
>  
>  		/* d_move screws up d_subdirs order */
> -		ceph_dir_clear_complete(new_dir);
> +		ceph_i_clear(new_dir, CEPH_I_COMPLETE);
>  
>  		d_move(old_dentry, new_dentry);
>  
> @@ -1065,44 +1066,6 @@ static int ceph_snapdir_d_revalidate(struct dentry *dentry,
>  }
>  
>  /*
> - * Set/clear/test dir complete flag on the dir's dentry.
> - */
> -void ceph_dir_set_complete(struct inode *inode)
> -{
> -	struct dentry *dentry = d_find_any_alias(inode);
> -	
> -	if (dentry && ceph_dentry(dentry) &&
> -	    ceph_test_mount_opt(ceph_sb_to_client(dentry->d_sb), DCACHE)) {
> -		dout(" marking %p (%p) complete\n", inode, dentry);
> -		set_bit(CEPH_D_COMPLETE, &ceph_dentry(dentry)->flags);
> -	}
> -	dput(dentry);
> -}
> -
> -void ceph_dir_clear_complete(struct inode *inode)
> -{
> -	struct dentry *dentry = d_find_any_alias(inode);
> -
> -	if (dentry && ceph_dentry(dentry)) {
> -		dout(" marking %p (%p) complete\n", inode, dentry);
> -		set_bit(CEPH_D_COMPLETE, &ceph_dentry(dentry)->flags);
> -	}
> -	dput(dentry);
> -}
> -
> -bool ceph_dir_test_complete(struct inode *inode)
> -{
> -	struct dentry *dentry = d_find_any_alias(inode);
> -
> -	if (dentry && ceph_dentry(dentry)) {
> -		dout(" marking %p (%p) NOT complete\n", inode, dentry);
> -		clear_bit(CEPH_D_COMPLETE, &ceph_dentry(dentry)->flags);
> -	}
> -	dput(dentry);
> -	return false;
> -}
> -
> -/*
>   * When the VFS prunes a dentry from the cache, we need to clear the
>   * complete flag on the parent directory.
>   *
> @@ -1110,15 +1073,13 @@ bool ceph_dir_test_complete(struct inode *inode)
>   */
>  static void ceph_d_prune(struct dentry *dentry)
>  {
> -	struct ceph_dentry_info *di;
> -
>  	dout("ceph_d_prune %p\n", dentry);
>  
>  	/* do we have a valid parent? */
>  	if (IS_ROOT(dentry))
>  		return;
>  
> -	/* if we are not hashed, we don't affect D_COMPLETE */
> +	/* if we are not hashed, we don't affect I_COMPLETE */
>  	if (d_unhashed(dentry))
>  		return;
>  
> @@ -1126,8 +1087,7 @@ static void ceph_d_prune(struct dentry *dentry)
>  	 * we hold d_lock, so d_parent is stable, and d_fsdata is never
>  	 * cleared until d_release
>  	 */
> -	di = ceph_dentry(dentry->d_parent);
> -	clear_bit(CEPH_D_COMPLETE, &di->flags);
> +	ceph_i_clear(dentry->d_parent->d_inode, CEPH_I_COMPLETE);
>  }
>  
>  /*
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 2971eaa..42c5769 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -561,7 +561,6 @@ static int fill_inode(struct inode *inode,
>  	struct ceph_inode_info *ci = ceph_inode(inode);
>  	int i;
>  	int issued = 0, implemented;
> -	int updating_inode = 0;
>  	struct timespec mtime, atime, ctime;
>  	u32 nsplits;
>  	struct ceph_buffer *xattr_blob = NULL;
> @@ -601,7 +600,6 @@ static int fill_inode(struct inode *inode,
>  	    (ci->i_version & ~1) >= le64_to_cpu(info->version))
>  		goto no_change;
>  	
> -	updating_inode = 1;
>  	issued = __ceph_caps_issued(ci, &implemented);
>  	issued |= implemented | __ceph_caps_dirty(ci);
>  
> @@ -716,6 +714,17 @@ static int fill_inode(struct inode *inode,
>  		       ceph_vinop(inode), inode->i_mode);
>  	}
>  
> +	/* set dir completion flag? */
> +	if (S_ISDIR(inode->i_mode) &&
> +	    ci->i_files == 0 && ci->i_subdirs == 0 &&
> +	    ceph_snap(inode) == CEPH_NOSNAP &&
> +	    (le32_to_cpu(info->cap.caps) & CEPH_CAP_FILE_SHARED) &&
> +	    (issued & CEPH_CAP_FILE_EXCL) == 0 &&
> +	    (ci->i_ceph_flags & CEPH_I_COMPLETE) == 0) {
> +		dout(" marking %p complete (empty)\n", inode);
> +		ci->i_ceph_flags |= CEPH_I_COMPLETE;
> +		ci->i_max_offset = 2;
> +	}
>  no_change:
>  	spin_unlock(&ci->i_ceph_lock);
>  
> @@ -766,19 +775,6 @@ no_change:
>  		__ceph_get_fmode(ci, cap_fmode);
>  	}
>  
> -	/* set dir completion flag? */
> -	if (S_ISDIR(inode->i_mode) &&
> -	    updating_inode &&                 /* didn't jump to no_change */
> -	    ci->i_files == 0 && ci->i_subdirs == 0 &&
> -	    ceph_snap(inode) == CEPH_NOSNAP &&
> -	    (le32_to_cpu(info->cap.caps) & CEPH_CAP_FILE_SHARED) &&
> -	    (issued & CEPH_CAP_FILE_EXCL) == 0 &&
> -	    !ceph_dir_test_complete(inode)) {
> -		dout(" marking %p complete (empty)\n", inode);
> -		ceph_dir_set_complete(inode);
> -		ci->i_max_offset = 2;
> -	}
> -
>  	/* update delegation info? */
>  	if (dirinfo)
>  		ceph_fill_dirfrag(inode, dirinfo);
> @@ -860,7 +856,7 @@ static void ceph_set_dentry_offset(struct dentry *dn)
>  	di = ceph_dentry(dn);
>  
>  	spin_lock(&ci->i_ceph_lock);
> -	if (!ceph_dir_test_complete(inode)) {
> +	if ((ceph_inode(inode)->i_ceph_flags & CEPH_I_COMPLETE) == 0) {
>  		spin_unlock(&ci->i_ceph_lock);
>  		return;
>  	}
> @@ -1065,7 +1061,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req,
>  			 * d_move() puts the renamed dentry at the end of
>  			 * d_subdirs.  We need to assign it an appropriate
>  			 * directory offset so we can behave when holding
> -			 * D_COMPLETE.
> +			 * I_COMPLETE.
>  			 */
>  			ceph_set_dentry_offset(req->r_old_dentry);
>  			dout("dn %p gets new offset %lld\n", req->r_old_dentry, 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index ccc68b0..e52b0fb 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2029,7 +2029,7 @@ out:
>  }
>  
>  /*
> - * Invalidate dir D_COMPLETE, dentry lease state on an aborted MDS
> + * Invalidate dir I_COMPLETE, dentry lease state on an aborted MDS
>   * namespace request.
>   */
>  void ceph_invalidate_dir_request(struct ceph_mds_request *req)
> @@ -2037,9 +2037,9 @@ void ceph_invalidate_dir_request(struct ceph_mds_request *req)
>  	struct inode *inode = req->r_locked_dir;
>  	struct ceph_inode_info *ci = ceph_inode(inode);
>  
> -	dout("invalidate_dir_request %p (D_COMPLETE, lease(s))\n", inode);
> +	dout("invalidate_dir_request %p (I_COMPLETE, lease(s))\n", inode);
>  	spin_lock(&ci->i_ceph_lock);
> -	ceph_dir_clear_complete(inode);
> +	ci->i_ceph_flags &= ~CEPH_I_COMPLETE;
>  	ci->i_release_count++;
>  	spin_unlock(&ci->i_ceph_lock);
>  
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 4353ebc..efbcb56 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -204,7 +204,6 @@ struct ceph_inode_xattr {
>   * Ceph dentry state
>   */
>  struct ceph_dentry_info {
> -	unsigned long flags;
>  	struct ceph_mds_session *lease_session;
>  	u32 lease_gen, lease_shared_gen;
>  	u32 lease_seq;
> @@ -215,18 +214,6 @@ struct ceph_dentry_info {
>  	u64 offset;
>  };
>  
> -/*
> - * dentry flags
> - *
> - * The locking for D_COMPLETE is a bit odd:
> - *  - we can clear it at almost any time (see ceph_d_prune)
> - *  - it is only meaningful if:
> - *    - we hold dir inode i_ceph_lock
> - *    - we hold dir FILE_SHARED caps
> - *    - the dentry D_COMPLETE is set
> - */
> -#define CEPH_D_COMPLETE 1  /* if set, d_u.d_subdirs is complete directory */
> -
>  struct ceph_inode_xattrs_info {
>  	/*
>  	 * (still encoded) xattr blob. we avoid the overhead of parsing
> @@ -267,7 +254,7 @@ struct ceph_inode_info {
>  	struct timespec i_rctime;
>  	u64 i_rbytes, i_rfiles, i_rsubdirs;
>  	u64 i_files, i_subdirs;
> -	u64 i_max_offset;  /* largest readdir offset, set with D_COMPLETE */
> +	u64 i_max_offset;  /* largest readdir offset, set with I_COMPLETE */
>  
>  	struct rb_root i_fragtree;
>  	struct mutex i_fragtree_mutex;
> @@ -432,6 +419,7 @@ static inline struct inode *ceph_find_inode(struct super_block *sb,
>  /*
>   * Ceph inode.
>   */
> +#define CEPH_I_COMPLETE  1  /* we have complete directory cached */
>  #define CEPH_I_NODELAY   4  /* do not delay cap release */
>  #define CEPH_I_FLUSH     8  /* do not delay flush of dirty metadata */
>  #define CEPH_I_NOFLUSH  16  /* do not flush dirty caps */
> @@ -489,13 +477,6 @@ static inline loff_t ceph_make_fpos(unsigned frag, unsigned off)
>  }
>  
>  /*
> - * set/clear directory D_COMPLETE flag
> - */
> -void ceph_dir_set_complete(struct inode *inode);
> -void ceph_dir_clear_complete(struct inode *inode);
> -bool ceph_dir_test_complete(struct inode *inode);
> -
> -/*
>   * caps helpers
>   */
>  static inline bool __ceph_is_any_real_caps(struct ceph_inode_info *ci)
> -- 
> 1.7.11.7
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
