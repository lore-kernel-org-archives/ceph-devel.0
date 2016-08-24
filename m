From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 15/16] rbd: add 'config_info' sysfs rbd device attribute
Date: Wed, 24 Aug 2016 15:18:39 +0200
Message-ID: <1472044720-29116-16-git-send-email-idryomov@gmail.com>
References: <1472044720-29116-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35679 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754086AbcHXNT6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2016 09:19:58 -0400
Received: by mail-yw0-f196.google.com with SMTP id r9so789608ywg.2
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 06:19:08 -0700 (PDT)
Received: from dhcp-1-219.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id e197sm5371294ywa.16.2016.08.24.06.19.06
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Aug 2016 06:19:07 -0700 (PDT)
In-Reply-To: <1472044720-29116-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

From: Mike Christie <mchristi@redhat.com>

Export the info used to setup the rbd image, so it can be used to remap
the image.

Signed-off-by: Mike Christie <mchristi@redhat.com>
[idryomov@gmail.com: do_rbd_add() EH]
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-rbd |  5 +++++
 drivers/block/rbd.c                     | 23 +++++++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-rbd b/Documentation/ABI/testing/sysfs-bus-rbd
index 7bf8d4fa6f63..6dccbf82fcf4 100644
--- a/Documentation/ABI/testing/sysfs-bus-rbd
+++ b/Documentation/ABI/testing/sysfs-bus-rbd
@@ -57,6 +57,11 @@ cluster_fsid
 
 	The ceph cluster UUID.  (August 2016, since 4.9.)
 
+config_info
+
+	The string written into /sys/bus/rbd/add{,_single_major}.  (August
+	2016, since 4.9.)
+
 features
 
 	A hexadecimal encoding of the feature bits for this image.
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 36ebec19dc20..8ff2dc872008 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -370,6 +370,7 @@ struct rbd_device {
 	unsigned long		flags;		/* possibly lock protected */
 	struct rbd_spec		*spec;
 	struct rbd_options	*opts;
+	char			*config_info;	/* add{,_single_major} string */
 
 	struct ceph_object_id	header_oid;
 	struct ceph_object_locator header_oloc;
@@ -4620,6 +4621,14 @@ static ssize_t rbd_cluster_fsid_show(struct device *dev,
 	return sprintf(buf, "%pU\n", &rbd_dev->rbd_client->client->fsid);
 }
 
+static ssize_t rbd_config_info_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);
+
+	return sprintf(buf, "%s\n", rbd_dev->config_info);
+}
+
 static ssize_t rbd_pool_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
@@ -4732,6 +4741,7 @@ static DEVICE_ATTR(minor, S_IRUGO, rbd_minor_show, NULL);
 static DEVICE_ATTR(client_addr, S_IRUGO, rbd_client_addr_show, NULL);
 static DEVICE_ATTR(client_id, S_IRUGO, rbd_client_id_show, NULL);
 static DEVICE_ATTR(cluster_fsid, S_IRUGO, rbd_cluster_fsid_show, NULL);
+static DEVICE_ATTR(config_info, S_IRUSR, rbd_config_info_show, NULL);
 static DEVICE_ATTR(pool, S_IRUGO, rbd_pool_show, NULL);
 static DEVICE_ATTR(pool_id, S_IRUGO, rbd_pool_id_show, NULL);
 static DEVICE_ATTR(name, S_IRUGO, rbd_name_show, NULL);
@@ -4749,6 +4759,7 @@ static struct attribute *rbd_attrs[] = {
 	&dev_attr_client_addr.attr,
 	&dev_attr_client_id.attr,
 	&dev_attr_cluster_fsid.attr,
+	&dev_attr_config_info.attr,
 	&dev_attr_pool.attr,
 	&dev_attr_pool_id.attr,
 	&dev_attr_name.attr,
@@ -4824,6 +4835,7 @@ static void rbd_dev_free(struct rbd_device *rbd_dev)
 
 	ceph_oid_destroy(&rbd_dev->header_oid);
 	ceph_oloc_destroy(&rbd_dev->header_oloc);
+	kfree(rbd_dev->config_info);
 
 	rbd_put_client(rbd_dev->rbd_client);
 	rbd_spec_put(rbd_dev->spec);
@@ -6223,10 +6235,18 @@ static ssize_t do_rbd_add(struct bus_type *bus,
 	spec = NULL;		/* rbd_dev now owns this */
 	rbd_opts = NULL;	/* rbd_dev now owns this */
 
+	rbd_dev->config_info = kstrdup(buf, GFP_KERNEL);
+	if (!rbd_dev->config_info) {
+		rc = -ENOMEM;
+		goto err_out_rbd_dev;
+	}
+
 	down_write(&rbd_dev->header_rwsem);
 	rc = rbd_dev_image_probe(rbd_dev, 0);
-	if (rc < 0)
+	if (rc < 0) {
+		up_write(&rbd_dev->header_rwsem);
 		goto err_out_rbd_dev;
+	}
 
 	/* If we are mapping a snapshot it must be marked read-only */
 
@@ -6253,7 +6273,6 @@ out:
 	return rc;
 
 err_out_rbd_dev:
-	up_write(&rbd_dev->header_rwsem);
 	rbd_dev_destroy(rbd_dev);
 err_out_client:
 	rbd_put_client(rbdc);
-- 
2.4.3

