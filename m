From: Alex Elder <elder@inktank.com>
Subject: [PATCH 01/12] rbd: new request tracking code
Date: Tue, 22 Jan 2013 16:28:27 -0600
Message-ID: <50FF128B.1030405@inktank.com>
References: <50FF11EA.3000808@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:41228 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855Ab3AVW2a (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 17:28:30 -0500
Received: by mail-ie0-f182.google.com with SMTP id s9so12638809iec.13
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 14:28:30 -0800 (PST)
In-Reply-To: <50FF11EA.3000808@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This patch fully implements the new request tracking code for rbd
I/O requests.

Each I/O request to an rbd image will get an rbd_image_request
structure allocated to track it.  This provides access to all
information about the original request, as well as access to the
set of one or more object requests that are initiated as a result
of the image request.

An rbd_obj_request structure defines a request sent to a single osd
object (possibly) as part of an rbd image request.  An rbd object
request refers to a ceph_osd_request structure built up to represent
the request; for now it will contain a single osd operation.  It
also provides space to hold the result status and the version of the
object when the osd request completes.

An rbd_obj_request structure can also stand on its own.  This will
be used for reading the version 1 header object, for issuing
acknowledgements to event notifications, and for making object
method calls.

All rbd object requests now complete asynchronously with respect
to the osd client--they supply a common callback routine.

This resolves:
    http://tracker.newdream.net/issues/3741

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |  596
++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 594 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 6689363..485fa70 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -181,6 +181,55 @@ struct rbd_req_coll {
 	struct rbd_req_status	status[0];
 };

+struct rbd_image_request;
+
+enum obj_req_type { obj_req_bio };	/* More types to come */
+
+struct rbd_obj_request;
+typedef void (*rbd_obj_callback_t)(struct rbd_obj_request *);
+
+struct rbd_obj_request {
+	const char		*object_name;
+	u64			offset;		/* object start byte */
+	u64			length;		/* bytes from offset */
+
+	struct rbd_image_request *image_request;
+	u32			which;		/* posn in image req array */
+
+	enum obj_req_type	type;
+	struct bio		*bio_list;
+
+	struct ceph_osd_request	*osd_req;
+
+	u64			xferred;	/* bytes transferred */
+	u64			version;
+	s32			result;
+	atomic_t		done;
+
+	rbd_obj_callback_t	callback;
+
+	struct kref		kref;
+};
+
+struct rbd_image_request {
+	struct request		*rq;
+	struct rbd_device	*rbd_dev;
+	union {
+		struct ceph_snap_context *snapc;	/* for writes */
+		u64		snap_id;		/* for reads */
+	};
+	u64			offset;	/* starting image byte offset */
+	u64			length;	/* byte count from offset */
+	spinlock_t		completion_lock;
+	u32			next_completion;
+	bool			write_request;	/* false for read */
+	u32			obj_req_count;
+
+	struct kref		kref;
+
+	struct rbd_obj_request	*obj_requests[0];
+};
+
 /*
  * a single io request
  */
@@ -1031,6 +1080,40 @@ out_err:
 	return NULL;
 }

+static void rbd_obj_request_get(struct rbd_obj_request *obj_request)
+{
+	kref_get(&obj_request->kref);
+}
+
+static void rbd_obj_request_destroy(struct kref *kref);
+static void rbd_obj_request_put(struct rbd_obj_request *obj_request)
+{
+	rbd_assert(obj_request != NULL);
+	kref_put(&obj_request->kref, rbd_obj_request_destroy);
+}
+
+static void rbd_image_request_get(struct rbd_image_request *image_request)
+{
+	kref_get(&image_request->kref);
+}
+
+static void rbd_image_request_destroy(struct kref *kref);
+static void rbd_image_request_put(struct rbd_image_request *image_request)
+{
+	rbd_assert(image_request != NULL);
+	kref_put(&image_request->kref, rbd_image_request_destroy);
+}
+
+static bool obj_req_type_valid(enum obj_req_type type)
+{
+	switch (type) {
+	case obj_req_bio:
+		return true;
+	default:
+		return false;
+	}
+}
+
 struct ceph_osd_req_op *rbd_osd_req_op_create(u16 opcode, ...)
 {
 	struct ceph_osd_req_op *op;
@@ -1395,6 +1478,19 @@ done:
 	return ret;
 }

