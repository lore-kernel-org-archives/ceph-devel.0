From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/3] rbd: add an rbd features field
Date: Fri, 07 Sep 2012 14:25:05 -0500
Message-ID: <504A4A11.4050905@inktank.com>
References: <504A498D.30708@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49934 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756733Ab2IGTZI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 15:25:08 -0400
Received: by iahk25 with SMTP id k25so3526991iah.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 12:25:07 -0700 (PDT)
In-Reply-To: <504A498D.30708@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Record the features values for each rbd image and each of its
snapshots.  This is really something that only becomes meaningful
for version 2 images, so this is just putting in place code
that will form common infrastructure.

It may be useful to expand the sysfs entries--and therefore the
information we maintain--for the image and for each snapshot.
But I'm going to hold off doing that until we start making
active use of the feature bits.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 Documentation/ABI/testing/sysfs-bus-rbd |    7 +++++
 drivers/block/rbd.c                     |   43
+++++++++++++++++++++++++++++--
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-rbd
b/Documentation/ABI/testing/sysfs-bus-rbd
index 6fe4224..1cf2adf 100644
--- a/Documentation/ABI/testing/sysfs-bus-rbd
+++ b/Documentation/ABI/testing/sysfs-bus-rbd
@@ -25,6 +25,10 @@ client_id

 	The ceph unique client id that was assigned for this specific session.

+features
+
+	A hexadecimal encoding of the feature bits for this image.
+
 major

 	The block device major number.
@@ -78,4 +82,7 @@ snap_size

 	The size of the image when this snapshot was taken.

+snap_features
+
+	A hexadecimal encoding of the feature bits for this snapshot.

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 2b048e3..c62d3f4 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -85,6 +85,7 @@
 struct rbd_image_header {
 	/* These four fields never change for a given rbd image */
 	char *object_prefix;
+	u64 features;
 	__u8 obj_order;
 	__u8 crypt_type;
 	__u8 comp_type;
@@ -148,12 +149,14 @@ struct rbd_snap {
 	u64			size;
 	struct list_head	node;
 	u64			id;
+	u64			features;
 };

 struct rbd_mapping {
 	char                    *snap_name;
 	u64                     snap_id;
 	u64                     size;
+	u64                     features;
 	bool                    snap_exists;
 	bool			read_only;
 };
@@ -590,6 +593,7 @@ static int rbd_header_from_disk(struct
rbd_image_header *header,
 		header->snap_sizes = NULL;
 	}

+	header->features = 0;	/* No features support in v1 images */
 	header->obj_order = ondisk->options.order;
 	header->crypt_type = ondisk->options.crypt_type;
 	header->comp_type = ondisk->options.comp_type;
@@ -632,6 +636,7 @@ static int snap_by_name(struct rbd_device *rbd_dev,
const char *snap_name)
 		if (!strcmp(snap_name, snap->name)) {
 			rbd_dev->mapping.snap_id = snap->id;
 			rbd_dev->mapping.size = snap->size;
+			rbd_dev->mapping.features = snap->features;

 			return 0;
 		}
@@ -648,6 +653,7 @@ static int rbd_dev_set_mapping(struct rbd_device
*rbd_dev, char *snap_name)
 		    sizeof (RBD_SNAP_HEAD_NAME))) {
 		rbd_dev->mapping.snap_id = CEPH_NOSNAP;
 		rbd_dev->mapping.size = rbd_dev->header.image_size;
+		rbd_dev->mapping.features = rbd_dev->header.features;
 		rbd_dev->mapping.snap_exists = false;
 		rbd_dev->mapping.read_only = rbd_dev->rbd_opts.read_only;
 		ret = 0;
@@ -1835,6 +1841,19 @@ static ssize_t rbd_size_show(struct device *dev,
 	return sprintf(buf, "%llu\n", (unsigned long long) size * SECTOR_SIZE);
 }

+/*
+ * Note this shows the features for whatever's mapped, which is not
+ * necessarily the base image.
+ */
+static ssize_t rbd_features_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);
+
+	return sprintf(buf, "0x%016llx\n",
+			(unsigned long long) rbd_dev->mapping.features);
+}
+
 static ssize_t rbd_major_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
