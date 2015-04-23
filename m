From: Douglas Fuller <dfuller@redhat.com>
Subject: [PATCH 3/3] rbd: re-read features during header refresh and detect changes.
Date: Thu, 23 Apr 2015 12:06:33 -0700
Message-ID: <c00b8183a5e73c6fda976ca17feb731ae5d896fa.1429814290.git.dfuller@redhat.com>
References: <cover.1429814290.git.dfuller@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36972 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030449AbbDWTHK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 Apr 2015 15:07:10 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t3NJ7Aeb016087
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Thu, 23 Apr 2015 15:07:10 -0400
Received: from rex001.front.sepia.ceph.com (vpn-56-33.rdu2.redhat.com [10.10.56.33])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t3NJ6vZY006593
	for <ceph-devel@vger.kernel.org>; Thu, 23 Apr 2015 15:07:10 -0400
In-Reply-To: <cover.1429814290.git.dfuller@redhat.com>
In-Reply-To: <cover.1429814290.git.dfuller@redhat.com>
References: <cover.1429814290.git.dfuller@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

From: Douglas Fuller <douglas.fuller@gmail.com>

Add a new header item to track when features have changed since mapping and
return EIO on I/O operations. Clean up and consolidate code path for
header read and update.  Remove unused code.

Signed-off-by: Douglas Fuller <douglas.fuller@gmail.com>
---
 drivers/block/rbd.c | 209 +++++++++++++++++++---------------------------------
 1 file changed, 77 insertions(+), 132 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 63771f6..1ab8c12 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -320,9 +320,17 @@ struct rbd_img_request {
 #define for_each_obj_request_safe(ireq, oreq, n) \
 	list_for_each_entry_safe_reverse(oreq, n, &(ireq)->obj_requests, links)
 
+enum rbd_mapping_state
+{
+	MAP_STATE_MAPPED,
+	MAP_STATE_DETACHED,
+};
+		
+
 struct rbd_mapping {
 	u64                     size;
 	u64                     features;
+	enum rbd_mapping_state	state;
 	bool			read_only;
 };
 
@@ -527,7 +535,7 @@ static void rbd_img_parent_read(struct rbd_obj_request *obj_request);
 static void rbd_dev_remove_parent(struct rbd_device *rbd_dev);
 
 static int rbd_dev_refresh(struct rbd_device *rbd_dev);
-static int rbd_dev_v2_header_onetime(struct rbd_device *rbd_dev);
+static int rbd_dev_v2_header_data(struct rbd_device *rbd_dev);
 static int rbd_dev_header_info(struct rbd_device *rbd_dev);
 static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev);
 static const char *rbd_dev_v2_snap_name(struct rbd_device *rbd_dev,
@@ -3336,6 +3344,14 @@ static void rbd_queue_workfn(struct work_struct *work)
 	else
 		op_type = OBJ_OP_READ;
 
+	/* If a configuration change was detected, issue EIO. */
+
+	if (rbd_dev->mapping.state == MAP_STATE_DETACHED)
+	{
+		result = -EIO;
+		goto err_rq;
+	}
+
 	/* Ignore/skip any zero-length requests */
 
 	if (!length) {
@@ -3670,12 +3686,23 @@ static void rbd_dev_update_size(struct rbd_device *rbd_dev)
 static int rbd_dev_refresh(struct rbd_device *rbd_dev)
 {
 	u64 mapping_size;
+	u64 features;
 	int ret;
 
 	down_write(&rbd_dev->header_rwsem);
 	mapping_size = rbd_dev->mapping.size;
+	features = rbd_dev->mapping.features;
 
 	ret = rbd_dev_header_info(rbd_dev);
+
+	if (ret == -ENXIO || (ret && features != rbd_dev->mapping.features))
+	{
+		rbd_dev->mapping.read_only = 1;
+		rbd_dev->mapping.state = MAP_STATE_DETACHED;
+		rbd_warn(rbd_dev,
+			"detected feature change in mapped device, setting read-only");
+	}
+
 	if (ret)
 		goto out;
 
@@ -3698,6 +3725,9 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev)
 
 out:
 	up_write(&rbd_dev->header_rwsem);
+
+	if (rbd_dev->mapping.read_only)
+		set_disk_ro(rbd_dev->disk, 1);
 	if (!ret && mapping_size != rbd_dev->mapping.size)
 		rbd_dev_update_size(rbd_dev);
 
@@ -4111,47 +4141,6 @@ static int _rbd_dev_v2_snap_size(struct rbd_device *rbd_dev, u64 snap_id,
 	return 0;
 }
 
-static int rbd_dev_v2_image_size(struct rbd_device *rbd_dev)
-{
-	return _rbd_dev_v2_snap_size(rbd_dev, CEPH_NOSNAP,
-					&rbd_dev->header.obj_order,
-					&rbd_dev->header.image_size);
-}
-
-static int rbd_dev_v2_object_prefix(struct rbd_device *rbd_dev)
-{
-	void *reply_buf;
-	int ret;
-	void *p;
-
-	reply_buf = kzalloc(RBD_OBJ_PREFIX_LEN_MAX, GFP_KERNEL);
-	if (!reply_buf)
-		return -ENOMEM;
-
-	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_name,
-				"rbd", "get_object_prefix", NULL, 0,
-				reply_buf, RBD_OBJ_PREFIX_LEN_MAX);
-	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
-	if (ret < 0)
-		goto out;
-
-	p = reply_buf;
-	rbd_dev->header.object_prefix = ceph_extract_encoded_string(&p,
-						p + ret, NULL, GFP_NOIO);
-	ret = 0;
-
-	if (IS_ERR(rbd_dev->header.object_prefix)) {
-		ret = PTR_ERR(rbd_dev->header.object_prefix);
-		rbd_dev->header.object_prefix = NULL;
-	} else {
-		dout("  object_prefix = %s\n", rbd_dev->header.object_prefix);
-	}
-out:
-	kfree(reply_buf);
-
-	return ret;
-}
-
 static int _rbd_dev_v2_snap_features(struct rbd_device *rbd_dev, u64 snap_id,
 		u64 *snap_features)
 {
@@ -4187,12 +4176,6 @@ static int _rbd_dev_v2_snap_features(struct rbd_device *rbd_dev, u64 snap_id,
 	return 0;
 }
 
-static int rbd_dev_v2_features(struct rbd_device *rbd_dev)
-{
-	return _rbd_dev_v2_snap_features(rbd_dev, CEPH_NOSNAP,
-						&rbd_dev->header.features);
-}
-
 static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev)
 {
 	struct rbd_spec *parent_spec;
@@ -4549,79 +4532,6 @@ out_err:
 	return ret;
 }
 
-static int rbd_dev_v2_snap_context(struct rbd_device *rbd_dev)
-{
-	size_t size;
-	int ret;
-	void *reply_buf;
-	void *p;
-	void *end;
-	u64 seq;
-	u32 snap_count;
-	struct ceph_snap_context *snapc;
-	u32 i;
-
-	/*
-	 * We'll need room for the seq value (maximum snapshot id),
-	 * snapshot count, and array of that many snapshot ids.
-	 * For now we have a fixed upper limit on the number we're
-	 * prepared to receive.
-	 */
-	size = sizeof (__le64) + sizeof (__le32) +
-			RBD_MAX_SNAP_COUNT * sizeof (__le64);
-	reply_buf = kzalloc(size, GFP_KERNEL);
-	if (!reply_buf)
-		return -ENOMEM;
-
-	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_name,
-				"rbd", "get_snapcontext", NULL, 0,
-				reply_buf, size);
-	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
-printk(KERN_INFO "%s: rbd_obj_method_sync returned %d\n", __func__, ret);
-	if (ret < 0)
-		goto out;
-
-	p = reply_buf;
-	end = reply_buf + ret;
-	ret = -ERANGE;
-	ceph_decode_64_safe(&p, end, seq, out);
-	ceph_decode_32_safe(&p, end, snap_count, out);
-
-	/*
-	 * Make sure the reported number of snapshot ids wouldn't go
-	 * beyond the end of our buffer.  But before checking that,
-	 * make sure the computed size of the snapshot context we
-	 * allocate is representable in a size_t.
-	 */
-	if (snap_count > (SIZE_MAX - sizeof (struct ceph_snap_context))
-				 / sizeof (u64)) {
-		ret = -EINVAL;
-		goto out;
-	}
-	if (!ceph_has_room(&p, end, snap_count * sizeof (__le64)))
-		goto out;
-	ret = 0;
-
-	snapc = ceph_create_snap_context(snap_count, GFP_KERNEL);
-	if (!snapc) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	snapc->seq = seq;
-	for (i = 0; i < snap_count; i++)
-		snapc->snaps[i] = ceph_decode_64(&p);
-
-	ceph_put_snap_context(rbd_dev->header.snapc);
-	rbd_dev->header.snapc = snapc;
-
-	dout("  snap context seq = %llu, snap_count = %u\n",
-		(unsigned long long)seq, (unsigned int)snap_count);
-out:
-	kfree(reply_buf);
-
-	return ret;
-}
-
 static const char *rbd_dev_v2_snap_name(struct rbd_device *rbd_dev,
 					u64 snap_id)
 {
@@ -4663,6 +4573,16 @@ out:
 	return snap_name;
 }
 
