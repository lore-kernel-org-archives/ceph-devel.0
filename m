From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: create pool_id device attribute
Date: Thu, 12 Jul 2012 12:05:20 -0500
Message-ID: <4FFF03D0.2010604@inktank.com>
References: <4FFD847C.7070205@inktank.com> <4FFD875B.3060608@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:37636 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932521Ab2GLRFW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jul 2012 13:05:22 -0400
Received: by mail-yx0-f174.google.com with SMTP id l2so2639200yen.19
        for <ceph-devel@vger.kernel.org>; Thu, 12 Jul 2012 10:05:22 -0700 (PDT)
In-Reply-To: <4FFD875B.3060608@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Add an entry under /sys/bus/rbd/devices/<N>/ named "pool_id" that
provides the id for the pool the rbd image is assocatied with.  This
is in addition to the pool name already provided.

Rename the "poolid" field in struct rbd_device  to be "pool_id".

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

Index: b/drivers/block/rbd.c
===================================================================
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -167,7 +167,7 @@ struct rbd_device {
 	int			obj_len;
 	char			obj_md_name[RBD_MAX_MD_NAME_LEN]; /* hdr nm. */
 	char			pool_name[RBD_MAX_POOL_NAME_LEN];
-	int			poolid;
+	int			pool_id;

 	struct ceph_osd_event   *watch_event;
 	struct ceph_osd_request *watch_request;
@@ -920,7 +920,7 @@ static int rbd_do_request(struct request
 	layout->fl_stripe_unit = cpu_to_le32(1 << RBD_MAX_OBJ_ORDER);
 	layout->fl_stripe_count = cpu_to_le32(1);
 	layout->fl_object_size = cpu_to_le32(1 << RBD_MAX_OBJ_ORDER);
-	layout->fl_pg_pool = cpu_to_le32(dev->poolid);
+	layout->fl_pg_pool = cpu_to_le32(dev->pool_id);
 	ceph_calc_raw_layout(osdc, layout, snapid, ofs, &len, &bno,
 				req, ops);

@@ -1643,7 +1643,7 @@ static int rbd_header_add_snap(struct rb
 		return -EINVAL;

 	monc = &dev->rbd_client->client->monc;
-	ret = ceph_monc_create_snapid(monc, dev->poolid, &new_snapid);
+	ret = ceph_monc_create_snapid(monc, dev->pool_id, &new_snapid);
 	dout("created snapid=%lld\n", new_snapid);
 	if (ret < 0)
 		return ret;
@@ -1847,6 +1847,14 @@ static ssize_t rbd_pool_show(struct devi
 	return sprintf(buf, "%s\n", rbd_dev->pool_name);
 }

+static ssize_t rbd_pool_id_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);
+
+	return sprintf(buf, "%d\n", rbd_dev->pool_id);
+}
+
 static ssize_t rbd_name_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
@@ -1887,6 +1895,7 @@ static DEVICE_ATTR(size, S_IRUGO, rbd_si
 static DEVICE_ATTR(major, S_IRUGO, rbd_major_show, NULL);
 static DEVICE_ATTR(client_id, S_IRUGO, rbd_client_id_show, NULL);
 static DEVICE_ATTR(pool, S_IRUGO, rbd_pool_show, NULL);
+static DEVICE_ATTR(pool_id, S_IRUGO, rbd_pool_id_show, NULL);
 static DEVICE_ATTR(name, S_IRUGO, rbd_name_show, NULL);
 static DEVICE_ATTR(refresh, S_IWUSR, NULL, rbd_image_refresh);
 static DEVICE_ATTR(current_snap, S_IRUGO, rbd_snap_show, NULL);
@@ -1897,6 +1906,7 @@ static struct attribute *rbd_attrs[] = {
 	&dev_attr_major.attr,
 	&dev_attr_client_id.attr,
 	&dev_attr_pool.attr,
+	&dev_attr_pool_id.attr,
 	&dev_attr_name.attr,
 	&dev_attr_current_snap.attr,
 	&dev_attr_refresh.attr,
@@ -2430,7 +2440,7 @@ static ssize_t rbd_add(struct bus_type *
 	rc = ceph_pg_poolid_by_name(osdc->osdmap, rbd_dev->pool_name);
 	if (rc < 0)
 		goto err_out_client;
-	rbd_dev->poolid = rc;
+	rbd_dev->pool_id = rc;

 	/* register our block device */
 	rc = register_blkdev(0, rbd_dev->name);
