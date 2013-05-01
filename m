From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/2] rbd: clear EXISTS flag if mapped snapshot disappears
Date: Wed, 01 May 2013 16:32:41 -0500
Message-ID: <518189F9.3070603@inktank.com>
References: <51818945.1040002@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:57052 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758667Ab3EAVco (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 May 2013 17:32:44 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so2449805iea.4
        for <ceph-devel@vger.kernel.org>; Wed, 01 May 2013 14:32:43 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id o10sm5766714igh.2.2013.05.01.14.32.42
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 01 May 2013 14:32:42 -0700 (PDT)
In-Reply-To: <51818945.1040002@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This functionality inadvertently disappeared in the last patch.

Image snapshots can get removed at just about any time.  In
particular it can disappear even if it is in use by an rbd
client as a mapped image.

The rbd client deals with such a disappearance by responding to new
requests with ENXIO.  This is implemented by each rbd device
maintaining an EXISTS flag, which is normally set but cleared if a
snapshot disappears.

This patch (re-)implements the clearing of that flag.

Whenever mapped image header information is refreshed, if the
mapping is for a snapshot, verify the mapped snapshot is still
present in the updated snapshot context.  If it is not, clear the
flag.

It is not necessary to check this in the initial probe, because the
probe will not succeed if the snapshot doesn't exist.

This resolves:
    http://tracker.ceph.com/issues/4880

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 0ca959f..3f58aba 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3114,6 +3114,25 @@ static int rbd_dev_v1_refresh(struct rbd_device
*rbd_dev)
 	return ret;
 }

+/*
+ * Clear the rbd device's EXISTS flag if the snapshot it's mapped to
+ * has disappeared from the (just updated) snapshot context.
+ */
+static void rbd_exists_validate(struct rbd_device *rbd_dev)
+{
+	u64 snap_id;
+
+	if (!test_bit(RBD_DEV_FLAG_EXISTS, &rbd_dev->flags))
+		return;
+
+	snap_id = rbd_dev->spec->snap_id;
+	if (snap_id == CEPH_NOSNAP)
+		return;
+
+	if (rbd_dev_snap_index(rbd_dev, snap_id) == BAD_SNAP_INDEX)
+		clear_bit(RBD_DEV_FLAG_EXISTS, &rbd_dev->flags);
+}
+
 static int rbd_dev_refresh(struct rbd_device *rbd_dev)
 {
 	u64 image_size;
@@ -3126,6 +3145,10 @@ static int rbd_dev_refresh(struct rbd_device
*rbd_dev)
 		ret = rbd_dev_v1_refresh(rbd_dev);
 	else
 		ret = rbd_dev_v2_refresh(rbd_dev);
+
+	/* If it's a mapped snapshot, validate its EXISTS flag */
+
+	rbd_exists_validate(rbd_dev);
 	mutex_unlock(&ctl_mutex);
 	if (ret)
 		rbd_warn(rbd_dev, "got notification but failed to "
-- 
1.7.9.5

