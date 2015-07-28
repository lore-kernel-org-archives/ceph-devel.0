From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] rbd: fix copyup completion race
Date: Tue, 28 Jul 2015 12:48:02 -0500
Message-ID: <55B7C052.9070804@ieee.org>
References: <1437129400-12392-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:34012 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874AbbG1RsF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jul 2015 13:48:05 -0400
Received: by igk11 with SMTP id 11so117365107igk.1
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jul 2015 10:48:04 -0700 (PDT)
In-Reply-To: <1437129400-12392-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@linaro.org>

On 07/17/2015 05:36 AM, Ilya Dryomov wrote:
> For write/discard obj_requests that involved a copyup method call, the
> opcode of the first op is CEPH_OSD_OP_CALL and the ->callback is
> rbd_img_obj_copyup_callback().  The latter frees copyup pages, sets
> ->xferred and delegates to rbd_img_obj_callback(), the "normal" image
> object callback, for reporting to block layer and putting refs.

First of all, I'm really sorry it took so long to get to
reviewing this.  The short of this is it looks good, but
it would be nice for you to read my description and affirm
it matches reality.  I also suggest you rename a function.

> rbd_osd_req_callback() however treats CEPH_OSD_OP_CALL as a trivial op,
> which means obj_request is marked done in rbd_osd_trivial_callback(),

This callback path really should be fixed so that every op in
the r_ops[] array gets handled separately.  That was sort of
planned, but we initially only had the one case (write copyup),
and it only had two ops.  Now we have 1, 2, or 3, and in principle
there could be more, so it would be better to support things
generically.  The obj_request should only be marked done *after*
all individual op callbacks have been processed.  But... that
can be done another day.

> *before* ->callback is invoked and rbd_img_obj_copyup_callback() has
> a chance to run.  Marking obj_request done essentially means giving
> rbd_img_obj_callback() a license to end it at any moment, so if another
> obj_request from the same img_request is being completed concurrently,
> rbd_img_obj_end_request() may very well be called on such prematurally
> marked done request:
> 
> <obj_request-1/2 reply>
> handle_reply()
>   rbd_osd_req_callback()
>     rbd_osd_trivial_callback()
>     rbd_obj_request_complete()
>     rbd_img_obj_copyup_callback()
>     rbd_img_obj_callback()
>                                     <obj_request-2/2 reply>
>                                     handle_reply()
>                                       rbd_osd_req_callback()
>                                         rbd_osd_trivial_callback()
>       for_each_obj_request(obj_request->img_request) {
>         rbd_img_obj_end_request(obj_request-1/2)
>         rbd_img_obj_end_request(obj_request-2/2) <--
>       }
> 
> Calling rbd_img_obj_end_request() on such a request leads to trouble,
> in particular because its ->xfferred is 0.  We report 0 to the block
> layer with blk_update_request(), get back 1 for "this request has more
> data in flight" and then trip on
> 
>     rbd_assert(more ^ (which == img_request->obj_request_count));

Another of these pesky assertions actually identifies a problem.

> with rhs (which == ...) being 1 because rbd_img_obj_end_request() has
> been called for both requests and lhs (more) being 1 because we haven't
> got a chance to set ->xfferred in rbd_img_obj_copyup_callback() yet.
> 
> To fix this, leverage that rbd wants to call class methods in only two
> cases: one is a generic method call wrapper (obj_request is standalone)
> and the other is a copyup (obj_request is part of an img_request).  So
> make a dedicated handler for CEPH_OSD_OP_CALL and directly invoke
> rbd_img_obj_copyup_callback() from it if obj_request is part of an
> img_request, similar to how CEPH_OSD_OP_READ handler invokes
> rbd_img_obj_request_read_callback().

OK, I understand what you're doing here.  I'm going to restate
it just to confirm that.

When an OSD request completes, rbd_osd_req_callback() is called.
It examines the first op in the object request's r_ops[] array.

