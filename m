From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH REPOST] rbd: end request on error in rbd_do_request()
 caller
Date: Tue, 15 Jan 2013 16:05:28 -0800
Message-ID: <50F5EEC8.8070004@inktank.com>
References: <50E60B83.2070703@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f52.google.com ([209.85.210.52]:44559 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932492Ab3APAGh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jan 2013 19:06:37 -0500
Received: by mail-da0-f52.google.com with SMTP id f10so278889dak.11
        for <ceph-devel@vger.kernel.org>; Tue, 15 Jan 2013 16:06:37 -0800 (PST)
In-Reply-To: <50E60B83.2070703@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/03/2013 02:51 PM, Alex Elder wrote:
> Only one of the three callers of rbd_do_request() provide a
> collection structure to aggregate status.
>
> If an error occurs in rbd_do_request(), have the caller
> take care of calling rbd_coll_end_req() if necessary in
> that one spot.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

>   drivers/block/rbd.c |   11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 0a35c34..1348825 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1126,12 +1126,8 @@ static int rbd_do_request(struct request *rq,
>   	struct ceph_osd_client *osdc;
>
>   	rbd_req = kzalloc(sizeof(*rbd_req), GFP_NOIO);
> -	if (!rbd_req) {
> -		if (coll)
> -			rbd_coll_end_req_index(rq, coll, coll_index,
> -					       (s32) -ENOMEM, len);
> +	if (!rbd_req)
>   		return -ENOMEM;
> -	}
>
>   	if (coll) {
>   		rbd_req->coll = coll;
> @@ -1206,7 +1202,6 @@ done_err:
>   	bio_chain_put(rbd_req->bio);
>   	ceph_osdc_put_request(osd_req);
>   done_pages:
> -	rbd_coll_end_req(rbd_req, (s32) ret, len);
>   	kfree(rbd_req);
>   	return ret;
>   }
> @@ -1359,7 +1354,9 @@ static int rbd_do_op(struct request *rq,
>   			     ops,
>   			     coll, coll_index,
>   			     rbd_req_cb, 0, NULL);
> -
> +	if (ret < 0)
> +		rbd_coll_end_req_index(rq, coll, coll_index,
> +					(s32) ret, seg_len);
>   	rbd_destroy_ops(ops);
>   done:
>   	kfree(seg_name);
>

