From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] rbd: assert next_completion under completion_lock
Date: Tue, 25 Mar 2014 10:25:12 -0500
Message-ID: <53319FD8.9020200@ieee.org>
References: <1395755268-11908-1-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f180.google.com ([209.85.220.180]:50408 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878AbaCYPYy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 11:24:54 -0400
Received: by mail-vc0-f180.google.com with SMTP id lf12so730785vcb.25
        for <ceph-devel@vger.kernel.org>; Tue, 25 Mar 2014 08:24:53 -0700 (PDT)
In-Reply-To: <1395755268-11908-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org
Cc: Olivier Bonvalet <ceph.list@daevel.fr>

On 03/25/2014 08:47 AM, Ilya Dryomov wrote:
> completion_lock is there specifically to protect next_completion.
> 
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  drivers/block/rbd.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index fbf41e058bfd..f044fab3da99 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2123,12 +2123,12 @@ static void rbd_img_obj_callback(struct rbd_obj_request *obj_request)
>  	rbd_assert(img_request->obj_request_count > 0);
>  	rbd_assert(which != BAD_WHICH);
>  	rbd_assert(which < img_request->obj_request_count);
> -	rbd_assert(which >= img_request->next_completion);
>  
>  	spin_lock_irq(&img_request->completion_lock);
> -	if (which != img_request->next_completion)
> +	if (which > img_request->next_completion)
>  		goto out;
>  
> +	rbd_assert(which == img_request->next_completion);
>  	for_each_obj_request_from(img_request, obj_request) {
>  		rbd_assert(more);
>  		rbd_assert(which < img_request->obj_request_count);
> 

