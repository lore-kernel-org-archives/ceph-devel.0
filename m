From: Alex Elder <elder@inktank.com>
Subject: [PATCH 08/20] libceph: keep source rather than message osd op array
Date: Fri, 05 Apr 2013 09:03:29 -0500
Message-ID: <515ED9B1.6010103@inktank.com>
References: <515ED849.9060901@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:58590 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161757Ab3DEODb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Apr 2013 10:03:31 -0400
Received: by mail-ie0-f182.google.com with SMTP id at1so4343600iec.27
        for <ceph-devel@vger.kernel.org>; Fri, 05 Apr 2013 07:03:31 -0700 (PDT)
In-Reply-To: <515ED849.9060901@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

An osd request keeps a pointer to the osd operations (ops) array
that it builds in its request message.

In order to allow each op in the array to have its own distinct
data, we will need to keep track of each op's data, and that
information does not go over the wire.

As long as we're tracking the data we might as well just track the
entire (source) op definition for each of the ops.  And if we're
doing that, we'll have no more need to keep a pointer to the
wire-encoded version.

This patch makes the array of source ops be kept with the osd
request structure, and uses that instead of the version encoded in
the message in places where that was previously used.  The array
will be embedded in the request structure, and the maximum number of
ops we ever actually use is currently 2.  So reduce CEPH_OSD_MAX_OP
to 2 to reduce the size of the structure.

The result of doing this sort of ripples back up, and as a result
various function parameters and local variables become unnecessary.

Make r_num_ops be unsigned, and move the definition of struct
ceph_osd_req_op earlier to ensure it's defined where needed.

It does not yet add per-op data, that's coming soon.

This resolves:
    http://tracker.ceph.com/issues/4656

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c             |   42 ++++++++++++-----------
 fs/ceph/addr.c                  |   21 +++++-------
 fs/ceph/file.c                  |    6 ++--
 include/linux/ceph/osd_client.h |   70
