From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 13/16] rbd: add 'cluster_fsid' sysfs rbd device attribute
Date: Wed, 24 Aug 2016 15:18:37 +0200
Message-ID: <1472044720-29116-14-git-send-email-idryomov@gmail.com>
References: <1472044720-29116-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36153 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753890AbcHXNT6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2016 09:19:58 -0400
Received: by mail-yw0-f196.google.com with SMTP id u134so786198ywg.3
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 06:19:05 -0700 (PDT)
Received: from dhcp-1-219.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id e197sm5371294ywa.16.2016.08.24.06.19.04
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Aug 2016 06:19:04 -0700 (PDT)
In-Reply-To: <1472044720-29116-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

From: Mike Christie <mchristi@redhat.com>

Export the cluster fsid, so tools like udev and multipath-tools can use
it for part of the uuid.

Signed-off-by: Mike Christie <mchristi@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-rbd |  4 ++++
 drivers/block/rbd.c                     | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-rbd b/Documentation/ABI/testing/sysfs-bus-rbd
index 273e27f2491f..9a655f3f4386 100644
--- a/Documentation/ABI/testing/sysfs-bus-rbd
+++ b/Documentation/ABI/testing/sysfs-bus-rbd
@@ -53,6 +53,10 @@ client_id
 
 	The ceph unique client id that was assigned for this specific session.
 
+cluster_fsid
+
+	The ceph cluster UUID.  (August 2016, since 4.9.)
+
 features
 
 	A hexadecimal encoding of the feature bits for this image.
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 69d76c3afcdd..c95104a80065 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4612,6 +4612,14 @@ static ssize_t rbd_client_id_show(struct device *dev,
 		       ceph_client_gid(rbd_dev->rbd_client->client));
 }
 
+static ssize_t rbd_cluster_fsid_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);
+
+	return sprintf(buf, "%pU\n", &rbd_dev->rbd_client->client->fsid);
+}
+
 static ssize_t rbd_pool_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
@@ -4715,6 +4723,7 @@ static DEVICE_ATTR(major, S_IRUGO, rbd_major_show, NULL);
 static DEVICE_ATTR(minor, S_IRUGO, rbd_minor_show, NULL);
 static DEVICE_ATTR(client_addr, S_IRUGO, rbd_client_addr_show, NULL);
 static DEVICE_ATTR(client_id, S_IRUGO, rbd_client_id_show, NULL);
+static DEVICE_ATTR(cluster_fsid, S_IRUGO, rbd_cluster_fsid_show, NULL);
 static DEVICE_ATTR(pool, S_IRUGO, rbd_pool_show, NULL);
 static DEVICE_ATTR(pool_id, S_IRUGO, rbd_pool_id_show, NULL);
 static DEVICE_ATTR(name, S_IRUGO, rbd_name_show, NULL);
@@ -4730,6 +4739,7 @@ static struct attribute *rbd_attrs[] = {
 	&dev_attr_minor.attr,
 	&dev_attr_client_addr.attr,
 	&dev_attr_client_id.attr,
+	&dev_attr_cluster_fsid.attr,
 	&dev_attr_pool.attr,
 	&dev_attr_pool_id.attr,
 	&dev_attr_name.attr,
-- 
2.4.3

