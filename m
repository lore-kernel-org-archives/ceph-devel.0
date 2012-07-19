From: Alex Elder <elder@inktank.com>
Subject: [PATCH 11/12] rbd: always pass ops array to rbd_req_sync_op()
Date: Thu, 19 Jul 2012 16:09:04 -0500
Message-ID: <50087770.6060307@inktank.com>
References: <500874F5.4090205@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40265 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739Ab2GSVJG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jul 2012 17:09:06 -0400
Received: by mail-yx0-f174.google.com with SMTP id l2so3302595yen.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jul 2012 14:09:06 -0700 (PDT)
In-Reply-To: <500874F5.4090205@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

All of the callers of rbd_req_sync_op() except one pass a non-null
"ops" pointer.  The only one that does not is rbd_req_sync_read(),
which passes CEPH_OSD_OP_READ as its "opcode" and, CEPH_OSD_FLAG_READ
for "flags".

By allocating the ops array in rbd_req_sync_read() and moving the
special case code for the null ops pointer into it, it becomes
clear that much of that code is not even necessary.

In addition, the "opcode" argument to rbd_req_sync_op() is never
actually used, so get rid of that.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   46 ++++++++++++++++------------------------------
 1 files changed, 16 insertions(+), 30 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 0535612..6279186 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1013,9 +1013,8 @@ static void rbd_simple_req_cb(struct
ceph_osd_request *req, struct ceph_msg *msg
 static int rbd_req_sync_op(struct rbd_device *rbd_dev,
 			   struct ceph_snap_context *snapc,
 			   u64 snapid,
-			   int opcode,
 			   int flags,
-			   struct ceph_osd_req_op *orig_ops,
+			   struct ceph_osd_req_op *ops,
 			   const char *object_name,
 			   u64 ofs, u64 len,
 			   char *buf,
@@ -1025,28 +1024,14 @@ static int rbd_req_sync_op(struct rbd_device
*rbd_dev,
 	int ret;
 	struct page **pages;
 	int num_pages;
-	struct ceph_osd_req_op *ops = orig_ops;
-	u32 payload_len;
+
+	BUG_ON(ops == NULL);

 	num_pages = calc_pages_for(ofs , len);
 	pages = ceph_alloc_page_vector(num_pages, GFP_KERNEL);
 	if (IS_ERR(pages))
 		return PTR_ERR(pages);

-	if (!orig_ops) {
-		payload_len = (flags & CEPH_OSD_FLAG_WRITE ? len : 0);
-		ret = -ENOMEM;
-		ops = rbd_create_rw_ops(1, opcode, payload_len);
-		if (!ops)
-			goto done;
-
-		if ((flags & CEPH_OSD_FLAG_WRITE) && buf) {
-			ret = ceph_copy_to_page_vector(pages, buf, ofs, len);
-			if (ret < 0)
-				goto done_ops;
-		}
-	}
-
 	ret = rbd_do_request(NULL, rbd_dev, snapc, snapid,
 			  object_name, ofs, len, NULL,
 			  pages, num_pages,
@@ -1056,14 +1041,11 @@ static int rbd_req_sync_op(struct rbd_device
*rbd_dev,
 			  NULL,
 			  linger_req, ver);
 	if (ret < 0)
-		goto done_ops;
+		goto done;

 	if ((flags & CEPH_OSD_FLAG_READ) && buf)
 		ret = ceph_copy_from_page_vector(pages, buf, ofs, ret);

-done_ops:
-	if (!orig_ops)
-		rbd_destroy_ops(ops);
 done:
 	ceph_release_page_vector(pages, num_pages);
 	return ret;
@@ -1170,12 +1152,20 @@ static int rbd_req_sync_read(struct rbd_device
*rbd_dev,
 			  char *buf,
 			  u64 *ver)
 {
-	return rbd_req_sync_op(rbd_dev, NULL,
+	struct ceph_osd_req_op *ops;
+	int ret;
+
+	ops = rbd_create_rw_ops(1, CEPH_OSD_OP_READ, 0);
+	if (!ops)
+		return -ENOMEM;
+
+	ret = rbd_req_sync_op(rbd_dev, NULL,
 			       snapid,
-			       CEPH_OSD_OP_READ,
 			       CEPH_OSD_FLAG_READ,
-			       NULL,
-			       object_name, ofs, len, buf, NULL, ver);
+			       ops, object_name, ofs, len, buf, NULL, ver);
+	rbd_destroy_ops(ops);
+
+	return ret;
 }

 /*
@@ -1257,7 +1247,6 @@ static int rbd_req_sync_watch(struct rbd_device
*rbd_dev,

 	ret = rbd_req_sync_op(rbd_dev, NULL,
 			      CEPH_NOSNAP,
-			      0,
 			      CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
 			      ops,
 			      object_name, 0, 0, NULL,
@@ -1296,7 +1285,6 @@ static int rbd_req_sync_unwatch(struct rbd_device
*rbd_dev,

 	ret = rbd_req_sync_op(rbd_dev, NULL,
 			      CEPH_NOSNAP,
-			      0,
 			      CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
 			      ops,
 			      object_name, 0, 0, NULL, NULL, NULL);
@@ -1353,7 +1341,6 @@ static int rbd_req_sync_notify(struct rbd_device
*rbd_dev,

 	ret = rbd_req_sync_op(rbd_dev, NULL,
 			       CEPH_NOSNAP,
-			       0,
 			       CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
 			       ops,
 			       object_name, 0, 0, NULL, NULL, NULL);
@@ -1402,7 +1389,6 @@ static int rbd_req_sync_exec(struct rbd_device
*rbd_dev,

 	ret = rbd_req_sync_op(rbd_dev, NULL,
 			       CEPH_NOSNAP,
-			       0,
 			       CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
 			       ops,
 			       object_name, 0, 0, NULL, NULL, NULL);
-- 
1.7.5.4