+++++++++++++++++++--------------------
 net/ceph/debugfs.c              |    4 +--
 net/ceph/osd_client.c           |   53 ++++++++++++++---------------
 6 files changed, 97 insertions(+), 99 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index fc41675..e6e2191 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1285,7 +1285,7 @@ static void rbd_osd_req_callback(struct
ceph_osd_request *osd_req,
 	 */
 	obj_request->xferred = osd_req->r_reply_op_len[0];
 	rbd_assert(obj_request->xferred < (u64) UINT_MAX);
-	opcode = osd_req->r_request_ops[0].op;
+	opcode = osd_req->r_ops[0].op;
 	switch (opcode) {
 	case CEPH_OSD_OP_READ:
 		rbd_osd_read_callback(obj_request);
@@ -1312,8 +1312,7 @@ static void rbd_osd_req_callback(struct
ceph_osd_request *osd_req,
 }

 static void rbd_osd_req_format_op(struct rbd_obj_request *obj_request,
-					bool write_request,
-					struct ceph_osd_req_op *op)
+					bool write_request)
 {
 	struct rbd_img_request *img_request = obj_request->img_request;
 	struct ceph_snap_context *snapc = NULL;
@@ -1333,7 +1332,7 @@ static void rbd_osd_req_format_op(struct
rbd_obj_request *obj_request,
 	}

 	ceph_osdc_build_request(obj_request->osd_req, obj_request->offset,
-			1, op, snapc, snap_id, mtime);
+			snapc, snap_id, mtime);
 }

 static struct ceph_osd_request *rbd_osd_req_create(
@@ -1562,7 +1561,7 @@ static int rbd_img_request_fill_bio(struct
rbd_img_request *img_request,
 	while (resid) {
 		const char *object_name;
 		unsigned int clone_size;
-		struct ceph_osd_req_op op;
+		struct ceph_osd_req_op *op;
 		u64 offset;
 		u64 length;

@@ -1591,8 +1590,9 @@ static int rbd_img_request_fill_bio(struct
rbd_img_request *img_request,
 		if (!obj_request->osd_req)
 			goto out_partial;

-		osd_req_op_extent_init(&op, opcode, offset, length, 0, 0);
-		rbd_osd_req_format_op(obj_request, write_request, &op);
+		op = &obj_request->osd_req->r_ops[0];
+		osd_req_op_extent_init(op, opcode, offset, length, 0, 0);
+		rbd_osd_req_format_op(obj_request, write_request);

 		/* status and version are initially zero-filled */

@@ -1693,7 +1693,7 @@ static int rbd_obj_notify_ack(struct rbd_device
*rbd_dev,
 				   u64 ver, u64 notify_id)
 {
 	struct rbd_obj_request *obj_request;
-	struct ceph_osd_req_op op;
+	struct ceph_osd_req_op *op;
 	struct ceph_osd_client *osdc;
 	int ret;

@@ -1707,8 +1707,9 @@ static int rbd_obj_notify_ack(struct rbd_device
*rbd_dev,
 	if (!obj_request->osd_req)
 		goto out;

-	osd_req_op_watch_init(&op, CEPH_OSD_OP_NOTIFY_ACK, notify_id, ver, 0);
-	rbd_osd_req_format_op(obj_request, false, &op);
+	op = &obj_request->osd_req->r_ops[0];
+	osd_req_op_watch_init(op, CEPH_OSD_OP_NOTIFY_ACK, notify_id, ver, 0);
+	rbd_osd_req_format_op(obj_request, false);

 	osdc = &rbd_dev->rbd_client->client->osdc;
 	obj_request->callback = rbd_obj_request_put;
@@ -1748,7 +1749,7 @@ static int rbd_dev_header_watch_sync(struct
rbd_device *rbd_dev, int start)
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
 	struct rbd_obj_request *obj_request;
-	struct ceph_osd_req_op op;
+	struct ceph_osd_req_op *op;
 	int ret;

 	rbd_assert(start ^ !!rbd_dev->watch_event);
@@ -1772,10 +1773,11 @@ static int rbd_dev_header_watch_sync(struct
rbd_device *rbd_dev, int start)
 	if (!obj_request->osd_req)
 		goto out_cancel;

-	osd_req_op_watch_init(&op, CEPH_OSD_OP_WATCH,
+	op = &obj_request->osd_req->r_ops[0];
+	osd_req_op_watch_init(op, CEPH_OSD_OP_WATCH,
 				rbd_dev->watch_event->cookie,
 				rbd_dev->header.obj_version, start);
-	rbd_osd_req_format_op(obj_request, true, &op);
+	rbd_osd_req_format_op(obj_request, true);

 	if (start)
 		ceph_osdc_set_request_linger(osdc, obj_request->osd_req);
@@ -1835,7 +1837,7 @@ static int rbd_obj_method_sync(struct rbd_device
*rbd_dev,
 {
 	struct rbd_obj_request *obj_request;
 	struct ceph_osd_client *osdc;
-	struct ceph_osd_req_op op;
+	struct ceph_osd_req_op *op;
 	struct page **pages;
 	u32 page_count;
 	int ret;
@@ -1865,9 +1867,10 @@ static int rbd_obj_method_sync(struct rbd_device
*rbd_dev,
 	if (!obj_request->osd_req)
 		goto out;

-	osd_req_op_cls_init(&op, CEPH_OSD_OP_CALL, class_name, method_name,
+	op = &obj_request->osd_req->r_ops[0];
+	osd_req_op_cls_init(op, CEPH_OSD_OP_CALL, class_name, method_name,
 					outbound, outbound_size);
-	rbd_osd_req_format_op(obj_request, false, &op);
+	rbd_osd_req_format_op(obj_request, false);

 	osdc = &rbd_dev->rbd_client->client->osdc;
 	ret = rbd_obj_request_submit(osdc, obj_request);
@@ -2045,8 +2048,8 @@ static int rbd_obj_read_sync(struct rbd_device
*rbd_dev,
 				char *buf, u64 *version)

 {
-	struct ceph_osd_req_op op;
 	struct rbd_obj_request *obj_request;
+	struct ceph_osd_req_op *op;
 	struct ceph_osd_client *osdc;
 	struct page **pages = NULL;
 	u32 page_count;
@@ -2071,8 +2074,9 @@ static int rbd_obj_read_sync(struct rbd_device
*rbd_dev,
 	if (!obj_request->osd_req)
 		goto out;

-	osd_req_op_extent_init(&op, CEPH_OSD_OP_READ, offset, length, 0, 0);
-	rbd_osd_req_format_op(obj_request, false, &op);
+	op = &obj_request->osd_req->r_ops[0];
+	osd_req_op_extent_init(op, CEPH_OSD_OP_READ, offset, length, 0, 0);
+	rbd_osd_req_format_op(obj_request, false);

 	osdc = &rbd_dev->rbd_client->client->osdc;
 	ret = rbd_obj_request_submit(osdc, obj_request);
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index c46b9d3..12bbba7 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -288,7 +288,6 @@ static int start_read(struct inode *inode, struct
list_head *page_list, int max)
 	struct page *page = list_entry(page_list->prev, struct page, lru);
 	struct ceph_vino vino;
 	struct ceph_osd_request *req;
-	struct ceph_osd_req_op op;
 	u64 off;
 	u64 len;
 	int i;
@@ -314,7 +313,7 @@ static int start_read(struct inode *inode, struct
list_head *page_list, int max)
 	     off, len);
 	vino = ceph_vino(inode);
 	req = ceph_osdc_new_request(osdc, &ci->i_layout, vino, off, &len,
-				    1, &op, CEPH_OSD_OP_READ,
+				    1, CEPH_OSD_OP_READ,
 				    CEPH_OSD_FLAG_READ, NULL,
 				    ci->i_truncate_seq, ci->i_truncate_size,
 				    false);
@@ -349,7 +348,7 @@ static int start_read(struct inode *inode, struct
list_head *page_list, int max)
 	req->r_callback = finish_read;
 	req->r_inode = inode;

-	ceph_osdc_build_request(req, off, 1, &op, NULL, vino.snap, NULL);
+	ceph_osdc_build_request(req, off, NULL, vino.snap, NULL);

 	dout("start_read %p starting %p %lld~%lld\n", inode, req, off, len);
 	ret = ceph_osdc_start_request(osdc, req, false);
@@ -567,7 +566,7 @@ static void writepages_finish(struct
ceph_osd_request *req,
 	struct ceph_snap_context *snapc = req->r_snapc;
 	struct address_space *mapping = inode->i_mapping;
 	int rc = req->r_result;
-	u64 bytes = le64_to_cpu(req->r_request_ops[0].extent.length);
+	u64 bytes = req->r_ops[0].extent.length;
 	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
 	long writeback_stat;
 	unsigned issued = ceph_caps_issued(ci);
@@ -635,8 +634,7 @@ static void writepages_finish(struct
ceph_osd_request *req,

 static struct ceph_osd_request *
 ceph_writepages_osd_request(struct inode *inode, u64 offset, u64 *len,
-				struct ceph_snap_context *snapc,
-				int num_ops, struct ceph_osd_req_op *ops)
+				struct ceph_snap_context *snapc, int num_ops)
 {
 	struct ceph_fs_client *fsc;
 	struct ceph_inode_info *ci;
@@ -648,7 +646,7 @@ ceph_writepages_osd_request(struct inode *inode, u64
offset, u64 *len,
 	/* BUG_ON(vino.snap != CEPH_NOSNAP); */

 	return ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout,
-			vino, offset, len, num_ops, ops, CEPH_OSD_OP_WRITE,
+			vino, offset, len, num_ops, CEPH_OSD_OP_WRITE,
 			CEPH_OSD_FLAG_WRITE|CEPH_OSD_FLAG_ONDISK,
 			snapc, ci->i_truncate_seq, ci->i_truncate_size, true);
 }
@@ -738,7 +736,6 @@ retry:
 	last_snapc = snapc;

 	while (!done && index <= end) {
-		struct ceph_osd_req_op ops[2];
 		int num_ops = do_sync ? 2 : 1;
 		struct ceph_vino vino;
 		unsigned i;
@@ -846,7 +843,7 @@ get_more_pages:
 				len = wsize;
 				req = ceph_writepages_osd_request(inode,
 							offset, &len, snapc,
-							num_ops, ops);
+							num_ops);

 				if (IS_ERR(req)) {
 					rc = PTR_ERR(req);
@@ -927,11 +924,11 @@ get_more_pages:

 		/* Update the write op length in case we changed it */

-		osd_req_op_extent_update(&ops[0], len);
+		osd_req_op_extent_update(&req->r_ops[0], len);

 		vino = ceph_vino(inode);
-		ceph_osdc_build_request(req, offset, num_ops, ops,
-					snapc, vino.snap, &inode->i_mtime);
+		ceph_osdc_build_request(req, offset, snapc, vino.snap,
+					&inode->i_mtime);

 		rc = ceph_osdc_start_request(&fsc->client->osdc, req, true);
 		BUG_ON(rc);
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 2f2d0a1..a1d85a8 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -478,7 +478,6 @@ static ssize_t ceph_sync_write(struct file *file,
const char __user *data,
 	struct ceph_snap_context *snapc;
 	struct ceph_vino vino;
 	struct ceph_osd_request *req;
-	struct ceph_osd_req_op ops[2];
 	int num_ops = 1;
 	struct page **pages;
 	int num_pages;
@@ -534,7 +533,7 @@ more:
 	snapc = ci->i_snap_realm->cached_context;
 	vino = ceph_vino(inode);
 	req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout,
-				    vino, pos, &len, num_ops, ops,
+				    vino, pos, &len, num_ops,
 				    CEPH_OSD_OP_WRITE, flags, snapc,
 				    ci->i_truncate_seq, ci->i_truncate_size,
 				    false);
@@ -579,8 +578,7 @@ more:
 					false, own_pages);

 	/* BUG_ON(vino.snap != CEPH_NOSNAP); */
-	ceph_osdc_build_request(req, pos, num_ops, ops,
-				snapc, vino.snap, &mtime);
+	ceph_osdc_build_request(req, pos, snapc, vino.snap, &mtime);

 	ret = ceph_osdc_start_request(&fsc->client->osdc, req, false);
 	if (!ret) {
diff --git a/include/linux/ceph/osd_client.h
b/include/linux/ceph/osd_client.h
index af60dac..f4c1a2a 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -48,7 +48,7 @@ struct ceph_osd {
 };


-#define CEPH_OSD_MAX_OP 10
+#define CEPH_OSD_MAX_OP	2

 enum ceph_osd_data_type {
 	CEPH_OSD_DATA_TYPE_NONE,
@@ -79,6 +79,34 @@ struct ceph_osd_data {
 	};
 };

+struct ceph_osd_req_op {
+	u16 op;           /* CEPH_OSD_OP_* */
+	u32 payload_len;
+	union {
+		struct {
+			u64 offset, length;
+			u64 truncate_size;
+			u32 truncate_seq;
+		} extent;
+		struct {
+			const char *class_name;
+			const char *method_name;
+			const void *indata;
+			u32 indata_len;
+			__u8 class_len;
+			__u8 method_len;
+			__u8 argc;
+		} cls;
+		struct {
+			u64 cookie;
+			u64 ver;
+			u32 prot_ver;
+			u32 timeout;
+			__u8 flag;
+		} watch;
+	};
+};
+
 /* an in-flight request */
 struct ceph_osd_request {
 	u64             r_tid;              /* unique for this client */
@@ -95,10 +123,11 @@ struct ceph_osd_request {
 	struct ceph_msg  *r_request, *r_reply;
 	int               r_flags;     /* any additional flags for the osd */
 	u32               r_sent;      /* >0 if r_request is sending/sent */
-	int               r_num_ops;

-	/* encoded message content */
-	struct ceph_osd_op *r_request_ops;
+	/* request osd ops array  */
+	unsigned int		r_num_ops;
+	struct ceph_osd_req_op	r_ops[CEPH_OSD_MAX_OP];
+
 	/* these are updated on each send */
 	__le32           *r_request_osdmap_epoch;
 	__le32           *r_request_flags;
@@ -193,34 +222,6 @@ struct ceph_osd_client {
 	struct workqueue_struct	*notify_wq;
 };

-struct ceph_osd_req_op {
-	u16 op;           /* CEPH_OSD_OP_* */
-	u32 payload_len;
-	union {
-		struct {
-			u64 offset, length;
-			u64 truncate_size;
-			u32 truncate_seq;
-		} extent;
-		struct {
-			const char *class_name;
-			const char *method_name;
-			const void *indata;
-			u32 indata_len;
-			__u8 class_len;
-			__u8 method_len;
-			__u8 argc;
-		} cls;
-		struct {
-			u64 cookie;
-			u64 ver;
-			u32 prot_ver;
-			u32 timeout;
-			__u8 flag;
-		} watch;
-	};
-};
-
 extern int ceph_osdc_init(struct ceph_osd_client *osdc,
 			  struct ceph_client *client);
 extern void ceph_osdc_stop(struct ceph_osd_client *osdc);
@@ -249,8 +250,6 @@ extern struct ceph_osd_request
*ceph_osdc_alloc_request(struct ceph_osd_client *
 					       gfp_t gfp_flags);

 extern void ceph_osdc_build_request(struct ceph_osd_request *req, u64 off,
-				    unsigned int num_ops,
-				    struct ceph_osd_req_op *src_ops,
 				    struct ceph_snap_context *snapc,
 				    u64 snap_id,
 				    struct timespec *mtime);
@@ -259,8 +258,7 @@ extern struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *,
 				      struct ceph_file_layout *layout,
 				      struct ceph_vino vino,
 				      u64 offset, u64 *len,
-				      int num_ops, struct ceph_osd_req_op *ops,
-				      int opcode, int flags,
+				      int num_ops, int opcode, int flags,
 				      struct ceph_snap_context *snapc,
 				      u32 truncate_seq, u64 truncate_size,
 				      bool use_mempool);
diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
index 00d051f..83661cd 100644
--- a/net/ceph/debugfs.c
+++ b/net/ceph/debugfs.c
@@ -123,8 +123,8 @@ static int osdc_show(struct seq_file *s, void *pp)
 	mutex_lock(&osdc->request_mutex);
 	for (p = rb_first(&osdc->requests); p; p = rb_next(p)) {
 		struct ceph_osd_request *req;
+		unsigned int i;
 		int opcode;
-		int i;

 		req = rb_entry(p, struct ceph_osd_request, r_node);

@@ -142,7 +142,7 @@ static int osdc_show(struct seq_file *s, void *pp)
 			seq_printf(s, "\t");

 		for (i = 0; i < req->r_num_ops; i++) {
-			opcode = le16_to_cpu(req->r_request_ops[i].op);
+			opcode = req->r_ops[i].op;
 			seq_printf(s, "\t%s", ceph_osd_op_name(opcode));
 		}

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 110cd83..ed4493d 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -186,6 +186,9 @@ struct ceph_osd_request
*ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
 	struct ceph_msg *msg;
 	size_t msg_size;

+	BUILD_BUG_ON(CEPH_OSD_MAX_OP > U16_MAX);
+	BUG_ON(num_ops > CEPH_OSD_MAX_OP);
+
 	msg_size = 4 + 4 + 8 + 8 + 4+8;
 	msg_size += 2 + 4 + 8 + 4 + 4; /* oloc */
 	msg_size += 1 + 8 + 4 + 4;     /* pg_t */
@@ -207,6 +210,7 @@ struct ceph_osd_request
*ceph_osdc_alloc_request(struct ceph_osd_client *osdc,

 	req->r_osdc = osdc;
 	req->r_mempool = use_mempool;
+	req->r_num_ops = num_ops;

 	kref_init(&req->r_kref);
 	init_completion(&req->r_completion);
@@ -418,12 +422,14 @@ void osd_req_op_watch_init(struct ceph_osd_req_op
*op, u16 opcode,
 EXPORT_SYMBOL(osd_req_op_watch_init);

 static u64 osd_req_encode_op(struct ceph_osd_request *req,
-			      struct ceph_osd_op *dst,
-			      struct ceph_osd_req_op *src)
+			      struct ceph_osd_op *dst, unsigned int which)
 {
+	struct ceph_osd_req_op *src;
 	u64 out_data_len = 0;
 	struct ceph_pagelist *pagelist;

+	BUG_ON(which >= req->r_num_ops);
+	src = &req->r_ops[which];
 	if (WARN_ON(!osd_req_opcode_valid(src->op))) {
 		pr_err("unrecognized osd opcode %d\n", src->op);

@@ -487,21 +493,17 @@ static u64 osd_req_encode_op(struct
ceph_osd_request *req,
  * build new request AND message
  *
  */
-void ceph_osdc_build_request(struct ceph_osd_request *req,
-			     u64 off, unsigned int num_ops,
-			     struct ceph_osd_req_op *src_ops,
-			     struct ceph_snap_context *snapc, u64 snap_id,
-			     struct timespec *mtime)
+void ceph_osdc_build_request(struct ceph_osd_request *req, u64 off,
+				struct ceph_snap_context *snapc, u64 snap_id,
+				struct timespec *mtime)
 {
 	struct ceph_msg *msg = req->r_request;
-	struct ceph_osd_req_op *src_op;
 	void *p;
 	size_t msg_size;
 	int flags = req->r_flags;
 	u64 data_len;
-	int i;
+	unsigned int i;

-	req->r_num_ops = num_ops;
 	req->r_snapid = snap_id;
 	req->r_snapc = ceph_get_snap_context(snapc);

@@ -541,12 +543,10 @@ void ceph_osdc_build_request(struct
ceph_osd_request *req,
 	p += req->r_oid_len;

 	/* ops--can imply data */
-	ceph_encode_16(&p, num_ops);
-	src_op = src_ops;
-	req->r_request_ops = p;
+	ceph_encode_16(&p, (u16)req->r_num_ops);
 	data_len = 0;
-	for (i = 0; i < num_ops; i++, src_op++) {
-		data_len += osd_req_encode_op(req, p, src_op);
+	for (i = 0; i < req->r_num_ops; i++) {
+		data_len += osd_req_encode_op(req, p, i);
 		p += sizeof(struct ceph_osd_op);
 	}

@@ -602,7 +602,6 @@ struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *osdc,
 					       struct ceph_file_layout *layout,
 					       struct ceph_vino vino,
 					       u64 off, u64 *plen, int num_ops,
-					       struct ceph_osd_req_op *ops,
 					       int opcode, int flags,
 					       struct ceph_snap_context *snapc,
 					       u32 truncate_seq,
@@ -610,6 +609,7 @@ struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *osdc,
 					       bool use_mempool)
 {
 	struct ceph_osd_request *req;
+	struct ceph_osd_req_op *op;
 	u64 objnum = 0;
 	u64 objoff = 0;
 	u64 objlen = 0;
@@ -623,6 +623,7 @@ struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *osdc,
 					GFP_NOFS);
 	if (!req)
 		return ERR_PTR(-ENOMEM);
+
 	req->r_flags = flags;

 	/* calculate max write size */
@@ -642,7 +643,8 @@ struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *osdc,
 			truncate_size = object_size;
 	}

-	osd_req_op_extent_init(&ops[0], opcode, objoff, objlen,
+	op = &req->r_ops[0];
+	osd_req_op_extent_init(op, opcode, objoff, objlen,
 				truncate_size, truncate_seq);
 	/*
 	 * A second op in the ops array means the caller wants to
@@ -650,7 +652,7 @@ struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *osdc,
 	 * osd will flush data quickly.
 	 */
 	if (num_ops > 1)
-		osd_req_op_init(&ops[1], CEPH_OSD_OP_STARTSYNC);
+		osd_req_op_init(++op, CEPH_OSD_OP_STARTSYNC);

 	req->r_file_layout = *layout;  /* keep a copy */

@@ -1342,7 +1344,8 @@ static void handle_reply(struct ceph_osd_client
*osdc, struct ceph_msg *msg,
 	struct ceph_osd_request *req;
 	u64 tid;
 	int object_len;
-	int numops, payload_len, flags;
+	unsigned int numops;
+	int payload_len, flags;
 	s32 result;
 	s32 retry_attempt;
 	struct ceph_pg pg;
@@ -1352,7 +1355,7 @@ static void handle_reply(struct ceph_osd_client
*osdc, struct ceph_msg *msg,
 	u32 osdmap_epoch;
 	int already_completed;
 	u32 bytes;
-	int i;
+	unsigned int i;

 	tid = le64_to_cpu(msg->hdr.tid);
 	dout("handle_reply %p tid %llu\n", msg, tid);
@@ -2116,12 +2119,11 @@ int ceph_osdc_readpages(struct ceph_osd_client
*osdc,
 			struct page **pages, int num_pages, int page_align)
 {
 	struct ceph_osd_request *req;
-	struct ceph_osd_req_op op;
 	int rc = 0;

 	dout("readpages on ino %llx.%llx on %llu~%llu\n", vino.ino,
 	     vino.snap, off, *plen);
-	req = ceph_osdc_new_request(osdc, layout, vino, off, plen, 1, &op,
+	req = ceph_osdc_new_request(osdc, layout, vino, off, plen, 1,
 				    CEPH_OSD_OP_READ, CEPH_OSD_FLAG_READ,
 				    NULL, truncate_seq, truncate_size,
 				    false);
@@ -2136,7 +2138,7 @@ int ceph_osdc_readpages(struct ceph_osd_client *osdc,
 	dout("readpages  final extent is %llu~%llu (%llu bytes align %d)\n",
 	     off, *plen, *plen, page_align);

-	ceph_osdc_build_request(req, off, 1, &op, NULL, vino.snap, NULL);
+	ceph_osdc_build_request(req, off, NULL, vino.snap, NULL);

 	rc = ceph_osdc_start_request(osdc, req, false);
 	if (!rc)
@@ -2160,12 +2162,11 @@ int ceph_osdc_writepages(struct ceph_osd_client
*osdc, struct ceph_vino vino,
 			 struct page **pages, int num_pages)
 {
 	struct ceph_osd_request *req;
-	struct ceph_osd_req_op op;
 	int rc = 0;
 	int page_align = off & ~PAGE_MASK;

 	BUG_ON(vino.snap != CEPH_NOSNAP);	/* snapshots aren't writeable */
-	req = ceph_osdc_new_request(osdc, layout, vino, off, &len, 1, &op,
+	req = ceph_osdc_new_request(osdc, layout, vino, off, &len, 1,
 				    CEPH_OSD_OP_WRITE,
 				    CEPH_OSD_FLAG_ONDISK | CEPH_OSD_FLAG_WRITE,
 				    snapc, truncate_seq, truncate_size,
@@ -2178,7 +2179,7 @@ int ceph_osdc_writepages(struct ceph_osd_client
*osdc, struct ceph_vino vino,
 				false, false);
 	dout("writepages %llu~%llu (%llu bytes)\n", off, len, len);

-	ceph_osdc_build_request(req, off, 1, &op, snapc, CEPH_NOSNAP, mtime);
+	ceph_osdc_build_request(req, off, snapc, CEPH_NOSNAP, mtime);

 	rc = ceph_osdc_start_request(osdc, req, true);
 	if (!rc)
-- 
1.7.9.5

