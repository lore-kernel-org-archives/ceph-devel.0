From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 4/6] ceph: allocate cap_release message when receiving
 cap import
Date: Sat, 5 Jan 2013 22:12:06 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301052210050.15430@cobra.newdream.net>
References: <1357299261-20591-1-git-send-email-zheng.z.yan@intel.com> <1357299261-20591-5-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50675 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822Ab3AFGMG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 6 Jan 2013 01:12:06 -0500
In-Reply-To: <1357299261-20591-5-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Sage Weil <sage@inktank.com>

This is one of those annoying situations where we may not have 
preallocated the memory and in the message handler may not be able to.  
It should be easy to find when we come back to clean that up, though, 
since almost all ceph_add_cap_releases() are similarly affected.


On Fri, 4 Jan 2013, Yan, Zheng wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> When client wants to release an imported cap, it's possible there
> is no reserved cap_release message in corresponding mds session.
> so __queue_cap_release causes kernel panic.
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  fs/ceph/caps.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index c90b245..7e90299 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -2832,6 +2832,9 @@ void ceph_handle_caps(struct ceph_mds_session *session,
>  	dout(" mds%d seq %lld cap seq %u\n", session->s_mds, session->s_seq,
>  	     (unsigned)seq);
>  
> +	if (op == CEPH_CAP_OP_IMPORT)
> +		ceph_add_cap_releases(mdsc, session);
> +
>  	/* lookup ino */
>  	inode = ceph_find_inode(sb, vino);
>  	ci = ceph_inode(inode);
> -- 
> 1.7.11.7
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
