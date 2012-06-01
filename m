From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 10/13] libceph: provide osd number when creating osd
Date: Thu, 31 May 2012 21:29:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1205312129390.2166@cobra.newdream.net>
References: <4FC673FC.3060004@inktank.com> <4FC6766E.4050007@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35082 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754306Ab2FAE3t (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Jun 2012 00:29:49 -0400
In-Reply-To: <4FC6766E.4050007@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Looks good!

Reviewed-by: Sage Weil <sage@inktank.com>

On Wed, 30 May 2012, Alex Elder wrote:

> Pass the osd number to the create_osd() routine, and move the
> initialization of fields that depend on it therein.
> 
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  net/ceph/osd_client.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index cca4c7f..e30efbc 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -624,7 +624,7 @@ static void osd_reset(struct ceph_connection *con)
>  /*
>   * Track open sessions with osds.
>   */
> -static struct ceph_osd *create_osd(struct ceph_osd_client *osdc)
> +static struct ceph_osd *create_osd(struct ceph_osd_client *osdc, int onum)
>  {
>  	struct ceph_osd *osd;
> 
> @@ -634,6 +634,7 @@ static struct ceph_osd *create_osd(struct ceph_osd_client
> *osdc)
> 
>  	atomic_set(&osd->o_ref, 1);
>  	osd->o_osdc = osdc;
> +	osd->o_osd = onum;
>  	INIT_LIST_HEAD(&osd->o_requests);
>  	INIT_LIST_HEAD(&osd->o_linger_requests);
>  	INIT_LIST_HEAD(&osd->o_osd_lru);
> @@ -643,6 +644,7 @@ static struct ceph_osd *create_osd(struct ceph_osd_client
> *osdc)
>  	osd->o_con.private = osd;
>  	osd->o_con.ops = &osd_con_ops;
>  	osd->o_con.peer_name.type = CEPH_ENTITY_TYPE_OSD;
> +	osd->o_con.peer_name.num = cpu_to_le64(onum);
> 
>  	INIT_LIST_HEAD(&osd->o_keepalive_item);
>  	return osd;
> @@ -998,15 +1000,13 @@ static int __map_request(struct ceph_osd_client *osdc,
>  	req->r_osd = __lookup_osd(osdc, o);
>  	if (!req->r_osd && o >= 0) {
>  		err = -ENOMEM;
> -		req->r_osd = create_osd(osdc);
> +		req->r_osd = create_osd(osdc, o);
>  		if (!req->r_osd) {
>  			list_move(&req->r_req_lru_item, &osdc->req_notarget);
>  			goto out;
>  		}
> 
>  		dout("map_request osd %p is osd%d\n", req->r_osd, o);
> -		req->r_osd->o_osd = o;
> -		req->r_osd->o_con.peer_name.num = cpu_to_le64(o);
>  		__insert_osd(osdc, req->r_osd);
> 
>  		ceph_con_open(&req->r_osd->o_con, &osdc->osdmap->osd_addr[o]);
> -- 
> 1.7.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
