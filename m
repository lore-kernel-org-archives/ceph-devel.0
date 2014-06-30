From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 01/14] libceph: rename ceph_osd_request::r_linger_osd
 to r_linger_osd_item
Date: Mon, 30 Jun 2014 07:16:08 -0500
Message-ID: <53B15508.1050605@ieee.org>
References: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com> <1403716607-13535-2-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:47006 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301AbaF3MQB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jun 2014 08:16:01 -0400
Received: by mail-ie0-f176.google.com with SMTP id rd18so6828498iec.35
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jun 2014 05:16:00 -0700 (PDT)
In-Reply-To: <1403716607-13535-2-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 06/25/2014 12:16 PM, Ilya Dryomov wrote:
> So that:
> 
> req->r_osd_item --> osd->o_requests list
> req->r_linger_osd_item --> osd->o_linger_requests list
> 
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>

This looks good and I prefer it too.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  include/linux/ceph/osd_client.h |    2 +-
>  net/ceph/osd_client.c           |    8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
> index 94ec69672164..7490a03ac163 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -117,7 +117,7 @@ struct ceph_osd_request {
>  	struct list_head r_req_lru_item;
>  	struct list_head r_osd_item;
>  	struct list_head r_linger_item;
> -	struct list_head r_linger_osd;
> +	struct list_head r_linger_osd_item;
>  	struct ceph_osd *r_osd;
>  	struct ceph_pg   r_pgid;
>  	int              r_pg_osds[CEPH_PG_MAX_SIZE];
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 05be0c181695..d5d2be3bd113 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -364,7 +364,7 @@ struct ceph_osd_request *ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
>  	RB_CLEAR_NODE(&req->r_node);
>  	INIT_LIST_HEAD(&req->r_unsafe_item);
>  	INIT_LIST_HEAD(&req->r_linger_item);
> -	INIT_LIST_HEAD(&req->r_linger_osd);
> +	INIT_LIST_HEAD(&req->r_linger_osd_item);
>  	INIT_LIST_HEAD(&req->r_req_lru_item);
>  	INIT_LIST_HEAD(&req->r_osd_item);
>  
> @@ -916,7 +916,7 @@ static void __kick_osd_requests(struct ceph_osd_client *osdc,
>  	 * list at the end to keep things in tid order.
>  	 */
>  	list_for_each_entry_safe(req, nreq, &osd->o_linger_requests,
> -				 r_linger_osd) {
> +				 r_linger_osd_item) {
>  		/*
>  		 * reregister request prior to unregistering linger so
>  		 * that r_osd is preserved.
> @@ -1218,7 +1218,7 @@ static void __register_linger_request(struct ceph_osd_client *osdc,
>  	ceph_osdc_get_request(req);
>  	list_add_tail(&req->r_linger_item, &osdc->req_linger);
>  	if (req->r_osd)
> -		list_add_tail(&req->r_linger_osd,
> +		list_add_tail(&req->r_linger_osd_item,
>  			      &req->r_osd->o_linger_requests);
>  }
>  
> @@ -1228,7 +1228,7 @@ static void __unregister_linger_request(struct ceph_osd_client *osdc,
>  	dout("__unregister_linger_request %p\n", req);
>  	list_del_init(&req->r_linger_item);
>  	if (req->r_osd) {
> -		list_del_init(&req->r_linger_osd);
> +		list_del_init(&req->r_linger_osd_item);
>  
>  		if (list_empty(&req->r_osd->o_requests) &&
>  		    list_empty(&req->r_osd->o_linger_requests)) {
> 

