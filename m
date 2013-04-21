From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: have rbd_obj_method_sync() return transfer count
Date: Sun, 21 Apr 2013 16:17:37 -0500
Message-ID: <51745771.5020009@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:63270 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720Ab3DUVRj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Apr 2013 17:17:39 -0400
Received: by mail-ie0-f169.google.com with SMTP id ar20so6518382iec.28
        for <ceph-devel@vger.kernel.org>; Sun, 21 Apr 2013 14:17:38 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Callers of rbd_obj_method_sync() don't know how many bytes of data
got returned by the class method call.  As a result, they have been
assuming enough got returned to decode whatever was expected.

This isn't safe.  We know how many bytes got transferred, so have
rbd_obj_method_sync() return that amount (rather than just 0) if
the call is successful.

Change all callers to use this return value to ensure decoding of
the results is done safely.

On the other hand, most callers of rbd_obj_method_sync() only
indicate success or failure, so all of *their* callers can simply
test for non-zero result.

This resolves:
    http://tracker.ceph.com/issues/4773

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   60
++++++++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 46d9bf7..3013cdb0 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2642,7 +2642,7 @@ static int rbd_obj_method_sync(struct rbd_device
*rbd_dev,
 	 * method.  Currently if this is present it will be a
 	 * snapshot id.
 	 */
-	page_count = (u32) calc_pages_for(0, inbound_size);
+	page_count = (u32)calc_pages_for(0, inbound_size);
 	pages = ceph_alloc_page_vector(page_count, GFP_KERNEL);
 	if (IS_ERR(pages))
 		return PTR_ERR(pages);
@@ -2689,7 +2689,9 @@ static int rbd_obj_method_sync(struct rbd_device
*rbd_dev,
 	ret = obj_request->result;
 	if (ret < 0)
 		goto out;
-	ret = 0;
+
+	rbd_assert(obj_request->xferred < (u64)INT_MAX);
+	ret = (int)obj_request->xferred;
 	ceph_copy_from_page_vector(pages, inbound, 0, obj_request->xferred);
 	if (version)
 		*version = obj_request->version;
@@ -3582,13 +3584,15 @@ static int _rbd_dev_v2_snap_size(struct
rbd_device *rbd_dev, u64 snap_id,
 	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
 	if (ret < 0)
 		return ret;
+	if (ret < sizeof (size_buf))
+		return -ERANGE;

 	*order = size_buf.order;
 	*snap_size = le64_to_cpu(size_buf.size);

 	dout("  snap_id 0x%016llx order = %u, snap_size = %llu\n",
-		(unsigned long long) snap_id, (unsigned int) *order,
-		(unsigned long long) *snap_size);
+		(unsigned long long)snap_id, (unsigned int)*order,
+		(unsigned long long)*snap_size);

 	return 0;
 }
@@ -3619,8 +3623,8 @@ static int rbd_dev_v2_object_prefix(struct
rbd_device *rbd_dev)

 	p = reply_buf;
 	rbd_dev->header.object_prefix = ceph_extract_encoded_string(&p,
-						p + RBD_OBJ_PREFIX_LEN_MAX,
-						NULL, GFP_NOIO);
+						p + ret, NULL, GFP_NOIO);
+	ret = 0;

 	if (IS_ERR(rbd_dev->header.object_prefix)) {
 		ret = PTR_ERR(rbd_dev->header.object_prefix);
@@ -3628,7 +3632,6 @@ static int rbd_dev_v2_object_prefix(struct
rbd_device *rbd_dev)
 	} else {
 		dout("  object_prefix = %s\n", rbd_dev->header.object_prefix);
 	}
-
 out:
 	kfree(reply_buf);

@@ -3653,6 +3656,8 @@ static int _rbd_dev_v2_snap_features(struct
rbd_device *rbd_dev, u64 snap_id,
 	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
 	if (ret < 0)
 		return ret;
+	if (ret < sizeof (features_buf))
+		return -ERANGE;

 	incompat = le64_to_cpu(features_buf.incompat);
 	if (incompat & ~RBD_FEATURES_SUPPORTED)
@@ -3661,9 +3666,9 @@ static int _rbd_dev_v2_snap_features(struct
rbd_device *rbd_dev, u64 snap_id,
 	*snap_features = le64_to_cpu(features_buf.features);

 	dout("  snap_id 0x%016llx features = 0x%016llx incompat = 0x%016llx\n",
-		(unsigned long long) snap_id,
-		(unsigned long long) *snap_features,
-		(unsigned long long) le64_to_cpu(features_buf.incompat));
+		(unsigned long long)snap_id,
+		(unsigned long long)*snap_features,
+		(unsigned long long)le64_to_cpu(features_buf.incompat));

 	return 0;
 }
@@ -3709,9 +3714,9 @@ static int rbd_dev_v2_parent_info(struct
rbd_device *rbd_dev)
 	if (ret < 0)
 		goto out_err;

-	ret = -ERANGE;
 	p = reply_buf;
 	end = reply_buf + size;
