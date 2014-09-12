From: Sage Weil <sweil@redhat.com>
Subject: Re: [PATCH 2/2] ceph: make sure request isn't in any waiting list
 when kicking request.
Date: Fri, 12 Sep 2014 13:16:19 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409121316140.21620@cobra.newdream.net>
References: <1410420156-3289-1-git-send-email-zyan@redhat.com> <1410420156-3289-2-git-send-email-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41296 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbaILUQT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Sep 2014 16:16:19 -0400
In-Reply-To: <1410420156-3289-2-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: ceph-devel@vger.kernel.org, "Yan, Zheng" <ukernel@gmail.com>

Reviewed-by: Sage Weil <sage@redhat.com>

On Thu, 11 Sep 2014, Yan, Zheng wrote:

> From: "Yan, Zheng" <ukernel@gmail.com>
> 
> we may corrupt waiting list if a request in the waiting list is kicked.
> 
> Signed-off-by: Yan, Zheng <zyan@redhat.com>
> ---
>  fs/ceph/mds_client.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 267ba44..a17fc49 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2078,6 +2078,7 @@ static void kick_requests(struct ceph_mds_client *mdsc, int mds)
>  		if (req->r_session &&
>  		    req->r_session->s_mds == mds) {
>  			dout(" kicking tid %llu\n", req->r_tid);
> +			list_del_init(&req->r_wait);
>  			__do_request(mdsc, req);
>  		}
>  	}
> -- 
> 1.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
