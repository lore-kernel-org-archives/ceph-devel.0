From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 07/14] libceph: unregister only registered linger requests
Date: Mon, 30 Jun 2014 08:50:58 -0500
Message-ID: <53B16B42.80902@ieee.org>
References: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com> <1403716607-13535-8-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:56406 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497AbaF3Nuv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jun 2014 09:50:51 -0400
Received: by mail-ig0-f181.google.com with SMTP id h15so4276882igd.8
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jun 2014 06:50:50 -0700 (PDT)
In-Reply-To: <1403716607-13535-8-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 06/25/2014 12:16 PM, Ilya Dryomov wrote:
> Linger requests that have not yet been registered should not be
> unregistered by __unregister_linger_request().  This messes up ref
> count and leads to use-after-free.
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


I just noticed something.  ceph_osdc_unregister_linger_request()
clears req->r_linger before calling __unregister_linger_request(),
which means this warning must be tripping a lot...

Just delete that assignment in ceph_osdc_unregister_linger_request()
as part of this commit.

					-Alex


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

