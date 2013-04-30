From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/4] rbd: define rbd_snap_size() and rbd_snap_features()
Date: Tue, 30 Apr 2013 07:42:58 -0500
Message-ID: <517FBC52.2070405@inktank.com>
References: <517FBBF0.9020904@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f177.google.com ([209.85.210.177]:46911 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760569Ab3D3MnA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Apr 2013 08:43:00 -0400
Received: by mail-ia0-f177.google.com with SMTP id y26so388907iab.8
        for <ceph-devel@vger.kernel.org>; Tue, 30 Apr 2013 05:42:59 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id dy5sm24464775igc.1.2013.04.30.05.42.58
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 05:42:58 -0700 (PDT)
In-Reply-To: <517FBBF0.9020904@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This patch defines a handful of new functions that will allow
us to get rid of the rbd device structure's list of snapshots.

Define rbd_snap_id_by_name() to look up a snapshot id given its
name.  This is efficient for format 1 images but not for format 2.
Fortunately it only gets called at mapping time so it's not that
critical.

Use rbd_snap_id_by_name() to find out the id for a snapshot getting
mapped, and pass that id to new functions rbd_snap_size() and
rbd_snap_features() to look up information about a given snapshot's
size and feature mask given its snapshot id.  All this gets done
in rbd_dev_mapping_set().

As a result, snap_by_name() is no longer needed, so get rid of it.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |  152
+++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 129 insertions(+), 23 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b1e1d12..67fd866d 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -435,6 +435,11 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev);
 static int rbd_dev_v2_refresh(struct rbd_device *rbd_dev);
 static const char *rbd_dev_v2_snap_name(struct rbd_device *rbd_dev,
 					u64 snap_id);
+static int _rbd_dev_v2_snap_size(struct rbd_device *rbd_dev, u64 snap_id,
+				u8 *order, u64 *snap_size);
+static int _rbd_dev_v2_snap_features(struct rbd_device *rbd_dev, u64
snap_id,
+		u64 *snap_features);
+static u64 rbd_snap_id_by_name(struct rbd_device *rbd_dev, const char
*name);

 static int rbd_open(struct block_device *bdev, fmode_t mode)
 {
@@ -840,7 +845,8 @@ static u32 rbd_dev_snap_index(struct rbd_device
*rbd_dev, u64 snap_id)
 	return BAD_SNAP_INDEX;
 }

-static const char *rbd_dev_v1_snap_name(struct rbd_device *rbd_dev, u64
snap_id)
+static const char *rbd_dev_v1_snap_name(struct rbd_device *rbd_dev,
+					u64 snap_id)
 {
 	u32 which;

@@ -863,35 +869,85 @@ static const char *rbd_snap_name(struct rbd_device
*rbd_dev, u64 snap_id)
 	return rbd_dev_v2_snap_name(rbd_dev, snap_id);
 }

-static struct rbd_snap *snap_by_name(struct rbd_device *rbd_dev,
-					const char *snap_name)
+static int rbd_snap_size(struct rbd_device *rbd_dev, u64 snap_id,
+				u64 *snap_size)
 {
-	struct rbd_snap *snap;
+	rbd_assert(rbd_image_format_valid(rbd_dev->image_format));
+	if (snap_id == CEPH_NOSNAP) {
+		*snap_size = rbd_dev->header.image_size;
+	} else if (rbd_dev->image_format == 1) {
+		u32 which;

-	list_for_each_entry(snap, &rbd_dev->snaps, node)
-		if (!strcmp(snap_name, snap->name))
-			return snap;
+		which = rbd_dev_snap_index(rbd_dev, snap_id);
+		if (which == BAD_SNAP_INDEX)
+			return -ENOENT;

-	return NULL;
+		*snap_size = rbd_dev->header.snap_sizes[which];
+	} else {
+		u64 size = 0;
+		int ret;
+
+		ret = _rbd_dev_v2_snap_size(rbd_dev, snap_id, NULL, &size);
+		if (ret)
+			return ret;
+
+		*snap_size = size;
+	}
+	return 0;
 }

