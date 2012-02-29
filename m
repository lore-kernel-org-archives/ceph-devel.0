From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 1/5] rbd: encapsulate argument parsing for rbd_add()
Date: Tue, 28 Feb 2012 19:59:10 -0800
Message-ID: <4F4DA28E.1090308@dreamhost.com>
References: <4F4DA1EA.3080705@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:40120 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755041Ab2B2D7L (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:59:11 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 299D324318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:59:11 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 1F97B24314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:59:11 -0800 (PST)
In-Reply-To: <4F4DA1EA.3080705@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Move the code that parses the arguments provided to rbd_add() (which
are supplied via /sys/bus/rbd/add) into a separate function.

Also rename the "mon_dev_name" variable in rbd_add() to be
"mon_addrs".   The variable represents a list of one or more
comma-separated monitor IP addresses, each with an optional port
number.  I think "mon_addrs" captures that notion a little better.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  drivers/block/rbd.c |   68 
+++++++++++++++++++++++++++++++-------------------
  1 files changed, 42 insertions(+), 26 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 29bbac1..3731a15 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2219,12 +2219,43 @@ static void rbd_id_put(struct rbd_device *rbd_dev)
  	atomic_cmpxchg(&rbd_id_max, rbd_id, max_id);
  }

+/*
+ * This fills in the pool_name, obj, obj_len, snap_name, obj_len,
+ * rbd_dev, rbd_md_name, and name fields of the given rbd_dev, based
+ * on the list of monitor addresses and other options provided via
+ * /sys/bus/rbd/add.
+ */
+static int rbd_add_parse_args(struct rbd_device *rbd_dev,
+			      const char *buf,
+			      char *mon_addrs,
+			      char *options)
+{
+	if (sscanf(buf, "%" __stringify(RBD_MAX_OPT_LEN) "s "
+		   "%" __stringify(RBD_MAX_OPT_LEN) "s "
+		   "%" __stringify(RBD_MAX_POOL_NAME_LEN) "s "
+		   "%" __stringify(RBD_MAX_OBJ_NAME_LEN) "s"
+		   "%" __stringify(RBD_MAX_SNAP_NAME_LEN) "s",
+		   mon_addrs, options, rbd_dev->pool_name,
+		   rbd_dev->obj, rbd_dev->snap_name) < 4)
+		return -EINVAL;
+
+	if (rbd_dev->snap_name[0] == 0)
+		memcpy(rbd_dev->snap_name, RBD_SNAP_HEAD_NAME,
+			sizeof RBD_SNAP_HEAD_NAME);
+
+	rbd_dev->obj_len = strlen(rbd_dev->obj);
+	snprintf(rbd_dev->obj_md_name, sizeof(rbd_dev->obj_md_name), "%s%s",
+		 rbd_dev->obj, RBD_SUFFIX);
+
+	return 0;
+}
+
  static ssize_t rbd_add(struct bus_type *bus,
  		       const char *buf,
  		       size_t count)
  {
  	struct rbd_device *rbd_dev;
-	char *mon_dev_name = NULL;
+	char *mon_addrs = NULL;
  	char *options = NULL;
  	struct ceph_osd_client *osdc;
  	int rc = -ENOMEM;
@@ -2235,8 +2266,8 @@ static ssize_t rbd_add(struct bus_type *bus,
  	rbd_dev = kzalloc(sizeof(*rbd_dev), GFP_KERNEL);
  	if (!rbd_dev)
  		goto err_nomem;
-	mon_dev_name = kmalloc(count, GFP_KERNEL);
-	if (!mon_dev_name)
+	mon_addrs = kmalloc(count, GFP_KERNEL);
+	if (!mon_addrs)
  		goto err_nomem;
  	options = kmalloc(count, GFP_KERNEL);
  	if (!options)
@@ -2250,30 +2281,15 @@ static ssize_t rbd_add(struct bus_type *bus,
  	/* generate unique id: find highest unique id, add one */
  	rbd_id_get(rbd_dev);

+	/* Fill in the device name, now that we have its id. */
+	snprintf(rbd_dev->name, DEV_NAME_LEN, RBD_DRV_NAME "%d", rbd_dev->id);
+
  	/* parse add command */
-	if (sscanf(buf, "%" __stringify(RBD_MAX_OPT_LEN) "s "
-		   "%" __stringify(RBD_MAX_OPT_LEN) "s "
-		   "%" __stringify(RBD_MAX_POOL_NAME_LEN) "s "
-		   "%" __stringify(RBD_MAX_OBJ_NAME_LEN) "s"
-		   "%" __stringify(RBD_MAX_SNAP_NAME_LEN) "s",
-		   mon_dev_name, options, rbd_dev->pool_name,
-		   rbd_dev->obj, rbd_dev->snap_name) < 4) {
-		rc = -EINVAL;
+	rc = rbd_add_parse_args(rbd_dev, buf, mon_addrs, options);
+	if (rc)
  		goto err_put_id;
-	}
-
-	if (rbd_dev->snap_name[0] == 0)
-		memcpy(rbd_dev->snap_name, RBD_SNAP_HEAD_NAME,
-			sizeof RBD_SNAP_HEAD_NAME);
-
-	rbd_dev->obj_len = strlen(rbd_dev->obj);
-	snprintf(rbd_dev->obj_md_name, sizeof(rbd_dev->obj_md_name), "%s%s",
-		 rbd_dev->obj, RBD_SUFFIX);
-
-	/* initialize rest of new object */
-	snprintf(rbd_dev->name, DEV_NAME_LEN, RBD_DRV_NAME "%d", rbd_dev->id);

-	rbd_dev->rbd_client = rbd_get_client(mon_dev_name, options);
+	rbd_dev->rbd_client = rbd_get_client(mon_addrs, options);
  	if (IS_ERR(rbd_dev->rbd_client)) {
  		rc = PTR_ERR(rbd_dev->rbd_client);
  		goto err_put_id;
@@ -2314,7 +2330,7 @@ err_out_bus:

  	rbd_bus_del_dev(rbd_dev);
  	kfree(options);
-	kfree(mon_dev_name);
+	kfree(mon_addrs);
  	return rc;

  err_out_blkdev:
@@ -2325,7 +2341,7 @@ err_put_id:
  	rbd_id_put(rbd_dev);
  err_nomem:
  	kfree(options);
-	kfree(mon_dev_name);
+	kfree(mon_addrs);
  	kfree(rbd_dev);

  	dout("Error adding device %s\n", buf);
-- 
1.7.5.4

