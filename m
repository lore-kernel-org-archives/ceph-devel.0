From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 07/14] libceph: unregister only registered linger requests
Date: Mon, 30 Jun 2014 08:05:33 -0500
Message-ID: <53B1609D.3090202@ieee.org>
References: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com> <1403716607-13535-8-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:61803 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007AbaF3NF2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jun 2014 09:05:28 -0400
Received: by mail-ie0-f176.google.com with SMTP id rd18so6548340iec.7
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jun 2014 06:05:28 -0700 (PDT)
In-Reply-To: <1403716607-13535-8-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 06/25/2014 12:16 PM, Ilya Dryomov wrote:
> Linger requests that have not yet been registered should not be
> unregistered by __unregister_linger_request().  This messes up ref
> count and leads to use-after-free.

This makes sense.  The problem can occur when updating the OSD
map.  An OSD *client* has its list of linger requests, but they
are not all necessarily registered as associated with the *OSD*.
So the __unregister_linger_request() call in kick_requests()
might pass a not-yet-registered linger request.

It could also occur if a client (like RBD) gets an error after
setting a request to linger but the request has completed
successfully.

Anyway, looks good.  This explains why the rename of the
r_linger_osd_item field was helpful.

Reviewed-by: Alex Elder <elder@linaro.org>

> 
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  net/ceph/osd_client.c |   15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index a9b7ea7bfdc6..12ec553a7e76 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1248,7 +1248,9 @@ static void __cancel_request(struct ceph_osd_request *req)
>  static void __register_linger_request(struct ceph_osd_client *osdc,
>  				    struct ceph_osd_request *req)
>  {
> -	dout("__register_linger_request %p\n", req);
> +	dout("%s %p tid %llu\n", __func__, req, req->r_tid);
> +	WARN_ON(!req->r_linger);
> +
>  	ceph_osdc_get_request(req);
>  	list_add_tail(&req->r_linger_item, &osdc->req_linger);
>  	if (req->r_osd)
> @@ -1259,8 +1261,17 @@ static void __register_linger_request(struct ceph_osd_client *osdc,
>  static void __unregister_linger_request(struct ceph_osd_client *osdc,
>  					struct ceph_osd_request *req)
>  {
> -	dout("__unregister_linger_request %p\n", req);
> +	WARN_ON(!req->r_linger);
> +
> +	if (list_empty(&req->r_linger_item)) {
> +		dout("%s %p tid %llu not registered\n", __func__, req,
> +		     req->r_tid);
> +		return;
> +	}
> +
> +	dout("%s %p tid %llu\n", __func__, req, req->r_tid);
>  	list_del_init(&req->r_linger_item);
> +
>  	if (req->r_osd) {
>  		list_del_init(&req->r_linger_osd_item);
>  		maybe_move_osd_to_lru(osdc, req->r_osd);
> 

