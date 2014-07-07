From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 11/14] rbd: add rbd_obj_watch_request_helper() helper
Date: Mon, 07 Jul 2014 17:36:28 -0500
Message-ID: <53BB20EC.2090403@ieee.org>
References: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com> <1403716607-13535-12-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:62709 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077AbaGGWg1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Jul 2014 18:36:27 -0400
Received: by mail-ig0-f176.google.com with SMTP id r10so11204igi.3
        for <ceph-devel@vger.kernel.org>; Mon, 07 Jul 2014 15:36:27 -0700 (PDT)
In-Reply-To: <1403716607-13535-12-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 06/25/2014 12:16 PM, Ilya Dryomov wrote:
> In the past, rbd_dev_header_watch_sync() used to handle both watch and
> unwatch requests and was entangled and leaky.  Commit b30a01f2a307
> ("rbd: fix osd_request memory leak in __rbd_dev_header_watch_sync()")
> split it into two separate functions.  This commit cleanly abstracts
> the common bits, relying on the fixed rbd_obj_request_wait().

Adding this without calling it leads to an unused function
warning in the build, I'm sure.

You could probably squash this into the next patch.

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  drivers/block/rbd.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 20147aec86f3..02cf7aba7679 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2971,6 +2971,59 @@ static void rbd_watch_cb(u64 ver, u64 notify_id, u8 opcode, void *data)
>  }
>  
>  /*
> + * Send a (un)watch request and wait for the ack.  Return a request
> + * with a ref held on success or error.
> + */
> +static struct rbd_obj_request *rbd_obj_watch_request_helper(
> +						struct rbd_device *rbd_dev,
> +						bool watch)
> +{
> +	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
> +	struct rbd_obj_request *obj_request;
> +	int ret;
> +
> +	obj_request = rbd_obj_request_create(rbd_dev->header_name, 0, 0,
> +					     OBJ_REQUEST_NODATA);
> +	if (!obj_request)
> +		return ERR_PTR(-ENOMEM);
> +
> +	obj_request->osd_req = rbd_osd_req_create(rbd_dev, true, 1,
> +						  obj_request);
> +	if (!obj_request->osd_req) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	osd_req_op_watch_init(obj_request->osd_req, 0, CEPH_OSD_OP_WATCH,
> +			      rbd_dev->watch_event->cookie, 0, watch);
> +	rbd_osd_req_format_write(obj_request);
> +
> +	if (watch)
> +		ceph_osdc_set_request_linger(osdc, obj_request->osd_req);
> +
> +	ret = rbd_obj_request_submit(osdc, obj_request);
> +	if (ret)
> +		goto out;
> +
> +	ret = rbd_obj_request_wait(obj_request);
> +	if (ret)
> +		goto out;
> +
> +	ret = obj_request->result;
> +	if (ret) {
> +		if (watch)
> +			rbd_obj_request_end(obj_request);
> +		goto out;
> +	}
> +
> +	return obj_request;
> +
> +out:
> +	rbd_obj_request_put(obj_request);
> +	return ERR_PTR(ret);
> +}
> +
> +/*
>   * Initiate a watch request, synchronously.
>   */
>  static int rbd_dev_header_watch_sync(struct rbd_device *rbd_dev)
> 

