From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/9] rbd: read the header before registering device
Date: Fri, 07 Sep 2012 10:44:52 -0500
Message-ID: <504A1674.70407@inktank.com>
References: <504A152E.4000905@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36790 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854Ab2IGPo4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 11:44:56 -0400
Received: by mail-iy0-f174.google.com with SMTP id k25so3327563iah.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 08:44:56 -0700 (PDT)
In-Reply-To: <504A152E.4000905@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Read the rbd header information and call rbd_dev_set_mapping()
earlier--before registering the block device or setting up the sysfs
entries for the image.  The sysfs entries provide users access to
some information that's only available after doing the rbd header
initialization, so this will make sure it's valid right away.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index d60db25..89d8ed7 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2598,10 +2598,24 @@ static ssize_t rbd_add(struct bus_type *bus,
 		goto err_out_client;
 	sprintf(rbd_dev->header_name, "%s%s", rbd_dev->image_name, RBD_SUFFIX);

+	/* Get information about the image being mapped */
+
+	rc = rbd_read_header(rbd_dev, &rbd_dev->header);
+	if (rc)
+		goto err_out_client;
+
+	rc = rbd_dev_snaps_update(rbd_dev);
+	if (rc)
+		goto err_out_header;
+
+	rc = rbd_dev_set_mapping(rbd_dev, snap_name);
+	if (rc)
+		goto err_out_header;
+
 	/* register our block device */
 	rc = register_blkdev(0, rbd_dev->name);
 	if (rc < 0)
-		goto err_out_client;
+		goto err_out_header;
 	rbd_dev->major = rc;

 	rc = rbd_bus_add_dev(rbd_dev);
@@ -2613,19 +2627,6 @@ static ssize_t rbd_add(struct bus_type *bus,
 	 * of the sysfs code (initiated by rbd_bus_del_dev()).
 	 */

-	/* contact OSD, request size info about the object being mapped */
-	rc = rbd_read_header(rbd_dev, &rbd_dev->header);
-	if (rc)
-		goto err_out_unlock;
-
-	rc = rbd_dev_snaps_update(rbd_dev);
-	if (rc)
-		goto err_out_unlock;
-
-	rc = rbd_dev_set_mapping(rbd_dev, snap_name);
-	if (rc)
-		goto err_out_unlock;
-
 	rc = rbd_dev_snaps_register(rbd_dev);
 	if (rc)
 		goto err_out_unlock;
@@ -2662,6 +2663,8 @@ err_out_bus:

 err_out_blkdev:
 	unregister_blkdev(rbd_dev->major, rbd_dev->name);
+err_out_header:
+	rbd_header_free(&rbd_dev->header);
 err_out_client:
 	kfree(rbd_dev->header_name);
 	rbd_put_client(rbd_dev);
-- 
1.7.9.5