If the first op in an r_ops[] array is a CALL, you handle it with
a new OSD request callback (sub)function rbd_osd_call_callback().
(That's a reasonable structural change to make anyway, I think.)
That function now distinguishes between a copyup request (which
will be for an image object) and a simple method call (which will
be a request on an object not associated with an image).

A simple method call will just mark the object request done
(as the trivial callback did previously).  As a result
rbd_osd_req_callback() will complete that object request.

Completion of an OSD copyup request will now be handled by
rbd_img_obj_copyup_callback().

Now let me step back.

A copyup object request is initiated only following completion
of a "read full" image request.  A "read full" request occurs
when a write is issued to to a range of a layered image that
overlaps the image's parent, and the target object of the
write is known to not yet exist.

In this case, the completion of the "read full" causes a copyup
OSD request to be created, replacing the object request's original
data to write to the target object.  It supplies the "full" data
to be written (from the parent), as well as the original data to
be written.  The OSD ensures that the result of the copyup is
that the target object contains the "full object" data with
the original write layered on top of (written after) that.

So...  Previously, the copyup OSD request would be issued,
with the original object request modified to call
rbd_img_obj_copyup_callback() when it completed.  This
meant the copyup would complete, and the copyup callback
function would essentially be inserted as an extra object
request callback function, called *before* the normal
rbd_img_obj_callback() completion function.

With this change, when the parent "read full" image request
completes, the original object request callback is left
as-is (I think/assume it's always rbd_img_obj_callback()).
However, unlike before, rbd_img_obj_copyup_callback()
is now called as part of the *osd request* completion
handling for the copyup operation.  This finishes before
the object request completion handling.  Rather than
chaining object request handlers, we clean up the copyup
OSD request as part of OSD completion (and then mark the
containing original object request done), and *then*
complete the object request normally.

I have two comments about this.
- I *think* this is a better way to do this anyway.  By
  which I mean that since we're setting up that copyup
  operation sort of behind the scenes, separate from the
  original object request, it's just as well that we
  clean up the pages allocated, etc. behind the scenes
  (at the OSD request layer, not the object request layer)
  also.
- Since rbd_img_obj_copyup_callback() is now being called
  in the OSD request callback context (only), it should
  be renamed rbd_osd_copyup_callback().

I wish there were a nice way to diagram the various
paths these requests take.  They're not overly
complicated, but every time I go through it I need
to sort of think through it again each time.

I'm going to say this looks good...

Reviewed-by: Alex Elder <elder@linaro.org>


> Cc: Alex Elder <elder@linaro.org>
> Cc: stable@vger.kernel.org # 3.10+, needs backporting for < 3.18
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  drivers/block/rbd.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index d94529d5c8e9..007e5d0cadaf 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -523,6 +523,7 @@ void rbd_warn(struct rbd_device *rbd_dev, const char *fmt, ...)
>  #  define rbd_assert(expr)	((void) 0)
>  #endif /* !RBD_DEBUG */
>  
> +static void rbd_img_obj_copyup_callback(struct rbd_obj_request *obj_request);
>  static int rbd_img_obj_request_submit(struct rbd_obj_request *obj_request);
>  static void rbd_img_parent_read(struct rbd_obj_request *obj_request);
>  static void rbd_dev_remove_parent(struct rbd_device *rbd_dev);
> @@ -1818,6 +1819,16 @@ static void rbd_osd_stat_callback(struct rbd_obj_request *obj_request)
>  	obj_request_done_set(obj_request);
>  }
>  
> +static void rbd_osd_call_callback(struct rbd_obj_request *obj_request)
> +{
> +	dout("%s: obj %p\n", __func__, obj_request);
> +
> +	if (obj_request_img_data_test(obj_request))
> +		rbd_img_obj_copyup_callback(obj_request);
> +	else
> +		obj_request_done_set(obj_request);
> +}
> +
>  static void rbd_osd_req_callback(struct ceph_osd_request *osd_req,
>  				struct ceph_msg *msg)
>  {
> @@ -1866,6 +1877,8 @@ static void rbd_osd_req_callback(struct ceph_osd_request *osd_req,
>  		rbd_osd_discard_callback(obj_request);
>  		break;
>  	case CEPH_OSD_OP_CALL:
> +		rbd_osd_call_callback(obj_request);
> +		break;
>  	case CEPH_OSD_OP_NOTIFY_ACK:
>  	case CEPH_OSD_OP_WATCH:
>  		rbd_osd_trivial_callback(obj_request);
> @@ -2537,6 +2550,8 @@ rbd_img_obj_copyup_callback(struct rbd_obj_request *obj_request)
>  	struct page **pages;
>  	u32 page_count;
>  
> +	dout("%s: obj %p\n", __func__, obj_request);
> +
>  	rbd_assert(obj_request->type == OBJ_REQUEST_BIO ||
>  		obj_request->type == OBJ_REQUEST_NODATA);
>  	rbd_assert(obj_request_img_data_test(obj_request));
> @@ -2563,9 +2578,7 @@ rbd_img_obj_copyup_callback(struct rbd_obj_request *obj_request)
>  	if (!obj_request->result)
>  		obj_request->xferred = obj_request->length;
>  
> -	/* Finish up with the normal image object callback */
> -
> -	rbd_img_obj_callback(obj_request);
> +	obj_request_done_set(obj_request);
>  }
>  
>  static void
> @@ -2650,7 +2663,6 @@ rbd_img_obj_parent_read_full_callback(struct rbd_img_request *img_request)
>  
>  	/* All set, send it off. */
>  
> -	orig_request->callback = rbd_img_obj_copyup_callback;

What is orig_request->callback here, is it always
rbd_img_obj_callback()?

>  	osdc = &rbd_dev->rbd_client->client->osdc;
>  	img_result = rbd_obj_request_submit(osdc, orig_request);
>  	if (!img_result)
> 

