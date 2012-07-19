From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/6] rbd: expose the correct size of the device in sysfs
Date: Thu, 19 Jul 2012 07:34:46 -0500
Message-ID: <5007FEE6.4050403@inktank.com>
References: <5007FDEA.9010605@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42918 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894Ab2GSMes (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jul 2012 08:34:48 -0400
Received: by yhmm54 with SMTP id m54so2672639yhm.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jul 2012 05:34:48 -0700 (PDT)
In-Reply-To: <5007FDEA.9010605@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

If an image was mapped to a snapshot, the size of the head version
would be shown. Protect capacity with header_rwsem, since it may
change.

Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
Reviewed-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index f171ceb..9c3a1db 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1724,6 +1724,8 @@ static int __rbd_refresh_header(struct rbd_device
*rbd_dev)
 	if (ret < 0)
 		return ret;

+	down_write(&rbd_dev->header_rwsem);
+
 	/* resized? */
 	if (rbd_dev->snap_id == CEPH_NOSNAP) {
 		sector_t size = (sector_t) h.image_size / SECTOR_SIZE;
@@ -1732,8 +1734,6 @@ static int __rbd_refresh_header(struct rbd_device
*rbd_dev)
 		set_capacity(rbd_dev->disk, size);
 	}

-	down_write(&rbd_dev->header_rwsem);
-
 	snap_seq = rbd_dev->header.snapc->seq;
 	if (rbd_dev->header.total_snaps &&
 	    rbd_dev->header.snapc->snaps[0] == snap_seq)
@@ -1853,8 +1853,13 @@ static ssize_t rbd_size_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
 	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);
+	sector_t size;
+
+	down_read(&rbd_dev->header_rwsem);
+	size = get_capacity(rbd_dev->disk);
+	up_read(&rbd_dev->header_rwsem);

-	return sprintf(buf, "%llu\n", (unsigned long
long)rbd_dev->header.image_size);
+	return sprintf(buf, "%llu\n", (unsigned long long) size * SECTOR_SIZE);
 }

 static ssize_t rbd_major_show(struct device *dev,
-- 
1.7.5.4

