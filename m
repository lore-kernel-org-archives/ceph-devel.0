From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/2] rbd: use binary search for snapshot lookup
Date: Wed, 01 May 2013 16:32:52 -0500
Message-ID: <51818A04.5040809@inktank.com>
References: <51818945.1040002@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f170.google.com ([209.85.210.170]:58898 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761635Ab3EAVcz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 May 2013 17:32:55 -0400
Received: by mail-ia0-f170.google.com with SMTP id k20so1735061iak.1
        for <ceph-devel@vger.kernel.org>; Wed, 01 May 2013 14:32:55 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id o10sm5767182igh.2.2013.05.01.14.32.53
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 01 May 2013 14:32:54 -0700 (PDT)
In-Reply-To: <51818945.1040002@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Use bsearch(3) to make snapshot lookup by id more efficient.  (There
could be thousands of snapshots, and conceivably many more.)

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 3f58aba..a6e5fe3 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -33,6 +33,7 @@
 #include <linux/ceph/mon_client.h>
 #include <linux/ceph/decode.h>
 #include <linux/parser.h>
+#include <linux/bsearch.h>

 #include <linux/kernel.h>
 #include <linux/device.h>
@@ -819,16 +820,39 @@ static const char *_rbd_dev_v1_snap_name(struct
rbd_device *rbd_dev, u32 which)
 	return kstrdup(snap_name, GFP_KERNEL);
 }

+/*
+ * Snapshot id comparison function for use with qsort()/bsearch().
+ * Note that result is for snapshots in *descending* order.
+ */
+static int snapid_compare_reverse(const void *s1, const void *s2)
+{
+	u64 snap_id1 = *(u64 *)s1;
+	u64 snap_id2 = *(u64 *)s2;
+
+	if (snap_id1 < snap_id2)
+		return 1;
+	return snap_id1 == snap_id2 ? 0 : 1;
+}
+
+/*
+ * Search a snapshot context to see if the given snapshot id is
+ * present.
+ *
+ * Returns the position of the snapshot id in the array if it's found,
+ * or BAD_SNAP_INDEX otherwise.
+ *
+ * Note: The snapshot array is in kept sorted (by the osd) in
+ * reverse order, highest snapshot id first.
+ */
 static u32 rbd_dev_snap_index(struct rbd_device *rbd_dev, u64 snap_id)
 {
 	struct ceph_snap_context *snapc = rbd_dev->header.snapc;
-	u32 which;
+	u64 *found;

-	for (which = 0; which < snapc->num_snaps; which++)
-		if (snapc->snaps[which] == snap_id)
-			return which;
+	found = bsearch(&snap_id, &snapc->snaps, snapc->num_snaps,
+				sizeof (snap_id), snapid_compare_reverse);

-	return BAD_SNAP_INDEX;
+	return found ? (u32)(found - &snapc->snaps[0]) : BAD_SNAP_INDEX;
 }

 static const char *rbd_dev_v1_snap_name(struct rbd_device *rbd_dev,
-- 
1.7.9.5

