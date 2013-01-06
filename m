From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 2/6] ceph: move dirty inode to migrating list when clearing
 auth caps
Date: Sat, 5 Jan 2013 22:05:22 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301052205170.15430@cobra.newdream.net>
References: <1357299261-20591-1-git-send-email-zheng.z.yan@intel.com> <1357299261-20591-3-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50604 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736Ab3AFGFX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 6 Jan 2013 01:05:23 -0500
In-Reply-To: <1357299261-20591-3-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Sage Weil <sage@inktank.com>

On Fri, 4 Jan 2013, Yan, Zheng wrote:

> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  fs/ceph/caps.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index a1d9bb3..a9fe2d5 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -611,8 +611,16 @@ retry:
>  
>  	if (flags & CEPH_CAP_FLAG_AUTH)
>  		ci->i_auth_cap = cap;
> -	else if (ci->i_auth_cap == cap)
> +	else if (ci->i_auth_cap == cap) {
>  		ci->i_auth_cap = NULL;
> +		spin_lock(&mdsc->cap_dirty_lock);
> +		if (!list_empty(&ci->i_dirty_item)) {
> +			dout(" moving %p to cap_dirty_migrating\n", inode);
> +			list_move(&ci->i_dirty_item,
> +				  &mdsc->cap_dirty_migrating);
> +		}
> +		spin_unlock(&mdsc->cap_dirty_lock);
> +	}
>  
>  	dout("add_cap inode %p (%llx.%llx) cap %p %s now %s seq %d mds%d\n",
>  	     inode, ceph_vinop(inode), cap, ceph_cap_string(issued),
> -- 
> 1.7.11.7
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
