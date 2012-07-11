From: Alex Elder <elder@inktank.com>
Subject: [PATCH 13/16] rbd: rename some fields in struct rbd_dev
Date: Wed, 11 Jul 2012 09:02:49 -0500
Message-ID: <4FFD8789.2010204@inktank.com>
References: <4FFD847C.7070205@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f52.google.com ([209.85.213.52]:50862 "EHLO
	mail-yw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932532Ab2GKOCv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jul 2012 10:02:51 -0400
Received: by yhpp61 with SMTP id p61so1430101yhp.11
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 07:02:51 -0700 (PDT)
In-Reply-To: <4FFD847C.7070205@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

An rbd image is not a single object, but a logical construct made up
of an aggregation of objects.

Rename some fields in struct rbd_dev, in hopes of reinforcing this.
    obj         --> image_name
    obj_len     --> image_name_len
    obj_md_name --> header_name

Also rename a related symbol name:
    RBD_MAX_MD_NAME_LEN --> RBD_MAX_HEADER_NAME_LEN

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   53
++++++++++++++++++++++++++-------------------------
 1 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index c38246b..14e675c 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -161,9 +161,9 @@ struct rbd_device {
 	spinlock_t		lock;		/* queue lock */

 	struct rbd_image_header	header;
-	char			*obj; /* rbd image name */
-	size_t			obj_len;
-	char			*obj_md_name; /* hdr nm. */
+	char			*image_name;
+	size_t			image_name_len;
+	char			*header_name;
 	int			pool_id;

 	struct ceph_osd_event   *watch_event;
@@ -1224,8 +1224,8 @@ static void rbd_watch_cb(u64 ver, u64 notify_id,
u8 opcode, void *data)
 	if (!rbd_dev)
 		return;

-	dout("rbd_watch_cb %s notify_id=%lld opcode=%d\n", rbd_dev->obj_md_name,
-		notify_id, (int)opcode);
+	dout("rbd_watch_cb %s notify_id=%lld opcode=%d\n",
+		rbd_dev->header_name, notify_id, (int) opcode);
 	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
 	rc = __rbd_refresh_header(rbd_dev);
 	mutex_unlock(&ctl_mutex);
@@ -1233,7 +1233,7 @@ static void rbd_watch_cb(u64 ver, u64 notify_id,
u8 opcode, void *data)
 		pr_warning(RBD_DRV_NAME "%d got notification but failed to "
 			   " update snaps: %d\n", rbd_dev->major, rc);

-	rbd_req_sync_notify_ack(rbd_dev, ver, notify_id, rbd_dev->obj_md_name);
+	rbd_req_sync_notify_ack(rbd_dev, ver, notify_id, rbd_dev->header_name);
 }

 /*
@@ -1321,7 +1321,7 @@ static void rbd_notify_cb(u64 ver, u64 notify_id,
u8 opcode, void *data)
 		return;

 	dout("rbd_notify_cb %s notify_id=%lld opcode=%d\n",
-				rbd_dev->obj_md_name,
+				rbd_dev->header_name,
 		notify_id, (int)opcode);
 }

@@ -1599,7 +1599,7 @@ static int rbd_read_header(struct rbd_device *rbd_dev,

 		rc = rbd_req_sync_read(rbd_dev,
 				       NULL, CEPH_NOSNAP,
-				       rbd_dev->obj_md_name,
+				       rbd_dev->header_name,
 				       0, len,
 				       (char *)dh, &ver);
 		if (rc < 0)
@@ -1609,7 +1609,8 @@ static int rbd_read_header(struct rbd_device *rbd_dev,
 		if (rc < 0) {
 			if (rc == -ENXIO)
 				pr_warning("unrecognized header format"
-					   " for image %s", rbd_dev->obj);
+					   " for image %s\n",
+					   rbd_dev->image_name);
 			goto out_dh;
 		}

@@ -1665,7 +1666,7 @@ static int rbd_header_add_snap(struct rbd_device
*rbd_dev,
 	ceph_encode_string_safe(&p, e, snap_name, name_len, bad);
 	ceph_encode_64_safe(&p, e, new_snapid, bad);

-	ret = rbd_req_sync_exec(rbd_dev, rbd_dev->obj_md_name,
+	ret = rbd_req_sync_exec(rbd_dev, rbd_dev->header_name,
 				"rbd", "snap_add",
 				data, p - data, &ver);

@@ -1862,7 +1863,7 @@ static ssize_t rbd_name_show(struct device *dev,
 {
 	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);

-	return sprintf(buf, "%s\n", rbd_dev->obj);
+	return sprintf(buf, "%s\n", rbd_dev->image_name);
 }

 static ssize_t rbd_snap_show(struct device *dev,
@@ -2164,7 +2165,7 @@ static int rbd_init_watch_dev(struct rbd_device
*rbd_dev)
 	int ret, rc;

 	do {
-		ret = rbd_req_sync_watch(rbd_dev, rbd_dev->obj_md_name,
+		ret = rbd_req_sync_watch(rbd_dev, rbd_dev->header_name,
 					 rbd_dev->header.obj_version);
 		if (ret == -ERANGE) {
 			mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
@@ -2327,7 +2328,7 @@ static inline char *dup_token(const char **buf,
size_t *lenp)
 }

 /*
- * This fills in the obj, obj_len, snap_name, rbd_dev, rbd_md_name,
+ * This fills in the image, image_len, snap_name, rbd_dev, header_name,
  * and name fields of the given rbd_dev, based on the list of
  * monitor addresses and other options provided via /sys/bus/rbd/add.
  *
@@ -2368,18 +2369,18 @@ static char *rbd_add_parse_args(struct
rbd_device *rbd_dev,
 	if (!pool_name)
 		goto out_err;

-	rbd_dev->obj = dup_token(&buf, &rbd_dev->obj_len);
-	if (!rbd_dev->obj)
+	rbd_dev->image_name = dup_token(&buf, &rbd_dev->image_name_len);
+	if (!rbd_dev->image_name)
 		goto out_err;

 	/* Create the name of the header object */

-	rbd_dev->obj_md_name = kmalloc(rbd_dev->obj_len
+	rbd_dev->header_name = kmalloc(rbd_dev->image_name_len
 						+ sizeof (RBD_SUFFIX),
 					GFP_KERNEL);
-	if (!rbd_dev->obj_md_name)
+	if (!rbd_dev->header_name)
 		goto out_err;
-	sprintf(rbd_dev->obj_md_name, "%s%s", rbd_dev->obj, RBD_SUFFIX);
+	sprintf(rbd_dev->header_name, "%s%s", rbd_dev->image_name, RBD_SUFFIX);

 	/*
 	 * The snapshot name is optional.  If none is is supplied,
@@ -2403,8 +2404,8 @@ static char *rbd_add_parse_args(struct rbd_device
*rbd_dev,
 	return pool_name;

 out_err:
-	kfree(rbd_dev->obj_md_name);
-	kfree(rbd_dev->obj);
+	kfree(rbd_dev->header_name);
+	kfree(rbd_dev->image_name);
 	kfree(pool_name);

 	return ERR_PTR(ret);
@@ -2513,8 +2514,8 @@ err_out_client:
 err_put_id:
 	if (pool_name) {
 		kfree(rbd_dev->snap_name);
-		kfree(rbd_dev->obj_md_name);
-		kfree(rbd_dev->obj);
+		kfree(rbd_dev->header_name);
+		kfree(rbd_dev->image_name);
 		kfree(pool_name);
 	}
 	rbd_id_put(rbd_dev);
@@ -2556,7 +2557,7 @@ static void rbd_dev_release(struct device *dev)
 						    rbd_dev->watch_request);
 	}
 	if (rbd_dev->watch_event)
-		rbd_req_sync_unwatch(rbd_dev, rbd_dev->obj_md_name);
+		rbd_req_sync_unwatch(rbd_dev, rbd_dev->header_name);

 	rbd_put_client(rbd_dev);

@@ -2566,8 +2567,8 @@ static void rbd_dev_release(struct device *dev)

 	/* done with the id, and with the rbd_dev */
 	kfree(rbd_dev->snap_name);
-	kfree(rbd_dev->obj_md_name);
-	kfree(rbd_dev->obj);
+	kfree(rbd_dev->header_name);
+	kfree(rbd_dev->image_name);
 	rbd_id_put(rbd_dev);
 	kfree(rbd_dev);

@@ -2638,7 +2639,7 @@ static ssize_t rbd_snap_add(struct device *dev,
 	mutex_unlock(&ctl_mutex);

 	/* make a best effort, don't error if failed */
-	rbd_req_sync_notify(rbd_dev, rbd_dev->obj_md_name);
+	rbd_req_sync_notify(rbd_dev, rbd_dev->header_name);

 	ret = count;
 	kfree(name);
-- 
1.7.5.4

