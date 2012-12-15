From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 5/9] libceph: init osd->o_node in create_osd()
Date: Fri, 14 Dec 2012 17:43:07 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212141727390.14354@cobra.newdream.net>
References: <50CA0915.1090801@inktank.com> <50CA0A0F.5070101@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40672 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932396Ab2LOBnH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Dec 2012 20:43:07 -0500
In-Reply-To: <50CA0A0F.5070101@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

We should drop this one, I think.  See upstream commit 
4c199a93a2d36b277a9fd209a0f2793f8460a215.  When we added the similar call 
on teh request tree it caused some noise in linux-next and then got 
removed.

sage

On Thu, 13 Dec 2012, Alex Elder wrote:

> It turns out to be harmless but the red-black node o_node in the
> ceph osd structure is not initialized in create_osd().  Add a
> call to rb_init_node() initialize it.
> 
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  net/ceph/osd_client.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 60c74c1..470816c 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -642,6 +642,7 @@ static struct ceph_osd *create_osd(struct
> ceph_osd_client *osdc, int onum)
>  	atomic_set(&osd->o_ref, 1);
>  	osd->o_osdc = osdc;
>  	osd->o_osd = onum;
> +	rb_init_node(&osd->o_node);
>  	INIT_LIST_HEAD(&osd->o_requests);
>  	INIT_LIST_HEAD(&osd->o_linger_requests);
>  	INIT_LIST_HEAD(&osd->o_osd_lru);
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
