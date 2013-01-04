From: Alex Elder <elder@inktank.com>
Subject: [PATCH REPOST 2/3] rbd: open code rbd_calc_raw_layout()
Date: Fri, 04 Jan 2013 08:53:14 -0600
Message-ID: <50E6ECDA.4090808@inktank.com>
References: <50E6EC84.2060304@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:56291 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754763Ab3ADOxR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jan 2013 09:53:17 -0500
Received: by mail-ie0-f173.google.com with SMTP id e13so19863798iej.18
        for <ceph-devel@vger.kernel.org>; Fri, 04 Jan 2013 06:53:17 -0800 (PST)
In-Reply-To: <50E6EC84.2060304@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This patch gets rid of rbd_calc_raw_layout() by simply open coding
it in its one caller.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   55
+++++++++++++++++----------------------------------
 1 file changed, 18 insertions(+), 37 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 46b52a4..e6db737 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1032,7 +1032,7 @@ static struct ceph_osd_req_op
*rbd_create_rw_op(int opcode, u32 payload_len)
 		return NULL;
 	/*
 	 * op extent offset and length will be set later on
-	 * in calc_raw_layout()
+	 * after ceph_calc_file_object_mapping().
 	 */
 	op->op = opcode;
 	op->payload_len = payload_len;
@@ -1101,40 +1101,6 @@ static void rbd_layout_init(struct
ceph_file_layout *layout, u64 pool_id)
 	layout->fl_pg_pool = cpu_to_le32((u32) pool_id);
 }

-int rbd_calc_raw_layout(struct ceph_file_layout *layout,
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
-	if (op->op == CEPH_OSD_OP_READ || op->op == CEPH_OSD_OP_WRITE) {
-		op->extent.offset = objoff;
-		op->extent.length = objlen;
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
-
 /*
  * Send ceph osd request
  */
@@ -1158,6 +1124,8 @@ static int rbd_do_request(struct request *rq,
 	struct ceph_osd_request *osd_req;
 	int ret;
 	u64 bno;
+	u64 obj_off = 0;
+	u64 obj_len = 0;
 	struct timespec mtime = CURRENT_TIME;
 	struct rbd_request *rbd_req;
 	struct ceph_osd_client *osdc;
@@ -1201,9 +1169,22 @@ static int rbd_do_request(struct request *rq,
 	osd_req->r_oid_len = strlen(osd_req->r_oid);

 	rbd_layout_init(&osd_req->r_file_layout, rbd_dev->spec->pool_id);
-	ret = rbd_calc_raw_layout(&osd_req->r_file_layout,
-				ofs, &len, &bno, osd_req, op);
+	ret = ceph_calc_file_object_mapping(&osd_req->r_file_layout, ofs, len,
+						&bno, &obj_off, &obj_len);
 	rbd_assert(ret == 0);
+	if (obj_len < len) {
+		dout(" skipping last %llu, final file extent %llu~%llu\n",
+		     len - obj_len, ofs, obj_len);
+		len = obj_len;
+	}
+	if (op->op == CEPH_OSD_OP_READ || op->op == CEPH_OSD_OP_WRITE) {
+		op->extent.offset = obj_off;
+		op->extent.length = obj_len;
+		if (op->op == CEPH_OSD_OP_WRITE)
+			op->payload_len = obj_len;
+	}
+	osd_req->r_num_pages = calc_pages_for(ofs, len);
+	osd_req->r_page_alignment = ofs & ~PAGE_MASK;

 	ceph_osdc_build_request(osd_req, ofs, len, 1, op,
 				snapc, snapid, &mtime);
-- 
1.7.9.5

