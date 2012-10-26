From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/2] rbd: move snap info out of rbd_mapping struct
Date: Fri, 26 Oct 2012 17:51:19 -0500
Message-ID: <508B13E7.30401@inktank.com>
References: <508B11E3.3040108@inktank.com> <508B1327.3090008@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:41518 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934127Ab2JZWvW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Oct 2012 18:51:22 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so2573233iag.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Oct 2012 15:51:21 -0700 (PDT)
In-Reply-To: <508B1327.3090008@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Moving the snap_id and snap_name fields into the separate
rbd_mapping structure was misguided.  (And in time, perhaps
we'll do away with that structure altogether...)

Move these fields back into struct rbd_device.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 2a523a1..05525b2 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -166,8 +166,6 @@ struct rbd_snap {
 };

 struct rbd_mapping {
-	char                    *snap_name;
-	u64                     snap_id;
 	u64                     size;
 	u64                     features;
 	bool                    snap_exists;
@@ -199,6 +197,9 @@ struct rbd_device {
 	char			*pool_name;
 	u64			pool_id;

+	char                    *snap_name;
+	u64                     snap_id;
+
 	struct ceph_osd_event   *watch_event;
 	struct ceph_osd_request *watch_request;

@@ -669,7 +670,7 @@ static int snap_by_name(struct rbd_device *rbd_dev,
const char *snap_name)

 	list_for_each_entry(snap, &rbd_dev->snaps, node) {
 		if (!strcmp(snap_name, snap->name)) {
-			rbd_dev->mapping.snap_id = snap->id;
+			rbd_dev->snap_id = snap->id;
 			rbd_dev->mapping.size = snap->size;
 			rbd_dev->mapping.features = snap->features;

@@ -686,7 +687,7 @@ static int rbd_dev_set_mapping(struct rbd_device
*rbd_dev, char *snap_name)

 	if (!memcmp(snap_name, RBD_SNAP_HEAD_NAME,
 		    sizeof (RBD_SNAP_HEAD_NAME))) {
-		rbd_dev->mapping.snap_id = CEPH_NOSNAP;
+		rbd_dev->snap_id = CEPH_NOSNAP;
 		rbd_dev->mapping.size = rbd_dev->header.image_size;
 		rbd_dev->mapping.features = rbd_dev->header.features;
 		rbd_dev->mapping.snap_exists = false;
@@ -698,7 +699,7 @@ static int rbd_dev_set_mapping(struct rbd_device
*rbd_dev, char *snap_name)
 		rbd_dev->mapping.snap_exists = true;
 		rbd_dev->mapping.read_only = true;
 	}
-	rbd_dev->mapping.snap_name = snap_name;
+	rbd_dev->snap_name = snap_name;
 done:
 	return ret;
 }
@@ -1278,7 +1279,7 @@ static int rbd_do_op(struct request *rq,
 		opcode = CEPH_OSD_OP_READ;
 		flags = CEPH_OSD_FLAG_READ;
 		snapc = NULL;
-		snapid = rbd_dev->mapping.snap_id;
+		snapid = rbd_dev->snap_id;
 		payload_len = 0;
 	}

@@ -1561,7 +1562,7 @@ static void rbd_rq_fn(struct request_queue *q)

 		down_read(&rbd_dev->header_rwsem);

-		if (rbd_dev->mapping.snap_id != CEPH_NOSNAP &&
+		if (rbd_dev->snap_id != CEPH_NOSNAP &&
 				!rbd_dev->mapping.snap_exists) {
 			up_read(&rbd_dev->header_rwsem);
 			dout("request for non-existent snapshot");
@@ -1800,7 +1801,7 @@ static void rbd_update_mapping_size(struct
rbd_device *rbd_dev)
 {
 	sector_t size;

-	if (rbd_dev->mapping.snap_id != CEPH_NOSNAP)
+	if (rbd_dev->snap_id != CEPH_NOSNAP)
 		return;

 	size = (sector_t) rbd_dev->header.image_size / SECTOR_SIZE;
@@ -2011,7 +2012,7 @@ static ssize_t rbd_snap_show(struct device *dev,
 {
 	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);

-	return sprintf(buf, "%s\n", rbd_dev->mapping.snap_name);
+	return sprintf(buf, "%s\n", rbd_dev->snap_name);
 }

 static ssize_t rbd_image_refresh(struct device *dev,
@@ -2567,12 +2568,11 @@ static int rbd_dev_snaps_update(struct
rbd_device *rbd_dev)

 			/* Existing snapshot not in the new snap context */

-			if (rbd_dev->mapping.snap_id == snap->id)
+			if (rbd_dev->snap_id == snap->id)
 				rbd_dev->mapping.snap_exists = false;
 			__rbd_remove_snap_dev(snap);
 			dout("%ssnap id %llu has been removed\n",
-				rbd_dev->mapping.snap_id == snap->id ?
-								"mapped " : "",
+				rbd_dev->snap_id == snap->id ?  "mapped " : "",
 				(unsigned long long) snap->id);

 			/* Done with this list entry; advance */
@@ -3256,7 +3256,7 @@ err_out_client:
 	rbd_put_client(rbd_dev);
 	kfree(rbd_dev->image_id);
 err_out_args:
-	kfree(rbd_dev->mapping.snap_name);
+	kfree(rbd_dev->snap_name);
 	kfree(rbd_dev->image_name);
 	kfree(rbd_dev->pool_name);
 err_out_mem:
@@ -3309,7 +3309,7 @@ static void rbd_dev_release(struct device *dev)
 	rbd_header_free(&rbd_dev->header);

 	/* done with the id, and with the rbd_dev */
-	kfree(rbd_dev->mapping.snap_name);
+	kfree(rbd_dev->snap_name);
 	kfree(rbd_dev->image_id);
 	kfree(rbd_dev->header_name);
 	kfree(rbd_dev->pool_name);
-- 
1.7.9.5

