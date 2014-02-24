From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 6/6] rbd: prefix rbd writes with CEPH_OSD_OP_SETALLOCHINT
 osd op
Date: Mon, 24 Feb 2014 08:59:19 -0600
Message-ID: <530B5E47.1020204@ieee.org>
References: <1393008946-7931-1-git-send-email-ilya.dryomov@inktank.com> <1393008946-7931-7-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:48429 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260AbaBXO7R (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Feb 2014 09:59:17 -0500
Received: by mail-ie0-f178.google.com with SMTP id ar20so3577635iec.9
        for <ceph-devel@vger.kernel.org>; Mon, 24 Feb 2014 06:59:17 -0800 (PST)
In-Reply-To: <1393008946-7931-7-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 02/21/2014 12:55 PM, Ilya Dryomov wrote:
> In an effort to reduce fragmentation, prefix every rbd write with
> a CEPH_OSD_OP_SETALLOCHINT osd op with an expected_write_size value set
> to the object size (1 << order).  Backwards compatibility is taken care
> of on the libceph/osd side.

If *every* write will include a hint, why even encode this as
a distinct opcode?  Why not just extend the definition of a
write operation to include the write hint data?  The server
side could check expected_object_size, and if 0 (or some other
invalid value) it means the client isn't supplying a hint.

However, on the assumption you want this to be a distinct
OSD op I think you generally did the right thing.  See my
comments below.  For now I'm not indicating "Reviewed-by"
because it sounds like the nature of this change is under
discussion still.  And I really do think that if the hint
is not going to be made more generic (and possibly even if
it is) I'd rather see this hinting done using an extension
of the write operation (like I suggest above).  In this
case it is clearly directly tied to every write operation
and separating it sort of obscures that.

					-Alex

> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  drivers/block/rbd.c |   66 ++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 49 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 6cf001ef00bc..14496f39c770 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1662,7 +1662,12 @@ static void rbd_osd_req_callback(struct ceph_osd_request *osd_req,
>  	 */
>  	obj_request->xferred = osd_req->r_reply_op_len[0];
>  	rbd_assert(obj_request->xferred < (u64)UINT_MAX);
> +
>  	opcode = osd_req->r_ops[0].op;
> +	if (opcode == CEPH_OSD_OP_SETALLOCHINT) {
> +		BUG_ON(osd_req->r_ops[1].op != CEPH_OSD_OP_WRITE);
> +		opcode = CEPH_OSD_OP_WRITE;
> +	}

I would rather see this handled as a distinct case below
rather than fudging the opcode.  Bury that BUG_ON() inside
inside rbd_osd_write_callback() logic to avoid encoding those
op-specific details here.  And change the BUG_ON() to rbd_assert().

>  	switch (opcode) {
>  	case CEPH_OSD_OP_READ:
>  		rbd_osd_read_callback(obj_request);
> @@ -1715,6 +1720,12 @@ static void rbd_osd_req_format_write(struct rbd_obj_request *obj_request)
>  			snapc, CEPH_NOSNAP, &mtime);
>  }
>  
> +/*
> + * Create an osd request.  A read request has one osd op (read).
> + * A write request has either one (watch) or two (hint+write) osd ops.
> + * (All rbd writes are prefixed with an allocation hint op, but

Maybe "rbd data writes" or something.  A watch changes state but
doesn't write data.

> + * technically osd watch is a write request, hence this distinction.)
> + */
>  static struct ceph_osd_request *rbd_osd_req_create(
>  					struct rbd_device *rbd_dev,
>  					bool write_request,
> @@ -1734,7 +1745,8 @@ static struct ceph_osd_request *rbd_osd_req_create(
>  			snapc = img_request->snapc;
>  	}
>  
> -	rbd_assert(num_ops == 1);
> +	rbd_assert((!write_request && num_ops == 1) ||
> +		   (write_request && num_ops >= 1 && num_ops <= 2));

Maybe:
	rbd_assert(num_ops == 1 || write_request && num_ops == 2);

>  
>  	/* Allocate and initialize the request, for the num_ops ops */
>  
> @@ -1760,8 +1772,8 @@ static struct ceph_osd_request *rbd_osd_req_create(
>  
>  /*
>   * Create a copyup osd request based on the information in the
> - * object request supplied.  A copyup request has two osd ops,
> - * a copyup method call, and a "normal" write request.
> + * object request supplied.  A copyup request has three osd ops,
> + * a copyup method call, a hint op, and a write op.

There's a comment in the caller that should be similarly updated:
         * We need a new one that can hold the two ops in a copyup
                                               ^^^
>   */
>  static struct ceph_osd_request *
>  rbd_osd_req_create_copyup(struct rbd_obj_request *obj_request)
> @@ -1777,12 +1789,12 @@ rbd_osd_req_create_copyup(struct rbd_obj_request *obj_request)
>  	rbd_assert(img_request);
>  	rbd_assert(img_request_write_test(img_request));
>  
> -	/* Allocate and initialize the request, for the two ops */
> +	/* Allocate and initialize the request, for the three ops */
>  
>  	snapc = img_request->snapc;
>  	rbd_dev = img_request->rbd_dev;
>  	osdc = &rbd_dev->rbd_client->client->osdc;
> -	osd_req = ceph_osdc_alloc_request(osdc, snapc, 2, false, GFP_ATOMIC);
> +	osd_req = ceph_osdc_alloc_request(osdc, snapc, 3, false, GFP_ATOMIC);
>  	if (!osd_req)
>  		return NULL;	/* ENOMEM */
>  
> @@ -2159,12 +2171,10 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
>  	struct page **pages = NULL;
>  	u64 img_offset;
>  	u64 resid;
> -	u16 opcode;

Why move opcode inside the inner loop?  It's not going
to change, is it?  (Maybe this was a leftover from an
abandoned attempt to do this a different way.)

>  
>  	dout("%s: img %p type %d data_desc %p\n", __func__, img_request,
>  		(int)type, data_desc);
>  
> -	opcode = write_request ? CEPH_OSD_OP_WRITE : CEPH_OSD_OP_READ;
>  	img_offset = img_request->offset;
>  	resid = img_request->length;
>  	rbd_assert(resid > 0);
> @@ -2183,6 +2193,8 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
>  		const char *object_name;
>  		u64 offset;
>  		u64 length;
> +		unsigned int which;

		unsigned int which = 0;

> +		u16 opcode;
>  
>  		object_name = rbd_segment_name(rbd_dev, img_offset);
>  		if (!object_name)
> @@ -2224,20 +2236,34 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
>  			pages += page_count;
>  		}
>  
> -		osd_req = rbd_osd_req_create(rbd_dev, write_request, 1,
> +		osd_req = rbd_osd_req_create(rbd_dev, write_request,
> +					     (write_request ? 2 : 1),
>  					     obj_request);
>  		if (!osd_req)
>  			goto out_partial;
>  		obj_request->osd_req = osd_req;
>  		obj_request->callback = rbd_img_obj_callback;
>  
> -		osd_req_op_extent_init(osd_req, 0, opcode, offset, length,
> -						0, 0);
> +		if (write_request) {



> +			osd_req_op_hint_init(osd_req, 0,
> +					     CEPH_OSD_OP_SETALLOCHINT,
> +					     rbd_obj_bytes(&rbd_dev->header),
> +					     rbd_obj_bytes(&rbd_dev->header),
> +					     0);
> +
> +			which = 1;
			which++;

> +			opcode = CEPH_OSD_OP_WRITE;
> +		} else {

And this block goes away (assign opcode outside the loop).

> +			which = 0;
> +			opcode = CEPH_OSD_OP_READ;
> +		}
> +		osd_req_op_extent_init(osd_req, which, opcode, offset, length,
> +				       0, 0);
>  		if (type == OBJ_REQUEST_BIO)
> -			osd_req_op_extent_osd_data_bio(osd_req, 0,
> +			osd_req_op_extent_osd_data_bio(osd_req, which,
>  					obj_request->bio_list, length);
>  		else
> -			osd_req_op_extent_osd_data_pages(osd_req, 0,
> +			osd_req_op_extent_osd_data_pages(osd_req, which,
>  					obj_request->pages, length,
>  					offset & ~PAGE_MASK, false, false);
>  
> @@ -2358,7 +2384,7 @@ rbd_img_obj_parent_read_full_callback(struct rbd_img_request *img_request)
>  
>  	/*
>  	 * The original osd request is of no use to use any more.
> -	 * We need a new one that can hold the two ops in a copyup
> +	 * We need a new one that can hold the three ops in a copyup
>  	 * request.  Allocate the new copyup osd request for the
>  	 * original request, and release the old one.
>  	 */
> @@ -2377,17 +2403,23 @@ rbd_img_obj_parent_read_full_callback(struct rbd_img_request *img_request)
>  	osd_req_op_cls_request_data_pages(osd_req, 0, pages, parent_length, 0,
>  						false, false);
>  
> -	/* Then the original write request op */
> +	/* Then the hint op */
> +
> +	osd_req_op_hint_init(osd_req, 1, CEPH_OSD_OP_SETALLOCHINT,
> +			     rbd_obj_bytes(&rbd_dev->header),
> +			     rbd_obj_bytes(&rbd_dev->header), 0);
> +
> +	/* And the original write request op */
>  
>  	offset = orig_request->offset;
>  	length = orig_request->length;
> -	osd_req_op_extent_init(osd_req, 1, CEPH_OSD_OP_WRITE,
> +	osd_req_op_extent_init(osd_req, 2, CEPH_OSD_OP_WRITE,
>  					offset, length, 0, 0);
>  	if (orig_request->type == OBJ_REQUEST_BIO)
> -		osd_req_op_extent_osd_data_bio(osd_req, 1,
> +		osd_req_op_extent_osd_data_bio(osd_req, 2,
>  					orig_request->bio_list, length);
>  	else
> -		osd_req_op_extent_osd_data_pages(osd_req, 1,
> +		osd_req_op_extent_osd_data_pages(osd_req, 2,
>  					orig_request->pages, length,
>  					offset & ~PAGE_MASK, false, false);
>  
> 

