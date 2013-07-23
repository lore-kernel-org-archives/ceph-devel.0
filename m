From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] ceph: trim deleted inode
Date: Mon, 22 Jul 2013 18:41:54 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307221838490.6532@cobra.newdream.net>
References: <1374373274-3457-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59710 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320Ab3GWBl4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Jul 2013 21:41:56 -0400
In-Reply-To: <1374373274-3457-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

On Sun, 21 Jul 2013, Yan, Zheng wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> The MDS uses caps message to notify clients about deleted inode.
> when receiving a such message, invalidate any alias of the inode.
> This makes the kernel release the inode ASAP.
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  fs/ceph/caps.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 25442b4..b446fdd 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -2334,6 +2334,28 @@ void ceph_put_wrbuffer_cap_refs(struct ceph_inode_info *ci, int nr,
>  }
>  
>  /*
> + * Invalidate unlinked inode's aliases, so we can drop the inode
> + * from the cache ASAP.
> + */
> +static void invalidate_aliases(struct inode *inode)
> +{
> +	struct dentry *dn;
> +
> +	dout("invalidate_aliases inode %p\n", inode);
> +	d_prune_aliases(inode);
> +	while ((dn = d_find_alias(inode))) {
> +		d_delete(dn);
> +		dput(dn);

I don't think this loop is safe.  d_delete() won't unlink the inode if 
there are other refs to the dentry, which would make this get stuck in a 
loop.  Maybe simple checking if we get the same dentry back from 
d_find_alias() as the previous call?

> +		/*
> +		 * for dir inode, d_find_alias() can return
> +		 * disconnected dentry
> +		 */
> +		if (S_ISDIR(inode->i_mode))
> +			break;
> +	}

If we handle the more general case, I'm not sure we need any special case 
here for the directory... although I confess I'm not sure why disconnected 
dentries should be treated specially at all.

> +}
> +
> +/*
>   * Handle a cap GRANT message from the MDS.  (Note that a GRANT may
>   * actually be a revocation if it specifies a smaller cap set.)
>   *
> @@ -2363,6 +2385,7 @@ static void handle_cap_grant(struct inode *inode, struct ceph_mds_caps *grant,
>  	int writeback = 0;
>  	int revoked_rdcache = 0;
>  	int queue_invalidate = 0;
> +	int deleted_inode = 0;
>  
>  	dout("handle_cap_grant inode %p cap %p mds%d seq %d %s\n",
>  	     inode, cap, mds, seq, ceph_cap_string(newcaps));
> @@ -2407,8 +2430,12 @@ static void handle_cap_grant(struct inode *inode, struct ceph_mds_caps *grant,
>  		     from_kgid(&init_user_ns, inode->i_gid));
>  	}
>  
> -	if ((issued & CEPH_CAP_LINK_EXCL) == 0)
> +	if ((issued & CEPH_CAP_LINK_EXCL) == 0) {
>  		set_nlink(inode, le32_to_cpu(grant->nlink));
> +		if (inode->i_nlink == 0 &&
> +		    (newcaps & (CEPH_CAP_LINK_SHARED | CEPH_CAP_LINK_EXCL)))
> +			deleted_inode = 1;
> +	}
>  
>  	if ((issued & CEPH_CAP_XATTR_EXCL) == 0 && grant->xattr_len) {
>  		int len = le32_to_cpu(grant->xattr_len);
> @@ -2517,6 +2544,8 @@ static void handle_cap_grant(struct inode *inode, struct ceph_mds_caps *grant,
>  		ceph_queue_writeback(inode);
>  	if (queue_invalidate)
>  		ceph_queue_invalidate(inode);
> +	if (deleted_inode)
> +		invalidate_aliases(inode);
>  	if (wake)
>  		wake_up_all(&ci->i_cap_wq);

This looks good, though.

Thanks!
sage


>  
> -- 
> 1.8.1.4
> 
> 
