From: Alex Elder <elder@inktank.com>
Subject: [PATCH, v2] libceph: let osd ops determine request data length
Date: Mon, 11 Mar 2013 10:37:20 -0500
Message-ID: <513DFA30.4090601@inktank.com>
References: <513CED66.1060902@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f49.google.com ([209.85.212.49]:37449 "EHLO
	mail-vb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041Ab3CKPhY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Mar 2013 11:37:24 -0400
Received: by mail-vb0-f49.google.com with SMTP id s24so1694765vbi.22
        for <ceph-devel@vger.kernel.org>; Mon, 11 Mar 2013 08:37:23 -0700 (PDT)
In-Reply-To: <513CED66.1060902@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The first version of this patch had a bug in osd_req_encode_op().
A check intended to see if the source opcode indicated it was
wrong.  It did this:
    if (CEPH_OSD_OP_WRITE)
when it should have done this:
    if (src->op == CEPH_OSD_OP_WRITE)
This versions corrects that problem.  The "review/wip-kill-trail"
branch has been updated to reflect this change.

					-Alex

The length of outgoing data in an osd request is dependent on the
osd ops that are embedded in that request.  Each op is encoded into
a request message using osd_req_encode_op(), so that should be used
to determine the amount of outgoing data implied by the op as it
is encoded.

Have osd_req_encode_op() return the number of bytes of outgoing data
implied by the op being encoded, and accumulate and use that in
ceph_osdc_build_request().

As a result, ceph_osdc_build_request() no longer requires its "len"
parameter, so get rid of it.

Using the sum of the op lengths rather than the length provided is
a valid change because:
    - The only callers of osd ceph_osdc_build_request() are
      rbd and the osd client (in ceph_osdc_new_request() on
      behalf of the file system).
    - When rbd calls it, the length provided is only non-zero for
      write requests, and in that case the single op has the
      same length value as what was passed here.
    - When called from ceph_osdc_new_request(), (it's not all that
      easy to see, but) the length passed is also always the same
      as the extent length encoded in its (single) write op if
      present.

This resolves:
    http://tracker.ceph.com/issues/4406

Signed-off-by: Alex Elder <elder@inktank.com>
---
v2:  Fix comparison bug in osd_req_encode_op()

 drivers/block/rbd.c             |    2 +-
 include/linux/ceph/osd_client.h |    3 +--
 net/ceph/osd_client.c           |   33 +++++++++++++++++++--------------
 3 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index ae6b976..cc74b2c 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1449,7 +1449,7 @@ static struct ceph_osd_request *rbd_osd_req_create(

 	/* osd_req will get its own reference to snapc (if non-null) */

-	ceph_osdc_build_request(osd_req, offset, length, 1, op,
+	ceph_osdc_build_request(osd_req, offset, 1, op,
 				snapc, snap_id, mtime);

 	return osd_req;
diff --git a/include/linux/ceph/osd_client.h
b/include/linux/ceph/osd_client.h
index a8016df..bcf3f72 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -249,8 +249,7 @@ extern struct ceph_osd_request
*ceph_osdc_alloc_request(struct ceph_osd_client *
 					       bool use_mempool,
 					       gfp_t gfp_flags);

-extern void ceph_osdc_build_request(struct ceph_osd_request *req,
-				    u64 off, u64 len,
+extern void ceph_osdc_build_request(struct ceph_osd_request *req, u64 off,
 				    unsigned int num_op,
 				    struct ceph_osd_req_op *src_ops,
 				    struct ceph_snap_context *snapc,
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 37d8961..ce34faa 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -222,10 +222,13 @@ struct ceph_osd_request
*ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
 }
 EXPORT_SYMBOL(ceph_osdc_alloc_request);

-static void osd_req_encode_op(struct ceph_osd_request *req,
+static u64 osd_req_encode_op(struct ceph_osd_request *req,
 			      struct ceph_osd_op *dst,
 			      struct ceph_osd_req_op *src)
 {
+	u64 out_data_len = 0;
+	u64 tmp;
+
 	dst->op = cpu_to_le16(src->op);

 	switch (src->op) {
@@ -233,10 +236,10 @@ static void osd_req_encode_op(struct
ceph_osd_request *req,
 		break;
 	case CEPH_OSD_OP_READ:
 	case CEPH_OSD_OP_WRITE:
-		dst->extent.offset =
-			cpu_to_le64(src->extent.offset);
-		dst->extent.length =
-			cpu_to_le64(src->extent.length);
+		if (src->op == CEPH_OSD_OP_WRITE)
+			out_data_len = src->extent.length;
+		dst->extent.offset = cpu_to_le64(src->extent.offset);
+		dst->extent.length = cpu_to_le64(src->extent.length);
 		dst->extent.truncate_size =
 			cpu_to_le64(src->extent.truncate_size);
 		dst->extent.truncate_seq =
@@ -247,12 +250,14 @@ static void osd_req_encode_op(struct
ceph_osd_request *req,
 		dst->cls.method_len = src->cls.method_len;
 		dst->cls.indata_len = cpu_to_le32(src->cls.indata_len);

+		tmp = req->r_trail.length;
 		ceph_pagelist_append(&req->r_trail, src->cls.class_name,
 				     src->cls.class_len);
 		ceph_pagelist_append(&req->r_trail, src->cls.method_name,
 				     src->cls.method_len);
 		ceph_pagelist_append(&req->r_trail, src->cls.indata,
 				     src->cls.indata_len);
+		out_data_len = req->r_trail.length - tmp;
 		break;
 	case CEPH_OSD_OP_STARTSYNC:
 		break;
@@ -326,6 +331,8 @@ static void osd_req_encode_op(struct
ceph_osd_request *req,
 		break;
 	}
 	dst->payload_len = cpu_to_le32(src->payload_len);
+
+	return out_data_len;
 }

 /*
@@ -333,7 +340,7 @@ static void osd_req_encode_op(struct
ceph_osd_request *req,
  *
  */
 void ceph_osdc_build_request(struct ceph_osd_request *req,
-			     u64 off, u64 len, unsigned int num_ops,
+			     u64 off, unsigned int num_ops,
 			     struct ceph_osd_req_op *src_ops,
 			     struct ceph_snap_context *snapc, u64 snap_id,
 			     struct timespec *mtime)
@@ -385,12 +392,13 @@ void ceph_osdc_build_request(struct
ceph_osd_request *req,
 	dout("oid '%.*s' len %d\n", req->r_oid_len, req->r_oid, req->r_oid_len);
 	p += req->r_oid_len;

-	/* ops */
+	/* ops--can imply data */
 	ceph_encode_16(&p, num_ops);
 	src_op = src_ops;
 	req->r_request_ops = p;
+	data_len = 0;
 	for (i = 0; i < num_ops; i++, src_op++) {
-		osd_req_encode_op(req, p, src_op);
+		data_len += osd_req_encode_op(req, p, src_op);
 		p += sizeof(struct ceph_osd_op);
 	}

@@ -407,11 +415,9 @@ void ceph_osdc_build_request(struct
ceph_osd_request *req,
 	req->r_request_attempts = p;
 	p += 4;

-	data_len = req->r_trail.length;
-	if (flags & CEPH_OSD_FLAG_WRITE) {
+	/* data */
+	if (flags & CEPH_OSD_FLAG_WRITE)
 		req->r_request->hdr.data_off = cpu_to_le16(off);
-		data_len += len;
-	}
 	req->r_request->hdr.data_len = cpu_to_le32(data_len);

 	BUG_ON(p > msg->front.iov_base + msg->front.iov_len);
@@ -477,13 +483,12 @@ struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *osdc,
 		ceph_osdc_put_request(req);
 		return ERR_PTR(r);
 	}
-
 	req->r_file_layout = *layout;  /* keep a copy */

 	snprintf(req->r_oid, sizeof(req->r_oid), "%llx.%08llx", vino.ino, bno);
 	req->r_oid_len = strlen(req->r_oid);

-	ceph_osdc_build_request(req, off, *plen, num_op, ops,
+	ceph_osdc_build_request(req, off, num_op, ops,
 				snapc, vino.snap, mtime);

 	return req;
-- 
1.7.9.5

