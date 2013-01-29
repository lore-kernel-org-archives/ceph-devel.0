From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 01/12, v2] rbd: new request tracking code
Date: Tue, 29 Jan 2013 02:43:11 -0800
Message-ID: <5107A7BF.4080704@inktank.com>
References: <50FF11EA.3000808@inktank.com> <50FF128B.1030405@inktank.com> <5101406E.4060602@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f41.google.com ([209.85.210.41]:61609 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129Ab3A2KnO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Jan 2013 05:43:14 -0500
Received: by mail-da0-f41.google.com with SMTP id e20so165833dak.14
        for <ceph-devel@vger.kernel.org>; Tue, 29 Jan 2013 02:43:14 -0800 (PST)
In-Reply-To: <5101406E.4060602@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/24/2013 06:08 AM, Alex Elder wrote:
> This is an update of the first patch in my request tracking
> code series.  After posting it the other day I identified some
> problems related to reference counting of image and object
> requests.  I also am starting to look at the details of
> implementing layered reads, and ended up making some
> substantive changes.  Since I have not seen any review
> feedback I thought the best thing would be to just
> re-post the updated patch.
>
> The remaining patches in the series have changed accordingly,
> but they have not really changed substantively, so I am
> not re-posting those (but will if it's requested).
>
> The main functional change is that an image request no longer
> maintains an array of object request pointers, it maintains
> a list of object requests.  This simplifies some things, and
> makes the image request structure fixed size.
>
> A few other functional changes:
> - Reference counting of object and image requests is now
>    done sensibly.
> - Image requests now support a callback when complete,
>    which will be used for layered I/O requests.
> - There are a few new helper functions that encapsulate
>    tying an object request to an image request.
> - An distinct value is now used for the "which" field
>    for object requests not associated with a image request
>    (mainly used for validation/assertions).
>
> Other changes:
> - Everything that was named "image_request" now uses
>    "img_request" instead.
> - A few blocks and lines of code have been rearranged.
>
> The updated series is available on the ceph-client git
> repository in the branch "wip-rbd-review-v2".
>
> 					-Alex
>
> This patch fully implements the new request tracking code for rbd
> I/O requests.
>
> Each I/O request to an rbd image will get an rbd_image_request
> structure allocated to track it.  This provides access to all
> information about the original request, as well as access to the
> set of one or more object requests that are initiated as a result
> of the image request.
>
> An rbd_obj_request structure defines a request sent to a single osd
> object (possibly) as part of an rbd image request.  An rbd object
> request refers to a ceph_osd_request structure built up to represent
> the request; for now it will contain a single osd operation.  It
> also provides space to hold the result status and the version of the
> object when the osd request completes.
>
> An rbd_obj_request structure can also stand on its own.  This will
> be used for reading the version 1 header object, for issuing
> acknowledgements to event notifications, and for making object
> method calls.
>
> All rbd object requests now complete asynchronously with respect
> to the osd client--they supply a common callback routine.
>
> This resolves:
>      http://tracker.newdream.net/issues/3741
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
> v2: - fixed reference counting
>      - image request callback support
>      - image/object connection helper functions
>      - distinct BAD_WHICH value for non-image object requests
>
>   drivers/block/rbd.c |  622
> ++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 620 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 6689363..46a61dd 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -181,6 +181,67 @@ struct rbd_req_coll {
>   	struct rbd_req_status	status[0];
>   };
>
> +struct rbd_img_request;
> +typedef void (*rbd_img_callback_t)(struct rbd_img_request *);
> +
> +#define	BAD_WHICH	U32_MAX		/* Good which or bad which, which? */
> +
> +struct rbd_obj_request;
> +typedef void (*rbd_obj_callback_t)(struct rbd_obj_request *);
> +
> +enum obj_req_type { obj_req_bio };	/* More types to come */

enum labels should be capitalized.

> +struct rbd_obj_request {
> +	const char		*object_name;
> +	u64			offset;		/* object start byte */
> +	u64			length;		/* bytes from offset */
> +
> +	struct rbd_img_request	*img_request;
> +	struct list_head	links;
> +	u32			which;		/* posn image request list */
> +
> +	enum obj_req_type	type;
> +	struct bio		*bio_list;
> +
> +	struct ceph_osd_request	*osd_req;
> +
> +	u64			xferred;	/* bytes transferred */
> +	u64			version;

This version is only used (uselessly) for the watch operation. It
should be removed in a future patch (along with the obj_ver in the
header).

> +	s32			result;
> +	atomic_t		done;
> +
> +	rbd_obj_callback_t	callback;
> +
> +	struct kref		kref;
> +};
> +
> +struct rbd_img_request {
> +	struct request		*rq;
> +	struct rbd_device	*rbd_dev;
> +	u64			offset;	/* starting image byte offset */
> +	u64			length;	/* byte count from offset */
> +	bool			write_request;	/* false for read */
> +	union {
> +		struct ceph_snap_context *snapc;	/* for writes */
> +		u64		snap_id;		/* for reads */
> +	};
> +	spinlock_t		completion_lock;

It'd be nice to have a comment describing what this lock protects.

> +	u32			next_completion;
> +	rbd_img_callback_t	callback;
> +
> +	u32			obj_request_count;
> +	struct list_head	obj_requests;

Maybe note that these are rbd_obj_requests, and not ceph_osd_requests.

> +	struct kref		kref;
> +};
> +
> +#define for_each_obj_request(ireq, oreq) \
> +	list_for_each_entry(oreq, &ireq->obj_requests, links)
> +#define for_each_obj_request_from(ireq, oreq) \
> +	list_for_each_entry_from(oreq, &ireq->obj_requests, links)
> +#define for_each_obj_request_safe(ireq, oreq, n) \
> +	list_for_each_entry_safe_reverse(oreq, n, &ireq->obj_requests, links)
> +
>   /*
>    * a single io request
>    */
> @@ -1031,6 +1092,62 @@ out_err:
>   	return NULL;
>   }
>
> +static void rbd_obj_request_get(struct rbd_obj_request *obj_request)
> +{
> +	kref_get(&obj_request->kref);
> +}
> +
> +static void rbd_obj_request_destroy(struct kref *kref);
> +static void rbd_obj_request_put(struct rbd_obj_request *obj_request)
> +{
> +	rbd_assert(obj_request != NULL);
> +	kref_put(&obj_request->kref, rbd_obj_request_destroy);
> +}
> +
> +static void rbd_img_request_get(struct rbd_img_request *img_request)
> +{
> +	kref_get(&img_request->kref);
> +}
> +
> +static void rbd_img_request_destroy(struct kref *kref);
> +static void rbd_img_request_put(struct rbd_img_request *img_request)
> +{
> +	rbd_assert(img_request != NULL);
> +	kref_put(&img_request->kref, rbd_img_request_destroy);
> +}
> +
> +static inline void rbd_img_obj_request_add(struct rbd_img_request
> *img_request,
> +					struct rbd_obj_request *obj_request)
> +{
> +	rbd_obj_request_get(obj_request);
> +	obj_request->img_request = img_request;
> +	list_add_tail(&obj_request->links, &img_request->obj_requests);
> +	obj_request->which = img_request->obj_request_count++;
> +	rbd_assert(obj_request->which != BAD_WHICH);
> +}
> +
> +static inline void rbd_img_obj_request_del(struct rbd_img_request
> *img_request,
> +					struct rbd_obj_request *obj_request)
> +{
> +	rbd_assert(obj_request->which != BAD_WHICH);
> +	obj_request->which = BAD_WHICH;
> +	list_del(&obj_request->links);
> +	rbd_assert(obj_request->img_request == img_request);
> +	obj_request->callback = NULL;
> +	obj_request->img_request = NULL;
> +	rbd_obj_request_put(obj_request);
> +}
> +
> +static bool obj_req_type_valid(enum obj_req_type type)
> +{
> +	switch (type) {
> +	case obj_req_bio:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>   struct ceph_osd_req_op *rbd_osd_req_op_create(u16 opcode, ...)
>   {
>   	struct ceph_osd_req_op *op;
> @@ -1395,6 +1512,26 @@ done:
>   	return ret;
>   }
>
> +static int rbd_obj_request_submit(struct ceph_osd_client *osdc,
> +				struct rbd_obj_request *obj_request)
> +{
> +	return ceph_osdc_start_request(osdc, obj_request->osd_req, false);
> +}
> +
> +static void rbd_img_request_complete(struct rbd_img_request *img_request)
> +{
> +	if (img_request->callback)
> +		img_request->callback(img_request);
> +	else
> +		rbd_img_request_put(img_request);
> +}

Why rely on the callback to rbd_img_request_put()? Wouldn't it be a
bit simpler to unconditionally do the put here?

> +static void rbd_obj_request_complete(struct rbd_obj_request *obj_request)
> +{
> +	if (obj_request->callback)
> +		obj_request->callback(obj_request);
> +}
> +
>   /*
>    * Request sync osd read
>    */
> @@ -1618,6 +1755,487 @@ static int rbd_dev_do_request(struct request *rq,
>   	return 0;
>   }
>
> +static void rbd_osd_read_callback(struct rbd_obj_request *obj_request,
> +				struct ceph_osd_op *op)
> +{
> +	u64 xferred;
> +
> +	/*
> +	 * We support a 64-bit length, but ultimately it has to be
> +	 * passed to blk_end_request(), which takes an unsigned int.
> +	 */
> +	xferred = le64_to_cpu(op->extent.length);
> +	rbd_assert(xferred < (u64) UINT_MAX);
> +	if (obj_request->result == (s32) -ENOENT) {
> +		zero_bio_chain(obj_request->bio_list, 0);
> +		obj_request->result = 0;
> +	} else if (xferred < obj_request->length && !obj_request->result) {
> +		zero_bio_chain(obj_request->bio_list, xferred);
> +		xferred = obj_request->length;
> +	}
> +	obj_request->xferred = xferred;
> +	atomic_set(&obj_request->done, 1);
> +}
> +
> +static void rbd_osd_write_callback(struct rbd_obj_request *obj_request,
> +				struct ceph_osd_op *op)
> +{
> +	obj_request->xferred = le64_to_cpu(op->extent.length);
> +	atomic_set(&obj_request->done, 1);
> +}
> +
> +static void rbd_osd_req_callback(struct ceph_osd_request *osd_req,
> +				struct ceph_msg *msg)
> +{
> +	struct rbd_obj_request *obj_request = osd_req->r_priv;
> +	struct ceph_osd_reply_head *reply_head;
> +	struct ceph_osd_op *op;
> +	u32 num_ops;
> +	u16 opcode;
> +
> +	rbd_assert(osd_req == obj_request->osd_req);
> +	rbd_assert(!!obj_request->img_request ^
> +				(obj_request->which == BAD_WHICH));
> +
> +	obj_request->xferred = le32_to_cpu(msg->hdr.data_len);
> +	reply_head = msg->front.iov_base;
> +	obj_request->result = (s32) le32_to_cpu(reply_head->result);
> +	obj_request->version = le64_to_cpu(osd_req->r_reassert_version.version);
> +
> +	num_ops = le32_to_cpu(reply_head->num_ops);
> +	WARN_ON(num_ops != 1);	/* For now */
> +
> +	op = &reply_head->ops[0];
> +	opcode = le16_to_cpu(op->op);
> +	switch (opcode) {
> +	case CEPH_OSD_OP_READ:
> +		rbd_osd_read_callback(obj_request, op);
> +		break;
> +	case CEPH_OSD_OP_WRITE:
> +		rbd_osd_write_callback(obj_request, op);
> +		break;
> +	default:
> +		rbd_warn(NULL, "%s: unsupported op %hu\n",
> +			obj_request->object_name, (unsigned short) opcode);
> +		break;
> +	}
> +
> +	if (atomic_read(&obj_request->done))
> +		rbd_obj_request_complete(obj_request);
> +}
> +
> +static struct ceph_osd_request *rbd_osd_req_create(
> +					struct rbd_device *rbd_dev,
> +					bool write_request,
> +					struct rbd_obj_request *obj_request,
> +					struct ceph_osd_req_op *op)
> +{
> +	struct rbd_img_request *img_request = obj_request->img_request;
> +	struct ceph_snap_context *snapc = NULL;
> +	struct ceph_osd_client *osdc;
> +	struct ceph_osd_request *osd_req;
> +	struct timespec now;
> +	struct timespec *mtime;
> +	u64 snap_id = CEPH_NOSNAP;
> +	u64 offset = obj_request->offset;
> +	u64 length = obj_request->length;
> +
> +	if (img_request) {
> +		rbd_assert(img_request->write_request == write_request);
> +		if (img_request->write_request)
> +			snapc = img_request->snapc;
> +		else
> +			snap_id = img_request->snap_id;
> +	}
> +
> +	/* Allocate and initialize the request, for the single op */
> +
> +	osdc = &rbd_dev->rbd_client->client->osdc;
> +	osd_req = ceph_osdc_alloc_request(osdc, snapc, 1, false, GFP_ATOMIC);
> +	if (!osd_req)
> +		return NULL;	/* ENOMEM */
> +
> +	rbd_assert(obj_req_type_valid(obj_request->type));
> +	switch (obj_request->type) {
> +	case obj_req_bio:
> +		rbd_assert(obj_request->bio_list != NULL);
> +		osd_req->r_bio = obj_request->bio_list;
> +		bio_get(osd_req->r_bio);
> +		/* osd client requires "num pages" even for bio */
> +		osd_req->r_num_pages = calc_pages_for(offset, length);
> +		break;
> +	}
> +
> +	if (write_request) {
> +		osd_req->r_flags = CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK;
> +		now = CURRENT_TIME;
> +		mtime = &now;
> +	} else {
> +		osd_req->r_flags = CEPH_OSD_FLAG_READ;
> +		mtime = NULL;	/* not needed for reads */
> +		offset = 0;	/* These are not used... */
> +		length = 0;	/* ...for osd read requests */
> +	}
> +
> +	osd_req->r_callback = rbd_osd_req_callback;
> +	osd_req->r_priv = obj_request;
> +
> +	/* No trailing '\0' required for the object name in the request */

It looks like ceph_calc_object_layout() does require the trailing '\0':

osd_client.c:
   __map_request()
     ceph_calc_object_layout(...,->r_oid,...)
       strlen(oid)

> +	osd_req->r_oid_len = strlen(obj_request->object_name);
> +	rbd_assert(osd_req->r_oid_len <= sizeof (osd_req->r_oid));
> +	memcpy(osd_req->r_oid, obj_request->object_name, osd_req->r_oid_len);
> +
> +	osd_req->r_file_layout = rbd_dev->layout;	/* struct */
> +
> +	/* osd_req will get its own reference to snapc (if non-null) */
> +
> +	ceph_osdc_build_request(osd_req, offset, length, 1, op,
> +				snapc, snap_id, mtime);
> +
> +	return osd_req;
> +}
> +
> +static void rbd_osd_req_destroy(struct ceph_osd_request *osd_req)
> +{
> +	ceph_osdc_put_request(osd_req);
> +}
> +
> +/* object_name is assumed to be a non-null pointer and NUL-terminated */
> +
> +static struct rbd_obj_request *rbd_obj_request_create(const char
> *object_name,
> +						u64 offset, u64 length,
> +						enum obj_req_type type)
> +{
> +	struct rbd_obj_request *obj_request;
> +	size_t size;
> +	char *name;
> +
> +	rbd_assert(obj_req_type_valid(type));
> +
> +	size = strlen(object_name) + 1;
> +	obj_request = kzalloc(sizeof (*obj_request) + size, GFP_KERNEL);
> +	if (!obj_request)
> +		return NULL;
> +
> +	name = (char *)(obj_request + 1);
> +	obj_request->object_name = memcpy(name, object_name, size);
> +	obj_request->offset = offset;
> +	obj_request->length = length;
> +	obj_request->which = BAD_WHICH;
> +	obj_request->type = type;
> +	INIT_LIST_HEAD(&obj_request->links);
> +	atomic_set(&obj_request->done, 0);
> +	kref_init(&obj_request->kref);
> +
> +	return obj_request;
> +}
> +
> +static void rbd_obj_request_destroy(struct kref *kref)
> +{
> +	struct rbd_obj_request *obj_request;
> +
> +	obj_request = container_of(kref, struct rbd_obj_request, kref);
> +
> +	rbd_assert(obj_request->img_request == NULL);
> +	rbd_assert(obj_request->which == BAD_WHICH);
> +
> +	if (obj_request->osd_req)
> +		rbd_osd_req_destroy(obj_request->osd_req);
> +
> +	rbd_assert(obj_req_type_valid(obj_request->type));
> +	switch (obj_request->type) {
> +	case obj_req_bio:
> +		if (obj_request->bio_list)
> +			bio_chain_put(obj_request->bio_list);
> +		break;
> +	}
> +
> +	kfree(obj_request);
> +}
> +
> +/*
> + * Caller is responsible for filling in the list of object requests
> + * that comprises the image request, and the Linux request pointer
> + * (if there is one).
> + */
> +struct rbd_img_request *rbd_img_request_create(struct rbd_device *rbd_dev,
> +					u64 offset, u64 length,
> +					bool write_request)
> +{
> +	struct rbd_img_request *img_request;
> +	struct ceph_snap_context *snapc = NULL;
> +
> +	img_request = kmalloc(sizeof (*img_request), GFP_ATOMIC);
> +	if (!img_request)
> +		return NULL;
> +
> +	if (write_request) {
> +		down_read(&rbd_dev->header_rwsem);
> +		snapc = ceph_get_snap_context(rbd_dev->header.snapc);
> +		up_read(&rbd_dev->header_rwsem);
> +		if (WARN_ON(!snapc)) {
> +			kfree(img_request);
> +			return NULL;	/* Shouldn't happen */
> +		}
> +	}
> +
> +	img_request->rq = NULL;
> +	img_request->rbd_dev = rbd_dev;
> +	img_request->offset = offset;
> +	img_request->length = length;
> +	img_request->write_request = write_request;
> +	if (write_request)
> +		img_request->snapc = snapc;
> +	else
> +		img_request->snap_id = rbd_dev->spec->snap_id;
> +	spin_lock_init(&img_request->completion_lock);
> +	img_request->next_completion = 0;
> +	img_request->callback = NULL;
> +	img_request->obj_request_count = 0;
> +	INIT_LIST_HEAD(&img_request->obj_requests);
> +	kref_init(&img_request->kref);
> +
> +	rbd_img_request_get(img_request);	/* Avoid a warning */
> +	rbd_img_request_put(img_request);	/* TEMPORARY */
> +
> +	return img_request;
> +}
> +
> +static void rbd_img_request_destroy(struct kref *kref)
> +{
> +	struct rbd_img_request *img_request;
> +	struct rbd_obj_request *obj_request;
> +	struct rbd_obj_request *next_obj_request;
> +
> +	img_request = container_of(kref, struct rbd_img_request, kref);
> +
> +	for_each_obj_request_safe(img_request, obj_request, next_obj_request)
> +		rbd_img_obj_request_del(img_request, obj_request);
> +
> +	if (img_request->write_request)
> +		ceph_put_snap_context(img_request->snapc);
> +
> +	kfree(img_request);
> +}
> +
> +static int rbd_img_request_fill_bio(struct rbd_img_request *img_request,
> +					struct bio *bio_list)
> +{
> +	struct rbd_device *rbd_dev = img_request->rbd_dev;
> +	struct rbd_obj_request *obj_request = NULL;
> +	struct rbd_obj_request *next_obj_request;
> +	unsigned int bio_offset;
> +	u64 image_offset;
> +	u64 resid;
> +	u16 opcode;
> +
> +	opcode = img_request->write_request ? CEPH_OSD_OP_WRITE
> +					      : CEPH_OSD_OP_READ;
> +	bio_offset = 0;
> +	image_offset = img_request->offset;
> +	rbd_assert(image_offset == bio_list->bi_sector << SECTOR_SHIFT);
> +	resid = img_request->length;
> +	while (resid) {
> +		const char *object_name;
> +		unsigned int clone_size;
> +		struct ceph_osd_req_op *op;
> +		u64 offset;
> +		u64 length;
> +
> +		object_name = rbd_segment_name(rbd_dev, image_offset);
> +		if (!object_name)
> +			goto out_unwind;
> +		offset = rbd_segment_offset(rbd_dev, image_offset);
> +		length = rbd_segment_length(rbd_dev, image_offset, resid);
> +		obj_request = rbd_obj_request_create(object_name,
> +						offset, length, obj_req_bio);
> +		kfree(object_name);	/* object request has its own copy */
> +		if (!obj_request)
> +			goto out_unwind;
> +
> +		rbd_assert(length <= (u64) UINT_MAX);
> +		clone_size = (unsigned int) length;
> +		obj_request->bio_list = bio_chain_clone_range(&bio_list,
> +						&bio_offset, clone_size,
> +						GFP_ATOMIC);
> +		if (!obj_request->bio_list)
> +			goto out_partial;
> +
> +		/*
> +		 * Build up the op to use in building the osd
> +		 * request.  Note that the contents of the op are
> +		 * copied by rbd_osd_req_create().
> +		 */
> +		op = rbd_osd_req_op_create(opcode, offset, length);
> +		if (!op)
> +			goto out_partial;
> +		obj_request->osd_req = rbd_osd_req_create(rbd_dev,
> +						img_request->write_request,
> +						obj_request, op);
> +		rbd_osd_req_op_destroy(op);
> +		if (!obj_request->osd_req)
> +			goto out_partial;
> +		/* status and version are initially zero-filled */
> +
> +		rbd_img_obj_request_add(img_request, obj_request);
> +
> +		image_offset += length;
> +		resid -= length;
> +	}
> +
> +	return 0;
> +
> +out_partial:
> +	rbd_obj_request_put(obj_request);
> +out_unwind:
> +	for_each_obj_request_safe(img_request, obj_request, next_obj_request)
> +		rbd_obj_request_put(obj_request);
> +
> +	return -ENOMEM;
> +}
> +
> +static void rbd_img_obj_callback(struct rbd_obj_request *obj_request)
> +{
> +	struct rbd_img_request *img_request;
> +	u32 which = obj_request->which;
> +	bool more = true;
> +
> +	img_request = obj_request->img_request;
> +	rbd_assert(img_request != NULL);
> +	rbd_assert(img_request->rq != NULL);
> +	rbd_assert(which != BAD_WHICH);
> +	rbd_assert(which < img_request->obj_request_count);
> +	rbd_assert(which >= img_request->next_completion);
> +
> +	spin_lock(&img_request->completion_lock);

In the current equivalent code (rbd_coll_end_req_index), we use
spin_lock_irq(), and don't hold the spinlock while calling
blk_end_request.

Why the change, and is this change safe?

> +	if (which != img_request->next_completion)
> +		goto out;
> +
> +	for_each_obj_request_from(img_request, obj_request) {
> +		unsigned int xferred;
> +		int result;
> +
> +		rbd_assert(more);
> +		rbd_assert(which < img_request->obj_request_count);
> +
> +		if (!atomic_read(&obj_request->done))
> +			break;
> +
> +		rbd_assert(obj_request->xferred <= (u64) UINT_MAX);
> +		xferred = (unsigned int) obj_request->xferred;
> +		result = (int) obj_request->result;
> +		if (result)
> +			rbd_warn(NULL, "obj_request %s result %d xferred %u\n",
> +				img_request->write_request ? "write" : "read",
> +				result, xferred);
> +
> +		more = blk_end_request(img_request->rq, result, xferred);
> +		which++;
> +	}
> +	rbd_assert(more ^ (which == img_request->obj_request_count));
> +	img_request->next_completion = which;
> +out:
> +	spin_unlock(&img_request->completion_lock);
> +
> +	if (!more)
> +		rbd_img_request_complete(img_request);
> +}
> +
> +static int rbd_img_request_submit(struct rbd_img_request *img_request)
> +{
> +	struct rbd_device *rbd_dev = img_request->rbd_dev;
> +	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
> +	struct rbd_obj_request *obj_request;
> +
> +	for_each_obj_request(img_request, obj_request) {
> +		int ret;
> +
> +		obj_request->callback = rbd_img_obj_callback;
> +		ret = rbd_obj_request_submit(osdc, obj_request);
> +		if (ret)
> +			return ret;
> +		/*
> +		 * The image request has its own reference to each
> +		 * of its object requests, so we can safely drop the
> +		 * initial one here.
> +		 */
> +		rbd_obj_request_put(obj_request);
> +	}
> +
> +	return 0;
> +}
> +
> +static void rbd_request_fn(struct request_queue *q)
> +{
> +	struct rbd_device *rbd_dev = q->queuedata;
> +	bool read_only = rbd_dev->mapping.read_only;
> +	struct request *rq;
> +	int result;
> +
> +	while ((rq = blk_fetch_request(q))) {
> +		bool write_request = rq_data_dir(rq) == WRITE;
> +		struct rbd_img_request *img_request;
> +		u64 offset;
> +		u64 length;
> +
> +		/* Ignore any non-FS requests that filter through. */
> +
> +		if (rq->cmd_type != REQ_TYPE_FS) {
> +			__blk_end_request_all(rq, 0);
> +			continue;
> +		}
> +
> +		spin_unlock_irq(q->queue_lock);
> +
> +		/* Disallow writes to a read-only device */
> +
> +		if (write_request) {
> +			result = -EROFS;
> +			if (read_only)
> +				goto end_request;
> +			rbd_assert(rbd_dev->spec->snap_id == CEPH_NOSNAP);
> +		}
> +
> +		/* Quit early if the snapshot has disappeared */
> +
> +		if (!atomic_read(&rbd_dev->exists)) {
> +			dout("request for non-existent snapshot");
> +			rbd_assert(rbd_dev->spec->snap_id != CEPH_NOSNAP);
> +			result = -ENXIO;
> +			goto end_request;
> +		}
> +
> +		offset = (u64) blk_rq_pos(rq) << SECTOR_SHIFT;
> +		length = (u64) blk_rq_bytes(rq);
> +
> +		result = -EINVAL;
> +		if (WARN_ON(offset && length > U64_MAX - offset + 1))
> +			goto end_request;	/* Shouldn't happen */
> +
> +		result = -ENOMEM;
> +		img_request = rbd_img_request_create(rbd_dev, offset, length,
> +							write_request);
> +		if (!img_request)
> +			goto end_request;
> +
> +		img_request->rq = rq;
> +
> +		result = rbd_img_request_fill_bio(img_request, rq->bio);
> +		if (!result)
> +			result = rbd_img_request_submit(img_request);
> +		if (result)
> +			rbd_img_request_put(img_request);
> +end_request:
> +		spin_lock_irq(q->queue_lock);
> +		if (result < 0) {
> +			rbd_warn(rbd_dev, "obj_request %s result %d\n",
> +				write_request ? "write" : "read", result);
> +			__blk_end_request_all(rq, result);
> +		}
> +	}
> +}
> +
>   /*
>    * block device queue callback
>    */
> @@ -1929,8 +2547,8 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
>   	disk->fops = &rbd_bd_ops;
>   	disk->private_data = rbd_dev;
>
> -	/* init rq */
> -	q = blk_init_queue(rbd_rq_fn, &rbd_dev->lock);
> +	(void) rbd_rq_fn;		/* avoid a warning */
> +	q = blk_init_queue(rbd_request_fn, &rbd_dev->lock);
>   	if (!q)
>   		goto out_disk;
>

