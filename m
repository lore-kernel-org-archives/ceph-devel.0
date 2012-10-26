From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/2] rbd: rename snap_exists field
Date: Fri, 26 Oct 2012 17:51:38 -0500
Message-ID: <508B13FA.7060407@inktank.com>
References: <508B11E3.3040108@inktank.com> <508B1327.3090008@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:41518 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934127Ab2JZWvq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Oct 2012 18:51:46 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so2573233iag.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Oct 2012 15:51:46 -0700 (PDT)
In-Reply-To: <508B1327.3090008@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

A Boolean field "snap_exists" in an rbd mapping is used to indicate
whether a mapped snapshot has been removed from an image's snapshot
context, to stop sending requests for that snapshot as soon as we
know it's gone.

Generalize the interpretation of this field so it applies to
non-snapshot (i.e. "head") mappings.  That is, define its value
to be false until the mapping has been set, and then define it to be
true for both snapshot mappings or head mappings.

Rename the field "exists" to reflect the broader interpretation.
The rbd_mapping structure is on its way out, so move the field
back into the rbd_device structure.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 05525b2..fb44d4d 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -168,7 +168,6 @@ struct rbd_snap {
 struct rbd_mapping {
 	u64                     size;
 	u64                     features;
-	bool                    snap_exists;
 	bool			read_only;
 };

@@ -189,6 +188,7 @@ struct rbd_device {
 	spinlock_t		lock;		/* queue lock */

 	struct rbd_image_header	header;
+	bool                    exists;
 	char			*image_id;
 	size_t			image_id_len;
 	char			*image_name;
@@ -690,16 +690,15 @@ static int rbd_dev_set_mapping(struct rbd_device
*rbd_dev, char *snap_name)
 		rbd_dev->snap_id = CEPH_NOSNAP;
 		rbd_dev->mapping.size = rbd_dev->header.image_size;
 		rbd_dev->mapping.features = rbd_dev->header.features;
-		rbd_dev->mapping.snap_exists = false;
 		ret = 0;
 	} else {
 		ret = snap_by_name(rbd_dev, snap_name);
 		if (ret < 0)
 			goto done;
-		rbd_dev->mapping.snap_exists = true;
 		rbd_dev->mapping.read_only = true;
 	}
 	rbd_dev->snap_name = snap_name;
+	rbd_dev->exists = true;
 done:
 	return ret;
 }
@@ -1562,8 +1561,8 @@ static void rbd_rq_fn(struct request_queue *q)

 		down_read(&rbd_dev->header_rwsem);

-		if (rbd_dev->snap_id != CEPH_NOSNAP &&
-				!rbd_dev->mapping.snap_exists) {
+		if (!rbd_dev->exists) {
+			rbd_assert(rbd_dev->snap_id != CEPH_NOSNAP);
 			up_read(&rbd_dev->header_rwsem);
 			dout("request for non-existent snapshot");
 			spin_lock_irq(q->queue_lock);
@@ -2569,7 +2568,7 @@ static int rbd_dev_snaps_update(struct rbd_device
*rbd_dev)
 			/* Existing snapshot not in the new snap context */

 			if (rbd_dev->snap_id == snap->id)
-				rbd_dev->mapping.snap_exists = false;
+				rbd_dev->exists = false;
 			__rbd_remove_snap_dev(snap);
 			dout("%ssnap id %llu has been removed\n",
 				rbd_dev->snap_id == snap->id ?  "mapped " : "",
-- 
1.7.9.5

