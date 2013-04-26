From: Alex Elder <elder@inktank.com>
Subject: [PATCH 7/7] rbd: refactor rbd_dev_probe_update_spec()
Date: Fri, 26 Apr 2013 13:01:12 -0500
Message-ID: <517AC0E8.3070701@inktank.com>
References: <517AC047.6060000@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:59868 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755834Ab3DZSBP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Apr 2013 14:01:15 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so5088722iec.8
        for <ceph-devel@vger.kernel.org>; Fri, 26 Apr 2013 11:01:14 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id b6sm4345115igv.5.2013.04.26.11.01.13
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 26 Apr 2013 11:01:13 -0700 (PDT)
In-Reply-To: <517AC047.6060000@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Fairly straightforward refactoring of rbd_dev_probe_update_spec().
The name is changed to rbd_dev_spec_update().

Rearrange it so nothing gets assigned to the spec until all of the
names have been successfully acquired.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   81
++++++++++++++++++++++++++-------------------------
 1 file changed, 42 insertions(+), 39 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index f65310c6..5918e0b 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3774,83 +3774,86 @@ out:
 }

 /*
- * When a parent image gets probed, we only have the pool, image,
- * and snapshot ids but not the names of any of them.  This call
- * is made later to fill in those names.  It has to be done after
- * rbd_dev_snaps_update() has completed because some of the
- * information (in particular, snapshot name) is not available
- * until then.
+ * When an rbd image has a parent image, it is identified by the
+ * pool, image, and snapshot ids (not names).  This function fills
+ * in the names for those ids.  (It's OK if we can't figure out the
+ * name for an image id, but the pool and snapshot ids should always
+ * exist and have names.)  All names in an rbd spec are dynamically
+ * allocated.
  *
  * When an image being mapped (not a parent) is probed, we have the
  * pool name and pool id, image name and image id, and the snapshot
  * name.  The only thing we're missing is the snapshot id.
+ *
+ * The set of snapshots for an image is not known until they have
+ * been read by rbd_dev_snaps_update(), so we can't completely fill
+ * in this information until after that has been called.
  */
-static int rbd_dev_probe_update_spec(struct rbd_device *rbd_dev)
+static int rbd_dev_spec_update(struct rbd_device *rbd_dev)
 {
-	struct ceph_osd_client *osdc;
-	const char *name;
-	void *reply_buf = NULL;
+	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
+	struct rbd_spec *spec = rbd_dev->spec;
+	const char *pool_name;
+	const char *image_name;
+	const char *snap_name;
 	int ret;

 	/*
 	 * An image being mapped will have the pool name (etc.), but
 	 * we need to look up the snapshot id.
 	 */
-	if (rbd_dev->spec->pool_name) {
-		if (strcmp(rbd_dev->spec->snap_name, RBD_SNAP_HEAD_NAME)) {
+	if (spec->pool_name) {
+		if (strcmp(spec->snap_name, RBD_SNAP_HEAD_NAME)) {
 			struct rbd_snap *snap;

-			snap = snap_by_name(rbd_dev, rbd_dev->spec->snap_name);
+			snap = snap_by_name(rbd_dev, spec->snap_name);
 			if (!snap)
 				return -ENOENT;
-			rbd_dev->spec->snap_id = snap->id;
+			spec->snap_id = snap->id;
 		} else {
-			rbd_dev->spec->snap_id = CEPH_NOSNAP;
+			spec->snap_id = CEPH_NOSNAP;
 		}

 		return 0;
 	}

-	/* Look up the pool name */
+	/* Get the pool name; we have to make our own copy of this */

-	osdc = &rbd_dev->rbd_client->client->osdc;
-	name = ceph_pg_pool_name_by_id(osdc->osdmap, rbd_dev->spec->pool_id);
-	if (!name) {
-		rbd_warn(rbd_dev, "there is no pool with id %llu",
-			rbd_dev->spec->pool_id);	/* Really a BUG() */
+	pool_name = ceph_pg_pool_name_by_id(osdc->osdmap, spec->pool_id);
+	if (!pool_name) {
+		rbd_warn(rbd_dev, "no pool with id %llu", spec->pool_id);
 		return -EIO;
 	}
-
-	rbd_dev->spec->pool_name = kstrdup(name, GFP_KERNEL);
-	if (!rbd_dev->spec->pool_name)
+	pool_name = kstrdup(pool_name, GFP_KERNEL);
+	if (!pool_name)
 		return -ENOMEM;

 	/* Fetch the image name; tolerate failure here */

-	name = rbd_dev_image_name(rbd_dev);
-	if (name)
-		rbd_dev->spec->image_name = (char *)name;
-	else
+	image_name = rbd_dev_image_name(rbd_dev);
+	if (!image_name)
 		rbd_warn(rbd_dev, "unable to get image name");

-	/* Look up the snapshot name. */
+	/* Look up the snapshot name, and make a copy */

-	name = rbd_snap_name(rbd_dev, rbd_dev->spec->snap_id);
-	if (!name) {
-		rbd_warn(rbd_dev, "no snapshot with id %llu",
-			rbd_dev->spec->snap_id);	/* Really a BUG() */
+	snap_name = rbd_snap_name(rbd_dev, spec->snap_id);
+	if (!snap_name) {
+		rbd_warn(rbd_dev, "no snapshot with id %llu", spec->snap_id);
 		ret = -EIO;
 		goto out_err;
 	}
-	rbd_dev->spec->snap_name = kstrdup(name, GFP_KERNEL);
-	if(!rbd_dev->spec->snap_name)
+	snap_name = kstrdup(snap_name, GFP_KERNEL);
+	if (!snap_name)
 		goto out_err;

+	spec->pool_name = pool_name;
+	spec->image_name = image_name;
+	spec->snap_name = snap_name;
+
 	return 0;
 out_err:
-	kfree(reply_buf);
-	kfree(rbd_dev->spec->pool_name);
-	rbd_dev->spec->pool_name = NULL;
+	kfree(image_name);
+	kfree(pool_name);

 	return ret;
 }
@@ -4706,7 +4709,7 @@ static int rbd_dev_probe_finish(struct rbd_device
*rbd_dev)
 	if (ret)
 		return ret;

-	ret = rbd_dev_probe_update_spec(rbd_dev);
+	ret = rbd_dev_spec_update(rbd_dev);
 	if (ret)
 		goto err_out_snaps;

-- 
1.7.9.5

