From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/4] rbd: expand lock protection in rbd_add()
Date: Fri, 07 Sep 2012 09:50:21 -0500
Message-ID: <504A09AD.80905@inktank.com>
References: <504A090F.7000706@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:54481 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932990Ab2IGOuW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 10:50:22 -0400
Received: by mail-ie0-f174.google.com with SMTP id e11so5147910iej.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 07:50:22 -0700 (PDT)
In-Reply-To: <504A090F.7000706@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Expand the region of code in rbd_add() protected by the header
semaphore to include the complete initialization sequence.  It may
not be strictly necessary, but it doesn't hurt.  And with the
upcoming changes to the order of steps here this offers easy
protection.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 214c937..6af09f1 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2553,6 +2553,8 @@ static ssize_t rbd_add(struct bus_type *bus,
 	INIT_LIST_HEAD(&rbd_dev->snaps);
 	init_rwsem(&rbd_dev->header_rwsem);

+	down_write(&rbd_dev->header_rwsem);
+
 	/* generate unique id: find highest unique id, add one */
 	rbd_dev_id_get(rbd_dev);

@@ -2598,18 +2600,17 @@ static ssize_t rbd_add(struct bus_type *bus,
 	/* contact OSD, request size info about the object being mapped */
 	rc = rbd_read_header(rbd_dev, &rbd_dev->header);
 	if (rc)
-		goto err_out_bus;
+		goto err_out_unlock;

-	/* no need to lock here, as rbd_dev is not registered yet */
 	rc = rbd_dev_snap_devs_update(rbd_dev);
 	if (rc)
-		goto err_out_bus;
+		goto err_out_unlock;

-	down_write(&rbd_dev->header_rwsem);
 	rc = rbd_header_set_snap(rbd_dev, snap_name);
-	up_write(&rbd_dev->header_rwsem);
 	if (rc)
-		goto err_out_bus;
+		goto err_out_unlock;
+
+	up_write(&rbd_dev->header_rwsem);

 	/* Set up the blkdev mapping. */

@@ -2630,6 +2631,8 @@ static ssize_t rbd_add(struct bus_type *bus,

 	return count;

+err_out_unlock:
+	up_write(&rbd_dev->header_rwsem);
 err_out_bus:
 	/* this will also clean up rest of rbd_dev stuff */

@@ -2649,6 +2652,7 @@ err_put_id:
 		kfree(rbd_dev->pool_name);
 	}
 	rbd_dev_id_put(rbd_dev);
+	up_write(&rbd_dev->header_rwsem);
 err_nomem:
 	kfree(rbd_dev);
 	kfree(options);
-- 
1.7.9.5

