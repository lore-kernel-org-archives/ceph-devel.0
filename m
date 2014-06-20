From: Sage Weil <sage@redhat.com>
Subject: Re: [PATCH 1/4] libceph: assert both regular and lingering lists in
 __remove_osd()
Date: Fri, 20 Jun 2014 14:17:20 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1406201417170.23452@cobra.newdream.net>
References: <1403255383-5729-1-git-send-email-ilya.dryomov@inktank.com> <1403255383-5729-2-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49688 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757903AbaFTVRV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jun 2014 17:17:21 -0400
In-Reply-To: <1403255383-5729-2-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by:

On Fri, 20 Jun 2014, Ilya Dryomov wrote:

> It is important that both regular and lingering requests lists are
> empty when the OSD is removed.
> 
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  net/ceph/osd_client.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index b0dfce77656a..6b8c5e8c49ce 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1007,7 +1007,8 @@ static void put_osd(struct ceph_osd *osd)
>  static void __remove_osd(struct ceph_osd_client *osdc, struct ceph_osd *osd)
>  {
>  	dout("__remove_osd %p\n", osd);
> -	BUG_ON(!list_empty(&osd->o_requests));
> +	BUG_ON(!list_empty(&osd->o_requests) ||
> +	       !list_empty(&osd->o_linger_requests));
>  	rb_erase(&osd->o_node, &osdc->osds);
>  	list_del_init(&osd->o_osd_lru);
>  	ceph_con_close(&osd->o_con);
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
