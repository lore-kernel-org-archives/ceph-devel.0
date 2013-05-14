From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH] rbd: drop original request earlier for existence check
Date: Mon, 13 May 2013 20:41:50 -0500
Message-ID: <5191965E.5080205@inktank.com>
References: <519195DC.1060609@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:50943 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755499Ab3ENBlw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 May 2013 21:41:52 -0400
Received: by mail-oa0-f46.google.com with SMTP id h2so8445349oag.33
        for <ceph-devel@vger.kernel.org>; Mon, 13 May 2013 18:41:51 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id yx4sm8645863obb.11.2013.05.13.18.41.50
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 13 May 2013 18:41:51 -0700 (PDT)
In-Reply-To: <519195DC.1060609@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 05/13/2013 08:39 PM, Alex Elder wrote:
> The reference to the original request dropped at the end of
> rbd_img_obj_exists_callback() corresponds to the reference taken
> in rbd_img_obj_exists_submit() to account for the stat request
> referring to it.  Move the put of that reference up right after
> clearing that pointer to make its purpose more obvious.

This patch and the one I just posted are available in the
"review/wip-postflatten" branch of the ceph-client git
repository.

					-Alex

> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  drivers/block/rbd.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 632dd35..b2f5c96 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2528,6 +2528,7 @@ static void rbd_img_obj_exists_callback(struct
> rbd_obj_request *obj_request)
>  	 */
>  	orig_request = obj_request->obj_request;
>  	obj_request->obj_request = NULL;
> +	rbd_obj_request_put(orig_request);
>  	rbd_assert(orig_request);
>  	rbd_assert(orig_request->img_request);
> 
> @@ -2548,7 +2549,6 @@ static void rbd_img_obj_exists_callback(struct
> rbd_obj_request *obj_request)
>  	if (!rbd_dev->parent_overlap) {
>  		struct ceph_osd_client *osdc;
> 
> -		rbd_obj_request_put(orig_request);
>  		osdc = &rbd_dev->rbd_client->client->osdc;
>  		result = rbd_obj_request_submit(osdc, orig_request);
>  		if (!result)
> @@ -2578,7 +2578,6 @@ static void rbd_img_obj_exists_callback(struct
> rbd_obj_request *obj_request)
>  out:
>  	if (orig_request->result)
>  		rbd_obj_request_complete(orig_request);
> -	rbd_obj_request_put(orig_request);
>  }
> 
>  static int rbd_img_obj_exists_submit(struct rbd_obj_request *obj_request)
> 

