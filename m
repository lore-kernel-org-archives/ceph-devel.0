From: Alex Elder <elder@linaro.org>
Subject: Re: [PATCH 10/14] rbd: rbd_obj_request_wait() should cancel the request
 if interrupted
Date: Mon, 07 Jul 2014 11:55:24 -0500
Message-ID: <53BAD0FC.5020007@linaro.org>
References: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com> <1403716607-13535-11-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:59158 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091AbaGGQzZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Jul 2014 12:55:25 -0400
Received: by mail-ig0-f176.google.com with SMTP id c1so11004693igq.3
        for <ceph-devel@vger.kernel.org>; Mon, 07 Jul 2014 09:55:24 -0700 (PDT)
In-Reply-To: <1403716607-13535-11-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 06/25/2014 12:16 PM, Ilya Dryomov wrote:
> rbd_obj_request_wait() should cancel the underlying OSD request if
> interrupted.  Otherwise libceph will hold onto it indefinitely, causing
> assert failures or leaking the original object request.

At first I didn't understand this.  Let me see if I've got
it now, though.

Each OSD request has a completion associated with it.  An
OSD request is started via ceph_osdc_start_request(), which
registers the request and takes a reference to it.  One can
call ceph_osdc_wait_request() after the request has been
successfully started.  Whether the wait succeeds or not,
by the time ceph_osdc_wait_request() returns the request
should have been cleaned up, back to the state it was
in before the start_request call.  That means the request
needs to be unregistered and its reference dropped, etc.

Similarly, each RBD object request has a completion associated
with it.  It is distinct from the OSD request associated
with the RBD object request because there may be more to do
for RBD request to complete than just complete one object
request.  An RBD object request is started by a call to
rbd_obj_request_submit(), and once that's successfully
returned, one can wait for it to complete using a call to
rbd_obj_request_wait().  And as above, that call should
return state to (roughly) where it was before the submit
call, whether the wait request succeeded or not.

Now, RBD doesn't actually wait for its object requests
to complete--all its OSD requests complete asynchronously.
Instead, it relies on the OSD client to call the callback
function (always rbd_osd_req_callback()) when it has
completed.  That function will lead to the RBD request's
completion being signaled when appropriate.

So...  What happens when an interrupt occurs after
rbd_obj_request_submit() has returned successfully?  That
function is a simple wrapper for ceph_osdc_start_request(),
so a successful return means the request was mapped and
put on a target's unsent list (or the OSD client's no
target list).  Nobody waits for the OSD request, so an
interrupt won't get the benefit of the cleanup done in
ceph_osdc_wait_request().  Therefore the RBD layer needs
to be responsible for doing that.

In other words, when rbd_obj_request_wait() gets an
interrupt while waiting for the completion, it needs
to clean up (end) the interrupted request, and
rbd_obj_request_end() sounds right.  And what that
cleanup function should do is basically the same
as what ceph_osdc_wait_request() should do in that
situation, which is call ceph_osdc_cancel_request().

The only question that leaves me with is, does
ceph_osdc_cancel_request() need to include the
call to complete_request() that's present in
ceph_osdc_wait_request()?

I'll leave it at that.  I think I've convinced myself
this is a good change.  So I await your confirmation
that I understand it right, and your answer to my
question above.  But in any case you can consider this:

Reviewed-by: Alex Elder <elder@linaro.org>

Sorry it's taking me so long to get through these.



> 
> This also adds an rbd wrapper around ceph_osdc_cancel_request() to
> match rbd_obj_request_submit() and rbd_obj_request_wait().
> 
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  drivers/block/rbd.c |   39 ++++++++++++++++++++++++++++-----------
>  1 file changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index b2c98c1bc037..20147aec86f3 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1527,11 +1527,37 @@ static bool obj_request_type_valid(enum obj_request_type type)
>  static int rbd_obj_request_submit(struct ceph_osd_client *osdc,
>  				struct rbd_obj_request *obj_request)
>  {
> -	dout("%s: osdc %p obj %p\n", __func__, osdc, obj_request);
> -
> +	dout("%s %p\n", __func__, obj_request);
>  	return ceph_osdc_start_request(osdc, obj_request->osd_req, false);
>  }
>  
> +static void rbd_obj_request_end(struct rbd_obj_request *obj_request)
> +{
> +	dout("%s %p\n", __func__, obj_request);
> +	ceph_osdc_cancel_request(obj_request->osd_req);
> +}
> +
> +/*
> + * Wait for an object request to complete.  If interrupted, cancel the
> + * underlying osd request.
> + */
> +static int rbd_obj_request_wait(struct rbd_obj_request *obj_request)
> +{
> +	int ret;
> +
> +	dout("%s %p\n", __func__, obj_request);
> +
> +	ret = wait_for_completion_interruptible(&obj_request->completion);
> +	if (ret < 0) {
> +		dout("%s %p interrupted\n", __func__, obj_request);
> +		rbd_obj_request_end(obj_request);
> +		return ret;
> +	}
> +
> +	dout("%s %p done\n", __func__, obj_request);
> +	return 0;
> +}
> +
>  static void rbd_img_request_complete(struct rbd_img_request *img_request)
>  {
>  
> @@ -1558,15 +1584,6 @@ static void rbd_img_request_complete(struct rbd_img_request *img_request)
>  		rbd_img_request_put(img_request);
>  }
>  
> -/* Caller is responsible for rbd_obj_request_destroy(obj_request) */
> -
> -static int rbd_obj_request_wait(struct rbd_obj_request *obj_request)
> -{
> -	dout("%s: obj %p\n", __func__, obj_request);
> -
> -	return wait_for_completion_interruptible(&obj_request->completion);
> -}
> -
>  /*
>   * The default/initial value for all image request flags is 0.  Each
>   * is conditionally set to 1 at image request initialization time
> 

