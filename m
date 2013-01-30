From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 4/4] rbd: don't drop watch requests on completion
Date: Wed, 30 Jan 2013 11:43:41 -0800
Message-ID: <510977ED.70203@inktank.com>
References: <51043EF2.4070305@inktank.com> <51043F71.3050208@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f42.google.com ([209.85.210.42]:41028 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229Ab3A3Tqi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jan 2013 14:46:38 -0500
Received: by mail-da0-f42.google.com with SMTP id z17so918434dal.15
        for <ceph-devel@vger.kernel.org>; Wed, 30 Jan 2013 11:46:38 -0800 (PST)
In-Reply-To: <51043F71.3050208@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/26/2013 12:41 PM, Alex Elder wrote:
> The new request code arranges to get a callback for every osd
> request we submit (this was not the case previously).
>
> We register a lingering object watch request for the header object
> for each mapped rbd image.
>
> If a connection problem occurs, the osd client will re-submit
> lingering requests.  And each time such a request is re-submitted,
> its callback function will get called again.

I think this should be fixed in the osd_client - rbd should only get
the callback once, when the watch is first registered. Later we
could add a separate callback to handle re-registration if we need to.

> We therefore need to ensure the object request associated with the
> lingering osd request stays valid, and the way to do that is to have
> an extra reference to the lingering osd request.
>
> So when a request to initiate a watch has completed, do not drop a
> reference as one normally would.  Instead, hold off dropping that
> reference until the request to tear down that watch request is done.
>
> Also, only set the rbd device's watch_request pointer after the
> watch request has been completed successfully, and clear the
> pointer once it's been torn down.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   31 ++++++++++++++++++++++---------
>   1 file changed, 22 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 340773f..177ba0c 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1716,6 +1716,7 @@ static int rbd_dev_header_watch_sync(struct
> rbd_device *rbd_dev, int start)
>   						&rbd_dev->watch_event);
>   		if (ret < 0)
>   			return ret;
> +		rbd_assert(rbd_dev->watch_event != NULL);
>   	}
>
>   	ret = -ENOMEM;
> @@ -1735,32 +1736,44 @@ static int rbd_dev_header_watch_sync(struct
> rbd_device *rbd_dev, int start)
>   	if (!obj_request->osd_req)
>   		goto out_cancel;
>
> -	if (start) {
> +	if (start)
>   		ceph_osdc_set_request_linger(osdc, obj_request->osd_req);
> -		rbd_dev->watch_request = obj_request;
> -	} else {
> +	else
>   		ceph_osdc_unregister_linger_request(osdc,
>   					rbd_dev->watch_request->osd_req);
> -		rbd_dev->watch_request = NULL;
> -	}
>   	ret = rbd_obj_request_submit(osdc, obj_request);
>   	if (ret)
>   		goto out_cancel;
>   	ret = rbd_obj_request_wait(obj_request);
>   	if (ret)
>   		goto out_cancel;
> -
>   	ret = obj_request->result;
>   	if (ret)
>   		goto out_cancel;
>
> -	if (start)
> -		goto done;	/* Done if setting up the watch request */
> +	/*
> +	 * Since a watch request is set to linger the osd client
> +	 * will hang onto it in case it needs to be re-sent in the
> +	 * event of connection loss.  If we're initiating the watch
> +	 * we therefore do *not* want to drop our reference to the
> +	 * object request now; we'll effectively transfer ownership
> +	 * of it to the osd client instead.  Instead, we'll drop
> +	 * that reference when the watch request gets torn down.
> +	 */
> +	if (start) {
> +		rbd_dev->watch_request = obj_request;
> +
> +		return 0;
> +	}
> +
> +	/* We have successfully torn down the watch request */
> +
> +	rbd_obj_request_put(rbd_dev->watch_request);
> +	rbd_dev->watch_request = NULL;
>   out_cancel:
>   	/* Cancel the event if we're tearing down, or on error */
>   	ceph_osdc_cancel_event(rbd_dev->watch_event);
>   	rbd_dev->watch_event = NULL;
> -done:
>   	if (obj_request)
>   		rbd_obj_request_put(obj_request);
>

