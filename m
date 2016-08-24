From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 12/16] rbd: add 'client_addr' sysfs rbd device attribute
Date: Wed, 24 Aug 2016 15:18:36 +0200
Message-ID: <1472044720-29116-13-git-send-email-idryomov@gmail.com>
References: <1472044720-29116-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35670 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753889AbcHXNT6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2016 09:19:58 -0400
Received: by mail-yw0-f195.google.com with SMTP id r9so789553ywg.2
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 06:19:04 -0700 (PDT)
Received: from dhcp-1-219.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id e197sm5371294ywa.16.2016.08.24.06.19.03
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Aug 2016 06:19:03 -0700 (PDT)
In-Reply-To: <1472044720-29116-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Export client addr/nonce, so userspace can check if a image is being
blacklisted.

Signed-off-by: Mike Christie <mchristi@redhat.com>
[idryomov@gmail.com: ceph_client_addr(), endianess fix]
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-rbd |  6 ++++++
 drivers/block/rbd.c                     | 13 +++++++++++++
 include/linux/ceph/libceph.h            |  1 +
 net/ceph/ceph_common.c                  |  6 ++++++
 4 files changed, 26 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-rbd b/Documentation/ABI/testing/sysfs-bus-rbd
index 2ddd680929d8..273e27f2491f 100644
--- a/Documentation/ABI/testing/sysfs-bus-rbd
+++ b/Documentation/ABI/testing/sysfs-bus-rbd
@@ -43,6 +43,12 @@ Description:	Available only if rbd module is inserted with single_major
 Entries under /sys/bus/rbd/devices/<dev-id>/
 --------------------------------------------
 
+client_addr
+
+	The ceph unique client entity_addr_t (address + nonce).
+	The format is <address>:<port>/<nonce>: '1.2.3.4:1234/5678' or
+	'[1:2:3:4:5:6:7:8]:1234/5678'.  (August 2016, since 4.9.)
+
 client_id
 
 	The ceph unique client id that was assigned for this specific session.
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index fd1a9891b348..69d76c3afcdd 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4592,6 +4592,17 @@ static ssize_t rbd_minor_show(struct device *dev,
 	return sprintf(buf, "%d\n", rbd_dev->minor);
 }
 
+static ssize_t rbd_client_addr_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);
+	struct ceph_entity_addr *client_addr =
+	    ceph_client_addr(rbd_dev->rbd_client->client);
+
+	return sprintf(buf, "%pISpc/%u\n", &client_addr->in_addr,
+		       le32_to_cpu(client_addr->nonce));
+}
+
 static ssize_t rbd_client_id_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
@@ -4702,6 +4713,7 @@ static DEVICE_ATTR(size, S_IRUGO, rbd_size_show, NULL);
 static DEVICE_ATTR(features, S_IRUGO, rbd_features_show, NULL);
 static DEVICE_ATTR(major, S_IRUGO, rbd_major_show, NULL);
 static DEVICE_ATTR(minor, S_IRUGO, rbd_minor_show, NULL);
+static DEVICE_ATTR(client_addr, S_IRUGO, rbd_client_addr_show, NULL);
 static DEVICE_ATTR(client_id, S_IRUGO, rbd_client_id_show, NULL);
 static DEVICE_ATTR(pool, S_IRUGO, rbd_pool_show, NULL);
 static DEVICE_ATTR(pool_id, S_IRUGO, rbd_pool_id_show, NULL);
@@ -4716,6 +4728,7 @@ static struct attribute *rbd_attrs[] = {
 	&dev_attr_features.attr,
 	&dev_attr_major.attr,
 	&dev_attr_minor.attr,
+	&dev_attr_client_addr.attr,
 	&dev_attr_client_id.attr,
 	&dev_attr_pool.attr,
 	&dev_attr_pool_id.attr,
diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index b4cffff70e44..1816c5e26581 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -264,6 +264,7 @@ extern struct ceph_client *ceph_create_client(struct ceph_options *opt,
 					      void *private,
 					      u64 supported_features,
 					      u64 required_features);
+struct ceph_entity_addr *ceph_client_addr(struct ceph_client *client);
 u64 ceph_client_gid(struct ceph_client *client);
 extern void ceph_destroy_client(struct ceph_client *client);
 extern int __ceph_open_session(struct ceph_client *client,
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 8a7921767308..464e88599b9d 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -566,6 +566,12 @@ int ceph_print_client_options(struct seq_file *m, struct ceph_client *client)
 }
 EXPORT_SYMBOL(ceph_print_client_options);
 
+struct ceph_entity_addr *ceph_client_addr(struct ceph_client *client)
+{
+	return &client->msgr.inst.addr;
+}
+EXPORT_SYMBOL(ceph_client_addr);
+
 u64 ceph_client_gid(struct ceph_client *client)
 {
 	return client->monc.auth->global_id;
-- 
2.4.3

