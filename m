From: Alex Elder <elder@linaro.org>
Subject: Re: [PATCH 4/8] rbd: move bumping img_request refcount into
 rbd_obj_request_submit()
Date: Sun, 25 Sep 2016 10:56:17 -0500
Message-ID: <93d01f3c-78a7-6407-8af9-78680455024f@linaro.org>
References: <1474304608-17958-1-git-send-email-idryomov@gmail.com>
 <1474304608-17958-5-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:38669 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034247AbcIYP4U (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 25 Sep 2016 11:56:20 -0400
Received: by mail-it0-f43.google.com with SMTP id n143so55694633ita.1
        for <ceph-devel@vger.kernel.org>; Sun, 25 Sep 2016 08:56:19 -0700 (PDT)
In-Reply-To: <1474304608-17958-5-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On 09/19/2016 12:03 PM, Ilya Dryomov wrote:
> Commit 0f2d5be792b0 ("rbd: use reference counts for image requests")
> added rbd_img_request_get(), which rbd_img_request_fill() calls for
> each obj_request added to img_request.  It was an urgent band-aid for
> the uglyness that is rbd_img_obj_callback() and none of the error paths
> were updated.

I'm not sure how to improve that function.  Object requests in
an image request need to be completed in sequential order,
because blk_update_request() requires that.  (Or maybe you
were referring to something else you find ugly.)

> Given that this img_request reference is meant to represent an
> obj_request that hasn't passed through rbd_img_obj_callback() yet,

It was, for the purpose of that commit.  But I don't like to think
of reference counting that way.  I usually try to reason about
reference counts as actual counts of pointers referring to objects.
And in that sense, I think it might have been better in the first
place to drop the an object request's reference to the image request
in rbd_img_obj_request_del(), where the img_request pointer gets
nulled out.  And move the call to rbd_img_request_get() for an
object request into rbd_img_obj_request_add(), where the pointer
gets assigned.  I don't know why I didn't do it that way before;
like you said it was sort of an urgently developed change.

I haven't investigated this alternative exhaustively, but if
it works I think it would be a cleaner fix.

> proper cleanup in appropriate destructors is a challenge.  However,
> noting that if we don't get a chance to call rbd_obj_request_complete(),
> there is not going to be a call to rbd_img_obj_callback(), we can move
> rbd_img_request_get() into rbd_obj_request_submit() and fixup the two
> places that call rbd_obj_request_complete() directly and not through
> rbd_obj_request_submit() to temporarily bump img_request, so that
> rbd_img_obj_callback() can put as usual.
> 
> This takes care of img_request leaks on errors on the submit side.

So *this* is the problem you're aiming to solve here...  It would
have been nice for you to call attention to where these leaks were
occurring.  (It seems rbd_img_obj_parent_read_full_callback()
and rbd_img_obj_exists_callback().)

It looks to me like your change is sound, but again, I think it
would be better to make the reference counting match the actual
recording of references to objects as I mentioned before.  I'm
going to ask for your opinion on that before I offer you my
"reviewed by" on this.

					-Alex

And now, some more gratuitous analysis...

We currently (without this patch) get a reference to an image request
for every object request populated in rbd_img_request_fill(), right
after calling rbd_img_obj_request_fill().  We want each of these to
have a matching reference drop, once that object request is completed,
and the object request no longer has any use for what's in the image
request.  Right now that occurs in rbd_img_obj_callback().  But that
function is only called if an image object request gets successfully
submitted.  And in particular, if an error occurs while processing
a layered write--either while doing an existence check for an object
or when doing a read of the parent data--the original image object
requests never get submitted, and therefore their references to the
image don't get dropped properly.  This issue is the subject of your
patch.  All other image object requests appear to get submitted,
and therefore properly release their reference.

There are two other image request references.  A reference taken
before submitting all the object requests in rbd_img_request_submit();
that reference is dropped in that same function after all object
requests are submitted.

The last reference is the reference that is set when the image
request is created.  That reference should be dropped when we are
done with the image request.  If an image request has no callback
function, that reference is dropped in rbd_img_request_complete().
If there is a callback, that callback function must eventually
lead to the image request reference being dropped.  Only two
image request callback functions are ever assigned:
  rbd_img_parent_read_callback()
  rbd_img_parent_read_full_callback()
Both of those functions grab information needed from the image,
then drop the "original" image request reference.

I might have missed something but I think with your fix, or with
the alternative I propose, we'll have all image request references
accounted for.

> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  drivers/block/rbd.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index b247200a0f28..d8070bd29fd1 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1610,11 +1610,17 @@ static bool obj_request_type_valid(enum obj_request_type type)
>  	}
>  }
>  
> +static void rbd_img_obj_callback(struct rbd_obj_request *obj_request);
> +
>  static void rbd_obj_request_submit(struct rbd_obj_request *obj_request)
>  {
>  	struct ceph_osd_request *osd_req = obj_request->osd_req;
>  
>  	dout("%s %p osd_req %p\n", __func__, obj_request, osd_req);
> +	if (obj_request_img_data_test(obj_request)) {
> +		WARN_ON(obj_request->callback != rbd_img_obj_callback);
> +		rbd_img_request_get(obj_request->img_request);
> +	}
>  	ceph_osdc_start_request(osd_req->r_osdc, osd_req, false);
>  }
>  
> @@ -2580,8 +2586,6 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
>  
>  		rbd_img_obj_request_fill(obj_request, osd_req, op_type, 0);
>  
> -		rbd_img_request_get(img_request);
> -
>  		img_offset += length;
>  		resid -= length;
>  	}
> @@ -2715,10 +2719,9 @@ rbd_img_obj_parent_read_full_callback(struct rbd_img_request *img_request)
>  	return;
>  
>  out_err:
> -	/* Record the error code and complete the request */
> -
>  	orig_request->result = img_result;
>  	orig_request->xferred = 0;
> +	rbd_img_request_get(orig_request->img_request);
>  	obj_request_done_set(orig_request);
>  	rbd_obj_request_complete(orig_request);
>  }
> @@ -2873,6 +2876,7 @@ static void rbd_img_obj_exists_callback(struct rbd_obj_request *obj_request)
>  fail_orig_request:
>  	orig_request->result = result;
>  	orig_request->xferred = 0;
> +	rbd_img_request_get(orig_request->img_request);
>  	obj_request_done_set(orig_request);
>  	rbd_obj_request_complete(orig_request);
>  }
> 

