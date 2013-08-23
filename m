From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 02/15] rbd: convert bus code to use bus_groups
Date: Fri, 23 Aug 2013 14:24:28 -0700
Message-ID: <1377293081-10957-2-git-send-email-gregkh@linuxfoundation.org>
References: <1377293081-10957-1-git-send-email-gregkh@linuxfoundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1377293081-10957-1-git-send-email-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yehuda Sadeh <yehuda@inktank.com>, Sage Weil <sage@inktank.com>, Alex Elder <elder@inktank.com>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

The bus_attrs field of struct bus_type is going away soon, dev_groups
should be used instead.  This converts the RBD bus code to use the
correct field.

Cc: Yehuda Sadeh <yehuda@inktank.com>
Cc: Sage Weil <sage@inktank.com>
Cc: Alex Elder <elder@inktank.com>
Cc: <ceph-devel@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/rbd.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4ad2ad9a..191cd177 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -397,15 +397,19 @@ static ssize_t rbd_remove(struct bus_type *bus, const char *buf,
 static int rbd_dev_image_probe(struct rbd_device *rbd_dev, bool mapping);
 static void rbd_spec_put(struct rbd_spec *spec);
 
-static struct bus_attribute rbd_bus_attrs[] = {
-	__ATTR(add, S_IWUSR, NULL, rbd_add),
-	__ATTR(remove, S_IWUSR, NULL, rbd_remove),
-	__ATTR_NULL
+static BUS_ATTR(add, S_IWUSR, NULL, rbd_add);
+static BUS_ATTR(remove, S_IWUSR, NULL, rbd_remove);
+
+static struct attribute *rbd_bus_attrs[] = {
+	&bus_attr_add.attr,
+	&bus_attr_remove.attr,
+	NULL,
 };
+ATTRIBUTE_GROUPS(rbd_bus);
 
 static struct bus_type rbd_bus_type = {
 	.name		= "rbd",
-	.bus_attrs	= rbd_bus_attrs,
+	.bus_groups	= rbd_bus_groups,
 };
 
 static void rbd_root_dev_release(struct device *dev)
-- 
1.8.3.rc0.20.gb99dd2e
