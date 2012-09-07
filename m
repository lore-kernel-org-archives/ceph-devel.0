From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/5] rbd: define rbd_dev_image_id()
Date: Fri, 07 Sep 2012 13:19:35 -0500
Message-ID: <504A3AB7.2020600@inktank.com>
References: <504A39E0.1040107@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41755 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283Ab2IGSTj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 14:19:39 -0400
Received: by mail-iy0-f174.google.com with SMTP id k25so3471231iah.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 11:19:39 -0700 (PDT)
In-Reply-To: <504A39E0.1040107@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

New format 2 rbd images are permanently identified by a unique image
id.  Each rbd image also has a name, but the name can be changed.
A format 2 rbd image will have an object--whose name is based on the
image name--which maps an image's name to its image id.

Create a new function rbd_dev_image_id() that checks for the
existence of the image id object, and if it's found, records the
image id in the rbd_device structure.

Create a new rbd device attribute (/sys/bus/rbd/<num>/image_id) that
makes this information available.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 Documentation/ABI/testing/sysfs-bus-rbd |    5 ++
 drivers/block/rbd.c                     |   99
+++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-rbd
b/Documentation/ABI/testing/sysfs-bus-rbd
index 3c17b62..7cbbe34 100644
--- a/Documentation/ABI/testing/sysfs-bus-rbd
+++ b/Documentation/ABI/testing/sysfs-bus-rbd
@@ -33,6 +33,11 @@ name

 	The name of the rbd image.

+image_id
+
+	The unique id for the rbd image.  (For rbd image format 1
+	this is empty.)
+
 pool

 	The name of the storage pool where this rbd image resides.
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index ba68566..5a3132e 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -66,6 +66,8 @@

 #define RBD_SNAP_HEAD_NAME	"-"

+#define	RBD_IMAGE_ID_LEN_MAX	64
+
 /*
  * An RBD device name will be "rbd#", where the "rbd" comes from
  * RBD_DRV_NAME above, and # is a unique integer identifier.
@@ -173,6 +175,8 @@ struct rbd_device {
 	spinlock_t		lock;		/* queue lock */

 	struct rbd_image_header	header;
+	char			*image_id;
+	size_t			image_id_len;
 	char			*image_name;
 	size_t			image_name_len;
 	char			*header_name;
@@ -1987,6 +1991,14 @@ static ssize_t rbd_name_show(struct device *dev,
 	return sprintf(buf, "%s\n", rbd_dev->image_name);
 }

+static ssize_t rbd_image_id_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);
+
+	return sprintf(buf, "%s\n", rbd_dev->image_id);
+}
+
 static ssize_t rbd_snap_show(struct device *dev,
 			     struct device_attribute *attr,
 			     char *buf)
@@ -2015,6 +2027,7 @@ static DEVICE_ATTR(client_id, S_IRUGO,
rbd_client_id_show, NULL);
 static DEVICE_ATTR(pool, S_IRUGO, rbd_pool_show, NULL);
 static DEVICE_ATTR(pool_id, S_IRUGO, rbd_pool_id_show, NULL);
 static DEVICE_ATTR(name, S_IRUGO, rbd_name_show, NULL);
+static DEVICE_ATTR(image_id, S_IRUGO, rbd_image_id_show, NULL);
 static DEVICE_ATTR(refresh, S_IWUSR, NULL, rbd_image_refresh);
 static DEVICE_ATTR(current_snap, S_IRUGO, rbd_snap_show, NULL);
 static DEVICE_ATTR(create_snap, S_IWUSR, NULL, rbd_snap_add);
@@ -2026,6 +2039,7 @@ static struct attribute *rbd_attrs[] = {
 	&dev_attr_pool.attr,
 	&dev_attr_pool_id.attr,
 	&dev_attr_name.attr,
+	&dev_attr_image_id.attr,
 	&dev_attr_current_snap.attr,
 	&dev_attr_refresh.attr,
 	&dev_attr_create_snap.attr,
@@ -2548,6 +2562,75 @@ out_err:
 	return err_ptr;
 }