+static int rbd_dev_v2_mutable_metadata(struct rbd_device *rbd_dev)
+{
+	return rbd_dev_v2_header_data(rbd_dev);
+}
+
+static int rbd_dev_v2_immutable_metadata(struct rbd_device *rbd_dev)
+{
+	return rbd_dev_v2_header_data(rbd_dev);
+}
+
 static int rbd_dev_v2_header_info(struct rbd_device *rbd_dev)
 {
 	bool first_time = rbd_dev->header.object_prefix == NULL;
@@ -4670,27 +4590,39 @@ static int rbd_dev_v2_header_info(struct rbd_device *rbd_dev)
 
 	if (!first_time)
 	{
-		ret = rbd_dev_v2_image_size(rbd_dev);
+		ret = rbd_dev_v2_mutable_metadata(rbd_dev);
 		if (ret)
-			return ret;
-
-		ret = rbd_dev_v2_snap_context(rbd_dev);
-		dout("rbd_dev_v2_snap_context returned %d\n", ret);
-		return ret;
+			goto out_err;
 	}
 	else
 	{
-		ret = rbd_dev_v2_header_onetime(rbd_dev);
+		ret = rbd_dev_v2_immutable_metadata(rbd_dev);
 		if (ret)
-			return ret;
+			goto out_err;
 	}
-	return ret; /* XXX change logic? */
+
+	if (rbd_dev->header.features & RBD_FEATURE_STRIPINGV2)
+	{
+		ret = rbd_dev_v2_striping_info(rbd_dev);
+		if (ret)
+			goto out_err;
+	}
+
+	ret = 0;
+out_err:
+	rbd_dev->header.features = 0;
+	kfree(rbd_dev->header.object_prefix);
+	rbd_dev->header.object_prefix = NULL;
+
+	return ret;
 }
 
 static int rbd_dev_header_info(struct rbd_device *rbd_dev)
 {
 	rbd_assert(rbd_image_format_valid(rbd_dev->image_format));
 
+	/* XXX need to fix 11418 here too? */
+
 	if (rbd_dev->image_format == 1)
 		return rbd_dev_v1_header_info(rbd_dev);
 
@@ -5142,7 +5074,6 @@ static int rbd_obj_header_method_add(struct ceph_osd_request *osd_req,
 	{
 		struct ceph_pagelist *pagelist;
 		pagelist = kmalloc(sizeof(*pagelist), GFP_NOFS);
-		/* XXX is this ever freed? */
 		if (!pagelist)
 			return -ENOMEM;
 
@@ -5288,6 +5219,12 @@ static int __extract_snapcontext(struct rbd_device *rbd_dev,
 	int i;
 	int ret;
 
+	/*
+	 * We'll need room for the seq value (maximum snapshot id),
+	 * snapshot count, and array of that many snapshot ids.
+	 * For now we have a fixed upper limit on the number we're
+	 * prepared to receive.
+	 */
 	snapc_max = sizeof(__le64) + sizeof(__le32) +
 		RBD_MAX_SNAP_COUNT * sizeof(__le64);
 
@@ -5303,6 +5240,12 @@ static int __extract_snapcontext(struct rbd_device *rbd_dev,
 	ceph_decode_64_safe(&p, q, seq, out_err);
 	ceph_decode_32_safe(&p, q, snap_count, out_err);
 
+	/*
+	 * Make sure the reported number of snapshot ids wouldn't go
+	 * beyond the end of our buffer.  But before checking that,
+	 * make sure the computed size of the snapshot context we
+	 * allocate is representable in a size_t.
+	 */
 	if (snap_count > (SIZE_MAX - sizeof(struct ceph_snap_context)) /
 		sizeof(u64))
 	{
@@ -5344,7 +5287,7 @@ static int __extract_size(struct rbd_device *rbd_dev,
 	return 0;
 }
 
-static int rbd_dev_v2_header_onetime(struct rbd_device *rbd_dev)
+static int rbd_dev_v2_header_data(struct rbd_device *rbd_dev)
 {
 	int ret;
 
@@ -5718,6 +5661,8 @@ static ssize_t do_rbd_add(struct bus_type *bus,
 		read_only = true;
 	rbd_dev->mapping.read_only = read_only;
 
+	rbd_dev->mapping.state = MAP_STATE_MAPPED;
+
 	rc = rbd_dev_device_setup(rbd_dev);
 	if (rc) {
 		/*
-- 
1.9.3

