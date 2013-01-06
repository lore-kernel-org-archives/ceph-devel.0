From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 3/6] ceph: allow revoking duplicated caps issued by
 non-auth MDS
Date: Sat, 5 Jan 2013 22:09:33 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301052208200.15430@cobra.newdream.net>
References: <1357299261-20591-1-git-send-email-zheng.z.yan@intel.com> <1357299261-20591-4-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50637 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736Ab3AFGJe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 6 Jan 2013 01:09:34 -0500
In-Reply-To: <1357299261-20591-4-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 4 Jan 2013, Yan, Zheng wrote:

> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> Allow revoking duplicated caps issued by non-auth MDS if these caps
> are also issued by auth MDS.
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  fs/ceph/caps.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index a9fe2d5..c90b245 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -1468,7 +1468,7 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags,
>  	struct ceph_mds_client *mdsc = fsc->mdsc;
>  	struct inode *inode = &ci->vfs_inode;
>  	struct ceph_cap *cap;
> -	int file_wanted, used;
> +	int file_wanted, used, cap_used;
>  	int took_snap_rwsem = 0;             /* true if mdsc->snap_rwsem held */
>  	int issued, implemented, want, retain, revoking, flushing = 0;
>  	int mds = -1;   /* keep track of how far we've gone through i_caps list
> @@ -1577,6 +1577,10 @@ retry_locked:
>  		     ceph_cap_string(cap->implemented),
>  		     ceph_cap_string(revoking));
>  
> +		cap_used = used;
> +		if (ci->i_auth_cap && cap != ci->i_auth_cap)
> +			cap_used &= ~ci->i_auth_cap->issued;
> +

Let's move this above the dout line, and include used_caps in that, or 
else the next person to parse the debug output will be very confused.  

Otherwise, looks good!

Reviewed-by: Sage Weil <sage@inktank.com>

>  		if (cap == ci->i_auth_cap &&
>  		    (cap->issued & CEPH_CAP_FILE_WR)) {
>  			/* request larger max_size from MDS? */
> @@ -1601,7 +1605,7 @@ retry_locked:
>  		}
>  
>  		/* completed revocation? going down and there are no caps? */
> -		if (revoking && (revoking & used) == 0) {
> +		if (revoking && (revoking & cap_used) == 0) {
>  			dout("completed revocation of %s\n",
>  			     ceph_cap_string(cap->implemented & ~cap->issued));
>  			goto ack;
> @@ -1678,8 +1682,8 @@ ack:
>  		sent++;
>  
>  		/* __send_cap drops i_ceph_lock */
> -		delayed += __send_cap(mdsc, cap, CEPH_CAP_OP_UPDATE, used, want,
> -				      retain, flushing, NULL);
> +		delayed += __send_cap(mdsc, cap, CEPH_CAP_OP_UPDATE, cap_used,
> +				      want, retain, flushing, NULL);
>  		goto retry; /* retake i_ceph_lock and restart our cap scan. */
>  	}
>  
> -- 
> 1.7.11.7
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