+static int rbd_obj_request_submit(struct ceph_osd_client *osdc,
+				struct rbd_obj_request *obj_request)
+{
+	int ret;
+
+	rbd_obj_request_get(obj_request);
+	ret = ceph_osdc_start_request(osdc, obj_request->osd_req, false);
+	if (ret)
+		rbd_obj_request_put(obj_request);
+
+	return ret;
+}
+
 /*
  * Request sync osd read
  */
@@ -1618,6 +1714,502 @@ static int rbd_dev_do_request(struct request *rq,
 	return 0;
 }

+/* Returns true if this call completed the last object request */
+
+static bool rbd_block_request_complete(struct rbd_image_request
*image_request,
+					u32 which)
+
+{
+	struct request *rq = image_request->rq;
+	bool more = true;
+
+	rbd_assert(rq != NULL);
+	rbd_assert(which < image_request->obj_req_count);
+	rbd_assert(which >= image_request->next_completion);
+
+	rbd_image_request_put(image_request);
+
+	spin_lock(&image_request->completion_lock);
+	if (which != image_request->next_completion)
+		goto out;
+	do {
+		struct rbd_obj_request *obj_request;
+		unsigned int xferred;
+		int result;
+
+		rbd_assert(more);
+		obj_request = image_request->obj_requests[which];
+		rbd_assert(obj_request != NULL);
+		if (!atomic_read(&obj_request->done))
+			break;
+		rbd_assert(obj_request->xferred <= (u64) UINT_MAX);
+		xferred = (unsigned int) obj_request->xferred;
+		result = (int) obj_request->result;
+
+		more = blk_end_request(rq, result, xferred);
+	} while (++which < image_request->obj_req_count);
+	rbd_assert(more ^ (which == image_request->obj_req_count));
+	image_request->next_completion = which;
+out:
+	spin_unlock(&image_request->completion_lock);
+
+	return !more;
+}
+
+static void rbd_osd_read_callback(struct rbd_obj_request *obj_request,
+				struct ceph_osd_op *op)
+{
+	u64 xferred;
+
+	/*
+	 * We support a 64-bit length, but ultimately it has to be
+	 * passed to blk_end_request(), which takes an unsigned int.
+	 */
+	xferred = le64_to_cpu(op->extent.length);
+	rbd_assert(xferred < (u64) UINT_MAX);
+	if (obj_request->result == (s32) -ENOENT) {
+		zero_bio_chain(obj_request->bio_list, 0);
+		obj_request->result = 0;
+	} else if (xferred < obj_request->length && !obj_request->result) {
+		zero_bio_chain(obj_request->bio_list, xferred);
+		xferred = obj_request->length;
+	}
+	obj_request->xferred = xferred;
+	atomic_set(&obj_request->done, 1);
+}
+
+static void rbd_osd_write_callback(struct rbd_obj_request *obj_request,
+				struct ceph_osd_op *op)
+{
+	obj_request->xferred = le64_to_cpu(op->extent.length);
+	atomic_set(&obj_request->done, 1);
+}
+
+static void rbd_obj_request_complete(struct rbd_obj_request *obj_request)
+{
+	if (obj_request->callback)
+		obj_request->callback(obj_request);
+}
+
+static void rbd_osd_req_callback(struct ceph_osd_request *osd_req,
+				struct ceph_msg *msg)
+{
+	struct rbd_obj_request *obj_request = osd_req->r_priv;
+	struct ceph_osd_reply_head *reply_head;
+	struct ceph_osd_op *op;
+	u32 num_ops;
+	u16 opcode;
+
+	rbd_assert(osd_req == obj_request->osd_req);
+	rbd_obj_request_put(obj_request);
+	obj_request->xferred = le32_to_cpu(msg->hdr.data_len);
+	reply_head = msg->front.iov_base;
+	obj_request->result = (s32) le32_to_cpu(reply_head->result);
+	obj_request->version = le64_to_cpu(osd_req->r_reassert_version.version);
+
+	num_ops = le32_to_cpu(reply_head->num_ops);
+	WARN_ON(num_ops != 1);	/* For now */
+
+	op = &reply_head->ops[0];
+	opcode = le16_to_cpu(op->op);
+	switch (opcode) {
+	case CEPH_OSD_OP_READ:
+		rbd_osd_read_callback(obj_request, op);
+		break;
+	case CEPH_OSD_OP_WRITE:
+		rbd_osd_write_callback(obj_request, op);
+		break;
+	default:
+		rbd_warn(NULL, "%s: unsupported op %hu\n",
+			obj_request->object_name, (unsigned short) opcode);
+		break;
+	}
+
+	if (atomic_read(&obj_request->done))
+		rbd_obj_request_complete(obj_request);
+}
+
+static struct ceph_osd_request *rbd_osd_req_create(
+					struct rbd_device *rbd_dev,
+					bool write_request,
+					struct rbd_obj_request *obj_request,
+					struct ceph_osd_req_op *op)
+{
+	struct rbd_image_request *image_request = obj_request->image_request;
+	struct ceph_snap_context *snapc = NULL;
+	struct ceph_osd_client *osdc;
+	struct ceph_osd_request *osd_req;
+	struct timespec now;
+	struct timespec *mtime;
+	u64 snap_id = CEPH_NOSNAP;
+	u64 offset = obj_request->offset;
+	u64 length = obj_request->length;
+
+	if (image_request) {
+		rbd_assert(image_request->write_request == write_request);
+		if (image_request->write_request)
+			snapc = image_request->snapc;
+		else
+			snap_id = image_request->snap_id;
+	}
+
+	/* Allocate and initialize the request, for the single op */
+
+	osdc = &rbd_dev->rbd_client->client->osdc;
+	osd_req = ceph_osdc_alloc_request(osdc, snapc, 1, false, GFP_ATOMIC);
+	if (!osd_req)
+		return NULL;	/* ENOMEM */
+
+	rbd_assert(obj_req_type_valid(obj_request->type));
+	switch (obj_request->type) {
+	case obj_req_bio:
+		rbd_assert(obj_request->bio_list != NULL);
+		osd_req->r_bio = obj_request->bio_list;
+		bio_get(osd_req->r_bio);
+		/* osd client requires "num pages" even for bio */
+		osd_req->r_num_pages = calc_pages_for(offset, length);
+		break;
+	}
+
+	if (write_request) {
+		osd_req->r_flags = CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK;
+		now = CURRENT_TIME;
+		mtime = &now;
+	} else {
+		osd_req->r_flags = CEPH_OSD_FLAG_READ;
+		mtime = NULL;	/* not needed for reads */
+		offset = 0;	/* These are not used... */
+		length = 0;	/* ...for osd read requests */
+	}
+
+	osd_req->r_callback = rbd_osd_req_callback;
+	osd_req->r_priv = obj_request;
+
+	/* No trailing '\0' required for the object name in the request */
+
+	osd_req->r_oid_len = strlen(obj_request->object_name);
+	rbd_assert(osd_req->r_oid_len <= sizeof (osd_req->r_oid));
+	memcpy(osd_req->r_oid, obj_request->object_name, osd_req->r_oid_len);
+
+	osd_req->r_file_layout = rbd_dev->layout;	/* struct */
+
+	/* osd_req will get its own reference to snapc (if non-null) */
+
+	ceph_osdc_build_request(osd_req, offset, length, 1, op,
+				snapc, snap_id, mtime);
+
+	return osd_req;
+}
+
+static void rbd_osd_req_destroy(struct ceph_osd_request *osd_req)
+{
+	ceph_osdc_put_request(osd_req);
+}
+
+/* object_name is assumed to be a non-null pointer and NUL-terminated */
+
+static struct rbd_obj_request *rbd_obj_request_create(const char
*object_name,
+						u64 offset, u64 length,
+						enum obj_req_type type)
+{
+	struct rbd_obj_request *obj_request;
+	size_t size;
+	char *name;
+
+	rbd_assert(obj_req_type_valid(type));
+
+	size = strlen(object_name) + 1;
+	obj_request = kzalloc(sizeof (*obj_request) + size, GFP_KERNEL);
+	if (!obj_request)
+		return NULL;
+
+	name = (char *)(obj_request + 1);
+	obj_request->object_name = memcpy(name, object_name, size);
+	obj_request->offset = offset;
+	obj_request->length = length;
+	obj_request->type = type;
+	atomic_set(&obj_request->done, 0);
+	kref_init(&obj_request->kref);
+
+	return obj_request;
+}
+
+static void rbd_obj_request_destroy(struct kref *kref)
+{
+	struct rbd_obj_request *obj_request;
+
+	obj_request = container_of(kref, struct rbd_obj_request, kref);
+	if (obj_request->osd_req)
+		rbd_osd_req_destroy(obj_request->osd_req);
+
+	rbd_assert(obj_req_type_valid(obj_request->type));
+	switch (obj_request->type) {
+	case obj_req_bio:
+		if (obj_request->bio_list)
+			bio_chain_put(obj_request->bio_list);
+		break;
+	}
+
+	kfree(obj_request);
+}
+
+/*
+ * Caller is responsible for filling in:
+ * - the Linux request pointer (if there is one)
+ * - the request offset and length (zeroes used otherwise)
+ * - the object request array
+ */
+struct rbd_image_request *rbd_image_request_create(struct rbd_device
*rbd_dev,
+					bool write_request, u32 obj_req_count)
+{
+	size_t size;
+	size_t obj_req_size;
+	struct rbd_image_request *image_request;
+	struct ceph_snap_context *snapc = NULL;
+
+	obj_req_size = obj_req_count * sizeof (image_request->obj_requests[0]);
+	size = sizeof (*image_request) + obj_req_size;
+	image_request = kmalloc(size, GFP_ATOMIC);
+	if (!image_request)
+		return NULL;
+
+	if (write_request) {
+		down_read(&rbd_dev->header_rwsem);
+		snapc = ceph_get_snap_context(rbd_dev->header.snapc);
+		up_read(&rbd_dev->header_rwsem);
+		if (WARN_ON(!snapc)) {
+			kfree(image_request);
+			return NULL;	/* Shouldn't happen */
+		}
+	}
+
+	image_request->rq = NULL;
+	image_request->rbd_dev = rbd_dev;
+	if (write_request)
+		image_request->snapc = snapc;
+	else
+		image_request->snap_id = rbd_dev->spec->snap_id;
+	image_request->offset = 0;
+	image_request->length = 0;
+	spin_lock_init(&image_request->completion_lock);
+	image_request->next_completion = 0;
+	image_request->write_request = write_request;
+	image_request->obj_req_count = obj_req_count;
+	kref_init(&image_request->kref);
+	memset(&image_request->obj_requests, 0, obj_req_size);
+
+	return image_request;
+}
+
+static void rbd_image_request_destroy(struct kref *kref)
+{
+	struct rbd_image_request *image_request;
+	u32 which;
+
+	image_request = container_of(kref, struct rbd_image_request, kref);
+
+	for (which = 0; which < image_request->obj_req_count; which++)
+		rbd_obj_request_put(image_request->obj_requests[which]);
+
+	if (image_request->write_request)
+		ceph_put_snap_context(image_request->snapc);
+
+	kfree(image_request);
+}
+
+static int rbd_image_request_fill_bio(struct rbd_image_request
*image_request,
+					struct bio *bio_list)
+{
+	struct rbd_device *rbd_dev = image_request->rbd_dev;
+	struct rbd_obj_request *obj_request = NULL;
+	unsigned int bio_offset;
+	u64 image_offset;
+	u64 resid;
+	u32 which;
+	u16 opcode;
+
+	opcode = image_request->write_request ? CEPH_OSD_OP_WRITE
+					      : CEPH_OSD_OP_READ;
+	bio_offset = 0;
+	image_offset = image_request->offset;
+	rbd_assert(image_offset == bio_list->bi_sector << SECTOR_SHIFT);
+	which = 0;
+	resid = image_request->length;
+	while (resid) {
+		const char *object_name;
+		unsigned int clone_size;
+		struct ceph_osd_req_op *op;
+		u64 offset;
+		u64 length;
+
+		rbd_assert(which < image_request->obj_req_count);
+
+		object_name = rbd_segment_name(rbd_dev, image_offset);
+		if (!object_name)
+			goto out_unwind;
+		offset = rbd_segment_offset(rbd_dev, image_offset);
+		length = rbd_segment_length(rbd_dev, image_offset, resid);
+		obj_request = rbd_obj_request_create(object_name,
+						offset, length, obj_req_bio);
+		kfree(object_name);	/* object request has its own copy */
+		if (!obj_request)
+			goto out_unwind;
+		obj_request->image_request = image_request;
+		obj_request->which = which;
+
+		rbd_assert(length <= (u64) UINT_MAX);
+		clone_size = (unsigned int) length;
+		obj_request->bio_list = bio_chain_clone_range(&bio_list,
+						&bio_offset, clone_size,
+						GFP_ATOMIC);
+		if (!obj_request->bio_list)
+			goto out_partial;
+
+		/*
+		 * Build up the op to use in building the osd
+		 * request.  Note that the contents of the op are
+		 * copied by rbd_osd_req_create().
+		 */
+		op = rbd_osd_req_op_create(opcode, offset, length);
+		if (!op)
+			goto out_partial;
+		obj_request->osd_req = rbd_osd_req_create(rbd_dev,
+						image_request->write_request,
+						obj_request, op);
+		rbd_osd_req_op_destroy(op);
+		if (!obj_request->osd_req)
+			goto out_partial;
+		/* status and version are initially zero-filled */
+
+		image_request->obj_requests[which++] = obj_request;
+
+		image_offset += length;
+		resid -= length;
+	}
+
+	return 0;
+
+out_partial:
+	rbd_obj_request_put(obj_request);
+out_unwind:
+	while (which--) {
+		rbd_obj_request_put(image_request->obj_requests[which]);
+		image_request->obj_requests[which] = NULL;
+	}
+
+	return -ENOMEM;
+}
+
+static void rbd_image_obj_callback(struct rbd_obj_request *obj_request)
+{
+	struct rbd_image_request *image_request = obj_request->image_request;
+	u32 which = obj_request->which;
+	bool done;
+
+	rbd_assert(image_request != NULL);
+	rbd_assert(obj_request == image_request->obj_requests[which]);
+
+	done = rbd_block_request_complete(image_request, which);
+	if (done)
+		rbd_image_request_put(image_request);
+}
+
+static int rbd_image_request_submit(struct rbd_image_request
*image_request)
+{
+	struct rbd_device *rbd_dev = image_request->rbd_dev;
+	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
+	u32 which;
+	int ret = 0;
+
+	for (which = 0; which < image_request->obj_req_count; which++) {
+		struct rbd_obj_request *obj_request;
+
+		obj_request = image_request->obj_requests[which];
+		obj_request->callback = rbd_image_obj_callback;
+		rbd_image_request_get(image_request);
+		ret = rbd_obj_request_submit(osdc, obj_request);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static void rbd_request_fn(struct request_queue *q)
+{
+	struct rbd_device *rbd_dev = q->queuedata;
+	bool read_only = rbd_dev->mapping.read_only;
+	struct request *rq;
+	int result;
+
+	while ((rq = blk_fetch_request(q))) {
+		bool write_request = rq_data_dir(rq) == WRITE;
+		struct rbd_image_request *image_request;
+		u64 offset;
+		u64 length;
+		int req_count;
+
+		/* Ignore any non-FS requests that filter through. */
+
+		if (rq->cmd_type != REQ_TYPE_FS) {
+			__blk_end_request_all(rq, 0);
+			continue;
+		}
+
+		spin_unlock_irq(q->queue_lock);
+
+		/* Disallow writes to a read-only device */
+
+		if (write_request) {
+			result = -EROFS;
+			if (read_only)
+				goto end_request;
+			rbd_assert(rbd_dev->spec->snap_id == CEPH_NOSNAP);
+		}
+
+		/* Quit early if the snapshot has disappeared */
+
+		if (!atomic_read(&rbd_dev->exists)) {
+			dout("request for non-existent snapshot");
+			rbd_assert(rbd_dev->spec->snap_id != CEPH_NOSNAP);
+			result = -ENXIO;
+			goto end_request;
+		}
+
+		/* Don't overrun max offset */
+
+		offset = (u64) blk_rq_pos(rq) << SECTOR_SHIFT;
+		length = (u64) blk_rq_bytes(rq);
+
+		result = -EINVAL;
+		if (WARN_ON(offset && length > U64_MAX - offset + 1))
+			goto end_request;	/* Shouldn't happen */
+
+		req_count = rbd_get_num_segments(&rbd_dev->header,
+							offset, length);
+		result = -ENOMEM;
+		image_request = rbd_image_request_create(rbd_dev,
+							write_request,
+							(u32) req_count);
+		if (!image_request)
+			goto end_request;
+
+		image_request->rq = rq;
+		image_request->offset = offset;
+		image_request->length = length;
+
+		result = rbd_image_request_fill_bio(image_request, rq->bio);
+		if (!result)
+			result = rbd_image_request_submit(image_request);
+		if (result)
+			rbd_image_request_put(image_request);
+end_request:
+		spin_lock_irq(q->queue_lock);
+		if (result < 0)
+			__blk_end_request_all(rq, result);
+	}
+}
+
 /*
  * block device queue callback
  */
@@ -1929,8 +2521,8 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 	disk->fops = &rbd_bd_ops;
 	disk->private_data = rbd_dev;

-	/* init rq */
-	q = blk_init_queue(rbd_rq_fn, &rbd_dev->lock);
+	(void) rbd_rq_fn;		/* avoid a warning */
+	q = blk_init_queue(rbd_request_fn, &rbd_dev->lock);
 	if (!q)
 		goto out_disk;

-- 
1.7.9.5

