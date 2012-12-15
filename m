From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 6/9] rbd: remove linger unconditionally
Date: Fri, 14 Dec 2012 21:12:29 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212142112220.23307@cobra.newdream.net>
References: <50CA0915.1090801@inktank.com> <50CA0A20.4000502@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42284 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706Ab2LOFM3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 15 Dec 2012 00:12:29 -0500
In-Reply-To: <50CA0A20.4000502@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Sage Weil <sage@inktank.com>

On Thu, 13 Dec 2012, Alex Elder wrote:

> In __unregister_linger_request(), the request is being removed
> from the osd client's req_linger list only when the request
> has a non-null osd pointer.  It should be done whether or not
> the request currently has an osd.
> 
> This is most likely a non-issue because I believe the request
> will always have an osd when this function is called.
> 
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  net/ceph/osd_client.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 470816c..b15b475 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -907,8 +907,8 @@ static void __unregister_linger_request(struct
> ceph_osd_client *osdc,
>  					struct ceph_osd_request *req)
>  {
>  	dout("__unregister_linger_request %p\n", req);
> +	list_del_init(&req->r_linger_item);
>  	if (req->r_osd) {
> -		list_del_init(&req->r_linger_item);
>  		list_del_init(&req->r_linger_osd);
> 
>  		if (list_empty(&req->r_osd->o_requests) &&
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
