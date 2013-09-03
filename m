From: Alex Elder <alex.elder@linaro.org>
Subject: Re: [PATCH v2 3/3] rbd: make rbd_obj_notify_ack() synchronous
Date: Tue, 03 Sep 2013 08:05:25 -0500
Message-ID: <5225DE95.4050700@linaro.org>
References: <1377824228-14632-1-git-send-email-josh.durgin@inktank.com> <1377824228-14632-3-git-send-email-josh.durgin@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:64207 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612Ab3ICNFU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Sep 2013 09:05:20 -0400
Received: by mail-ie0-f174.google.com with SMTP id k14so10015633iea.19
        for <ceph-devel@vger.kernel.org>; Tue, 03 Sep 2013 06:05:20 -0700 (PDT)
In-Reply-To: <1377824228-14632-3-git-send-email-josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 08/29/2013 07:57 PM, Josh Durgin wrote:
> The only user is rbd_watch_cb(). If this is asynchronous, there is no

The only user *of rbd_obj_notify_ack()* is rbd_watch_cb().  ...

> tracking of when it completes, so it may still be in progress when the

I think what you're saying is that, because it's currently
asynchronous, the object request may still be in progress.
(I had a little trouble parsing this, as you can see...)

> osd_client is shut down.  This results in a BUG() since the osd client
> assumes no requests are in flight when it stops. Since all notifies
> are flushed now, waiting for the notify ack to complete before
> returning from the watch callback ensures there are no notify acks in
> flight during shutdown.
> 
> Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
> ---
>  drivers/block/rbd.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 2223617..0e83a10 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2826,13 +2826,15 @@ static int rbd_obj_notify_ack(struct rbd_device *rbd_dev, u64 notify_id)

Since you are now making this function wait for the object request
to complete, you should rename the function to match the convention of
all the others that do this.  That is, please rename it:
    rbd_obj_notify_ack_sync()

There's another problem though.  This function used a clever trick of
assigning rbd_obj_request_put() as the object request's callback
function.  This allowed the request to just be sent and cleaned up
whenever it completed.

Since you're now waiting for completion here you need to do the
cleanup here as well.  (Otherwise it might have completed before
the wait call even begins, with unpleasant results.)

So here's what I think you need to do:
- Rename the function rbd_obj_notify_ack_sync()
- delete this line in that function:
        obj_request->callback = rbd_obj_request_put;
- Add your call to rbd_obj_request_wait() (though
  you could ignore the return value).
- Make the call to rbd_obj_request_put() at the end of
  that function unconditional.  I.e., drop the "if (ret)"
  and fix the indentation.

					-Alex

>  	obj_request->osd_req = rbd_osd_req_create(rbd_dev, false, obj_request);
>  	if (!obj_request->osd_req)
>  		goto out;
> -	obj_request->callback = rbd_obj_request_put;
>  
>  	osd_req_op_watch_init(obj_request->osd_req, 0, CEPH_OSD_OP_NOTIFY_ACK,
>  					notify_id, 0, 0);
>  	rbd_osd_req_format_read(obj_request);
>  
>  	ret = rbd_obj_request_submit(osdc, obj_request);
> +	if (ret)
> +		goto out;
> +	ret = rbd_obj_request_wait(obj_request);
>  out:
>  	if (ret)
>  		rbd_obj_request_put(obj_request);
> 

