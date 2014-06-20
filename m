From: Sage Weil <sage@redhat.com>
Subject: Re: [PATCH 3/4] rbd: rbd_obj_request_wait() should cancel the request
 if interrupted
Date: Fri, 20 Jun 2014 14:17:34 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1406201417310.23452@cobra.newdream.net>
References: <1403255383-5729-1-git-send-email-ilya.dryomov@inktank.com> <1403255383-5729-4-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49706 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757903AbaFTVRf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jun 2014 17:17:35 -0400
In-Reply-To: <1403255383-5729-4-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by:

On Fri, 20 Jun 2014, Ilya Dryomov wrote:

> rbd_obj_request_wait() should cancel the underlying OSD request if
> interrupted.  Otherwise libceph will hold onto it indefinitely, causing
> assert failures or leaking the original object request.
> 
> Fixes: http://tracker.ceph.com/issues/6628
> 
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  drivers/block/rbd.c |   20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index b2c98c1bc037..1701595648ce 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1558,13 +1558,25 @@ static void rbd_img_request_complete(struct rbd_img_request *img_request)
>  		rbd_img_request_put(img_request);
>  }
>  
> -/* Caller is responsible for rbd_obj_request_destroy(obj_request) */
> -
> +/*
> + * Wait for an object request to complete.  If interrupted, cancel the
> + * underlying osd request.
> + */
>  static int rbd_obj_request_wait(struct rbd_obj_request *obj_request)
>  {
> -	dout("%s: obj %p\n", __func__, obj_request);
> +	int ret;
> +
> +	dout("%s obj %p\n", __func__, obj_request);
>  
> -	return wait_for_completion_interruptible(&obj_request->completion);
> +	ret = wait_for_completion_interruptible(&obj_request->completion);
> +	if (ret < 0) {
> +		dout("%s obj %p interrupted\n", __func__, obj_request);
> +		ceph_osdc_cancel_request(obj_request->osd_req);
> +		return ret;
> +	}
> +
> +	dout("%s obj %p done\n", __func__, obj_request);
> +	return 0;
>  }
>  
>  /*
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
