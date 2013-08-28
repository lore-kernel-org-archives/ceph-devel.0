From: <gregkh@linuxfoundation.org>
Subject: patch "rbd: convert bus code to use bus_groups" added to driver-core tree
Date: Tue, 27 Aug 2013 22:32:50 -0700
Message-ID: <13776679701763@kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:44985 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753308Ab3H1Faj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Aug 2013 01:30:39 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: gregkh@linuxfoundation.org, ceph-devel@vger.kernel.org, elder@linaro.org, sage@inktank.com, yehuda@inktank.com


This is a note to let you know that I've just added the patch titled

    rbd: convert bus code to use bus_groups

to my driver-core git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
in the driver-core-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From b15a21dddad552f7e42ae8a7da84de334f6acdcf Mon Sep 17 00:00:00 2001
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 23 Aug 2013 14:24:28 -0700
Subject: rbd: convert bus code to use bus_groups

The bus_attrs field of struct bus_type is going away soon, dev_groups
should be used instead.  This converts the RBD bus code to use the
correct field.

Cc: Yehuda Sadeh <yehuda@inktank.com>
Cc: Sage Weil <sage@inktank.com>
Acked-by: Alex Elder <elder@linaro.org>
Cc: <ceph-devel@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/rbd.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4ad2ad9..191cd17 100644
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
1.8.4.6.g82e253f.dirty


