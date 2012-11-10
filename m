From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/2] rbd: only get snap context for write requests
Date: Fri, 09 Nov 2012 21:06:39 -0600
Message-ID: <509DC4BF.7080405@inktank.com>
References: <509DC473.805@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:52173 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036Ab2KJDGl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Nov 2012 22:06:41 -0500
Received: by mail-ia0-f174.google.com with SMTP id y32so3202533iag.19
        for <ceph-devel@vger.kernel.org>; Fri, 09 Nov 2012 19:06:41 -0800 (PST)
In-Reply-To: <509DC473.805@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Right now we get and release the header semaphore every time we
process a request for an rbd image.  We do this because for write
requests we need to supply the snapshot context, and we can't
safely get a reference to it without holding that semaphore.

There's no need to get the snap context if we're doing a read,
so avoid doing so in that case.

The rbd_device->exists field can be updated asynchronously, changing
from set to clear if a mapped snapshot disappears from the base
image's snapshot context.  Although I don't think synchronizing
access to this carefully is that critical, it is converted here to
be an atomic variable so a request is aware the flag is clear as
soon as that is known.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b86f5e5..bac4304 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -229,7 +229,7 @@ struct rbd_device {
 	spinlock_t		lock;		/* queue lock */

 	struct rbd_image_header	header;
-	bool                    exists;
+	atomic_t		exists;
 	struct rbd_spec		*spec;

 	char			*header_name;
@@ -753,7 +753,7 @@ static int rbd_dev_set_mapping(struct rbd_device
*rbd_dev)
 			goto done;
 		rbd_dev->mapping.read_only = true;
 	}
-	rbd_dev->exists = true;
+	atomic_set(&rbd_dev->exists, 1);
 done:
 	return ret;
 }
@@ -1333,8 +1333,7 @@ static int rbd_do_op(struct request *rq,
 	} else {
 		opcode = CEPH_OSD_OP_READ;
 		flags = CEPH_OSD_FLAG_READ;
-		ceph_put_snap_context(snapc);
-		snapc = NULL;
+		rbd_assert(!snapc);
 		snapid = rbd_dev->spec->snap_id;
 		payload_len = 0;
 	}
@@ -1652,6 +1651,7 @@ static void rbd_rq_fn(struct request_queue *q)

 	while ((rq = blk_fetch_request(q))) {
 		struct ceph_snap_context *snapc = NULL;
+		bool write_request = rq_data_dir(rq) == WRITE;
 		int result;

 		dout("fetched request\n");
@@ -1667,19 +1667,17 @@ static void rbd_rq_fn(struct request_queue *q)
 		/* Stop writes to a read-only device */

 		result = -EROFS;
-		if (read_only && rq_data_dir(rq) == WRITE)
+		if (read_only && write_request)
 			goto out_end_request;

-		/* Grab a reference to the snapshot context */
+		/* Grab a reference to the snapshot context if needed */

-		down_read(&rbd_dev->header_rwsem);
-		if (rbd_dev->exists) {
+		if (write_request) {
+			down_read(&rbd_dev->header_rwsem);
 			snapc = ceph_get_snap_context(rbd_dev->header.snapc);
 			rbd_assert(snapc != NULL);
-		}
-		up_read(&rbd_dev->header_rwsem);
-
-		if (!snapc) {
+			up_read(&rbd_dev->header_rwsem);
+		} else if (!atomic_read(&rbd_dev->exists)) {
 			rbd_assert(rbd_dev->spec->snap_id != CEPH_NOSNAP);
 			dout("request for non-existent snapshot");
 			result = -ENXIO;
@@ -2295,6 +2293,7 @@ struct rbd_device *rbd_dev_create(struct
rbd_client *rbdc,
 		return NULL;

 	spin_lock_init(&rbd_dev->lock);
+	atomic_set(&rbd_dev->exists, 0);
 	INIT_LIST_HEAD(&rbd_dev->node);
 	INIT_LIST_HEAD(&rbd_dev->snaps);
 	init_rwsem(&rbd_dev->header_rwsem);
@@ -2919,7 +2918,7 @@ static int rbd_dev_snaps_update(struct rbd_device
*rbd_dev)
 			/* Existing snapshot not in the new snap context */

 			if (rbd_dev->spec->snap_id == snap->id)
-				rbd_dev->exists = false;
+				atomic_set(&rbd_dev->exists, 0);
 			rbd_remove_snap_dev(snap);
 			dout("%ssnap id %llu has been removed\n",
 				rbd_dev->spec->snap_id == snap->id ?
-- 
1.7.9.5

