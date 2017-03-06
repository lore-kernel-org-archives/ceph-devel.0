From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] rbd: supported_features bus attribute
Date: Mon,  6 Mar 2017 16:24:05 +0100
Message-ID: <1488813845-4201-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33059 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752797AbdCFPY0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Mar 2017 10:24:26 -0500
Received: by mail-wm0-f65.google.com with SMTP id n11so14318452wma.0
        for <ceph-devel@vger.kernel.org>; Mon, 06 Mar 2017 07:24:25 -0800 (PST)
Received: from localhost.localdomain.com (ip-78-102-108-116.net.upcbroadband.cz. [78.102.108.116])
        by smtp.gmail.com with ESMTPSA id w30sm27355682wrb.5.2017.03.06.07.24.23
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Mar 2017 07:24:24 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

... so that userspace can generate meaningful error messages and spell
out unsupported features that need to be disabled.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4138ed8565c6..8cfbac1e815e 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -120,10 +120,11 @@ static int atomic_dec_return_safe(atomic_t *v)
 
 /* Feature bits */
 
-#define RBD_FEATURE_LAYERING	(1<<0)
-#define RBD_FEATURE_STRIPINGV2	(1<<1)
-#define RBD_FEATURE_EXCLUSIVE_LOCK (1<<2)
-#define RBD_FEATURE_DATA_POOL (1<<7)
+#define RBD_FEATURE_LAYERING		(1ULL<<0)
+#define RBD_FEATURE_STRIPINGV2		(1ULL<<1)
+#define RBD_FEATURE_EXCLUSIVE_LOCK	(1ULL<<2)
+#define RBD_FEATURE_DATA_POOL		(1ULL<<7)
+
 #define RBD_FEATURES_ALL	(RBD_FEATURE_LAYERING |		\
 				 RBD_FEATURE_STRIPINGV2 |	\
 				 RBD_FEATURE_EXCLUSIVE_LOCK |	\
@@ -499,16 +500,23 @@ static bool rbd_is_lock_owner(struct rbd_device *rbd_dev)
 	return is_lock_owner;
 }
 
+static ssize_t rbd_supported_features_show(struct bus_type *bus, char *buf)
+{
+	return sprintf(buf, "0x%llx\n", RBD_FEATURES_SUPPORTED);
+}
+
 static BUS_ATTR(add, S_IWUSR, NULL, rbd_add);
 static BUS_ATTR(remove, S_IWUSR, NULL, rbd_remove);
 static BUS_ATTR(add_single_major, S_IWUSR, NULL, rbd_add_single_major);
 static BUS_ATTR(remove_single_major, S_IWUSR, NULL, rbd_remove_single_major);
+static BUS_ATTR(supported_features, S_IRUGO, rbd_supported_features_show, NULL);
 
 static struct attribute *rbd_bus_attrs[] = {
 	&bus_attr_add.attr,
 	&bus_attr_remove.attr,
 	&bus_attr_add_single_major.attr,
 	&bus_attr_remove_single_major.attr,
+	&bus_attr_supported_features.attr,
 	NULL,
 };
 
-- 
2.4.3

