From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/4] libceph: pass num_op with ops
Date: Wed, 14 Nov 2012 10:34:42 -0600
Message-ID: <50A3C822.9040405@inktank.com>
References: <50A3C7D0.2050809@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:54151 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422671Ab2KNQeo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Nov 2012 11:34:44 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so882810iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Nov 2012 08:34:44 -0800 (PST)
In-Reply-To: <50A3C7D0.2050809@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Both ceph_osdc_alloc_request() and ceph_osdc_build_request() are
provided an array of ceph osd request operations.  Rather than just
passing the number of operations in the array, the caller is
required append an additional zeroed operation structure to signal
the end of the array.

All callers know the number of operations at the time these
functions are called, so drop the silly zero entry and supply that
number directly.  As a result, get_num_ops() is no longer needed.
This also means that ceph_osdc_alloc_request() never uses its ops
argument, so that can be dropped.

Also rbd_create_rw_ops() no longer needs to add one to reserve room
for the additional op.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c             |    9 +++++----
 include/linux/ceph/osd_client.h |    3 ++-
 net/ceph/osd_client.c           |   39
+++++++++++++--------------------------
 3 files changed, 20 insertions(+), 31 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index aca3eca..5a69a74 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1028,12 +1028,12 @@ out_err:
 /*
  * helpers for osd request op vectors.
  */
