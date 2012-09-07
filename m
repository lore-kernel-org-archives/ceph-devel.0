From: Alex Elder <elder@inktank.com>
Subject: [PATCH 6/9] rbd: get snapshot name for a v2 image
Date: Fri, 07 Sep 2012 16:14:06 -0500
Message-ID: <504A639E.7080503@inktank.com>
References: <504A6273.7030807@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:38161 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756453Ab2IGVOI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 17:14:08 -0400
Received: by mail-ie0-f174.google.com with SMTP id e11so40763iej.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 14:14:08 -0700 (PDT)
In-Reply-To: <504A6273.7030807@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Define rbd_dev_v2_snap_name() to fetch the name for a particular
snapshot in a format 2 rbd image.

Define rbd_dev_v2_snap_info() to to be a wrapper for getting the
name, size, and features for a particular snapshot, using an
interface that matches the equivalent function for version 1 images.

Define rbd_dev_snap_info() wrapper function and use it to call the
appropriate function for getting the snapshot name, size, and
features, dependent on the rbd image format.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   78
++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 8ff84fd..c6922a1 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2313,6 +2313,82 @@ out:
 	return 0;
 }

+static char *rbd_dev_v2_snap_name(struct rbd_device *rbd_dev, u32 which)
+{
+	size_t size;
+	void *reply_buf;
+	__le64 snap_id;
+	int ret;
+	void *p;
+	void *end;
+	size_t snap_name_len;
+	char *snap_name;
+
+	size = sizeof (__le32) + RBD_MAX_SNAP_NAME_LEN;
+	reply_buf = kmalloc(size, GFP_KERNEL);
+	if (!reply_buf)
+		return ERR_PTR(-ENOMEM);
+
+	snap_id = cpu_to_le64(rbd_dev->header.snapc->snaps[which]);
+	ret = rbd_req_sync_exec(rbd_dev, rbd_dev->header_name,
+				"rbd", "get_snapshot_name",
+				(char *) &snap_id, sizeof (snap_id),
+				reply_buf, size,
+				CEPH_OSD_FLAG_READ, NULL);
+	dout("%s: rbd_req_sync_exec returned %d\n", __func__, ret);
+	if (ret < 0)
+		goto out;
+
+	p = reply_buf;
+	end = (char *) reply_buf + size;
+	snap_name_len = 0;
+	snap_name = ceph_extract_encoded_string(&p, end, &snap_name_len,
+				GFP_KERNEL);
+	if (IS_ERR(snap_name)) {
+		ret = PTR_ERR(snap_name);
+		goto out;
+	} else
+		dout("  snap_id 0x%016llx snap_name = %s\n",
+			(unsigned long long) le64_to_cpu(snap_id), snap_name);
+	kfree(reply_buf);
+
+	return snap_name;
+out:
+	kfree(reply_buf);
+
+	return ERR_PTR(ret);
+}
+
+static char *rbd_dev_v2_snap_info(struct rbd_device *rbd_dev, u32 which,
+		u64 *snap_size, u64 *snap_features)
+{
+	__le64 snap_id;
+	u8 order;
+	int ret;
+
+	snap_id = rbd_dev->header.snapc->snaps[which];
+	ret = _rbd_dev_v2_snap_size(rbd_dev, snap_id, &order, snap_size);
+	if (ret)
+		return ERR_PTR(ret);
+	ret = _rbd_dev_v2_snap_features(rbd_dev, snap_id, snap_features);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return rbd_dev_v2_snap_name(rbd_dev, which);
+}
+
+static char *rbd_dev_snap_info(struct rbd_device *rbd_dev, u32 which,
+		u64 *snap_size, u64 *snap_features)
+{
+	if (rbd_dev->image_format == 1)
+		return rbd_dev_v1_snap_info(rbd_dev, which,
+					snap_size, snap_features);
+	if (rbd_dev->image_format == 2)
+		return rbd_dev_v2_snap_info(rbd_dev, which,
+					snap_size, snap_features);
+	return ERR_PTR(-EINVAL);
+}
+
 /*
  * Scan the rbd device's current snapshot list and compare it to the
  * newly-received snapshot context.  Remove any existing snapshots
@@ -2366,7 +2442,7 @@ static int rbd_dev_snaps_update(struct rbd_device
*rbd_dev)
 			continue;
 		}

-		snap_name = rbd_dev_v1_snap_info(rbd_dev, index,
+		snap_name = rbd_dev_snap_info(rbd_dev, index,
 						&snap_size, &snap_features);
 		if (IS_ERR(snap_name))
 			return PTR_ERR(snap_name);
-- 
1.7.9.5

