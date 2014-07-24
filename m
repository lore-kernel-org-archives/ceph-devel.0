From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 4/8] rbd: split rbd_dev_spec_update() into two functions
Date: Thu, 24 Jul 2014 12:42:45 +0400
Message-ID: <1406191369-6746-5-git-send-email-ilya.dryomov@inktank.com>
References: <1406191369-6746-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:40003 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934448AbaGXInH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jul 2014 04:43:07 -0400
Received: by mail-la0-f45.google.com with SMTP id ty20so1625385lab.4
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jul 2014 01:43:04 -0700 (PDT)
Received: from localhost ([109.110.66.237])
        by mx.google.com with ESMTPSA id c7sm9602492lbd.37.2014.07.24.01.43.03
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 24 Jul 2014 01:43:03 -0700 (PDT)
In-Reply-To: <1406191369-6746-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

rbd_dev_spec_update() has two modes of operation, with nothing in
common between them.  Split it into two functions, one for each mode
and make our expectations more clear.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 drivers/block/rbd.c |   79 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 31 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4541f6027e4a..23df1773ef77 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3798,6 +3798,9 @@ static struct rbd_spec *rbd_spec_alloc(void)
 	spec = kzalloc(sizeof (*spec), GFP_KERNEL);
 	if (!spec)
 		return NULL;
+
+	spec->pool_id = CEPH_NOPOOL;
+	spec->snap_id = CEPH_NOSNAP;
 	kref_init(&spec->kref);
 
 	return spec;
@@ -4257,18 +4260,38 @@ static u64 rbd_snap_id_by_name(struct rbd_device *rbd_dev, const char *name)
 }
 
 /*
- * When an rbd image has a parent image, it is identified by the
- * pool, image, and snapshot ids (not names).  This function fills
- * in the names for those ids.  (It's OK if we can't figure out the
- * name for an image id, but the pool and snapshot ids should always
- * exist and have names.)  All names in an rbd spec are dynamically
- * allocated.
+ * An image being mapped will have everything but the snap id.
+ */
+static int rbd_spec_fill_snap_id(struct rbd_device *rbd_dev)
+{
+	struct rbd_spec *spec = rbd_dev->spec;
+
+	rbd_assert(spec->pool_id != CEPH_NOPOOL && spec->pool_name);
+	rbd_assert(spec->image_id && spec->image_name);
+	rbd_assert(spec->snap_name);
+
+	if (strcmp(spec->snap_name, RBD_SNAP_HEAD_NAME)) {
+		u64 snap_id;
+
+		snap_id = rbd_snap_id_by_name(rbd_dev, spec->snap_name);
+		if (snap_id == CEPH_NOSNAP)
+			return -ENOENT;
+
+		spec->snap_id = snap_id;
+	} else {
+		spec->snap_id = CEPH_NOSNAP;
+	}
+
+	return 0;
+}
+
+/*
+ * A parent image will have all ids but none of the names.
  *
- * When an image being mapped (not a parent) is probed, we have the
- * pool name and pool id, image name and image id, and the snapshot
- * name.  The only thing we're missing is the snapshot id.
+ * All names in an rbd spec are dynamically allocated.  It's OK if we
+ * can't figure out the name for an image id.
  */
-static int rbd_dev_spec_update(struct rbd_device *rbd_dev)
+static int rbd_spec_fill_names(struct rbd_device *rbd_dev)
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
 	struct rbd_spec *spec = rbd_dev->spec;
@@ -4277,24 +4300,9 @@ static int rbd_dev_spec_update(struct rbd_device *rbd_dev)
 	const char *snap_name;
 	int ret;
 
-	/*
-	 * An image being mapped will have the pool name (etc.), but
-	 * we need to look up the snapshot id.
-	 */
-	if (spec->pool_name) {
-		if (strcmp(spec->snap_name, RBD_SNAP_HEAD_NAME)) {
-			u64 snap_id;
-
-			snap_id = rbd_snap_id_by_name(rbd_dev, spec->snap_name);
-			if (snap_id == CEPH_NOSNAP)
-				return -ENOENT;
-			spec->snap_id = snap_id;
-		} else {
-			spec->snap_id = CEPH_NOSNAP;
-		}
-
-		return 0;
-	}
+	rbd_assert(spec->pool_id != CEPH_NOPOOL);
+	rbd_assert(spec->image_id);
+	rbd_assert(spec->snap_id != CEPH_NOSNAP);
 
 	/* Get the pool name; we have to make our own copy of this */
 
@@ -4313,7 +4321,7 @@ static int rbd_dev_spec_update(struct rbd_device *rbd_dev)
 	if (!image_name)
 		rbd_warn(rbd_dev, "unable to get image name");
 
-	/* Look up the snapshot name, and make a copy */
+	/* Fetch the snapshot name */
 
 	snap_name = rbd_snap_name(rbd_dev, spec->snap_id);
 	if (IS_ERR(snap_name)) {
@@ -4326,10 +4334,10 @@ static int rbd_dev_spec_update(struct rbd_device *rbd_dev)
 	spec->snap_name = snap_name;
 
 	return 0;
+
 out_err:
 	kfree(image_name);
 	kfree(pool_name);
-
 	return ret;
 }
 
@@ -5158,7 +5166,16 @@ static int rbd_dev_image_probe(struct rbd_device *rbd_dev, bool mapping)
 	if (ret)
 		goto err_out_watch;
 
-	ret = rbd_dev_spec_update(rbd_dev);
+	/*
+	 * If this image is the one being mapped, we have pool name and
+	 * id, image name and id, and snap name - need to fill snap id.
+	 * Otherwise this is a parent image, identified by pool, image
+	 * and snap ids - need to fill in names for those ids.
+	 */
+	if (mapping)
+		ret = rbd_spec_fill_snap_id(rbd_dev);
+	else
+		ret = rbd_spec_fill_names(rbd_dev);
 	if (ret)
 		goto err_out_probe;
 
-- 
1.7.10.4

