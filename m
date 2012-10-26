From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: remove snapshots on error in rbd_add()
Date: Fri, 26 Oct 2012 17:45:00 -0500
Message-ID: <508B126C.8060200@inktank.com>
References: <508B11E3.3040108@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:54899 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757732Ab2JZWpI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Oct 2012 18:45:08 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so2570229iag.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Oct 2012 15:45:07 -0700 (PDT)
In-Reply-To: <508B11E3.3040108@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

If rbd_dev_snaps_update() has ever been called for an rbd device
structure there could be snapshot structures on its snaps list.
In rbd_add(), this function is called but a subsequent error
path neglected to clean up any of these snapshots.

Add a call to rbd_remove_all_snaps() in the appropriate spot to
remedy this.  Change a couple of error labels to be a little
clearer while there.

And drop the leading underscorse from the function name; there's
nothing special about that function that they might signify.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index cc06c55..147c8df 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1787,7 +1787,7 @@ static int rbd_read_header(struct rbd_device *rbd_dev,
 	return ret;
 }

-static void __rbd_remove_all_snaps(struct rbd_device *rbd_dev)
+static void rbd_remove_all_snaps(struct rbd_device *rbd_dev)
 {
 	struct rbd_snap *snap;
 	struct rbd_snap *next;
@@ -3179,11 +3179,11 @@ static ssize_t rbd_add(struct bus_type *bus,
 	/* no need to lock here, as rbd_dev is not registered yet */
 	rc = rbd_dev_snaps_update(rbd_dev);
 	if (rc)
-		goto err_out_header;
+		goto err_out_probe;

 	rc = rbd_dev_set_mapping(rbd_dev, snap_name);
 	if (rc)
-		goto err_out_header;
+		goto err_out_snaps;

 	/* generate unique id: find highest unique id, add one */
 	rbd_dev_id_get(rbd_dev);
@@ -3247,7 +3247,9 @@ err_out_blkdev:
 	unregister_blkdev(rbd_dev->major, rbd_dev->name);
 err_out_id:
 	rbd_dev_id_put(rbd_dev);
-err_out_header:
+err_out_snaps:
+	rbd_remove_all_snaps(rbd_dev);
+err_out_probe:
 	rbd_header_free(&rbd_dev->header);
 err_out_client:
 	kfree(rbd_dev->header_name);
@@ -3345,7 +3347,7 @@ static ssize_t rbd_remove(struct bus_type *bus,
 		goto done;
 	}

-	__rbd_remove_all_snaps(rbd_dev);
+	rbd_remove_all_snaps(rbd_dev);
 	rbd_bus_del_dev(rbd_dev);

 done:
-- 
1.7.9.5

