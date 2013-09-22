From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 3/3] ceph: drop unconnected inodes
Date: Sat, 21 Sep 2013 20:54:28 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309212052120.19555@cobra.newdream.net>
References: <1379717080-15626-1-git-send-email-zheng.z.yan@intel.com> <1379717080-15626-4-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43893 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615Ab3IVDy3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 21 Sep 2013 23:54:29 -0400
In-Reply-To: <1379717080-15626-4-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

On Sat, 21 Sep 2013, Yan, Zheng wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> Positve dentry and corresponding inode are always accompanied in MDS reply.
> So no need to keep inode in the cache after dropping all its aliases.

Reviewed-by: Sage Weil <sage@inktank.com>


> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  fs/ceph/inode.c | 10 ++++++++++
>  fs/ceph/super.c |  1 +
>  fs/ceph/super.h |  1 +
>  3 files changed, 12 insertions(+)
> 
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 833a4d5..49d4de0 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -436,6 +436,16 @@ void ceph_destroy_inode(struct inode *inode)
>  	call_rcu(&inode->i_rcu, ceph_i_callback);
>  }
>  
> +int ceph_drop_inode(struct inode *inode)
> +{
> +	/*
> +	 * Positve dentry and corresponding inode are always accompanied
> +	 * in MDS reply. So no need to keep inode in the cache after
> +	 * dropping all its aliases.
> +	 */
> +	return 1;
> +}
> +
>  /*
>   * Helpers to fill in size, ctime, mtime, and atime.  We have to be
>   * careful because either the client or MDS may have more up to date
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index 6a0951e..e58bd4a 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -686,6 +686,7 @@ static const struct super_operations ceph_super_ops = {
>  	.alloc_inode	= ceph_alloc_inode,
>  	.destroy_inode	= ceph_destroy_inode,
>  	.write_inode    = ceph_write_inode,
> +	.drop_inode	= ceph_drop_inode,
>  	.sync_fs        = ceph_sync_fs,
>  	.put_super	= ceph_put_super,
>  	.show_options   = ceph_show_options,
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 6014b0a..a538b51 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -691,6 +691,7 @@ extern const struct inode_operations ceph_file_iops;
>  
>  extern struct inode *ceph_alloc_inode(struct super_block *sb);
>  extern void ceph_destroy_inode(struct inode *inode);
> +extern int ceph_drop_inode(struct inode *inode);
>  
>  extern struct inode *ceph_get_inode(struct super_block *sb,
>  				    struct ceph_vino vino);
> -- 
> 1.8.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
