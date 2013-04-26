From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/6] rbd: fix leak of snapshots during initial probe
Date: Fri, 26 Apr 2013 07:05:40 -0500
Message-ID: <517A6D94.9000008@inktank.com>
References: <517A6D39.80000@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:42934 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995Ab3DZMFm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Apr 2013 08:05:42 -0400
Received: by mail-ie0-f171.google.com with SMTP id e11so4817928iej.2
        for <ceph-devel@vger.kernel.org>; Fri, 26 Apr 2013 05:05:42 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id s16sm2564178ign.4.2013.04.26.05.05.40
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 26 Apr 2013 05:05:41 -0700 (PDT)
In-Reply-To: <517A6D39.80000@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

When an rbd image is initially mapped, its snapshot context is
collected, and then a list of snapshot entries representing the
snapshots in that context is created.  The list is created using
rbd_dev_snaps_update().  (This function also supports updating an
existing snapshot list based on a new snapshot context.)

If an error occurs, updating the list is aborted, and the list is
currently left as-is, in an inconsistent state.  At that point,
there may be a partially-constructed list, but the calling functions
(rbd_dev_probe_finish() from rbd_dev_probe() from rbd_add()) never
clean them up.  So this constitutes a leak.

A snapshot list that is inconsistent with the current snapshot
context is of no use, and might even be actively bad.  So rather
than just having the caller clean it up, have rbd_dev_snaps_update()
just clear out the entire snapshot list in the event an error
occurs.

The other place rbd_dev_snaps_update() is used is when a refresh is
triggered, either because of a watch callback or via a write to the
/sys/bus/rbd/devices/<id>/refresh interface.  An error while
updating the snapshots has no substantive effect in either of those
cases, but one of them issues a warning.  Move that warning to the
common rbd_dev_refresh() function so it gets issued regardless of
how it got initiated.

This is part of:
    http://tracker.ceph.com/issues/4803

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   50
++++++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 515fbf9..28b652c 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2521,7 +2521,6 @@ static void rbd_watch_cb(u64 ver, u64 notify_id,
u8 opcode, void *data)
 {
 	struct rbd_device *rbd_dev = (struct rbd_device *)data;
 	u64 hver;
-	int rc;

 	if (!rbd_dev)
 		return;
@@ -2529,10 +2528,7 @@ static void rbd_watch_cb(u64 ver, u64 notify_id,
u8 opcode, void *data)
 	dout("%s: \"%s\" notify_id %llu opcode %u\n", __func__,
 		rbd_dev->header_name, (unsigned long long) notify_id,
 		(unsigned int) opcode);
-	rc = rbd_dev_refresh(rbd_dev, &hver);
-	if (rc)
-		rbd_warn(rbd_dev, "got notification but failed to "
-			   " update snaps: %d\n", rc);
+	(void)rbd_dev_refresh(rbd_dev, &hver);

 	rbd_obj_notify_ack(rbd_dev, hver, notify_id);
 }
@@ -3085,6 +3081,9 @@ static int rbd_dev_refresh(struct rbd_device
*rbd_dev, u64 *hver)
 		ret = rbd_dev_v2_refresh(rbd_dev, hver);
 	mutex_unlock(&ctl_mutex);
 	revalidate_disk(rbd_dev->disk);
+	if (ret)
+		rbd_warn(rbd_dev, "got notification but failed to "
+			   " update snaps: %d\n", ret);

 	return ret;
 }
@@ -4010,6 +4009,11 @@ out:
  * Assumes the snapshots in the snapshot context are sorted by
  * snapshot id, highest id first.  (Snapshots in the rbd_dev's list
  * are also maintained in that order.)
+ *
+ * Note that any error occurs while updating the snapshot list
+ * aborts the update, and the entire list is cleared.  The snapshot
+ * list becomes inconsistent at that point anyway, so it might as
+ * well be empty.
  */
 static int rbd_dev_snaps_update(struct rbd_device *rbd_dev)
 {
@@ -4018,8 +4022,9 @@ static int rbd_dev_snaps_update(struct rbd_device
*rbd_dev)
 	struct list_head *head = &rbd_dev->snaps;
 	struct list_head *links = head->next;
 	u32 index = 0;
+	int ret = 0;

-	dout("%s: snap count is %u\n", __func__, (unsigned int) snap_count);
+	dout("%s: snap count is %u\n", __func__, (unsigned int)snap_count);
 	while (index < snap_count || links != head) {
 		u64 snap_id;
 		struct rbd_snap *snap;
@@ -4040,17 +4045,17 @@ static int rbd_dev_snaps_update(struct
rbd_device *rbd_dev)
 			 * A previously-existing snapshot is not in
 			 * the new snap context.
 			 *
-			 * If the now missing snapshot is the one the
-			 * image is mapped to, clear its exists flag
-			 * so we can avoid sending any more requests
-			 * to it.
+			 * If the now-missing snapshot is the one
+			 * the image represents, clear its existence
+			 * flag so we can avoid sending any more
+			 * requests to it.
 			 */
 			if (rbd_dev->spec->snap_id == snap->id)
 				clear_bit(RBD_DEV_FLAG_EXISTS, &rbd_dev->flags);
 			dout("removing %ssnap id %llu\n",
 				rbd_dev->spec->snap_id == snap->id ?
 							"mapped " : "",
-				(unsigned long long) snap->id);
+				(unsigned long long)snap->id);
 			rbd_remove_snap_dev(snap);

 			/* Done with this list entry; advance */
@@ -4061,11 +4066,14 @@ static int rbd_dev_snaps_update(struct
rbd_device *rbd_dev)

 		snap_name = rbd_dev_snap_info(rbd_dev, index,
 					&snap_size, &snap_features);
-		if (IS_ERR(snap_name))
-			return PTR_ERR(snap_name);
+		if (IS_ERR(snap_name)) {
+			ret = PTR_ERR(snap_name);
+			dout("failed to get snap info, error %d\n", ret);
+			goto out_err;
+		}

-		dout("entry %u: snap_id = %llu\n", (unsigned int) snap_count,
-			(unsigned long long) snap_id);
+		dout("entry %u: snap_id = %llu\n", (unsigned int)snap_count,
+			(unsigned long long)snap_id);
 		if (!snap || (snap_id != CEPH_NOSNAP && snap->id < snap_id)) {
 			struct rbd_snap *new_snap;

@@ -4074,11 +4082,9 @@ static int rbd_dev_snaps_update(struct rbd_device
*rbd_dev)
 			new_snap = __rbd_add_snap_dev(rbd_dev, snap_name,
 					snap_id, snap_size, snap_features);
 			if (IS_ERR(new_snap)) {
-				int err = PTR_ERR(new_snap);
-
-				dout("  failed to add dev, error %d\n", err);
-
-				return err;
+				ret = PTR_ERR(new_snap);
+				dout("  failed to add dev, error %d\n", ret);
+				goto out_err;
 			}

 			/* New goes before existing, or at end of list */
@@ -4109,6 +4115,10 @@ static int rbd_dev_snaps_update(struct rbd_device
*rbd_dev)
 	dout("%s: done\n", __func__);

 	return 0;
+out_err:
+	rbd_remove_all_snaps(rbd_dev);
+
+	return ret;
 }

 static int rbd_bus_add_dev(struct rbd_device *rbd_dev)
-- 
1.7.9.5

