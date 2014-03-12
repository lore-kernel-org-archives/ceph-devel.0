From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 2/3] rbd: extend the operation type
Date: Wed, 12 Mar 2014 00:01:51 -0500
Message-ID: <531FEA3F.9090205@ieee.org>
References: <1394598285-17225-1-git-send-email-lucienchao@gmail.com> <1394598285-17225-3-git-send-email-lucienchao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:58198 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472AbaCLFBt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Mar 2014 01:01:49 -0400
Received: by mail-ie0-f171.google.com with SMTP id ar20so10160627iec.30
        for <ceph-devel@vger.kernel.org>; Tue, 11 Mar 2014 22:01:49 -0700 (PDT)
In-Reply-To: <1394598285-17225-3-git-send-email-lucienchao@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guangliang Zhao <lucienchao@gmail.com>, ceph-devel@vger.kernel.org
Cc: sage@inktank.com

On 03/11/2014 11:24 PM, Guangliang Zhao wrote:
> It could only handle the read and write operations now,
> extend it for the coming discard support.

OK, here too I think this looks good, but please consider
the comments I've provided below.

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Guangliang Zhao <lucienchao@gmail.com>
> ---
>  drivers/block/rbd.c |   89 ++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 60 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 965b9b9..ca1fd14 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -209,6 +209,20 @@ enum obj_request_type {
>  	OBJ_REQUEST_NODATA, OBJ_REQUEST_BIO, OBJ_REQUEST_PAGES
>  };
>  
> +enum obj_operation_type {
> +	OBJ_OPT_WRITE,
> +	OBJ_OPT_READ,
> +};
> +
> +/*
> + * Do *not* change order of the elements, it corresponds with
> + * the above enum
> + */

I don't like this.  Why not do this instead, so you don't have
to worry about the above comment?

static const char *obj_operation_name[] = {
	[OBJ_OPT_WRITE]		= "write",
	[OBJ_OPT_READ]		= "read",
};

Beyond that, I'd actually prefer to use a helper function
to return the name, using a switch statement.  That way
the default case could return a string that indicated a
bad operation value was provided rather than just being a
null pointer.

