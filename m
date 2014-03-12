From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 3/3] rbd: add discard support for rbd
Date: Wed, 12 Mar 2014 00:26:59 -0500
Message-ID: <531FF023.7080600@ieee.org>
References: <1394598285-17225-1-git-send-email-lucienchao@gmail.com> <1394598285-17225-4-git-send-email-lucienchao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:34603 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbaCLF1W (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Mar 2014 01:27:22 -0400
Received: by mail-ig0-f171.google.com with SMTP id hl1so13380092igb.4
        for <ceph-devel@vger.kernel.org>; Tue, 11 Mar 2014 22:27:22 -0700 (PDT)
In-Reply-To: <1394598285-17225-4-git-send-email-lucienchao@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guangliang Zhao <lucienchao@gmail.com>, ceph-devel@vger.kernel.org
Cc: sage@inktank.com

On 03/11/2014 11:24 PM, Guangliang Zhao wrote:
> This resolve:
> 	http://tracker.ceph.com/issues/190

This should have a bit more explanation here.  Perhaps mention
that a new DISCARD image request type flag is defined which
includes no data.  A bunch of the changes here are just making
minor extensions to allow for the third operation type (discard).
You could also mention that discard requests on an image will
remove the objects that back the discarded range if they're
completely contained within that range; the object at the end
of the discarded range is truncated or zeroed.

In any case, this looks nice to me.  It's another case
where adding the feature seems not that intrusive, and
fits within the existing framework pretty well.

There is a bug below, which you should fix.  I have a few
other comments too, for you to consider.

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Guangliang Zhao <lucienchao@gmail.com>
> ---
>  drivers/block/rbd.c |  105 +++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 93 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index ca1fd14..67ea156 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -212,6 +212,7 @@ enum obj_request_type {
>  enum obj_operation_type {
>  	OBJ_OPT_WRITE,
>  	OBJ_OPT_READ,
> +	OBJ_OPT_DISCARD,

I really find the "OPT" distracting.  It reads as "option"
to me.  OBJ_OP_* would be my suggestion.

>  };
>  
>  /*
> @@ -221,6 +222,7 @@ enum obj_operation_type {
>  static const char* obj_opt[] = {
>  	"write",
>  	"read",
> +	"discard",
>  };
>  
>  enum obj_req_flags {
> @@ -228,6 +230,7 @@ enum obj_req_flags {
>  	OBJ_REQ_IMG_DATA,	/* object usage: standalone = 0, image = 1 */
>  	OBJ_REQ_KNOWN,		/* EXISTS flag valid: no = 0, yes = 1 */
>  	OBJ_REQ_EXISTS,		/* target exists: no = 0, yes = 1 */
> +	IMG_REQ_DISCARD,	/* discard: normal = 0, discard request = 1 */

This is an image request flag so it should be added to the img_req_flags
enum definition, not here.  This is a bug.

>  };
>  
>  struct rbd_obj_request {
> @@ -1518,6 +1521,21 @@ static bool img_request_write_test(struct rbd_img_request *img_request)
>  	return test_bit(IMG_REQ_WRITE, &img_request->flags) != 0;
>  }
>  
> +/*
> + * Set the discard flag when the img_request is an discard request
> + */
> +static void img_request_discard_set(struct rbd_img_request *img_request)
> +{
> +	set_bit(IMG_REQ_DISCARD, &img_request->flags);
> +	smp_mb();
> +}
> +
> +static bool img_request_discard_test(struct rbd_img_request *img_request)
> +{
> +	smp_mb();
> +	return test_bit(IMG_REQ_DISCARD, &img_request->flags) != 0;
> +}
> +
>  static void img_request_child_set(struct rbd_img_request *img_request)
>  {
>  	set_bit(IMG_REQ_CHILD, &img_request->flags);
> @@ -1640,6 +1658,18 @@ static void rbd_osd_write_callback(struct rbd_obj_request *obj_request)
>  	obj_request_done_set(obj_request);
>  }
>  
> +static void rbd_osd_discard_callback(struct rbd_obj_request *obj_request)
> +{
> +	dout("%s: obj %p result %d %llu\n", __func__, obj_request,
> +		obj_request->result, obj_request->length);
> +	/*
> +	 * There is no such thing as a successful short write.  Set

Maybe update the comment here to say "short *discard*" (not write).
I'm assuming the statement is true, I didn't verify it.

> +	 * it to our originally-requested length.
> +	 */
> +	obj_request->xferred = obj_request->length;
> +	obj_request_done_set(obj_request);
> +}
> +
>  /*
>   * For a simple stat call there's nothing to do.  We'll do more if
>   * this is part of a write sequence for a layered image.
> @@ -1687,6 +1717,11 @@ static void rbd_osd_req_callback(struct ceph_osd_request *osd_req,
>  	case CEPH_OSD_OP_STAT:
>  		rbd_osd_stat_callback(obj_request);
>  		break;
> +	case CEPH_OSD_OP_DELETE:
> +	case CEPH_OSD_OP_TRUNCATE:
> +	case CEPH_OSD_OP_ZERO:
> +		rbd_osd_discard_callback(obj_request);
> +		break;
>  	case CEPH_OSD_OP_CALL:
>  	case CEPH_OSD_OP_NOTIFY_ACK:
>  	case CEPH_OSD_OP_WATCH:
> @@ -1729,6 +1764,20 @@ static void rbd_osd_req_format_write(struct rbd_obj_request *obj_request)
>  			snapc, CEPH_NOSNAP, &mtime);
>  }
>  
> +static void rbd_osd_req_format_discard(struct rbd_obj_request *obj_request)
> +{
> +	struct rbd_img_request *img_request = obj_request->img_request;
> +	struct ceph_osd_request *osd_req = obj_request->osd_req;
> +	struct timespec mtime = CURRENT_TIME;
> +	u64 snap_id;
> +
> +	rbd_assert(osd_req != NULL);
> +
> +	snap_id = img_request ? img_request->snap_id : CEPH_NOSNAP;
> +	ceph_osdc_build_request(osd_req, obj_request->offset,
> +			NULL, snap_id, &mtime);
> +}
> +
>  static struct ceph_osd_request *rbd_osd_req_create(
>  					struct rbd_device *rbd_dev,
>  					enum obj_operation_type type,
> @@ -1738,12 +1787,15 @@ static struct ceph_osd_request *rbd_osd_req_create(
>  	struct ceph_osd_client *osdc;
>  	struct ceph_osd_request *osd_req;
>  	bool write_request = (type == OBJ_OPT_WRITE) != 0;
> +	bool discard_request = (type == OBJ_OPT_DISCARD) != 0;
>  
>  	if (obj_request_img_data_test(obj_request)) {
>  		struct rbd_img_request *img_request = obj_request->img_request;
>  
>  		rbd_assert(write_request ==
>  				img_request_write_test(img_request));
> +		rbd_assert(discard_request ==
> +				img_request_discard_test(img_request));
>  
>  		if (type == OBJ_OPT_WRITE)
>  			snapc = img_request->snapc;
> @@ -1756,7 +1808,7 @@ static struct ceph_osd_request *rbd_osd_req_create(
>  	if (!osd_req)
>  		return NULL;	/* ENOMEM */
>  
> -	if (type == OBJ_OPT_WRITE)
> +	if (type == OBJ_OPT_WRITE || type == OBJ_OPT_DISCARD)
>  		osd_req->r_flags = CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK;
>  	else
>  		osd_req->r_flags = CEPH_OSD_FLAG_READ;
> @@ -1982,7 +2034,10 @@ static struct rbd_img_request *rbd_img_request_create(
>  	img_request->offset = offset;
>  	img_request->length = length;
>  	img_request->flags = 0;
> -	if (type == OBJ_OPT_WRITE) {
> +	if (type == OBJ_OPT_DISCARD) {
> +		img_request_discard_set(img_request);
> +		img_request->snap_id = rbd_dev->spec->snap_id;
> +	} else if (type == OBJ_OPT_WRITE) {
>  		img_request_write_set(img_request);
>  		img_request->snapc = rbd_dev->header.snapc;
>  	} else {
> @@ -2083,8 +2138,13 @@ static bool rbd_img_obj_end_request(struct rbd_obj_request *obj_request)
>  		struct rbd_device *rbd_dev = img_request->rbd_dev;
>  		enum obj_operation_type type;
>  
> -		type = img_request_write_test(img_request) ? OBJ_OPT_WRITE :
> -								OBJ_OPT_READ;
> +		if (img_request_discard_test(img_request))
> +			type = OBJ_OPT_DISCARD;
> +		else if (img_request_write_test(img_request))
> +			type = OBJ_OPT_WRITE;
> +		else
> +			type = OBJ_OPT_READ;
> +
>  		rbd_warn(rbd_dev, "%s %llx at %llx (%llx)\n",
>  			obj_opt[type], obj_request->length,
>  			obj_request->img_offset, obj_request->offset);
> @@ -2170,6 +2230,7 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
>  	unsigned int bio_offset = 0;
>  	struct page **pages = NULL;
>  	enum obj_operation_type  op_type;
> +	u64 object_size = (u64) 1 << rbd_dev->header.obj_order;
>  	u64 img_offset;
>  	u64 resid;
>  	u16 opcode;
> @@ -2185,8 +2246,7 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
>  		bio_list = data_desc;
>  		rbd_assert(img_offset ==
>  			   bio_list->bi_iter.bi_sector << SECTOR_SHIFT);
> -	} else {
> -		rbd_assert(type == OBJ_REQUEST_PAGES);
> +	} else if (type == OBJ_REQUEST_PAGES) {
>  		pages = data_desc;
>  	}
>  
> @@ -2225,7 +2285,7 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
>  								GFP_ATOMIC);
>  			if (!obj_request->bio_list)
>  				goto out_partial;
> -		} else {
> +		} else if (type == OBJ_REQUEST_PAGES) {
>  			unsigned int page_count;
>  
>  			obj_request->pages = pages;
> @@ -2236,7 +2296,15 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
>  			pages += page_count;
>  		}
>  
> -		if (img_request_write_test(img_request)) {
> +		if (img_request_discard_test(img_request)) {
> +			op_type = OBJ_OPT_DISCARD;
> +			if (!offset && length == object_size)
> +				opcode = CEPH_OSD_OP_DELETE;
> +			else if (offset + length == object_size)
> +				opcode = CEPH_OSD_OP_TRUNCATE;

I wonder if the OSD detects a zero operation that extends to
the end of the object, and if so, it could convert it to a
truncate.  This would happen if the last object were not
a "full-sized" image object.

> +			else
> +				opcode = CEPH_OSD_OP_ZERO;
> +		} else if (img_request_write_test(img_request)) {
>  			op_type = OBJ_OPT_WRITE;
>  			opcode = CEPH_OSD_OP_WRITE;
>  		} else {
> @@ -2255,13 +2323,15 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
>  		if (type == OBJ_REQUEST_BIO)
>  			osd_req_op_extent_osd_data_bio(osd_req, 0,
>  					obj_request->bio_list, length);
> -		else
> +		else if (type == OBJ_REQUEST_PAGES)
>  			osd_req_op_extent_osd_data_pages(osd_req, 0,
>  					obj_request->pages, length,
>  					offset & ~PAGE_MASK, false, false);
>  
>  		if (op_type == OBJ_OPT_WRITE)
>  			rbd_osd_req_format_write(obj_request);
> +		else if (op_type == OBJ_OPT_DISCARD)
> +			rbd_osd_req_format_discard(obj_request);
>  		else
>  			rbd_osd_req_format_read(obj_request);
>  
> @@ -3093,7 +3163,9 @@ static void rbd_request_fn(struct request_queue *q)
>  
>  		spin_unlock_irq(q->queue_lock);
>  
> -		if (rq->cmd_flags & REQ_WRITE)
> +		if (rq->cmd_flags & REQ_DISCARD)
> +			type = OBJ_OPT_DISCARD;
> +		else if (rq->cmd_flags & REQ_WRITE)
>  			type = OBJ_OPT_WRITE;
>  		else
>  			type = OBJ_OPT_READ;
> @@ -3143,8 +3215,12 @@ static void rbd_request_fn(struct request_queue *q)
>  
>  		img_request->rq = rq;
>  
> -		result = rbd_img_request_fill(img_request, OBJ_REQUEST_BIO,
> -						rq->bio);
> +		if (type == OBJ_OPT_DISCARD)
> +			result = rbd_img_request_fill(img_request,
> +						OBJ_REQUEST_NODATA, NULL);
> +		else
> +			result = rbd_img_request_fill(img_request,
> +						OBJ_REQUEST_BIO, rq->bio);
>  		if (!result)
>  			result = rbd_img_request_submit(img_request);
>  		if (result)
> @@ -3452,6 +3528,11 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
>  	blk_queue_io_min(q, segment_size);
>  	blk_queue_io_opt(q, segment_size);
>  
> +	/* enable the discard support */
> +	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
> +	q->limits.discard_granularity = segment_size;
> +	q->limits.discard_alignment = segment_size;
> +
>  	blk_queue_merge_bvec(q, rbd_merge_bvec);
>  	disk->queue = q;
>  
> 

