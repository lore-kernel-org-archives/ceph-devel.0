From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] libceph: osd_client: don't drop reply reference too
 early
Date: Wed, 6 Jun 2012 09:18:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206060917500.6423@cobra.newdream.net>
References: <4FCECD7F.9030002@inktank.com> <4FCECEDE.4030902@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56736 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757191Ab2FFQSo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jun 2012 12:18:44 -0400
In-Reply-To: <4FCECEDE.4030902@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 5 Jun 2012, Alex Elder wrote:
> In ceph_osdc_release_request(), a reference to the r_reply message
> is dropped.  But just after that, that same message is revoked if it
> was in use to receive an incoming reply.  Reorder these so we are
> sure we hold a reference until we're actually done with the message.
> 
> Signed-off-by: Alex Elder <elder@inktank.com>

Reviewed-by: Sage Weil <sage@inktank.com>

Good catch.

> ---
>  net/ceph/osd_client.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index e30efbc..d8b6d31 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -139,8 +139,6 @@ void ceph_osdc_release_request(struct kref *kref)
> 
>  	if (req->r_request)
>  		ceph_msg_put(req->r_request);
> -	if (req->r_reply)
> -		ceph_msg_put(req->r_reply);
>  	if (req->r_con_filling_msg) {
>  		dout("release_request revoking pages %p from con %p\n",
>  		     req->r_pages, req->r_con_filling_msg);
> @@ -148,6 +146,8 @@ void ceph_osdc_release_request(struct kref *kref)
>  				      req->r_reply);
>  		ceph_con_put(req->r_con_filling_msg);
>  	}
> +	if (req->r_reply)
> +		ceph_msg_put(req->r_reply);
>  	if (req->r_own_pages)
>  		ceph_release_page_vector(req->r_pages,
>  					 req->r_num_pages);
> -- 
> 1.7.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
