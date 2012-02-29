From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 3/5] rbd: do a few checks at build time
Date: Tue, 28 Feb 2012 19:59:16 -0800
Message-ID: <4F4DA294.7050008@dreamhost.com>
References: <4F4DA1EA.3080705@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:40137 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470Ab2B2D7R (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:59:17 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id C674324318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:59:16 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id BAEE924314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:59:16 -0800 (PST)
In-Reply-To: <4F4DA1EA.3080705@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is a bit gratuitous, but there are a few things that can be
verified at build time rather than run time, so do that.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  drivers/block/rbd.c |   15 ++++++++++++---
  1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index d2157a7..0602ed9 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -53,7 +53,14 @@

  #define RBD_SNAP_HEAD_NAME	"-"

+/*
+ * An RBD device name will be "rbd#", where the "rbd" comes from
+ * RBD_DRV_NAME above, and # is a unique integer identifier.
+ * MAX_INT_FORMAT_WIDTH is used in ensuring DEV_NAME_LEN is big
+ * enough to hold all possible device names.
+ */
  #define DEV_NAME_LEN		32
+#define MAX_INT_FORMAT_WIDTH	((5 * sizeof (int)) / 2 + 1)

  #define RBD_NOTIFY_TIMEOUT_DEFAULT 10

@@ -2303,8 +2310,9 @@ static int rbd_add_parse_args(struct rbd_device 
*rbd_dev,

  	rbd_dev->obj_len = len;

-	snprintf(rbd_dev->obj_md_name, sizeof(rbd_dev->obj_md_name), "%s%s",
-		 rbd_dev->obj, RBD_SUFFIX);
+	BUILD_BUG_ON(RBD_MAX_MD_NAME_LEN
+				< RBD_MAX_OBJ_NAME_LEN + sizeof RBD_SUFFIX);
+	sprintf(rbd_dev->obj_md_name, "%s%s", rbd_dev->obj, RBD_SUFFIX);

  	/*
  	 * The snapshot name is optional, but it's an error if it's
@@ -2352,7 +2360,8 @@ static ssize_t rbd_add(struct bus_type *bus,
  	rbd_id_get(rbd_dev);

  	/* Fill in the device name, now that we have its id. */
-	snprintf(rbd_dev->name, DEV_NAME_LEN, RBD_DRV_NAME "%d", rbd_dev->id);
+	BUILD_BUG_ON(DEV_NAME_LEN < sizeof RBD_DRV_NAME + MAX_INT_FORMAT_WIDTH);
+	sprintf(rbd_dev->name, "%s%d", RBD_DRV_NAME, rbd_dev->id);

  	/* parse add command */
  	rc = rbd_add_parse_args(rbd_dev, buf, mon_addrs, count,
-- 
1.7.5.4

