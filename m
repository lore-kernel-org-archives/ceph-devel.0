From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/3] libceph: kill ceph_calc_raw_layout()
Date: Sat, 16 Feb 2013 10:34:48 -0600
Message-ID: <511FB528.8030705@inktank.com>
References: <511FB4D9.7050009@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:55728 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753627Ab3BPQev (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 11:34:51 -0500
Received: by mail-qa0-f53.google.com with SMTP id z4so729450qan.19
        for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 08:34:50 -0800 (PST)
In-Reply-To: <511FB4D9.7050009@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There is no caller of ceph_calc_raw_layout() outside of libceph, so
there's no need to export from the module.

Furthermore, there is only one caller, in calc_layout(), and it
is not much more than a simple wrapper for that function.

So get rid of ceph_calc_raw_layout() and embed it instead within
calc_layout().

While touching "osd_client.c", get rid of the unnecessary forward
declaration of __send_request().

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/osd_client.h |    5 ---
 net/ceph/osd_client.c           |   77
++++++++++++++++-----------------------
 2 files changed, 32 insertions(+), 50 deletions(-)

diff --git a/include/linux/ceph/osd_client.h
b/include/linux/ceph/osd_client.h
index 5812802..c39e7ed 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -207,11 +207,6 @@ extern void ceph_osdc_handle_reply(struct
ceph_osd_client *osdc,
 extern void ceph_osdc_handle_map(struct ceph_osd_client *osdc,
 				 struct ceph_msg *msg);

-extern int ceph_calc_raw_layout(struct ceph_file_layout *layout,
-			u64 off, u64 *plen, u64 *bno,
-			struct ceph_osd_request *req,
-			struct ceph_osd_req_op *op);
-
 extern struct ceph_osd_request *ceph_osdc_alloc_request(struct
ceph_osd_client *osdc,
 					       struct ceph_snap_context *snapc,
 					       unsigned int num_op,
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 0d67cd3..cd3a489 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -38,49 +38,6 @@ static int op_has_extent(int op)
 		op == CEPH_OSD_OP_WRITE);
 }

-int ceph_calc_raw_layout(struct ceph_file_layout *layout,
-			u64 off, u64 *plen, u64 *bno,
-			struct ceph_osd_request *req,
-			struct ceph_osd_req_op *op)
-{
-	u64 orig_len = *plen;
-	u64 objoff, objlen;    /* extent in object */
-	int r;
-
-	/* object extent? */
-	r = ceph_calc_file_object_mapping(layout, off, orig_len, bno,
-					  &objoff, &objlen);
-	if (r < 0)
-		return r;
-	if (objlen < orig_len) {
-		*plen = objlen;
-		dout(" skipping last %llu, final file extent %llu~%llu\n",
-		     orig_len - *plen, off, *plen);
-	}
-
-	if (op_has_extent(op->op)) {
-		u32 osize = le32_to_cpu(layout->fl_object_size);
-		op->extent.offset = objoff;
-		op->extent.length = objlen;
-		if (op->extent.truncate_size <= off - objoff) {
-			op->extent.truncate_size = 0;
-		} else {
-			op->extent.truncate_size -= off - objoff;
-			if (op->extent.truncate_size > osize)
-				op->extent.truncate_size = osize;
-		}
-	}
-	req->r_num_pages = calc_pages_for(off, *plen);
-	req->r_page_alignment = off & ~PAGE_MASK;
-	if (op->op == CEPH_OSD_OP_WRITE)
-		op->payload_len = *plen;
-
-	dout("calc_layout bno=%llx %llu~%llu (%d pages)\n",
-	     *bno, objoff, objlen, req->r_num_pages);
-	return 0;
-}
-EXPORT_SYMBOL(ceph_calc_raw_layout);
-
 /*
  * Implement client access to distributed object storage cluster.
  *
@@ -112,12 +69,42 @@ static int calc_layout(struct ceph_vino vino,
 		       struct ceph_osd_request *req,
 		       struct ceph_osd_req_op *op)
 {
-	u64 bno;
+	u64 orig_len = *plen;
+	u64 bno = 0;
+	u64 objoff = 0;
+	u64 objlen = 0;
 	int r;

-	r = ceph_calc_raw_layout(layout, off, plen, &bno, req, op);
+	/* object extent? */
+	r = ceph_calc_file_object_mapping(layout, off, orig_len, &bno,
+					  &objoff, &objlen);
 	if (r < 0)
 		return r;
+	if (objlen < orig_len) {
+		*plen = objlen;
+		dout(" skipping last %llu, final file extent %llu~%llu\n",
+		     orig_len - *plen, off, *plen);
+	}
+
+	if (op_has_extent(op->op)) {
+		u32 osize = le32_to_cpu(layout->fl_object_size);
+		op->extent.offset = objoff;
+		op->extent.length = objlen;
+		if (op->extent.truncate_size <= off - objoff) {
+			op->extent.truncate_size = 0;
+		} else {
+			op->extent.truncate_size -= off - objoff;
+			if (op->extent.truncate_size > osize)
+				op->extent.truncate_size = osize;
+		}
+	}
+	req->r_num_pages = calc_pages_for(off, *plen);
+	req->r_page_alignment = off & ~PAGE_MASK;
+	if (op->op == CEPH_OSD_OP_WRITE)
+		op->payload_len = *plen;
+
+	dout("calc_layout bno=%llx %llu~%llu (%d pages)\n",
+	     bno, objoff, objlen, req->r_num_pages);

 	snprintf(req->r_oid, sizeof(req->r_oid), "%llx.%08llx", vino.ino, bno);
 	req->r_oid_len = strlen(req->r_oid);
-- 
1.7.9.5

