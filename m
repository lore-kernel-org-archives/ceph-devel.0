From: Alex Elder <elder@linaro.org>
Subject: Re: [PATCH 3/8] rbd: mark the original request as done if stat
 request fails
Date: Fri, 23 Sep 2016 16:39:21 -0500
Message-ID: <958d3978-03b3-1d51-2bc6-1f80af9a0755@linaro.org>
References: <1474304608-17958-1-git-send-email-idryomov@gmail.com>
 <1474304608-17958-4-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:34482 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758358AbcIWVjX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Sep 2016 17:39:23 -0400
Received: by mail-io0-f170.google.com with SMTP id e66so41770540iod.1
        for <ceph-devel@vger.kernel.org>; Fri, 23 Sep 2016 14:39:23 -0700 (PDT)
In-Reply-To: <1474304608-17958-4-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On 09/19/2016 12:03 PM, Ilya Dryomov wrote:
> If stat request fails with something other than -ENOENT (which just
> means that we need to copyup), the original object request is never
> marked as done and therefore never completed.  Fix this by moving the
> mark done + complete snippet from rbd_img_obj_parent_read_full() into
> rbd_img_obj_exists_callback().  The former remains covered, as the
> latter is its only caller (through rbd_img_obj_request_submit()).
> 
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Did you ever see this happen?

This little block of code (setting an error and marking a
request done) is found in two other spots in the code; maybe
it could be encapsulated.  (That wouldn't have helped in
this case, however.)

It took me a while to refresh on all the moving parts here.
Let me explain what I see.

No matter what, when an object request gets submitted, it
must eventually have its result code set, get marked done,
and be completed by a call to rbd_obj_request_complete().

An image object gets submitted by rbd_img_obj_request_submit().
Initially, rbd_img_request_submit() calls this for every object
request in the image request.  If any errors occur here, the
image request is dropped, and in the process of cleaning up
the image request, its reference to its objects are dropped as
well.  (Here it's possible some requests are never submitted,
and therefore never marked done...  But I think that's OK.)

There is one other place rbd_img_obj_request_submit() gets
called.  Before getting to that, let's look at what it does.

Simple image object requests (reads, or non-layered writes,
or layered writes that are known to not overlap the parent)
require no special treatment.  The object request is submitted,
and it will eventually be marked done and be completed.

For a layered write request, we need to know whether an image
object exists, and if we don't know we submit a stat call for
that object so we can find out.  When that call completes,
rbd_img_obj_exists_callback() records the result (whether the
object exists), and then re-submits the original image object
request.  This is the second spot rbd_img_obj_request_submit()
is called.  If an error occurs at this stage, we need to mark
the original request done and complete it.
--> This is the location of the bug this patch fixes--the
    original request was not getting marked done in the event
    of an error.

The last case is a call to rbd_img_obj_request_submit() for
a non-simple request in which we know the target image object
doesn't exist.  So in that case we issue a read of the data
in the parent object backing the full (target) image object,
in rbd_img_obj_parent_read_full().  This is necessary so that
data can be supplied to the target OSD in a copyup request.
Previously, if an error occurred calling that function, the
original image object request would be marked done and completed.
Otherwise, that parent image would, when complete, cause
rbd_img_obj_parent_read_full_callback() to be called.  This
patch changes that (discussed below).

If an error occurs in rbd_img_obj_parent_read_full_callback(),
that function marks the original image object request done
and completes it.  Otherwise the original request is converted
into a copyup request, and that gets submitted to the original
image object.  Eventually rbd_osd_copyup_callback() is called,
which marks the original request done, and as a result,
rbd_osd_req_callback() completes that request.

This covers all the cases.

Now about the change...

In in rbd_img_obj_parent_read_full() you have eliminated
setting the object request result, marking it done, and
completing it.  Now that function will simply return an
error if one occurs.  The only caller of that function is
rbd_img_obj_request_submit(), and as laid out above, we
know an error occurring there leads to the original image
object request being marked done and completed.

Or rather, it's done properly provided the fix for the
bug in rbd_img_obj_exists_callback() is in place.

So I guess I'd say this looks good, and in summary:

Reviewed-by: Alex Elder <elder@linaro.org>

I have one minor suggestion below.

> ---
>  drivers/block/rbd.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 027e0817a118..b247200a0f28 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2805,10 +2805,6 @@ out_err:
>  		ceph_release_page_vector(pages, page_count);
>  	if (parent_request)
>  		rbd_img_request_put(parent_request);
> -	obj_request->result = result;
> -	obj_request->xferred = 0;
> -	obj_request_done_set(obj_request);
> -

You should change the comment at the top of this function so
it indicates that it is no longer this function that takes
care of passing the error on to the original image object
request.

>  	return result;
>  }
>  
> @@ -2860,19 +2856,25 @@ static void rbd_img_obj_exists_callback(struct rbd_obj_request *obj_request)
>  		obj_request_existence_set(orig_request, true);
>  	} else if (result == -ENOENT) {
>  		obj_request_existence_set(orig_request, false);
> -	} else if (result) {
> -		orig_request->result = result;
> -		goto out;
> +	} else {
> +		goto fail_orig_request;
>  	}
>  
>  	/*
>  	 * Resubmit the original request now that we have recorded
>  	 * whether the target object exists.
>  	 */
> -	orig_request->result = rbd_img_obj_request_submit(orig_request);
> -out:
> -	if (orig_request->result)
> -		rbd_obj_request_complete(orig_request);
> +	result = rbd_img_obj_request_submit(orig_request);
> +	if (result)
> +		goto fail_orig_request;
> +
> +	return;
> +
> +fail_orig_request:
> +	orig_request->result = result;
> +	orig_request->xferred = 0;
> +	obj_request_done_set(orig_request);
> +	rbd_obj_request_complete(orig_request);
>  }
>  
>  static int rbd_img_obj_exists_submit(struct rbd_obj_request *obj_request)
> 

