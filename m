From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] ceph: check directory's completeness before emitting
 directory entry
Date: Tue, 8 Apr 2014 08:11:12 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1404080810550.22715@cobra.newdream.net>
References: <1396965055-6334-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45476 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757207AbaDHPLN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Apr 2014 11:11:13 -0400
In-Reply-To: <1396965055-6334-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Sage Weil <sage@inktank.com>

Updated the commit in the tree.

sage

On Tue, 8 Apr 2014, Yan, Zheng wrote:

> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  fs/ceph/dir.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 766410a..8c7f90b 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -182,9 +182,16 @@ more:
>  	spin_unlock(&dentry->d_lock);
>  	spin_unlock(&parent->d_lock);
>  
> +	/* make sure a dentry wasn't dropped while we didn't have parent lock */
> +	if (!ceph_dir_is_complete(dir)) {
> +		dout(" lost dir complete on %p; falling back to mds\n", dir);
> +		dput(dentry);
> +		err = -EAGAIN;
> +		goto out;
> +	}
> +
>  	dout(" %llu (%llu) dentry %p %.*s %p\n", di->offset, ctx->pos,
>  	     dentry, dentry->d_name.len, dentry->d_name.name, dentry->d_inode);
> -	ctx->pos = di->offset;
>  	if (!dir_emit(ctx, dentry->d_name.name,
>  		      dentry->d_name.len,
>  		      ceph_translate_ino(dentry->d_sb, dentry->d_inode->i_ino),
> @@ -198,19 +205,12 @@ more:
>  		return 0;
>  	}
>  
> +	ctx->pos = di->offset + 1;
> +
>  	if (last)
>  		dput(last);
>  	last = dentry;
>  
> -	ctx->pos++;
> -
> -	/* make sure a dentry wasn't dropped while we didn't have parent lock */
> -	if (!ceph_dir_is_complete(dir)) {
> -		dout(" lost dir complete on %p; falling back to mds\n", dir);
> -		err = -EAGAIN;
> -		goto out;
> -	}
> -
>  	spin_lock(&parent->d_lock);
>  	p = p->prev;	/* advance to next dentry */
>  	goto more;
> @@ -296,6 +296,8 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
>  		err = __dcache_readdir(file, ctx, shared_gen);
>  		if (err != -EAGAIN)
>  			return err;
> +		frag = fpos_frag(ctx->pos);
> +		off = fpos_off(ctx->pos);
>  	} else {
>  		spin_unlock(&ci->i_ceph_lock);
>  	}
> -- 
> 1.8.5.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
