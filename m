From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/6] rbd: kill rbd_update_mapping_size()
Date: Mon, 06 May 2013 20:37:40 -0500
Message-ID: <51885AE4.1030209@inktank.com>
References: <51885A97.9070005@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f180.google.com ([209.85.210.180]:41510 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759433Ab3EGBhm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 May 2013 21:37:42 -0400
Received: by mail-ia0-f180.google.com with SMTP id 21so40905iay.39
        for <ceph-devel@vger.kernel.org>; Mon, 06 May 2013 18:37:42 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id xf4sm5168565igb.8.2013.05.06.18.37.40
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 06 May 2013 18:37:41 -0700 (PDT)
In-Reply-To: <51885A97.9070005@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Since rbd_update_mapping_size() is now a trivial wrapper, just open
code it in its two callers.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index a0f1fe5..0a24cdf 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3118,15 +3118,6 @@ static int rbd_read_header(struct rbd_device
*rbd_dev,
 	return ret;
 }

-static void rbd_update_mapping_size(struct rbd_device *rbd_dev)
-{
-	if (rbd_dev->spec->snap_id != CEPH_NOSNAP)
-		return;
-
-	if (rbd_dev->mapping.size != rbd_dev->header.image_size)
-		rbd_dev->mapping.size = rbd_dev->header.image_size;
-}
-
 /*
  * only read the first part of the ondisk header, without the snaps info
  */
@@ -3143,7 +3134,9 @@ static int rbd_dev_v1_refresh(struct rbd_device
*rbd_dev)

 	/* Update image size, and check for resize of mapped image */
 	rbd_dev->header.image_size = h.image_size;
-	rbd_update_mapping_size(rbd_dev);
+	if (rbd_dev->spec->snap_id == CEPH_NOSNAP)
+		if (rbd_dev->mapping.size != rbd_dev->header.image_size)
+			rbd_dev->mapping.size = rbd_dev->header.image_size;

 	/* rbd_dev->header.object_prefix shouldn't change */
 	kfree(rbd_dev->header.snap_sizes);
@@ -4074,7 +4067,9 @@ static int rbd_dev_v2_refresh(struct rbd_device
*rbd_dev)
 	ret = rbd_dev_v2_image_size(rbd_dev);
 	if (ret)
 		goto out;
-	rbd_update_mapping_size(rbd_dev);
+	if (rbd_dev->spec->snap_id == CEPH_NOSNAP)
+		if (rbd_dev->mapping.size != rbd_dev->header.image_size)
+			rbd_dev->mapping.size = rbd_dev->header.image_size;

 	ret = rbd_dev_v2_snap_context(rbd_dev);
 	dout("rbd_dev_v2_snap_context returned %d\n", ret);
-- 
1.7.9.5