> +static const char* obj_opt[] = {
> +	"write",
> +	"read",
> +};
> +
>  enum obj_req_flags {
>  	OBJ_REQ_DONE,		/* completion flag: not done = 0, done = 1 */
>  	OBJ_REQ_IMG_DATA,	/* object usage: standalone = 0, image = 1 */
> @@ -1717,19 +1731,21 @@ static void rbd_osd_req_format_write(struct rbd_obj_request *obj_request)
>  
>  static struct ceph_osd_request *rbd_osd_req_create(
>  					struct rbd_device *rbd_dev,
> -					bool write_request,
> +					enum obj_operation_type type,
>  					struct rbd_obj_request *obj_request)
>  {
>  	struct ceph_snap_context *snapc = NULL;
>  	struct ceph_osd_client *osdc;
>  	struct ceph_osd_request *osd_req;
> +	bool write_request = (type == OBJ_OPT_WRITE) != 0;

How about just:
	bool write_request = type == OBJ_OPT_WRITE;

(Add parentheses around the condition if you feel you must.)

Furthermore, this write_request value is just used in an
assertion, so...
>  
>  	if (obj_request_img_data_test(obj_request)) {
>  		struct rbd_img_request *img_request = obj_request->img_request;

The write_request local variable should be assigned only inside
this block (the only place it's used).

>  		rbd_assert(write_request ==
>  				img_request_write_test(img_request));
> -		if (write_request)
> +
> +		if (type == OBJ_OPT_WRITE)
>  			snapc = img_request->snapc;

And instead, I think I'd rather see:

	if (obj_request_img_data_test(obj_request)) {
		struct rbd_img_request *img_request = obj_request->img_request;

		if (type == OBJ_OPT_WRITE) {
			rbd_assert(img_request_write_test(img_request));
			snapc = img_request->snapc;
		}
	}
		
>  	}
>  
> @@ -1740,7 +1756,7 @@ static struct ceph_osd_request *rbd_osd_req_create(
>  	if (!osd_req)
>  		return NULL;	/* ENOMEM */
>  
> -	if (write_request)
> +	if (type == OBJ_OPT_WRITE)
>  		osd_req->r_flags = CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK;
>  	else
>  		osd_req->r_flags = CEPH_OSD_FLAG_READ;
> @@ -1947,7 +1963,7 @@ static bool rbd_dev_parent_get(struct rbd_device *rbd_dev)
>  static struct rbd_img_request *rbd_img_request_create(
>  					struct rbd_device *rbd_dev,
>  					u64 offset, u64 length,
> -					bool write_request)
> +					enum obj_operation_type type)
>  {
>  	struct rbd_img_request *img_request;
>  
> @@ -1955,7 +1971,7 @@ static struct rbd_img_request *rbd_img_request_create(
>  	if (!img_request)
>  		return NULL;
>  
> -	if (write_request) {
> +	if (type == OBJ_OPT_WRITE) {
>  		down_read(&rbd_dev->header_rwsem);
>  		ceph_get_snap_context(rbd_dev->header.snapc);
>  		up_read(&rbd_dev->header_rwsem);
> @@ -1966,7 +1982,7 @@ static struct rbd_img_request *rbd_img_request_create(
>  	img_request->offset = offset;
>  	img_request->length = length;
>  	img_request->flags = 0;
> -	if (write_request) {
> +	if (type == OBJ_OPT_WRITE) {
>  		img_request_write_set(img_request);
>  		img_request->snapc = rbd_dev->header.snapc;
>  	} else {
> @@ -1983,8 +1999,7 @@ static struct rbd_img_request *rbd_img_request_create(
>  	kref_init(&img_request->kref);
>  
>  	dout("%s: rbd_dev %p %s %llu/%llu -> img %p\n", __func__, rbd_dev,
> -		write_request ? "write" : "read", offset, length,
> -		img_request);
> +		obj_opt[type], offset, length, img_request);
>  
>  	return img_request;
>  }
> @@ -2024,8 +2039,8 @@ static struct rbd_img_request *rbd_parent_request_create(
>  	rbd_assert(obj_request->img_request);
>  	rbd_dev = obj_request->img_request->rbd_dev;
>  
> -	parent_request = rbd_img_request_create(rbd_dev->parent,
> -						img_offset, length, false);
> +	parent_request = rbd_img_request_create(rbd_dev->parent, img_offset,
> +						length, OBJ_OPT_READ);
>  	if (!parent_request)
>  		return NULL;
>  
> @@ -2066,11 +2081,13 @@ static bool rbd_img_obj_end_request(struct rbd_obj_request *obj_request)
>  	result = obj_request->result;
>  	if (result) {
>  		struct rbd_device *rbd_dev = img_request->rbd_dev;
> +		enum obj_operation_type type;
>  
> +		type = img_request_write_test(img_request) ? OBJ_OPT_WRITE :
> +								OBJ_OPT_READ;
>  		rbd_warn(rbd_dev, "%s %llx at %llx (%llx)\n",
> -			img_request_write_test(img_request) ? "write" : "read",
> -			obj_request->length, obj_request->img_offset,
> -			obj_request->offset);
> +			obj_opt[type], obj_request->length,
> +			obj_request->img_offset, obj_request->offset);
>  		rbd_warn(rbd_dev, "  result %d xferred %x\n",
>  			result, xferred);
>  		if (!img_request->result)
> @@ -2149,10 +2166,10 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
>  	struct rbd_device *rbd_dev = img_request->rbd_dev;
>  	struct rbd_obj_request *obj_request = NULL;
>  	struct rbd_obj_request *next_obj_request;
> -	bool write_request = img_request_write_test(img_request);
>  	struct bio *bio_list = NULL;
>  	unsigned int bio_offset = 0;
>  	struct page **pages = NULL;
> +	enum obj_operation_type  op_type;

You used just "type" consistently for variables of this type
above.  Pick a name and stick to it.  I think just "type" is
fine but it might be too generic, so "op_type" might be a
better choice.

>  	u64 img_offset;
>  	u64 resid;
>  	u16 opcode;
> @@ -2160,7 +2177,6 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
>  	dout("%s: img %p type %d data_desc %p\n", __func__, img_request,
>  		(int)type, data_desc);
>  
> -	opcode = write_request ? CEPH_OSD_OP_WRITE : CEPH_OSD_OP_READ;
>  	img_offset = img_request->offset;
>  	resid = img_request->length;
>  	rbd_assert(resid > 0);
> @@ -2220,8 +2236,15 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
>  			pages += page_count;
>  		}
>  
> -		osd_req = rbd_osd_req_create(rbd_dev, write_request,
> -						obj_request);
> +		if (img_request_write_test(img_request)) {
> +			op_type = OBJ_OPT_WRITE;
> +			opcode = CEPH_OSD_OP_WRITE;
> +		} else {
> +			op_type = OBJ_OPT_READ;
> +			opcode = CEPH_OSD_OP_READ;
> +		}
> +
> +		osd_req = rbd_osd_req_create(rbd_dev, op_type, obj_request);
>  		if (!osd_req)
>  			goto out_partial;
>  		obj_request->osd_req = osd_req;
> @@ -2237,7 +2260,7 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
>  					obj_request->pages, length,
>  					offset & ~PAGE_MASK, false, false);
>  
> -		if (write_request)
> +		if (op_type == OBJ_OPT_WRITE)
>  			rbd_osd_req_format_write(obj_request);
>  		else
>  			rbd_osd_req_format_read(obj_request);
> @@ -2604,7 +2627,7 @@ static int rbd_img_obj_exists_submit(struct rbd_obj_request *obj_request)
>  
>  	rbd_assert(obj_request->img_request);
>  	rbd_dev = obj_request->img_request->rbd_dev;
> -	stat_request->osd_req = rbd_osd_req_create(rbd_dev, false,
> +	stat_request->osd_req = rbd_osd_req_create(rbd_dev, OBJ_OPT_READ,
>  						stat_request);
>  	if (!stat_request->osd_req)
>  		goto out;
> @@ -2814,7 +2837,8 @@ static int rbd_obj_notify_ack_sync(struct rbd_device *rbd_dev, u64 notify_id)
>  		return -ENOMEM;
>  
>  	ret = -ENOMEM;
> -	obj_request->osd_req = rbd_osd_req_create(rbd_dev, false, obj_request);
> +	obj_request->osd_req = rbd_osd_req_create(rbd_dev, OBJ_OPT_READ,
> +							obj_request);
>  	if (!obj_request->osd_req)
>  		goto out;
>  
> @@ -2877,7 +2901,8 @@ static int __rbd_dev_header_watch_sync(struct rbd_device *rbd_dev, bool start)
>  	if (!obj_request)
>  		goto out_cancel;
>  
> -	obj_request->osd_req = rbd_osd_req_create(rbd_dev, true, obj_request);
> +	obj_request->osd_req = rbd_osd_req_create(rbd_dev, OBJ_OPT_WRITE,
> +							obj_request);
>  	if (!obj_request->osd_req)
>  		goto out_cancel;
>  
> @@ -2985,7 +3010,8 @@ static int rbd_obj_method_sync(struct rbd_device *rbd_dev,
>  	obj_request->pages = pages;
>  	obj_request->page_count = page_count;
>  
> -	obj_request->osd_req = rbd_osd_req_create(rbd_dev, false, obj_request);
> +	obj_request->osd_req = rbd_osd_req_create(rbd_dev, OBJ_OPT_READ,
> +							obj_request);
>  	if (!obj_request->osd_req)
>  		goto out;
>  
> @@ -3040,7 +3066,7 @@ static void rbd_request_fn(struct request_queue *q)
>  	int result;
>  
>  	while ((rq = blk_fetch_request(q))) {
> -		bool write_request = rq_data_dir(rq) == WRITE;
> +		enum obj_operation_type type;
>  		struct rbd_img_request *img_request;
>  		u64 offset;
>  		u64 length;
> @@ -3067,9 +3093,14 @@ static void rbd_request_fn(struct request_queue *q)
>  
>  		spin_unlock_irq(q->queue_lock);
>  
> -		/* Disallow writes to a read-only device */
> +		if (rq->cmd_flags & REQ_WRITE)
> +			type = OBJ_OPT_WRITE;
> +		else
> +			type = OBJ_OPT_READ;
> +
> +		/* Only allow reads to a read-only device */
>  
> -		if (write_request) {
> +		if (type != OBJ_OPT_READ) {
>  			result = -EROFS;
>  			if (read_only)
>  				goto end_request;
> @@ -3106,7 +3137,7 @@ static void rbd_request_fn(struct request_queue *q)
>  
>  		result = -ENOMEM;
>  		img_request = rbd_img_request_create(rbd_dev, offset, length,
> -							write_request);
> +							type);
>  		if (!img_request)
>  			goto end_request;
>  
> @@ -3122,8 +3153,7 @@ end_request:
>  		spin_lock_irq(q->queue_lock);
>  		if (result < 0) {
>  			rbd_warn(rbd_dev, "%s %llx at %llx result %d\n",
> -				write_request ? "write" : "read",
> -				length, offset, result);
> +				obj_opt[type], length, offset, result);
>  
>  			__blk_end_request_all(rq, result);
>  		}
> @@ -3218,7 +3248,8 @@ static int rbd_obj_read_sync(struct rbd_device *rbd_dev,
>  	obj_request->pages = pages;
>  	obj_request->page_count = page_count;
>  
> -	obj_request->osd_req = rbd_osd_req_create(rbd_dev, false, obj_request);
> +	obj_request->osd_req = rbd_osd_req_create(rbd_dev, OBJ_OPT_READ,
> +							obj_request);
>  	if (!obj_request->osd_req)
>  		goto out;
>  
> 

