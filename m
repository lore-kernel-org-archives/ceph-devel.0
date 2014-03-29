From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] rbd: drop an unsafe assertion
Date: Fri, 28 Mar 2014 17:41:31 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1403281739030.22715@cobra.newdream.net>
References: <1395867122-9340-1-git-send-email-elder@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58084 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683AbaC2Alc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Mar 2014 20:41:32 -0400
In-Reply-To: <1395867122-9340-1-git-send-email-elder@linaro.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ilya.dryomov@inktank.com, Alex Elder <elder@linaro.org>
Cc: ceph-devel@vger.kernel.org, ob@daevel.fr

Hi Alex, Ilya,

I've added this and the previous patch to a for-linus branch to send to 
Linux for 3.14.  The net of the two patches is simply removing the assert, 
however... the first changes several lines that then get changed back.  
Should we squash them?

Thanks!
sage


On Wed, 26 Mar 2014, Alex Elder wrote:

> Olivier Bonvalet reported having repeated crashes due to a failed
> assertion he was hitting in rbd_img_obj_callback():
> 
>     Assertion failure in rbd_img_obj_callback() at line 2165:
> 	rbd_assert(which == img_request->next_completion);
> 
> With a lot of help from Olivier with reproducing the problem
> we were able to determine the object and image requests had
> already been completed (and often freed) at the point the
> assertion failed.
> 
> There was a great deal of discussion on the ceph-devel mailing list
> about this.  The problem only arose when there were two (or more)
> object requests in an image request, and the problem was always
> seen when the second request was being completed.
> 
> The problem is due to a race in the window between setting the
> "done" flag on an object request and checking the image request's
> next completion value.  When the first object request completes, it
> checks to see if its successor request is marked "done", and if
> so, that request is also completed.  In the process, the image
> request's next_completion value is updated to reflect that both
> the first and second requests are completed.  By the time the
> second request is able to check the next_completion value, it
> has been set to a value *greater* than its own "which" value,
> which caused an assertion to fail.
> 
> Fix this problem by skipping over any completion processing
> unless the completing object request is the next one expected.
> Test only for inequality (not >=), and eliminate the bad
> assertion.
> 
> Tested-by: Olivier Bonvalet <ob@daevel.fr>
> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>  drivers/block/rbd.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index f044fab..4c95b50 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2125,10 +2125,9 @@ static void rbd_img_obj_callback(struct rbd_obj_request *obj_request)
>  	rbd_assert(which < img_request->obj_request_count);
>  
>  	spin_lock_irq(&img_request->completion_lock);
> -	if (which > img_request->next_completion)
> +	if (which != img_request->next_completion)
>  		goto out;
>  
> -	rbd_assert(which == img_request->next_completion);
>  	for_each_obj_request_from(img_request, obj_request) {
>  		rbd_assert(more);
>  		rbd_assert(which < img_request->obj_request_count);
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
