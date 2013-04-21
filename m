From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/2] rbd: void data pointers for rbd_obj_method_sync()
Date: Sun, 21 Apr 2013 16:17:11 -0500
Message-ID: <51745757.4070307@inktank.com>
References: <5174571C.4010203@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:58906 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720Ab3DUVRO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Apr 2013 17:17:14 -0400
Received: by mail-ia0-f174.google.com with SMTP id h23so219053iae.33
        for <ceph-devel@vger.kernel.org>; Sun, 21 Apr 2013 14:17:13 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id ua6sm12933298igb.0.2013.04.21.14.17.12
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 14:17:12 -0700 (PDT)
In-Reply-To: <5174571C.4010203@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Make the inbound and outbound data parameters have void rather than
character type for rbd_obj_method_sync().  This makes it more clear
they don't expect typed data, and eliminates the need for some silly
type casts.

One more unrelated change: define the features buffer used in
_rbd_dev_v2_snap_features() to be a packed data structure.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   44 ++++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index e6da301..46d9bf7 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2623,9 +2623,9 @@ static int rbd_obj_method_sync(struct rbd_device
*rbd_dev,
 			     const char *object_name,
 			     const char *class_name,
 			     const char *method_name,
-			     const char *outbound,
+			     const void *outbound,
 			     size_t outbound_size,
-			     char *inbound,
+			     void *inbound,
 			     size_t inbound_size,
 			     u64 *version)
 {
@@ -3577,8 +3577,8 @@ static int _rbd_dev_v2_snap_size(struct rbd_device
*rbd_dev, u64 snap_id,

 	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_name,
 				"rbd", "get_size",
-				(char *) &snapid, sizeof (snapid),
-				(char *) &size_buf, sizeof (size_buf), NULL);
+				&snapid, sizeof (snapid),
+				&size_buf, sizeof (size_buf), NULL);
 	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
 	if (ret < 0)
 		return ret;
@@ -3611,8 +3611,7 @@ static int rbd_dev_v2_object_prefix(struct
rbd_device *rbd_dev)
 		return -ENOMEM;

 	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_name,
-				"rbd", "get_object_prefix",
-				NULL, 0,
+				"rbd", "get_object_prefix", NULL, 0,
 				reply_buf, RBD_OBJ_PREFIX_LEN_MAX, NULL);
 	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
 	if (ret < 0)
@@ -3643,15 +3642,14 @@ static int _rbd_dev_v2_snap_features(struct
rbd_device *rbd_dev, u64 snap_id,
 	struct {
 		__le64 features;
 		__le64 incompat;
-	} features_buf = { 0 };
+	} __attribute__ ((packed)) features_buf = { 0 };
 	u64 incompat;
 	int ret;

 	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_name,
 				"rbd", "get_features",
-				(char *) &snapid, sizeof (snapid),
-				(char *) &features_buf, sizeof (features_buf),
-				NULL);
+				&snapid, sizeof (snapid),
+				&features_buf, sizeof (features_buf), NULL);
 	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
 	if (ret < 0)
 		return ret;
@@ -3705,15 +3703,15 @@ static int rbd_dev_v2_parent_info(struct
rbd_device *rbd_dev)
 	snapid = cpu_to_le64(CEPH_NOSNAP);
 	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_name,
 				"rbd", "get_parent",
-				(char *) &snapid, sizeof (snapid),
-				(char *) reply_buf, size, NULL);
+				&snapid, sizeof (snapid),
+				reply_buf, size, NULL);
 	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
 	if (ret < 0)
 		goto out_err;

 	ret = -ERANGE;
 	p = reply_buf;
-	end = (char *) reply_buf + size;
+	end = reply_buf + size;
 	ceph_decode_64_safe(&p, end, parent_spec->pool_id, out_err);
 	if (parent_spec->pool_id == CEPH_NOPOOL)
 		goto out;	/* No parent?  No problem. */
@@ -3766,7 +3764,7 @@ static char *rbd_dev_image_name(struct rbd_device
*rbd_dev)
 		return NULL;

 	p = image_id;
-	end = (char *) image_id + image_id_size;
+	end = image_id + image_id_size;
 	ceph_encode_string(&p, end, rbd_dev->spec->image_id, (u32) len);

 	size = sizeof (__le32) + RBD_IMAGE_NAME_LEN_MAX;
@@ -3777,11 +3775,11 @@ static char *rbd_dev_image_name(struct
rbd_device *rbd_dev)
 	ret = rbd_obj_method_sync(rbd_dev, RBD_DIRECTORY,
 				"rbd", "dir_get_name",
 				image_id, image_id_size,
-				(char *) reply_buf, size, NULL);
+				reply_buf, size, NULL);
 	if (ret < 0)
 		goto out;
 	p = reply_buf;
-	end = (char *) reply_buf + size;
+	end = reply_buf + size;
 	image_name = ceph_extract_encoded_string(&p, end, &len, GFP_KERNEL);
 	if (IS_ERR(image_name))
 		image_name = NULL;
@@ -3830,7 +3828,7 @@ static int rbd_dev_probe_update_spec(struct
rbd_device *rbd_dev)

 	name = rbd_dev_image_name(rbd_dev);
 	if (name)
-		rbd_dev->spec->image_name = (char *) name;
+		rbd_dev->spec->image_name = (char *)name;
 	else
 		rbd_warn(rbd_dev, "unable to get image name");

@@ -3881,8 +3879,7 @@ static int rbd_dev_v2_snap_context(struct
rbd_device *rbd_dev, u64 *ver)
 		return -ENOMEM;

 	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_name,
-				"rbd", "get_snapcontext",
-				NULL, 0,
+				"rbd", "get_snapcontext", NULL, 0,
 				reply_buf, size, ver);
 	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
 	if (ret < 0)
@@ -3890,7 +3887,7 @@ static int rbd_dev_v2_snap_context(struct
rbd_device *rbd_dev, u64 *ver)

 	ret = -ERANGE;
 	p = reply_buf;
-	end = (char *) reply_buf + size;
+	end = reply_buf + size;
 	ceph_decode_64_safe(&p, end, seq, out);
 	ceph_decode_32_safe(&p, end, snap_count, out);

@@ -3951,14 +3948,14 @@ static char *rbd_dev_v2_snap_name(struct
rbd_device *rbd_dev, u32 which)
 	snap_id = cpu_to_le64(rbd_dev->header.snapc->snaps[which]);
 	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_name,
 				"rbd", "get_snapshot_name",
-				(char *) &snap_id, sizeof (snap_id),
+				&snap_id, sizeof (snap_id),
 				reply_buf, size, NULL);
 	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
 	if (ret < 0)
 		goto out;

 	p = reply_buf;
-	end = (char *) reply_buf + size;
+	end = reply_buf + size;
 	snap_name = ceph_extract_encoded_string(&p, end, NULL, GFP_KERNEL);
 	if (IS_ERR(snap_name)) {
 		ret = PTR_ERR(snap_name);
@@ -4554,8 +4551,7 @@ static int rbd_dev_image_id(struct rbd_device
*rbd_dev)
 	}

 	ret = rbd_obj_method_sync(rbd_dev, object_name,
-				"rbd", "get_id",
-				NULL, 0,
+				"rbd", "get_id", NULL, 0,
 				response, RBD_IMAGE_ID_LEN_MAX, NULL);
 	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
 	if (ret < 0)
-- 
1.7.9.5

