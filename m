From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/5] rbd: drop rbd_obj_method_sync() version parameter
Date: Tue, 30 Apr 2013 07:32:35 -0500
Message-ID: <517FB9E3.7060605@inktank.com>
References: <517FB909.40309@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f169.google.com ([209.85.210.169]:59153 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760554Ab3D3Mcg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Apr 2013 08:32:36 -0400
Received: by mail-ia0-f169.google.com with SMTP id l29so392335iag.14
        for <ceph-devel@vger.kernel.org>; Tue, 30 Apr 2013 05:32:36 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id q3sm24452304igw.0.2013.04.30.05.32.35
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 05:32:35 -0700 (PDT)
In-Reply-To: <517FB909.40309@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Only NULL is passed as the version argument to rbd_obj_method_sync(),
so get rid of it.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index e405c61..ddf4305 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1,3 +1,4 @@
+
 /*
    rbd.c -- Export ceph rados objects as a Linux block device

@@ -2602,8 +2603,7 @@ static int rbd_obj_method_sync(struct rbd_device
*rbd_dev,
 			     const void *outbound,
 			     size_t outbound_size,
 			     void *inbound,
-			     size_t inbound_size,
-			     u64 *version)
+			     size_t inbound_size)
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
 	struct rbd_obj_request *obj_request;
@@ -2669,8 +2669,6 @@ static int rbd_obj_method_sync(struct rbd_device
*rbd_dev,
 	rbd_assert(obj_request->xferred < (u64)INT_MAX);
 	ret = (int)obj_request->xferred;
 	ceph_copy_from_page_vector(pages, inbound, 0, obj_request->xferred);
-	if (version)
-		*version = obj_request->version;
 out:
 	if (obj_request)
 		rbd_obj_request_put(obj_request);
@@ -3463,7 +3461,7 @@ static int _rbd_dev_v2_snap_size(struct rbd_device
*rbd_dev, u64 snap_id,
 	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_name,
 				"rbd", "get_size",
 				&snapid, sizeof (snapid),
-				&size_buf, sizeof (size_buf), NULL);
+				&size_buf, sizeof (size_buf));
 	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
 	if (ret < 0)
 		return ret;
@@ -3500,7 +3498,7 @@ static int rbd_dev_v2_object_prefix(struct
rbd_device *rbd_dev)

 	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_name,
 				"rbd", "get_object_prefix", NULL, 0,
-				reply_buf, RBD_OBJ_PREFIX_LEN_MAX, NULL);
+				reply_buf, RBD_OBJ_PREFIX_LEN_MAX);
 	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
 	if (ret < 0)
 		goto out;
@@ -3536,7 +3534,7 @@ static int _rbd_dev_v2_snap_features(struct
rbd_device *rbd_dev, u64 snap_id,
 	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_name,
 				"rbd", "get_features",
 				&snapid, sizeof (snapid),
-				&features_buf, sizeof (features_buf), NULL);
+				&features_buf, sizeof (features_buf));
 	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
 	if (ret < 0)
 		return ret;
@@ -3593,7 +3591,7 @@ static int rbd_dev_v2_parent_info(struct
rbd_device *rbd_dev)
 	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_name,
 				"rbd", "get_parent",
 				&snapid, sizeof (snapid),
-				reply_buf, size, NULL);
+				reply_buf, size);
 	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
 	if (ret < 0)
 		goto out_err;
@@ -3650,7 +3648,7 @@ static int rbd_dev_v2_striping_info(struct
rbd_device *rbd_dev)

 	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_name,
 				"rbd", "get_stripe_unit_count", NULL, 0,
-				(char *)&striping_info_buf, size, NULL);
+				(char *)&striping_info_buf, size);
 	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
 	if (ret < 0)
 		return ret;
@@ -3717,7 +3715,7 @@ static char *rbd_dev_image_name(struct rbd_device
*rbd_dev)
 	ret = rbd_obj_method_sync(rbd_dev, RBD_DIRECTORY,
 				"rbd", "dir_get_name",
 				image_id, image_id_size,
-				reply_buf, size, NULL);
+				reply_buf, size);
 	if (ret < 0)
 		goto out;
 	p = reply_buf;
@@ -3848,7 +3846,7 @@ static int rbd_dev_v2_snap_context(struct
rbd_device *rbd_dev)

 	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_name,
 				"rbd", "get_snapcontext", NULL, 0,
-				reply_buf, size, NULL);
+				reply_buf, size);
 	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
 	if (ret < 0)
 		goto out;
@@ -3913,7 +3911,7 @@ static const char *rbd_dev_v2_snap_name(struct
rbd_device *rbd_dev, u32 which)
 	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_name,
 				"rbd", "get_snapshot_name",
 				&snap_id, sizeof (snap_id),
-				reply_buf, size, NULL);
+				reply_buf, size);
 	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
 	if (ret < 0) {
 		snap_name = ERR_PTR(ret);
@@ -4506,7 +4504,7 @@ static int rbd_dev_image_id(struct rbd_device
*rbd_dev)

 	ret = rbd_obj_method_sync(rbd_dev, object_name,
 				"rbd", "get_id", NULL, 0,
-				response, RBD_IMAGE_ID_LEN_MAX, NULL);
+				response, RBD_IMAGE_ID_LEN_MAX);
 	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
 	if (ret == -ENOENT) {
 		image_id = kstrdup("", GFP_KERNEL);
-- 
1.7.9.5

