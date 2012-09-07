From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/3] rbd: encapsulate code that gets snapshot info
Date: Fri, 07 Sep 2012 14:25:11 -0500
Message-ID: <504A4A17.8060008@inktank.com>
References: <504A498D.30708@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:55902 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283Ab2IGTZQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 15:25:16 -0400
Received: by mail-ie0-f174.google.com with SMTP id e11so5637710iej.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 12:25:16 -0700 (PDT)
In-Reply-To: <504A498D.30708@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Create a function that encapsulates looking up the name, size and
features related to a given snapshot, which is indicated by its
index in an rbd device's snapshot context array of snapshot ids.

This interface will be used to hide differences between the format 1
and format 2 images.

At the moment this (looking up the name anyway) is slightly less
efficient than what's done currently, but we may be able to optimize
this a bit later on by cacheing the last lookup if it proves to be a
problem.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index c62d3f4..e6b8fa6 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2097,6 +2097,25 @@ err:
 	return ERR_PTR(ret);
 }

+static char *rbd_dev_v1_snap_info(struct rbd_device *rbd_dev, u32 which,
+		u64 *snap_size, u64 *snap_features)
+{
+	char *snap_name;
+
+	rbd_assert(which < rbd_dev->header.snapc->num_snaps);
+
+	*snap_size = rbd_dev->header.snap_sizes[which];
+	*snap_features = 0;	/* No features for v1 */
+
+	/* Skip over names until we find the one we are looking for */
+
+	snap_name = rbd_dev->header.snap_names;
+	while (which--)
+		snap_name += strlen(snap_name) + 1;
+
+	return snap_name;
+}
+
 /*
  * Scan the rbd device's current snapshot list and compare it to the
  * newly-received snapshot context.  Remove any existing snapshots
@@ -2113,7 +2132,6 @@ static int rbd_dev_snaps_update(struct rbd_device
*rbd_dev)
 {
 	struct ceph_snap_context *snapc = rbd_dev->header.snapc;
 	const u32 snap_count = snapc->num_snaps;
-	char *snap_name = rbd_dev->header.snap_names;
 	struct list_head *head = &rbd_dev->snaps;
 	struct list_head *links = head->next;
 	u32 index = 0;
@@ -2122,6 +2140,9 @@ static int rbd_dev_snaps_update(struct rbd_device
*rbd_dev)
 	while (index < snap_count || links != head) {
 		u64 snap_id;
 		struct rbd_snap *snap;
+		char *snap_name;
+		u64 snap_size = 0;
+		u64 snap_features = 0;

 		snap_id = index < snap_count ? snapc->snaps[index]
 					     : CEPH_NOSNAP;
@@ -2148,16 +2169,20 @@ static int rbd_dev_snaps_update(struct
rbd_device *rbd_dev)
 			continue;
 		}

+		snap_name = rbd_dev_v1_snap_info(rbd_dev, index,
+						&snap_size, &snap_features);
+		if (IS_ERR(snap_name))
+			return PTR_ERR(snap_name);
+
 		dout("entry %u: snap_id = %llu\n", (unsigned int) snap_count,
 			(unsigned long long) snap_id);
 		if (!snap || (snap_id != CEPH_NOSNAP && snap->id < snap_id)) {
-			struct rbd_image_header	*header = &rbd_dev->header;
 			struct rbd_snap *new_snap;

 			/* We haven't seen this snapshot before */

 			new_snap = __rbd_add_snap_dev(rbd_dev, snap_name,
-					snap_id, header->snap_sizes[index], 0);
+					snap_id, snap_size, snap_features);
 			if (IS_ERR(new_snap)) {
 				int err = PTR_ERR(new_snap);

@@ -2178,9 +2203,9 @@ static int rbd_dev_snaps_update(struct rbd_device
*rbd_dev)

 			dout("  already present\n");

-			rbd_assert(snap->size ==
-					rbd_dev->header.snap_sizes[index]);
+			rbd_assert(snap->size == snap_size);
 			rbd_assert(!strcmp(snap->name, snap_name));
+			rbd_assert(snap->features == snap_features);

 			/* Done with this list entry; advance */

@@ -2190,7 +2215,6 @@ static int rbd_dev_snaps_update(struct rbd_device
*rbd_dev)
 		/* Advance to the next entry in the snapshot context */

 		index++;
-		snap_name += strlen(snap_name) + 1;
 	}
 	dout("%s: done\n", __func__);

-- 
1.7.9.5

