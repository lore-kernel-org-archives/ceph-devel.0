From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/4] rbd: drop flags parameter from rbd_req_sync_exec()
Date: Fri, 09 Nov 2012 21:44:18 -0600
Message-ID: <509DCD92.7030403@inktank.com>
References: <509DCCE6.5060009@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:57136 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993Ab2KJDoS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Nov 2012 22:44:18 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so6904726iea.19
        for <ceph-devel@vger.kernel.org>; Fri, 09 Nov 2012 19:44:18 -0800 (PST)
In-Reply-To: <509DCCE6.5060009@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

All callers of rbd_req_sync_exec() pass CEPH_OSD_FLAG_READ as their
flags argument.  Delete that parameter and use CEPH_OSD_FLAG_READ
within the function.  If we find a need to support write operations
we can add it back again.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 6a31f38..958f4a8 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1526,7 +1526,6 @@ static int rbd_req_sync_exec(struct rbd_device
*rbd_dev,
 			     size_t outbound_size,
 			     char *inbound,
 			     size_t inbound_size,
-			     int flags,
 			     u64 *ver)
 {
 	struct ceph_osd_req_op *ops;
@@ -1557,8 +1556,7 @@ static int rbd_req_sync_exec(struct rbd_device
*rbd_dev,
 	ops[0].cls.indata_len = outbound_size;

 	ret = rbd_req_sync_op(rbd_dev, NULL,
-			       CEPH_NOSNAP,
-			       flags, ops,
+			       CEPH_NOSNAP, CEPH_OSD_FLAG_READ, ops,
 			       object_name, 0, inbound_size, inbound,
 			       NULL, ver);

@@ -2413,8 +2411,7 @@ static int _rbd_dev_v2_snap_size(struct rbd_device
*rbd_dev, u64 snap_id,
 	ret = rbd_req_sync_exec(rbd_dev, rbd_dev->header_name,
 				"rbd", "get_size",
 				(char *) &snapid, sizeof (snapid),
-				(char *) &size_buf, sizeof (size_buf),
-				CEPH_OSD_FLAG_READ, NULL);
+				(char *) &size_buf, sizeof (size_buf), NULL);
 	dout("%s: rbd_req_sync_exec returned %d\n", __func__, ret);
 	if (ret < 0)
 		return ret;
@@ -2449,8 +2446,7 @@ static int rbd_dev_v2_object_prefix(struct
rbd_device *rbd_dev)
 	ret = rbd_req_sync_exec(rbd_dev, rbd_dev->header_name,
 				"rbd", "get_object_prefix",
 				NULL, 0,
-				reply_buf, RBD_OBJ_PREFIX_LEN_MAX,
-				CEPH_OSD_FLAG_READ, NULL);
+				reply_buf, RBD_OBJ_PREFIX_LEN_MAX, NULL);
 	dout("%s: rbd_req_sync_exec returned %d\n", __func__, ret);
 	if (ret < 0)
 		goto out;
@@ -2489,7 +2485,7 @@ static int _rbd_dev_v2_snap_features(struct
rbd_device *rbd_dev, u64 snap_id,
 				"rbd", "get_features",
 				(char *) &snapid, sizeof (snapid),
 				(char *) &features_buf, sizeof (features_buf),
-				CEPH_OSD_FLAG_READ, NULL);
+				NULL);
 	dout("%s: rbd_req_sync_exec returned %d\n", __func__, ret);
 	if (ret < 0)
 		return ret;
@@ -2544,8 +2540,7 @@ static int rbd_dev_v2_parent_info(struct
rbd_device *rbd_dev)
 	ret = rbd_req_sync_exec(rbd_dev, rbd_dev->header_name,
 				"rbd", "get_parent",
 				(char *) &snapid, sizeof (snapid),
-				(char *) reply_buf, size,
-				CEPH_OSD_FLAG_READ, NULL);
+				(char *) reply_buf, size, NULL);
 	dout("%s: rbd_req_sync_exec returned %d\n", __func__, ret);
 	if (ret < 0)
 		goto out_err;
@@ -2610,8 +2605,7 @@ static char *rbd_dev_image_name(struct rbd_device
*rbd_dev)
 	ret = rbd_req_sync_exec(rbd_dev, RBD_DIRECTORY,
 				"rbd", "dir_get_name",
 				image_id, image_id_size,
-				(char *) reply_buf, size,
-				CEPH_OSD_FLAG_READ, NULL);
+				(char *) reply_buf, size, NULL);
 	if (ret < 0)
 		goto out;
 	p = reply_buf;
@@ -2717,8 +2711,7 @@ static int rbd_dev_v2_snap_context(struct
rbd_device *rbd_dev, u64 *ver)
 	ret = rbd_req_sync_exec(rbd_dev, rbd_dev->header_name,
 				"rbd", "get_snapcontext",
 				NULL, 0,
-				reply_buf, size,
-				CEPH_OSD_FLAG_READ, ver);
+				reply_buf, size, ver);
 	dout("%s: rbd_req_sync_exec returned %d\n", __func__, ret);
 	if (ret < 0)
 		goto out;
@@ -2787,8 +2780,7 @@ static char *rbd_dev_v2_snap_name(struct
rbd_device *rbd_dev, u32 which)
 	ret = rbd_req_sync_exec(rbd_dev, rbd_dev->header_name,
 				"rbd", "get_snapshot_name",
 				(char *) &snap_id, sizeof (snap_id),
-				reply_buf, size,
-				CEPH_OSD_FLAG_READ, NULL);
+				reply_buf, size, NULL);
 	dout("%s: rbd_req_sync_exec returned %d\n", __func__, ret);
 	if (ret < 0)
 		goto out;
@@ -3396,8 +3388,7 @@ static int rbd_dev_image_id(struct rbd_device
*rbd_dev)
 	ret = rbd_req_sync_exec(rbd_dev, object_name,
 				"rbd", "get_id",
 				NULL, 0,
-				response, RBD_IMAGE_ID_LEN_MAX,
-				CEPH_OSD_FLAG_READ, NULL);
+				response, RBD_IMAGE_ID_LEN_MAX, NULL);
 	dout("%s: rbd_req_sync_exec returned %d\n", __func__, ret);
 	if (ret < 0)
 		goto out;
-- 
1.7.9.5

