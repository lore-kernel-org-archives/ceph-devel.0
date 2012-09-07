From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/9]  rbd: assign header name later
Date: Fri, 07 Sep 2012 10:44:19 -0500
Message-ID: <504A1653.7020609@inktank.com>
References: <504A152E.4000905@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:63393 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854Ab2IGPo1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 11:44:27 -0400
Received: by ieje11 with SMTP id e11so5261193iej.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 08:44:27 -0700 (PDT)
In-Reply-To: <504A152E.4000905@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Move the assignment of the header name for an rbd image a bit later,
outside rbd_add_parse_args() and into its caller.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4dff92f..14034e3 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2475,15 +2475,6 @@ static char *rbd_add_parse_args(struct rbd_device
*rbd_dev,
 	if (!rbd_dev->image_name)
 		goto out_err;

-	/* Create the name of the header object */
-
-	rbd_dev->header_name = kmalloc(rbd_dev->image_name_len
-						+ sizeof (RBD_SUFFIX),
-					GFP_KERNEL);
-	if (!rbd_dev->header_name)
-		goto out_err;
-	sprintf(rbd_dev->header_name, "%s%s", rbd_dev->image_name, RBD_SUFFIX);
-
 	/* Snapshot name is optional */
 	len = next_token(&buf);
 	if (!len) {
@@ -2501,8 +2492,6 @@ dout("    SNAP_NAME is <%s>, len is %zd\n",
snap_name, len);
 	return snap_name;

 out_err:
-	kfree(rbd_dev->header_name);
-	rbd_dev->header_name = NULL;
 	kfree(rbd_dev->image_name);
 	rbd_dev->image_name = NULL;
 	rbd_dev->image_name_len = 0;
@@ -2569,6 +2558,15 @@ static ssize_t rbd_add(struct bus_type *bus,
 		goto err_out_client;
 	rbd_dev->pool_id = rc;

+	/* Create the name of the header object */
+
+	rbd_dev->header_name = kmalloc(rbd_dev->image_name_len
+						+ sizeof (RBD_SUFFIX),
+					GFP_KERNEL);
+	if (!rbd_dev->header_name)
+		goto err_out_client;
+	sprintf(rbd_dev->header_name, "%s%s", rbd_dev->image_name, RBD_SUFFIX);
+
 	/* register our block device */
 	rc = register_blkdev(0, rbd_dev->name);
 	if (rc < 0)
@@ -2630,11 +2628,11 @@ err_out_bus:
 err_out_blkdev:
 	unregister_blkdev(rbd_dev->major, rbd_dev->name);
 err_out_client:
+	kfree(rbd_dev->header_name);
 	rbd_put_client(rbd_dev);
 err_put_id:
 	if (rbd_dev->pool_name) {
 		kfree(rbd_dev->mapping.snap_name);
-		kfree(rbd_dev->header_name);
 		kfree(rbd_dev->image_name);
 		kfree(rbd_dev->pool_name);
 	}
-- 
1.7.9.5

