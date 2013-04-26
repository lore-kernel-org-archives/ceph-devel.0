From: Alex Elder <elder@inktank.com>
Subject: [PATCH 5/6, v2] rbd: fix leak of format 2 snapshot names
Date: Fri, 26 Apr 2013 12:40:22 -0500
Message-ID: <517ABC06.7080200@inktank.com>
References: <517A6D39.80000@inktank.com> <517A6DD1.2080102@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:34175 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754814Ab3DZRkY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Apr 2013 13:40:24 -0400
Received: by mail-ie0-f172.google.com with SMTP id c12so5285054ieb.31
        for <ceph-devel@vger.kernel.org>; Fri, 26 Apr 2013 10:40:24 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id hi4sm4274171igc.6.2013.04.26.10.40.23
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 26 Apr 2013 10:40:23 -0700 (PDT)
In-Reply-To: <517A6DD1.2080102@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

(I found a bug in this (which masked another bug).  Here is
version 2.  I have corrected it and updated the various
branches that depended on it.)


When the snapshot context for an rbd device gets updated (or the
initial one is recorded) a a list of snapshot structures is created
to represent them, one entry per snapshot.  Each entry includes a
dynamically-allocated copy of the snapshot name.

Currently the name is allocated in rbd_snap_create(), as a duplicate
of the passed-in name.

For format 1 images, the snapshot name provided is just a pointer to
an existing name.  But for format 2 images, the passed-in name is
already dynamically allocated, and in the the process of duplicating
it here we are leaking the passed-in name.

Fix this by dynamically allocating the name for format 1 snapshots
also, and then stop allocating a duplicate in rbd_snap_create().

Change rbd_dev_v1_snap_info() so none of its parameters is
side-effected unless it's going to return success.

This is part of:
    http://tracker.ceph.com/issues/4803

Signed-off-by: Alex Elder <elder@inktank.com>
---
v2: kill an errant semicolon; use loop iterator rather than "which"

 drivers/block/rbd.c |   30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 916741b..c15bb3f 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3427,46 +3427,44 @@ static struct rbd_snap *rbd_snap_create(struct
rbd_device *rbd_dev,
 						u64 snap_features)
 {
 	struct rbd_snap *snap;
-	int ret;

 	snap = kzalloc(sizeof (*snap), GFP_KERNEL);
 	if (!snap)
 		return ERR_PTR(-ENOMEM);

-	ret = -ENOMEM;
-	snap->name = kstrdup(snap_name, GFP_KERNEL);
-	if (!snap->name)
-		goto err;
-
+	snap->name = snap_name;
 	snap->id = snap_id;
 	snap->size = snap_size;
 	snap->features = snap_features;

 	return snap;
-
-err:
-	kfree(snap->name);
-	kfree(snap);
-
-	return ERR_PTR(ret);
 }

+/*
+ * Returns a dynamically-allocated snapshot name if successful, or a
+ * pointer-coded error otherwise.
+ */
 static char *rbd_dev_v1_snap_info(struct rbd_device *rbd_dev, u32 which,
 		u64 *snap_size, u64 *snap_features)
 {
 	char *snap_name;
+	int i;

 	rbd_assert(which < rbd_dev->header.snapc->num_snaps);

-	*snap_size = rbd_dev->header.snap_sizes[which];
-	*snap_features = 0;	/* No features for v1 */
-
 	/* Skip over names until we find the one we are looking for */

 	snap_name = rbd_dev->header.snap_names;
-	while (which--)
+	for (i = 0; i < which; i++)
 		snap_name += strlen(snap_name) + 1;

+	snap_name = kstrdup(snap_name, GFP_KERNEL);
+	if (!snap_name)
+		return ERR_PTR(-ENOMEM);
+
+	*snap_size = rbd_dev->header.snap_sizes[which];
+	*snap_features = 0;	/* No features for v1 */
+
 	return snap_name;
 }

-- 
1.7.9.5