@@ -1884,6 +1903,10 @@ static ssize_t rbd_image_id_show(struct device *dev,
 	return sprintf(buf, "%s\n", rbd_dev->image_id);
 }

+/*
+ * Shows the name of the currently-mapped snapshot (or
+ * RBD_SNAP_HEAD_NAME for the base image).
+ */
 static ssize_t rbd_snap_show(struct device *dev,
 			     struct device_attribute *attr,
 			     char *buf)
@@ -1907,6 +1930,7 @@ static ssize_t rbd_image_refresh(struct device *dev,
 }

 static DEVICE_ATTR(size, S_IRUGO, rbd_size_show, NULL);
+static DEVICE_ATTR(features, S_IRUGO, rbd_features_show, NULL);
 static DEVICE_ATTR(major, S_IRUGO, rbd_major_show, NULL);
 static DEVICE_ATTR(client_id, S_IRUGO, rbd_client_id_show, NULL);
 static DEVICE_ATTR(pool, S_IRUGO, rbd_pool_show, NULL);
@@ -1918,6 +1942,7 @@ static DEVICE_ATTR(current_snap, S_IRUGO,
rbd_snap_show, NULL);

 static struct attribute *rbd_attrs[] = {
 	&dev_attr_size.attr,
+	&dev_attr_features.attr,
 	&dev_attr_major.attr,
 	&dev_attr_client_id.attr,
 	&dev_attr_pool.attr,
@@ -1971,12 +1996,24 @@ static ssize_t rbd_snap_id_show(struct device *dev,
 	return sprintf(buf, "%llu\n", (unsigned long long)snap->id);
 }

+static ssize_t rbd_snap_features_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct rbd_snap *snap = container_of(dev, struct rbd_snap, dev);
+
+	return sprintf(buf, "0x%016llx\n",
+			(unsigned long long) snap->features);
+}
+
 static DEVICE_ATTR(snap_size, S_IRUGO, rbd_snap_size_show, NULL);
 static DEVICE_ATTR(snap_id, S_IRUGO, rbd_snap_id_show, NULL);
+static DEVICE_ATTR(snap_features, S_IRUGO, rbd_snap_features_show, NULL);

 static struct attribute *rbd_snap_attrs[] = {
 	&dev_attr_snap_size.attr,
 	&dev_attr_snap_id.attr,
+	&dev_attr_snap_features.attr,
 	NULL,
 };

@@ -2032,7 +2069,8 @@ static int rbd_register_snap_dev(struct rbd_snap
*snap,

 static struct rbd_snap *__rbd_add_snap_dev(struct rbd_device *rbd_dev,
 						const char *snap_name,
-						u64 snap_id, u64 snap_size)
+						u64 snap_id, u64 snap_size,
+						u64 snap_features)
 {
 	struct rbd_snap *snap;
 	int ret;
@@ -2048,6 +2086,7 @@ static struct rbd_snap *__rbd_add_snap_dev(struct
rbd_device *rbd_dev,

 	snap->id = snap_id;
 	snap->size = snap_size;
+	snap->features = snap_features;

 	return snap;

@@ -2118,7 +2157,7 @@ static int rbd_dev_snaps_update(struct rbd_device
*rbd_dev)
 			/* We haven't seen this snapshot before */

 			new_snap = __rbd_add_snap_dev(rbd_dev, snap_name,
-					snap_id, header->snap_sizes[index]);
+					snap_id, header->snap_sizes[index], 0);
 			if (IS_ERR(new_snap)) {
 				int err = PTR_ERR(new_snap);

-- 
1.7.9.5