-static int rbd_dev_mapping_set(struct rbd_device *rbd_dev)
+static int rbd_snap_features(struct rbd_device *rbd_dev, u64 snap_id,
+			u64 *snap_features)
 {
-	if (!memcmp(rbd_dev->spec->snap_name, RBD_SNAP_HEAD_NAME,
-		    sizeof (RBD_SNAP_HEAD_NAME))) {
-		rbd_dev->mapping.size = rbd_dev->header.image_size;
-		rbd_dev->mapping.features = rbd_dev->header.features;
+	rbd_assert(rbd_image_format_valid(rbd_dev->image_format));
+	if (snap_id == CEPH_NOSNAP) {
+		*snap_features = rbd_dev->header.features;
+	} else if (rbd_dev->image_format == 1) {
+		*snap_features = 0;	/* No features for format 1 */
 	} else {
-		struct rbd_snap *snap;
+		u64 features = 0;
+		int ret;
+
+		ret = _rbd_dev_v2_snap_features(rbd_dev, snap_id, &features);
+		if (ret)
+			return ret;
+
+		*snap_features = features;
+	}
+	return 0;
+}

-		snap = snap_by_name(rbd_dev, rbd_dev->spec->snap_name);
-		if (!snap)
+static int rbd_dev_mapping_set(struct rbd_device *rbd_dev)
+{
+	const char *snap_name = rbd_dev->spec->snap_name;
+	u64 snap_id;
+	u64 size = 0;
+	u64 features = 0;
+	int ret;
+
+	if (strcmp(snap_name, RBD_SNAP_HEAD_NAME)) {
+		snap_id = rbd_snap_id_by_name(rbd_dev, snap_name);
+		if (snap_id == CEPH_NOSNAP)
 			return -ENOENT;
-		rbd_dev->mapping.size = snap->size;
-		rbd_dev->mapping.features = snap->features;
-		rbd_dev->mapping.read_only = true;
+	} else {
+		snap_id = CEPH_NOSNAP;
 	}

+	ret = rbd_snap_size(rbd_dev, snap_id, &size);
+	if (ret)
+		return ret;
+	ret = rbd_snap_features(rbd_dev, snap_id, &features);
+	if (ret)
+		return ret;
+
+	rbd_dev->mapping.size = size;
+	rbd_dev->mapping.features = features;
+
+	/* If we are mapping a snapshot it must be marked read-only */
+
+	if (snap_id != CEPH_NOSNAP)
+		rbd_dev->mapping.read_only = true;
+
 	return 0;
 }

@@ -3766,6 +3822,56 @@ out:
 	return image_name;
 }

+static u64 rbd_v1_snap_id_by_name(struct rbd_device *rbd_dev, const
char *name)
+{
+	struct ceph_snap_context *snapc = rbd_dev->header.snapc;
+	const char *snap_name;
+	u32 which = 0;
+
+	/* Skip over names until we find the one we are looking for */
+
+	snap_name = rbd_dev->header.snap_names;
+	while (which < snapc->num_snaps) {
+		if (!strcmp(name, snap_name))
+			return snapc->snaps[which];
+		snap_name += strlen(snap_name) + 1;
+		which++;
+	}
+	return CEPH_NOSNAP;
+}
+
+static u64 rbd_v2_snap_id_by_name(struct rbd_device *rbd_dev, const
char *name)
+{
+	struct ceph_snap_context *snapc = rbd_dev->header.snapc;
+	u32 which;
+	bool found = false;
+	u64 snap_id;
+
+	for (which = 0; !found && which < snapc->num_snaps; which++) {
+		const char *snap_name;
+
+		snap_id = snapc->snaps[which];
+		snap_name = rbd_dev_v2_snap_name(rbd_dev, snap_id);
+		if (IS_ERR(snap_name))
+			break;
+		found = !strcmp(name, snap_name);
+		kfree(snap_name);
+	}
+	return found ? snap_id : CEPH_NOSNAP;
+}
+
+/*
+ * Assumes name is never RBD_SNAP_HEAD_NAME; returns CEPH_NOSNAP if
+ * no snapshot by that name is found, or if an error occurs.
+ */
+static u64 rbd_snap_id_by_name(struct rbd_device *rbd_dev, const char
*name)
+{
+	if (rbd_dev->image_format == 1)
+		return rbd_v1_snap_id_by_name(rbd_dev, name);
+
+	return rbd_v2_snap_id_by_name(rbd_dev, name);
+}
+
 /*
  * When an rbd image has a parent image, it is identified by the
  * pool, image, and snapshot ids (not names).  This function fills
@@ -3797,12 +3903,12 @@ static int rbd_dev_spec_update(struct rbd_device
*rbd_dev)
 	 */
 	if (spec->pool_name) {
 		if (strcmp(spec->snap_name, RBD_SNAP_HEAD_NAME)) {
-			struct rbd_snap *snap;
+			u64 snap_id;

-			snap = snap_by_name(rbd_dev, spec->snap_name);
-			if (!snap)
+			snap_id = rbd_snap_id_by_name(rbd_dev, spec->snap_name);
+			if (snap_id == CEPH_NOSNAP)
 				return -ENOENT;
-			spec->snap_id = snap->id;
+			spec->snap_id = snap_id;
 		} else {
 			spec->snap_id = CEPH_NOSNAP;
 		}
-- 
1.7.9.5