-static struct ceph_osd_req_op *rbd_create_rw_ops(int num_ops,
+static struct ceph_osd_req_op *rbd_create_rw_ops(int num_op,
 					int opcode, u32 payload_len)
 {
 	struct ceph_osd_req_op *ops;

-	ops = kzalloc(sizeof (*ops) * (num_ops + 1), GFP_NOIO);
+	ops = kzalloc(num_op * sizeof (*ops), GFP_NOIO);
 	if (!ops)
 		return NULL;

@@ -1151,7 +1151,7 @@ static int rbd_do_request(struct request *rq,
 		(unsigned long long) len, coll, coll_index);

 	osdc = &rbd_dev->rbd_client->client->osdc;
-	osd_req = ceph_osdc_alloc_request(osdc, snapc, ops, false, GFP_NOIO);
+	osd_req = ceph_osdc_alloc_request(osdc, snapc, num_op, false, GFP_NOIO);
 	if (!osd_req) {
 		ret = -ENOMEM;
 		goto done_pages;
@@ -1180,7 +1180,8 @@ static int rbd_do_request(struct request *rq,
 				ofs, &len, &bno, osd_req, ops);
 	rbd_assert(ret == 0);

-	ceph_osdc_build_request(osd_req, ofs, len, ops, snapc, snapid, &mtime);
+	ceph_osdc_build_request(osd_req, ofs, len, num_op, ops,
+				snapc, snapid, &mtime);

 	if (linger_req) {
 		ceph_osdc_set_request_linger(osdc, osd_req);
diff --git a/include/linux/ceph/osd_client.h
b/include/linux/ceph/osd_client.h
index 75f56d3..2b04d05 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -214,12 +214,13 @@ extern int ceph_calc_raw_layout(struct
ceph_file_layout *layout,

 extern struct ceph_osd_request *ceph_osdc_alloc_request(struct
ceph_osd_client *osdc,
 					       struct ceph_snap_context *snapc,
-					       struct ceph_osd_req_op *ops,
+					       unsigned int num_op,
 					       bool use_mempool,
 					       gfp_t gfp_flags);

 extern void ceph_osdc_build_request(struct ceph_osd_request *req,
 				    u64 off, u64 len,
+				    unsigned int num_op,
 				    struct ceph_osd_req_op *src_ops,
 				    struct ceph_snap_context *snapc,
 				    u64 snap_id,
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 5ed9c92..a19a87f 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -152,25 +152,14 @@ void ceph_osdc_release_request(struct kref *kref)
 }
 EXPORT_SYMBOL(ceph_osdc_release_request);

-static int get_num_ops(struct ceph_osd_req_op *ops)
-{
-	int i = 0;
-
-	while (ops[i].op)
-		i++;
-
-	return i;
-}
-
 struct ceph_osd_request *ceph_osdc_alloc_request(struct ceph_osd_client
*osdc,
 					       struct ceph_snap_context *snapc,
-					       struct ceph_osd_req_op *ops,
+					       unsigned int num_op,
 					       bool use_mempool,
 					       gfp_t gfp_flags)
 {
 	struct ceph_osd_request *req;
 	struct ceph_msg *msg;
-	int num_op = get_num_ops(ops);
 	size_t msg_size = sizeof(struct ceph_osd_request_head);

 	msg_size += num_op*sizeof(struct ceph_osd_op);
@@ -309,7 +298,7 @@ static void osd_req_encode_op(struct
ceph_osd_request *req,
  *
  */
 void ceph_osdc_build_request(struct ceph_osd_request *req,
-			     u64 off, u64 len,
+			     u64 off, u64 len, unsigned int num_op,
 			     struct ceph_osd_req_op *src_ops,
 			     struct ceph_snap_context *snapc, u64 snap_id,
 			     struct timespec *mtime)
@@ -319,7 +308,6 @@ void ceph_osdc_build_request(struct ceph_osd_request
*req,
 	struct ceph_osd_req_op *src_op;
 	struct ceph_osd_op *op;
 	void *p;
-	int num_op = get_num_ops(src_ops);
 	size_t msg_size = sizeof(*head) + num_op*sizeof(*op);
 	int flags = req->r_flags;
 	u64 data_len = 0;
@@ -338,20 +326,17 @@ void ceph_osdc_build_request(struct
ceph_osd_request *req,
 	head->flags = cpu_to_le32(flags);
 	if (flags & CEPH_OSD_FLAG_WRITE)
 		ceph_encode_timespec(&head->mtime, mtime);
+	BUG_ON(num_op > (unsigned int) ((u16) -1));
 	head->num_ops = cpu_to_le16(num_op);

-
 	/* fill in oid */
 	head->object_len = cpu_to_le32(req->r_oid_len);
 	memcpy(p, req->r_oid, req->r_oid_len);
 	p += req->r_oid_len;

 	src_op = src_ops;
-	while (src_op->op) {
-		osd_req_encode_op(req, op, src_op);
-		src_op++;
-		op++;
-	}
+	while (num_op--)
+		osd_req_encode_op(req, op, src_op++);

 	data_len += req->r_trail.length;

@@ -406,8 +391,9 @@ struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *osdc,
 					       bool use_mempool, int num_reply,
 					       int page_align)
 {
-	struct ceph_osd_req_op ops[3];
+	struct ceph_osd_req_op ops[2];
 	struct ceph_osd_request *req;
+	unsigned int num_op = 1;
 	int r;

 	ops[0].op = opcode;
@@ -418,11 +404,11 @@ struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *osdc,
 	if (do_sync) {
 		ops[1].op = CEPH_OSD_OP_STARTSYNC;
 		ops[1].payload_len = 0;
-		ops[2].op = 0;
-	} else
-		ops[1].op = 0;
+		num_op++;
+	}

-	req = ceph_osdc_alloc_request(osdc, snapc, ops, use_mempool, GFP_NOFS);
+	req = ceph_osdc_alloc_request(osdc, snapc, num_op, use_mempool,
+					GFP_NOFS);
 	if (!req)
 		return ERR_PTR(-ENOMEM);
 	req->r_flags = flags;
@@ -438,7 +424,8 @@ struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *osdc,
 	req->r_num_pages = calc_pages_for(page_align, *plen);
 	req->r_page_alignment = page_align;

-	ceph_osdc_build_request(req, off, *plen, ops, snapc, vino.snap, mtime);
+	ceph_osdc_build_request(req, off, *plen, num_op, ops,
+				snapc, vino.snap, mtime);

 	return req;
 }
-- 
1.7.9.5

