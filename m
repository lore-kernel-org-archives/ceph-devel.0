From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 2/2] rbd: don't leak rbd_req for rbd_req_sync_notify_ack()
Date: Mon, 03 Dec 2012 13:07:55 -0800
Message-ID: <50BD14AB.30207@inktank.com>
References: <50B8D8D4.9020703@inktank.com> <50B8D937.5060600@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:59293 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511Ab2LCVIG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Dec 2012 16:08:06 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so2199175pad.19
        for <ceph-devel@vger.kernel.org>; Mon, 03 Dec 2012 13:08:06 -0800 (PST)
In-Reply-To: <50B8D937.5060600@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 11/30/2012 08:05 AM, Alex Elder wrote:
> When rbd_req_sync_notify_ack() calls rbd_do_request() it supplies
> rbd_simple_req_cb() as its callback function.  Because the callback
> is supplied, an rbd_req structure gets allocated and populated so it
> can be used by the callback.  However rbd_simple_req_cb() is not
> freeing (or even using) the rbd_req structure, so it's getting
> leaked.
>
> Since rbd_simple_req_cb() has no need for the rbd_req structure,
> just avoid allocating one for this case.  Of the three calls to
> rbd_do_request(), only the one from rbd_do_op() needs the rbd_req
> structure, and that call can be distinguished from the other two
> because it supplies a non-null rbd_collection pointer.
>
> So fix this leak by only allocating the rbd_req structure if a
> non-null "coll" value is provided to rbd_do_request().
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 78493e7..fca0ebf 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1182,7 +1182,7 @@ static int rbd_do_request(struct request *rq,
>   		bio_get(osd_req->r_bio);
>   	}
>
> -	if (rbd_cb) {
> +	if (coll) {
>   		ret = -ENOMEM;
>   		rbd_req = kmalloc(sizeof(*rbd_req), GFP_NOIO);
>   		if (!rbd_req)
> @@ -1193,7 +1193,7 @@ static int rbd_do_request(struct request *rq,
>   		rbd_req->pages = pages;
>   		rbd_req->len = len;
>   		rbd_req->coll = coll;
> -		rbd_req->coll_index = coll ? coll_index : 0;
> +		rbd_req->coll_index = coll_index;
>   	}
>
>   	osd_req->r_callback = rbd_cb;
>

