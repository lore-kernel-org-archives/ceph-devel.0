From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/5] rbd: don't bother checking whether order changes
Date: Sat, 27 Apr 2013 14:39:55 -0500
Message-ID: <517C298B.6050801@inktank.com>
References: <517C2914.8030400@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:33822 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753986Ab3D0Tj5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 27 Apr 2013 15:39:57 -0400
Received: by mail-ie0-f181.google.com with SMTP id tp5so5960183ieb.40
        for <ceph-devel@vger.kernel.org>; Sat, 27 Apr 2013 12:39:56 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id d4sm9290353igc.3.2013.04.27.12.39.55
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 12:39:55 -0700 (PDT)
In-Reply-To: <517C2914.8030400@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

When a format 2 image is refreshed, code is in place to verify that
the object order never changes from what it was originally.  This
relies on the fact that the refresh will occur *after* an initial
load of information about the image.

An upcoming patch makes it possible for the refresh to occur first,
so we can no longer make this order check.  The order really can't
ever change anyway--this was just a sanity check.  So get rid of it.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index d7a36d1..1832b6a 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4015,20 +4015,12 @@ static char *rbd_dev_snap_info(struct rbd_device
*rbd_dev, u32 which,
 static int rbd_dev_v2_refresh(struct rbd_device *rbd_dev, u64 *hver)
 {
 	int ret;
-	__u8 obj_order;

 	down_write(&rbd_dev->header_rwsem);

-	/* Grab old order first, to see if it changes */
-
-	obj_order = rbd_dev->header.obj_order,
 	ret = rbd_dev_v2_image_size(rbd_dev);
 	if (ret)
 		goto out;
-	if (rbd_dev->header.obj_order != obj_order) {
-		ret = -EIO;
-		goto out;
-	}
 	rbd_update_mapping_size(rbd_dev);

 	ret = rbd_dev_v2_snap_context(rbd_dev, hver);
-- 
1.7.9.5

