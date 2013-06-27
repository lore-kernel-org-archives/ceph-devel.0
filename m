From: Alex Elder <alex.elder@linaro.org>
Subject: Re: [PATCH] rbd: send snapshot context with writes
Date: Thu, 27 Jun 2013 07:40:19 -0500
Message-ID: <51CC32B3.8010907@linaro.org>
References: <1372277199-9774-1-git-send-email-josh.durgin@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:65059 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819Ab3F0MkV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Jun 2013 08:40:21 -0400
Received: by mail-ie0-f172.google.com with SMTP id 16so1439416iea.17
        for <ceph-devel@vger.kernel.org>; Thu, 27 Jun 2013 05:40:20 -0700 (PDT)
In-Reply-To: <1372277199-9774-1-git-send-email-josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 06/26/2013 03:06 PM, Josh Durgin wrote:
> Sending the right snapshot context with each write is required for
> snapshots to work. Due to the ordering of calls, the snapshot context
> is never set for any requests. This causes writes to the current
> version of the image to be reflected in all snapshots, which are
> supposed to be read-only.
> 
> This happens because rbd_osd_req_format_write() sets the snapshot
> context based on obj_request->img_request. At this point, however,
> obj_request->img_request has not been set yet, to the snapshot context
> is set to NULL. Fix this by moving rbd_img_obj_request_add(), which
> sets obj_request->img_request, before the osd request formatting
> calls.
> 
> This resolves:
>     http://tracker.ceph.com/issues/5465

That appears to be the wrong bug number.

One fix needed for commenting style (don't use "//"), but otherwise
this looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> Reported-by: Karol Jurak <karol.jurak@gmail.com>
> Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
> ---
>  drivers/block/rbd.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index d79831a..4b03d02 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2266,13 +2266,15 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
>  					obj_request->pages, length,
>  					offset & ~PAGE_MASK, false, false);
>  
> +		// writes get the snapc from the img_request, so
> +		// set it before formatting the osd_req

Don't use C++ comments, use /* */.

> +		rbd_img_obj_request_add(img_request, obj_request);
>  		if (write_request)
>  			rbd_osd_req_format_write(obj_request);
>  		else
>  			rbd_osd_req_format_read(obj_request);
>  
>  		obj_request->img_offset = img_offset;
> -		rbd_img_obj_request_add(img_request, obj_request);
>  
>  		img_offset += length;
>  		resid -= length;
> 

