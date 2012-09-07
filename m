From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/7] rbd: return snap name from rbd_add_parse_args()
Date: Fri, 07 Sep 2012 08:45:28 -0500
Message-ID: <5049FA78.9080603@inktank.com>
References: <5049F951.2030706@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33631 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283Ab2IGNp3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 09:45:29 -0400
Received: by mail-ie0-f174.google.com with SMTP id e11so5014223iej.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 06:45:29 -0700 (PDT)
In-Reply-To: <5049F951.2030706@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is the first of two patches aimed at isolating the code that
sets the mapping information into a single spot.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   72
++++++++++++++++++++++++++-------------------------
 1 file changed, 37 insertions(+), 35 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4377a83..1a64ba2 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2477,28 +2477,31 @@ static inline char *dup_token(const char **buf,
size_t *lenp)
 }

 /*
- * This fills in the pool_name, image_name, image_name_len, snap_name,
- * rbd_dev, rbd_md_name, and name fields of the given rbd_dev, based
- * on the list of monitor addresses and other options provided via
- * /sys/bus/rbd/add.
+ * This fills in the pool_name, image_name, image_name_len, rbd_dev,
+ * rbd_md_name, and name fields of the given rbd_dev, based on the
+ * list of monitor addresses and other options provided via
+ * /sys/bus/rbd/add.  Returns a pointer to a dynamically-allocated
+ * copy of the snapshot name to map if successful, or a
+ * pointer-coded error otherwise.
  *
  * Note: rbd_dev is assumed to have been initially zero-filled.
  */
-static int rbd_add_parse_args(struct rbd_device *rbd_dev,
-			      const char *buf,
-			      const char **mon_addrs,
-			      size_t *mon_addrs_size,
-			      char *options,
-			     size_t options_size)
+static char *rbd_add_parse_args(struct rbd_device *rbd_dev,
+				const char *buf,
+				const char **mon_addrs,
+				size_t *mon_addrs_size,
+				char *options,
+				size_t options_size)
 {
 	size_t len;
-	int ret;
+	char *err_ptr = ERR_PTR(-EINVAL);
+	char *snap_name;

 	/* The first four tokens are required */

 	len = next_token(&buf);
 	if (!len)
-		return -EINVAL;
+		return err_ptr;
 	*mon_addrs_size = len + 1;
 	*mon_addrs = buf;

@@ -2506,9 +2509,9 @@ static int rbd_add_parse_args(struct rbd_device
*rbd_dev,

 	len = copy_token(&buf, options, options_size);
 	if (!len || len >= options_size)
-		return -EINVAL;
+		return err_ptr;

-	ret = -ENOMEM;
+	err_ptr = ERR_PTR(-ENOMEM);
 	rbd_dev->pool_name = dup_token(&buf, NULL);
 	if (!rbd_dev->pool_name)
 		goto out_err;
@@ -2526,26 +2529,21 @@ static int rbd_add_parse_args(struct rbd_device
*rbd_dev,
 		goto out_err;
 	sprintf(rbd_dev->header_name, "%s%s", rbd_dev->image_name, RBD_SUFFIX);

-	/*
-	 * The snapshot name is optional.  If none is is supplied,
-	 * we use the default value.
-	 */
-	rbd_dev->mapping.snap_name = dup_token(&buf, &len);
-	if (!rbd_dev->mapping.snap_name)
-		goto out_err;
+	/* Snapshot name is optional */
+	len = next_token(&buf);
 	if (!len) {
-		/* Replace the empty name with the default */
-		kfree(rbd_dev->mapping.snap_name);
-		rbd_dev->mapping.snap_name
-			= kmalloc(sizeof (RBD_SNAP_HEAD_NAME), GFP_KERNEL);
-		if (!rbd_dev->mapping.snap_name)
-			goto out_err;
-
-		memcpy(rbd_dev->mapping.snap_name, RBD_SNAP_HEAD_NAME,
-			sizeof (RBD_SNAP_HEAD_NAME));
+		buf = RBD_SNAP_HEAD_NAME; /* No snapshot supplied */
+		len = sizeof (RBD_SNAP_HEAD_NAME) - 1;
 	}
+	snap_name = kmalloc(len + 1, GFP_KERNEL);
+	if (!snap_name)
+		goto out_err;
+	memcpy(snap_name, buf, len);
+	*(snap_name + len) = '\0';

-	return 0;
+dout("    SNAP_NAME is <%s>, len is %zd\n", snap_name, len);
+
+	return snap_name;

 out_err:
 	kfree(rbd_dev->header_name);
@@ -2556,7 +2554,7 @@ out_err:
 	kfree(rbd_dev->pool_name);
 	rbd_dev->pool_name = NULL;

-	return ret;
+	return err_ptr;
 }

 static ssize_t rbd_add(struct bus_type *bus,
@@ -2569,6 +2567,7 @@ static ssize_t rbd_add(struct bus_type *bus,
 	size_t mon_addrs_size = 0;
 	struct ceph_osd_client *osdc;
 	int rc = -ENOMEM;
+	char *snap_name;

 	if (!try_module_get(THIS_MODULE))
 		return -ENODEV;
@@ -2595,10 +2594,13 @@ static ssize_t rbd_add(struct bus_type *bus,
 	sprintf(rbd_dev->name, "%s%d", RBD_DRV_NAME, rbd_dev->dev_id);

 	/* parse add command */
-	rc = rbd_add_parse_args(rbd_dev, buf, &mon_addrs, &mon_addrs_size,
-				options, count);
-	if (rc)
+	snap_name = rbd_add_parse_args(rbd_dev, buf,
+				&mon_addrs, &mon_addrs_size, options, count);
+	if (IS_ERR(snap_name)) {
+		rc = PTR_ERR(snap_name);
 		goto err_put_id;
+	}
+	rbd_dev->mapping.snap_name = snap_name;

 	rc = rbd_get_client(rbd_dev, mon_addrs, mon_addrs_size - 1, options);
 	if (rc < 0)
-- 
1.7.9.5

