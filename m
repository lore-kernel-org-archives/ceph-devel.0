From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] libceph: define source request op functions
Date: Wed, 03 Apr 2013 11:40:31 -0700
Message-ID: <515C779F.5080108@inktank.com>
References: <51560691.1060202@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f42.google.com ([209.85.210.42]:42665 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756310Ab3DCSku (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Apr 2013 14:40:50 -0400
Received: by mail-da0-f42.google.com with SMTP id n15so782665dad.1
        for <ceph-devel@vger.kernel.org>; Wed, 03 Apr 2013 11:40:49 -0700 (PDT)
In-Reply-To: <51560691.1060202@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Great! This looks a lot better to me.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 03/29/2013 02:24 PM, Alex Elder wrote:
> The rbd code has a function that allocates and populates a
> ceph_osd_req_op structure (the in-core version of an osd request
> operation).  When reviewed, Josh suggested two things: that the
> big varargs function might be better split into type-specific
> functions; and that this functionality really belongs in the osd
> client rather than rbd.
>
> This patch implements both of Josh's suggestions.  It breaks
> up the rbd function into separate functions and defines them
> in the osd client module as exported interfaces.  Unlike the
> rbd version, however, the functions don't allocate an osd_req_op
> structure; they are provided the address of one and that is
> initialized instead.
>
> The rbd function has been eliminated and calls to it have been
> replaced by calls to the new routines.  The rbd code now now use a
> stack (struct) variable to hold the op rather than allocating and
> freeing it each time.
>
> For now only the capabilities used by rbd are implemented.
> Implementing all the other osd op types, and making the rest of the
> code use it will be done separately, in the next few patches.
>
> Note that only the extent, cls, and watch portions of the
> ceph_osd_req_op structure are currently used.  Delete the others
> (xattr, pgls, and snap) from its definition so nobody thinks it's
> actually implemented or needed.  We can add it back again later
> if needed, when we know it's been tested.
>
> This resolves (and a few follow-on patches):
>      http://tracker.ceph.com/issues/3861
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c             |  117
> ++++++---------------------------------
>   include/linux/ceph/osd_client.h |   26 ++++-----
>   net/ceph/osd_client.c           |   84 ++++++++++++++++++++++++++++
>   3 files changed, 111 insertions(+), 116 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 9c97204..02d821e 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1134,76 +1134,6 @@ static bool obj_request_type_valid(enum
> obj_request_type type)
>   	}
>   }
>
> -static struct ceph_osd_req_op *rbd_osd_req_op_create(u16 opcode, ...)
> -{
> -	struct ceph_osd_req_op *op;
> -	va_list args;
> -	size_t size;
> -
> -	op = kzalloc(sizeof (*op), GFP_NOIO);
> -	if (!op)
> -		return NULL;
> -	op->op = opcode;
> -	va_start(args, opcode);
> -	switch (opcode) {
> -	case CEPH_OSD_OP_READ:
> -	case CEPH_OSD_OP_WRITE:
> -		/* rbd_osd_req_op_create(READ, offset, length) */
> -		/* rbd_osd_req_op_create(WRITE, offset, length) */
> -		op->extent.offset = va_arg(args, u64);
> -		op->extent.length = va_arg(args, u64);
> -		if (opcode == CEPH_OSD_OP_WRITE)
> -			op->payload_len = op->extent.length;
> -		break;
> -	case CEPH_OSD_OP_STAT:
> -		break;
> -	case CEPH_OSD_OP_CALL:
> -		/* rbd_osd_req_op_create(CALL, class, method, data, datalen) */
> -		op->cls.class_name = va_arg(args, char *);
> -		size = strlen(op->cls.class_name);
> -		rbd_assert(size <= (size_t) U8_MAX);
> -		op->cls.class_len = size;
> -		op->payload_len = size;
> -
> -		op->cls.method_name = va_arg(args, char *);
> -		size = strlen(op->cls.method_name);
> -		rbd_assert(size <= (size_t) U8_MAX);
> -		op->cls.method_len = size;
> -		op->payload_len += size;
> -
> -		op->cls.argc = 0;
> -		op->cls.indata = va_arg(args, void *);
> -		size = va_arg(args, size_t);
> -		rbd_assert(size <= (size_t) U32_MAX);
> -		op->cls.indata_len = (u32) size;
> -		op->payload_len += size;
> -		break;
> -	case CEPH_OSD_OP_NOTIFY_ACK:
> -	case CEPH_OSD_OP_WATCH:
> -		/* rbd_osd_req_op_create(NOTIFY_ACK, cookie, version) */
> -		/* rbd_osd_req_op_create(WATCH, cookie, version, flag) */
> -		op->watch.cookie = va_arg(args, u64);
> -		op->watch.ver = va_arg(args, u64);
> -		op->watch.ver = cpu_to_le64(op->watch.ver);
> -		if (opcode == CEPH_OSD_OP_WATCH && va_arg(args, int))
> -			op->watch.flag = (u8) 1;
> -		break;
> -	default:
> -		rbd_warn(NULL, "unsupported opcode %hu\n", opcode);
> -		kfree(op);
> -		op = NULL;
> -		break;
> -	}
> -	va_end(args);
> -
> -	return op;
> -}
> -
> -static void rbd_osd_req_op_destroy(struct ceph_osd_req_op *op)
> -{
> -	kfree(op);
> -}
> -
>   static int rbd_obj_request_submit(struct ceph_osd_client *osdc,
>   				struct rbd_obj_request *obj_request)
>   {
> @@ -1628,7 +1558,7 @@ static int rbd_img_request_fill_bio(struct
> rbd_img_request *img_request,
>   	while (resid) {
>   		const char *object_name;
>   		unsigned int clone_size;
> -		struct ceph_osd_req_op *op;
> +		struct ceph_osd_req_op op;
>   		u64 offset;
>   		u64 length;
>
> @@ -1657,13 +1587,10 @@ static int rbd_img_request_fill_bio(struct
> rbd_img_request *img_request,
>   		 * request.  Note that the contents of the op are
>   		 * copied by rbd_osd_req_create().
>   		 */
> -		op = rbd_osd_req_op_create(opcode, offset, length);
> -		if (!op)
> -			goto out_partial;
> +		osd_req_op_extent_init(&op, opcode, offset, length, 0, 0);
>   		obj_request->osd_req = rbd_osd_req_create(rbd_dev,
>   						img_request->write_request,
> -						obj_request, op);
> -		rbd_osd_req_op_destroy(op);
> +						obj_request, &op);
>   		if (!obj_request->osd_req)
>   			goto out_partial;
>   		/* status and version are initially zero-filled */
> @@ -1765,7 +1692,7 @@ static int rbd_obj_notify_ack(struct rbd_device
> *rbd_dev,
>   				   u64 ver, u64 notify_id)
>   {
>   	struct rbd_obj_request *obj_request;
> -	struct ceph_osd_req_op *op;
> +	struct ceph_osd_req_op op;
>   	struct ceph_osd_client *osdc;
>   	int ret;
>
> @@ -1775,12 +1702,9 @@ static int rbd_obj_notify_ack(struct rbd_device
> *rbd_dev,
>   		return -ENOMEM;
>
>   	ret = -ENOMEM;
> -	op = rbd_osd_req_op_create(CEPH_OSD_OP_NOTIFY_ACK, notify_id, ver);
> -	if (!op)
> -		goto out;
> +	osd_req_op_watch_init(&op, CEPH_OSD_OP_NOTIFY_ACK, notify_id, ver, 0);
>   	obj_request->osd_req = rbd_osd_req_create(rbd_dev, false,
> -						obj_request, op);
> -	rbd_osd_req_op_destroy(op);
> +						obj_request, &op);
>   	if (!obj_request->osd_req)
>   		goto out;
>
> @@ -1822,7 +1746,7 @@ static int rbd_dev_header_watch_sync(struct
> rbd_device *rbd_dev, int start)
>   {
>   	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
>   	struct rbd_obj_request *obj_request;
> -	struct ceph_osd_req_op *op;
> +	struct ceph_osd_req_op op;
>   	int ret;
>
>   	rbd_assert(start ^ !!rbd_dev->watch_event);
> @@ -1842,14 +1766,11 @@ static int rbd_dev_header_watch_sync(struct
> rbd_device *rbd_dev, int start)
>   	if (!obj_request)
>   		goto out_cancel;
>
> -	op = rbd_osd_req_op_create(CEPH_OSD_OP_WATCH,
> +	osd_req_op_watch_init(&op, CEPH_OSD_OP_WATCH,
>   				rbd_dev->watch_event->cookie,
>   				rbd_dev->header.obj_version, start);
> -	if (!op)
> -		goto out_cancel;
>   	obj_request->osd_req = rbd_osd_req_create(rbd_dev, true,
> -							obj_request, op);
> -	rbd_osd_req_op_destroy(op);
> +							obj_request, &op);
>   	if (!obj_request->osd_req)
>   		goto out_cancel;
>
> @@ -1911,7 +1832,7 @@ static int rbd_obj_method_sync(struct rbd_device
> *rbd_dev,
>   {
>   	struct rbd_obj_request *obj_request;
>   	struct ceph_osd_client *osdc;
> -	struct ceph_osd_req_op *op;
> +	struct ceph_osd_req_op op;
>   	struct page **pages;
>   	u32 page_count;
>   	int ret;
> @@ -1938,13 +1859,10 @@ static int rbd_obj_method_sync(struct rbd_device
> *rbd_dev,
>   	obj_request->pages = pages;
>   	obj_request->page_count = page_count;
>
> -	op = rbd_osd_req_op_create(CEPH_OSD_OP_CALL, class_name,
> -					method_name, outbound, outbound_size);
> -	if (!op)
> -		goto out;
> +	osd_req_op_cls_init(&op, CEPH_OSD_OP_CALL, class_name, method_name,
> +					outbound, outbound_size);
>   	obj_request->osd_req = rbd_osd_req_create(rbd_dev, false,
> -						obj_request, op);
> -	rbd_osd_req_op_destroy(op);
> +						obj_request, &op);
>   	if (!obj_request->osd_req)
>   		goto out;
>
> @@ -2124,7 +2042,7 @@ static int rbd_obj_read_sync(struct rbd_device
> *rbd_dev,
>   				char *buf, u64 *version)
>
>   {
> -	struct ceph_osd_req_op *op;
> +	struct ceph_osd_req_op op;
>   	struct rbd_obj_request *obj_request;
>   	struct ceph_osd_client *osdc;
>   	struct page **pages = NULL;
> @@ -2146,12 +2064,9 @@ static int rbd_obj_read_sync(struct rbd_device
> *rbd_dev,
>   	obj_request->pages = pages;
>   	obj_request->page_count = page_count;
>
> -	op = rbd_osd_req_op_create(CEPH_OSD_OP_READ, offset, length);
> -	if (!op)
> -		goto out;
> +	osd_req_op_extent_init(&op, CEPH_OSD_OP_READ, offset, length, 0, 0);
>   	obj_request->osd_req = rbd_osd_req_create(rbd_dev, false,
> -						obj_request, op);
> -	rbd_osd_req_op_destroy(op);
> +						obj_request, &op);
>   	if (!obj_request->osd_req)
>   		goto out;
>
> diff --git a/include/linux/ceph/osd_client.h
> b/include/linux/ceph/osd_client.h
> index 1dab291..5fd2cbf 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -202,14 +202,6 @@ struct ceph_osd_req_op {
>   			u32 truncate_seq;
>   		} extent;
>   		struct {
> -			const char *name;
> -			const void *val;
> -			u32 name_len;
> -			u32 value_len;
> -			__u8 cmp_op;       /* CEPH_OSD_CMPXATTR_OP_* */
> -			__u8 cmp_mode;     /* CEPH_OSD_CMPXATTR_MODE_* */
> -		} xattr;
> -		struct {
>   			const char *class_name;
>   			const char *method_name;
>   			const void *indata;
> @@ -220,13 +212,6 @@ struct ceph_osd_req_op {
>   		} cls;
>   		struct {
>   			u64 cookie;
> -			u64 count;
> -		} pgls;
> -	        struct {
> -		        u64 snapid;
> -	        } snap;
> -		struct {
> -			u64 cookie;
>   			u64 ver;
>   			u32 prot_ver;
>   			u32 timeout;
> @@ -244,6 +229,17 @@ extern void ceph_osdc_handle_reply(struct
> ceph_osd_client *osdc,
>   extern void ceph_osdc_handle_map(struct ceph_osd_client *osdc,
>   				 struct ceph_msg *msg);
>
> +extern void osd_req_op_init(struct ceph_osd_req_op *op, u16 opcode);
> +extern void osd_req_op_extent_init(struct ceph_osd_req_op *op, u16 opcode,
> +					u64 offset, u64 length,
> +					u64 truncate_size, u32 truncate_seq);
> +extern void osd_req_op_cls_init(struct ceph_osd_req_op *op, u16 opcode,
> +					const char *class, const char *method,
> +					const void *request_data,
> +					size_t request_data_size);
> +extern void osd_req_op_watch_init(struct ceph_osd_req_op *op, u16 opcode,
> +					u64 cookie, u64 version, int flag);
> +
>   extern struct ceph_osd_request *ceph_osdc_alloc_request(struct
> ceph_osd_client *osdc,
>   					       struct ceph_snap_context *snapc,
>   					       unsigned int num_op,
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 4e5c043..02ed728 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -289,6 +289,90 @@ static bool osd_req_opcode_valid(u16 opcode)
>   	}
>   }
>
> +/*
> + * This is an osd op init function for opcodes that have no data or
> + * other information associated with them.  It also serves as a
> + * common init routine for all the other init functions, below.
> + */
> +void osd_req_op_init(struct ceph_osd_req_op *op, u16 opcode)
> +{
> +	BUG_ON(!osd_req_opcode_valid(opcode));
> +
> +	memset(op, 0, sizeof (*op));
> +
> +	op->op = opcode;
> +}
> +
> +void osd_req_op_extent_init(struct ceph_osd_req_op *op, u16 opcode,
> +				u64 offset, u64 length,
> +				u64 truncate_size, u32 truncate_seq)
> +{
> +	size_t payload_len = 0;
> +
> +	BUG_ON(opcode != CEPH_OSD_OP_READ && opcode != CEPH_OSD_OP_WRITE);
> +
> +	osd_req_op_init(op, opcode);
> +
> +	op->extent.offset = offset;
> +	op->extent.length = length;
> +	op->extent.truncate_size = truncate_size;
> +	op->extent.truncate_seq = truncate_seq;
> +	if (opcode == CEPH_OSD_OP_WRITE)
> +		payload_len += length;
> +
> +	op->payload_len = payload_len;
> +}
> +EXPORT_SYMBOL(osd_req_op_extent_init);
> +
> +void osd_req_op_cls_init(struct ceph_osd_req_op *op, u16 opcode,
> +			const char *class, const char *method,
> +			const void *request_data, size_t request_data_size)
> +{
> +	size_t payload_len = 0;
> +	size_t size;
> +
> +	BUG_ON(opcode != CEPH_OSD_OP_CALL);
> +
> +	osd_req_op_init(op, opcode);
> +
> +	op->cls.class_name = class;
> +	size = strlen(class);
> +	BUG_ON(size > (size_t) U8_MAX);
> +	op->cls.class_len = size;
> +	payload_len += size;
> +
> +	op->cls.method_name = method;
> +	size = strlen(method);
> +	BUG_ON(size > (size_t) U8_MAX);
> +	op->cls.method_len = size;
> +	payload_len += size;
> +
> +	op->cls.indata = request_data;
> +	BUG_ON(request_data_size > (size_t) U32_MAX);
> +	op->cls.indata_len = (u32) request_data_size;
> +	payload_len += request_data_size;
> +
> +	op->cls.argc = 0;	/* currently unused */
> +
> +	op->payload_len = payload_len;
> +}
> +EXPORT_SYMBOL(osd_req_op_cls_init);
> +
> +void osd_req_op_watch_init(struct ceph_osd_req_op *op, u16 opcode,
> +				u64 cookie, u64 version, int flag)
> +{
> +	BUG_ON(opcode != CEPH_OSD_OP_NOTIFY_ACK && opcode != CEPH_OSD_OP_WATCH);
> +
> +	osd_req_op_init(op, opcode);
> +
> +	op->watch.cookie = cookie;
> +	/* op->watch.ver = version; */	/* XXX 3847 */
> +	op->watch.ver = cpu_to_le64(version);
> +	if (opcode == CEPH_OSD_OP_WATCH && flag)
> +		op->watch.flag = (u8) 1;
> +}
> +EXPORT_SYMBOL(osd_req_op_watch_init);
> +
>   static u64 osd_req_encode_op(struct ceph_osd_request *req,
>   			      struct ceph_osd_op *dst,
>   			      struct ceph_osd_req_op *src)
>

