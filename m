From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] ceph: fix null pointer dereference in
 discard_cap_releases()
Date: Sun, 23 Mar 2014 21:51:11 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1403232151020.26602@cobra.newdream.net>
References: <1395627512-7067-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43787 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbaCXEvL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Mar 2014 00:51:11 -0400
In-Reply-To: <1395627512-7067-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 24 Mar 2014, Yan, Zheng wrote:
> send_mds_reconnect() may call discard_cap_releases() after all
> release messages have been dropped by cleanup_cap_releases()
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>

Reviewed-by: Sage Weil <sage@inktank.com>
> ---
>  fs/ceph/mds_client.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index f260bd8..77640ada4 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -1462,15 +1462,18 @@ static void discard_cap_releases(struct ceph_mds_client *mdsc,
>  
>  	dout("discard_cap_releases mds%d\n", session->s_mds);
>  
> -	/* zero out the in-progress message */
> -	msg = list_first_entry(&session->s_cap_releases,
> -			       struct ceph_msg, list_head);
> -	head = msg->front.iov_base;
> -	num = le32_to_cpu(head->num);
> -	dout("discard_cap_releases mds%d %p %u\n", session->s_mds, msg, num);
> -	head->num = cpu_to_le32(0);
> -	msg->front.iov_len = sizeof(*head);
> -	session->s_num_cap_releases += num;
> +	if (!list_empty(&session->s_cap_releases)) {
> +		/* zero out the in-progress message */
> +		msg = list_first_entry(&session->s_cap_releases,
> +					struct ceph_msg, list_head);
> +		head = msg->front.iov_base;
> +		num = le32_to_cpu(head->num);
> +		dout("discard_cap_releases mds%d %p %u\n",
> +		     session->s_mds, msg, num);
> +		head->num = cpu_to_le32(0);
> +		msg->front.iov_len = sizeof(*head);
> +		session->s_num_cap_releases += num;
> +	}
>  
>  	/* requeue completed messages */
>  	while (!list_empty(&session->s_cap_releases_done)) {
> -- 
> 1.8.5.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