+	ret = -ERANGE;
 	ceph_decode_64_safe(&p, end, parent_spec->pool_id, out_err);
 	if (parent_spec->pool_id == CEPH_NOPOOL)
 		goto out;	/* No parent?  No problem. */
@@ -3719,8 +3724,8 @@ static int rbd_dev_v2_parent_info(struct
rbd_device *rbd_dev)
 	/* The ceph file layout needs to fit pool id in 32 bits */

 	ret = -EIO;
-	if (WARN_ON(parent_spec->pool_id > (u64) U32_MAX))
-		goto out;
+	if (WARN_ON(parent_spec->pool_id > (u64)U32_MAX))
+		goto out_err;

 	image_id = ceph_extract_encoded_string(&p, end, NULL, GFP_KERNEL);
 	if (IS_ERR(image_id)) {
@@ -3765,7 +3770,7 @@ static char *rbd_dev_image_name(struct rbd_device
*rbd_dev)

 	p = image_id;
 	end = image_id + image_id_size;
-	ceph_encode_string(&p, end, rbd_dev->spec->image_id, (u32) len);
+	ceph_encode_string(&p, end, rbd_dev->spec->image_id, (u32)len);

 	size = sizeof (__le32) + RBD_IMAGE_NAME_LEN_MAX;
 	reply_buf = kmalloc(size, GFP_KERNEL);
@@ -3885,9 +3890,9 @@ static int rbd_dev_v2_snap_context(struct
rbd_device *rbd_dev, u64 *ver)
 	if (ret < 0)
 		goto out;

-	ret = -ERANGE;
 	p = reply_buf;
-	end = reply_buf + size;
+	end = reply_buf + ret;
+	ret = -ERANGE;
 	ceph_decode_64_safe(&p, end, seq, out);
 	ceph_decode_32_safe(&p, end, snap_count, out);

@@ -3912,6 +3917,7 @@ static int rbd_dev_v2_snap_context(struct
rbd_device *rbd_dev, u64 *ver)
 		ret = -ENOMEM;
 		goto out;
 	}
+	ret = 0;

 	atomic_set(&snapc->nref, 1);
 	snapc->seq = seq;
@@ -3922,12 +3928,11 @@ static int rbd_dev_v2_snap_context(struct
rbd_device *rbd_dev, u64 *ver)
 	rbd_dev->header.snapc = snapc;

 	dout("  snap context seq = %llu, snap_count = %u\n",
-		(unsigned long long) seq, (unsigned int) snap_count);
-
+		(unsigned long long)seq, (unsigned int)snap_count);
 out:
 	kfree(reply_buf);

-	return 0;
+	return ret;
 }

 static char *rbd_dev_v2_snap_name(struct rbd_device *rbd_dev, u32 which)
@@ -3962,7 +3967,7 @@ static char *rbd_dev_v2_snap_name(struct
rbd_device *rbd_dev, u32 which)
 		goto out;
 	} else {
 		dout("  snap_id 0x%016llx snap_name = %s\n",
-			(unsigned long long) le64_to_cpu(snap_id), snap_name);
+			(unsigned long long)le64_to_cpu(snap_id), snap_name);
 	}
 	kfree(reply_buf);

@@ -4559,8 +4564,10 @@ static int rbd_dev_image_id(struct rbd_device
*rbd_dev)

 	p = response;
 	rbd_dev->spec->image_id = ceph_extract_encoded_string(&p,
-						p + RBD_IMAGE_ID_LEN_MAX,
+						p + ret,
 						NULL, GFP_NOIO);
+	ret = 0;
+
 	if (IS_ERR(rbd_dev->spec->image_id)) {
 		ret = PTR_ERR(rbd_dev->spec->image_id);
 		rbd_dev->spec->image_id = NULL;
@@ -4605,7 +4612,7 @@ static int rbd_dev_v1_probe(struct rbd_device
*rbd_dev)
 	/* Version 1 images have no parent (no layering) */

 	rbd_dev->parent_spec = NULL;
-	rbd_dev->parent_overlap = 0;
+	rbd_dev->parent_overlap =40;

 	rbd_dev->image_format = 1;

@@ -4641,28 +4648,27 @@ static int rbd_dev_v2_probe(struct rbd_device
*rbd_dev)
 			RBD_HEADER_PREFIX, rbd_dev->spec->image_id);

 	/* Get the size and object order for the image */
-
 	ret = rbd_dev_v2_image_size(rbd_dev);
-	if (ret < 0)
+	if (ret)
 		goto out_err;

 	/* Get the object prefix (a.k.a. block_name) for the image */

 	ret = rbd_dev_v2_object_prefix(rbd_dev);
-	if (ret < 0)
+	if (ret)
 		goto out_err;

 	/* Get the and check features for the image */

 	ret = rbd_dev_v2_features(rbd_dev);
-	if (ret < 0)
+	if (ret)
 		goto out_err;

 	/* If the image supports layering, get the parent info */

 	if (rbd_dev->header.features & RBD_FEATURE_LAYERING) {
 		ret = rbd_dev_v2_parent_info(rbd_dev);
-		if (ret < 0)
+		if (ret)
 			goto out_err;
 	}

-- 
1.7.9.5

