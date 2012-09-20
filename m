From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] ceph: Fix oops when handling mdsmap that decreases
 max_mds
Date: Thu, 20 Sep 2012 11:11:39 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209201111360.8980@cobra.newdream.net>
References: <1348134145-4646-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46684 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279Ab2ITSLk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Sep 2012 14:11:40 -0400
In-Reply-To: <1348134145-4646-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

Applied, thanks!

sage

On Thu, 20 Sep 2012, Yan, Zheng wrote:

> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> When i >= newmap->m_max_mds, ceph_mdsmap_get_addr(newmap, i) return
> NULL. Passing NULL to memcmp() triggers oops.
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  fs/ceph/mds_client.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index a5a7354..1bcf712 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2625,7 +2625,8 @@ static void check_new_map(struct ceph_mds_client *mdsc,
>  		     ceph_mdsmap_is_laggy(newmap, i) ? " (laggy)" : "",
>  		     session_state_name(s->s_state));
>  
> -		if (memcmp(ceph_mdsmap_get_addr(oldmap, i),
> +		if (i >= newmap->m_max_mds ||
> +		    memcmp(ceph_mdsmap_get_addr(oldmap, i),
>  			   ceph_mdsmap_get_addr(newmap, i),
>  			   sizeof(struct ceph_entity_addr))) {
>  			if (s->s_state == CEPH_MDS_SESSION_OPENING) {
> -- 
> 1.7.11.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
