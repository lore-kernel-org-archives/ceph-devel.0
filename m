From: Alex Elder <elder@inktank.com>
Subject: [PATCH REPOST 1/3] rbd: pull in ceph_calc_raw_layout()
Date: Fri, 04 Jan 2013 08:52:34 -0600
Message-ID: <50E6ECB2.1080804@inktank.com>
References: <50E6EC84.2060304@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f182.google.com ([209.85.210.182]:46421 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754854Ab3ADOwg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jan 2013 09:52:36 -0500
Received: by mail-ia0-f182.google.com with SMTP id x2so13899301iad.13
        for <ceph-devel@vger.kernel.org>; Fri, 04 Jan 2013 06:52:36 -0800 (PST)
In-Reply-To: <50E6EC84.2060304@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is the first in a series of patches aimed at eliminating
the use of ceph_calc_raw_layout() by rbd.

It simply pulls in a copy of that function and renames it
rbd_calc_raw_layout().

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index a57d6e9..46b52a4 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1101,6 +1101,40 @@ static void rbd_layout_init(struct
ceph_file_layout *layout, u64 pool_id)
 	layout->fl_pg_pool = cpu_to_le32((u32) pool_id);
 }

+int rbd_calc_raw_layout(struct ceph_file_layout *layout,
+			u64 off, u64 *plen, u64 *bno,
+			struct ceph_osd_request *req,
+			struct ceph_osd_req_op *op)
+{
+	u64 orig_len = *plen;
+	u64 objoff, objlen;    /* extent in object */
+	int r;
+
+	/* object extent? */
+	r = ceph_calc_file_object_mapping(layout, off, orig_len, bno,
+					  &objoff, &objlen);
+	if (r < 0)
+		return r;
+	if (objlen < orig_len) {
+		*plen = objlen;
+		dout(" skipping last %llu, final file extent %llu~%llu\n",
+		     orig_len - *plen, off, *plen);
+	}
+
+	if (op->op == CEPH_OSD_OP_READ || op->op == CEPH_OSD_OP_WRITE) {
+		op->extent.offset = objoff;
+		op->extent.length = objlen;
+	}
+	req->r_num_pages = calc_pages_for(off, *plen);
+	req->r_page_alignment = off & ~PAGE_MASK;
+	if (op->op == CEPH_OSD_OP_WRITE)
+		op->payload_len = *plen;
+
+	dout("calc_layout bno=%llx %llu~%llu (%d pages)\n",
+	     *bno, objoff, objlen, req->r_num_pages);
+	return 0;
+}
+
 /*
  * Send ceph osd request
  */
@@ -1167,7 +1201,7 @@ static int rbd_do_request(struct request *rq,
 	osd_req->r_oid_len = strlen(osd_req->r_oid);

 	rbd_layout_init(&osd_req->r_file_layout, rbd_dev->spec->pool_id);
-	ret = ceph_calc_raw_layout(&osd_req->r_file_layout,
+	ret = rbd_calc_raw_layout(&osd_req->r_file_layout,
 				ofs, &len, &bno, osd_req, op);
 	rbd_assert(ret == 0);

-- 
1.7.9.5

