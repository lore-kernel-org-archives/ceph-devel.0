From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] ceph: don't reference req after put
Date: Thu, 29 Nov 2012 08:55:53 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211290855440.30450@cobra.newdream.net>
References: <50B77378.1040202@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59371 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334Ab2K2Qzy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Nov 2012 11:55:54 -0500
In-Reply-To: <50B77378.1040202@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Reviewed-by: Sage Weil <sage@inktank.com>

On Thu, 29 Nov 2012, Alex Elder wrote:

> In __unregister_request(), there is a call to list_del_init()
> referencing a request that was the subject of a call to
> ceph_osdc_put_request() on the previous line.  This is not
> safe, because the request structure could have been freed
> by the time we reach the list_del_init().
> 
> Fix this by reversing the order of these lines.
> 
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  net/ceph/osd_client.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 9b6f0e4..d1177ec 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -797,9 +797,9 @@ static void __unregister_request(struct
> ceph_osd_client *osdc,
>  			req->r_osd = NULL;
>  	}
> 
> +	list_del_init(&req->r_req_lru_item);
>  	ceph_osdc_put_request(req);
> 
> -	list_del_init(&req->r_req_lru_item);
>  	if (osdc->num_requests == 0) {
>  		dout(" no requests, canceling timeout\n");
>  		__cancel_osd_timeout(osdc);
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
