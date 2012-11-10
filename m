From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: separate layout init
Date: Fri, 09 Nov 2012 21:39:24 -0600
Message-ID: <509DCC6C.7050900@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:65268 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416Ab2KJDj1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Nov 2012 22:39:27 -0500
Received: by mail-ia0-f174.google.com with SMTP id y32so3212856iag.19
        for <ceph-devel@vger.kernel.org>; Fri, 09 Nov 2012 19:39:27 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Pull a block of code that initializes the layout structure in an osd
request into its own function so it can be reused.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index bac4304..2d8f2ed 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -54,6 +54,7 @@

 /* It might be useful to have this defined elsewhere too */

+#define	U32_MAX	((u32) (~0U))
 #define	U64_MAX	((u64) (~0ULL))

 #define RBD_DRV_NAME "rbd"
@@ -1098,6 +1099,16 @@ static void rbd_coll_end_req(struct rbd_request
*rbd_req,
 				ret, len);
 }

+static void rbd_layout_init(struct ceph_file_layout *layout, u64 pool_id)
+{
+	memset(layout, 0, sizeof (*layout));
+	layout->fl_stripe_unit = cpu_to_le32(1 << RBD_MAX_OBJ_ORDER);
+	layout->fl_stripe_count = cpu_to_le32(1);
+	layout->fl_object_size = cpu_to_le32(1 << RBD_MAX_OBJ_ORDER);
+	rbd_assert(pool_id <= (u64) U32_MAX);
+	layout->fl_pg_pool = cpu_to_le32((u32) pool_id);
+}
+
 /*
  * Send ceph osd request
  */
@@ -1119,7 +1130,6 @@ static int rbd_do_request(struct request *rq,
 			  u64 *ver)
 {
 	struct ceph_osd_request *osd_req;
-	struct ceph_file_layout *layout;
 	int ret;
 	u64 bno;
 	struct timespec mtime = CURRENT_TIME;
@@ -1163,14 +1173,9 @@ static int rbd_do_request(struct request *rq,
 	strncpy(osd_req->r_oid, object_name, sizeof(osd_req->r_oid));
 	osd_req->r_oid_len = strlen(osd_req->r_oid);

-	layout = &osd_req->r_file_layout;
-	memset(layout, 0, sizeof(*layout));
-	layout->fl_stripe_unit = cpu_to_le32(1 << RBD_MAX_OBJ_ORDER);
-	layout->fl_stripe_count = cpu_to_le32(1);
-	layout->fl_object_size = cpu_to_le32(1 << RBD_MAX_OBJ_ORDER);
-	layout->fl_pg_pool = cpu_to_le32((int) rbd_dev->spec->pool_id);
-	ret = ceph_calc_raw_layout(osdc, layout, snapid, ofs, &len, &bno,
-				   osd_req, ops);
+	rbd_layout_init(&osd_req->r_file_layout, rbd_dev->spec->pool_id);
+	ret = ceph_calc_raw_layout(osdc, &osd_req->r_file_layout,
+				snapid, ofs, &len, &bno, osd_req, ops);
 	rbd_assert(ret == 0);

 	ceph_osdc_build_request(osd_req, ofs, &len,
-- 
1.7.9.5