+/*
+ * An rbd format 2 image has a unique identifier, distinct from the
+ * name given to it by the user.  Internally, that identifier is
+ * what's used to specify the names of objects related to the image.
+ *
+ * A special "rbd id" object is used to map an rbd image name to its
+ * id.  If that object doesn't exist, then there is no v2 rbd image
+ * with the supplied name.
+ *
+ * This function will record the given rbd_dev's image_id field if
+ * it can be determined, and in that case will return 0.  If any
+ * errors occur a negative errno will be returned and the rbd_dev's
+ * image_id field will be unchanged (and should be NULL).
+ */
+static int rbd_dev_image_id(struct rbd_device *rbd_dev)
+{
+	int ret;
+	size_t size;
+	char *object_name;
+	void *response;
+	void *p;
+
+	/*
+	 * First, see if the format 2 image id file exists, and if
+	 * so, get the image's persistent id from it.
+	 */
+	size = sizeof (RBD_ID_PREFIX) + rbd_dev->image_name_len;
+	object_name = kmalloc(size, GFP_NOIO);
+	if (!object_name)
+		return -ENOMEM;
+	sprintf(object_name, "%s%s", RBD_ID_PREFIX, rbd_dev->image_name);
+	dout("rbd id object name is %s\n", object_name);
+
+	/* Response will be an encoded string, which includes a length */
+
+	size = sizeof (__le32) + RBD_IMAGE_ID_LEN_MAX;
+	response = kzalloc(size, GFP_NOIO);
+	if (!response) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = rbd_req_sync_exec(rbd_dev, object_name,
+				"rbd", "get_id",
+				NULL, 0,
+				response, RBD_IMAGE_ID_LEN_MAX,
+				CEPH_OSD_FLAG_READ, NULL);
+	dout("%s: rbd_req_sync_exec returned %d\n", __func__, ret);
+	if (ret < 0)
+		goto out;
+	ret = 0;	/* rbd_req_sync_exec() can return positive */
+
+	p = response;
+	rbd_dev->image_id = ceph_extract_encoded_string(&p,
+						p + RBD_IMAGE_ID_LEN_MAX,
+						&rbd_dev->image_id_len,
+						GFP_NOIO);
+	if (IS_ERR(rbd_dev->image_id)) {
+		ret = PTR_ERR(rbd_dev->image_id);
+		rbd_dev->image_id = NULL;
+	} else
+		dout("image_id is %s\n", rbd_dev->image_id);
+out:
+	kfree(response);
+	kfree(object_name);
+
+	return ret;
+}
+
 static ssize_t rbd_add(struct bus_type *bus,
 		       const char *buf,
 		       size_t count)
@@ -2597,6 +2680,20 @@ static ssize_t rbd_add(struct bus_type *bus,
 		goto err_out_client;
 	rbd_dev->pool_id = rc;

+	rc = rbd_dev_image_id(rbd_dev);
+	if (rc == -ENOENT) {
+		/* Version 1 images have no id; empty string is used */
+		rbd_dev->image_id = kstrdup("", GFP_KERNEL);
+		if (!rbd_dev->image_id) {
+			rc = -ENOMEM;
+			goto err_out_client;
+		}
+		rbd_dev->image_id_len = 0;
+	} else {
+	        /* Not actually supporting format 2 yet */
+		goto err_out_client;
+	}
+
 	/* Create the name of the header object */

 	rbd_dev->header_name = kmalloc(rbd_dev->image_name_len
@@ -2688,6 +2785,7 @@ err_out_header:
 err_out_client:
 	kfree(rbd_dev->header_name);
 	rbd_put_client(rbd_dev);
+	kfree(rbd_dev->image_id);
 err_out_args:
 	kfree(rbd_dev->mapping.snap_name);
 	kfree(rbd_dev->image_name);
@@ -2744,6 +2842,7 @@ static void rbd_dev_release(struct device *dev)

 	/* done with the id, and with the rbd_dev */
 	kfree(rbd_dev->mapping.snap_name);
+	kfree(rbd_dev->image_id);
 	kfree(rbd_dev->header_name);
 	kfree(rbd_dev->pool_name);
 	kfree(rbd_dev->image_name);
-- 
1.7.9.5

