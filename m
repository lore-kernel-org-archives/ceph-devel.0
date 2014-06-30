From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 02/14] libceph: add maybe_move_osd_to_lru() and switch
 to it
Date: Mon, 30 Jun 2014 07:17:19 -0500
Message-ID: <53B1554F.3050205@ieee.org>
References: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com> <1403716607-13535-3-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:41366 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755709AbaF3MRN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jun 2014 08:17:13 -0400
Received: by mail-ie0-f180.google.com with SMTP id rl12so6854209iec.11
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jun 2014 05:17:12 -0700 (PDT)
In-Reply-To: <1403716607-13535-3-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 06/25/2014 12:16 PM, Ilya Dryomov wrote:
> Abstract out __move_osd_to_lru() logic from __unregister_request() and
> __unregister_linger_request().
> 
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  net/ceph/osd_client.c |   26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index d5d2be3bd113..6202923b41ff 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1029,12 +1029,23 @@ static void remove_all_osds(struct ceph_osd_client *osdc)
>  static void __move_osd_to_lru(struct ceph_osd_client *osdc,
>  			      struct ceph_osd *osd)
>  {
> -	dout("__move_osd_to_lru %p\n", osd);
> +	dout("%s %p\n", __func__, osd);
>  	BUG_ON(!list_empty(&osd->o_osd_lru));
> +
>  	list_add_tail(&osd->o_osd_lru, &osdc->osd_lru);
>  	osd->lru_ttl = jiffies + osdc->client->options->osd_idle_ttl * HZ;
>  }
>  
> +static void maybe_move_osd_to_lru(struct ceph_osd_client *osdc,
> +				  struct ceph_osd *osd)
> +{
> +	dout("%s %p\n", __func__, osd);
> +
> +	if (list_empty(&osd->o_requests) &&
> +	    list_empty(&osd->o_linger_requests))
> +		__move_osd_to_lru(osdc, osd);
> +}
> +
>  static void __remove_osd_from_lru(struct ceph_osd *osd)
>  {
>  	dout("__remove_osd_from_lru %p\n", osd);
> @@ -1182,11 +1193,7 @@ static void __unregister_request(struct ceph_osd_client *osdc,
>  		ceph_msg_revoke(req->r_request);
>  
>  		list_del_init(&req->r_osd_item);
> -		if (list_empty(&req->r_osd->o_requests) &&
> -		    list_empty(&req->r_osd->o_linger_requests)) {
> -			dout("moving osd to %p lru\n", req->r_osd);
> -			__move_osd_to_lru(osdc, req->r_osd);
> -		}
> +		maybe_move_osd_to_lru(osdc, req->r_osd);
>  		if (list_empty(&req->r_linger_item))
>  			req->r_osd = NULL;
>  	}
> @@ -1229,12 +1236,7 @@ static void __unregister_linger_request(struct ceph_osd_client *osdc,
>  	list_del_init(&req->r_linger_item);
>  	if (req->r_osd) {
>  		list_del_init(&req->r_linger_osd_item);
> -
> -		if (list_empty(&req->r_osd->o_requests) &&
> -		    list_empty(&req->r_osd->o_linger_requests)) {
> -			dout("moving osd to %p lru\n", req->r_osd);
> -			__move_osd_to_lru(osdc, req->r_osd);
> -		}
> +		maybe_move_osd_to_lru(osdc, req->r_osd);
>  		if (list_empty(&req->r_osd_item))
>  			req->r_osd = NULL;
>  	}
> 

