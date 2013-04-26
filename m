From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/6] rbd: make snap_size order parameter optional
Date: Fri, 26 Apr 2013 07:05:53 -0500
Message-ID: <517A6DA1.90809@inktank.com>
References: <517A6D39.80000@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f170.google.com ([209.85.210.170]:37574 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654Ab3DZMFz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Apr 2013 08:05:55 -0400
Received: by mail-ia0-f170.google.com with SMTP id k20so555724iak.29
        for <ceph-devel@vger.kernel.org>; Fri, 26 Apr 2013 05:05:54 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id dy5sm2838369igc.1.2013.04.26.05.05.53
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 26 Apr 2013 05:05:54 -0700 (PDT)
In-Reply-To: <517A6D39.80000@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Only one of the two callers of _rbd_dev_v2_snap_size() needs the
order value returned.  So make that an optional argument--a null
pointer if the caller doesn't need it.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 28b652c..1e01f0d 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3494,7 +3494,8 @@ static int _rbd_dev_v2_snap_size(struct rbd_device
*rbd_dev, u64 snap_id,
 	if (ret < sizeof (size_buf))
 		return -ERANGE;

-	*order = size_buf.order;
+	if (order)
+		*order = size_buf.order;
 	*snap_size = le64_to_cpu(size_buf.size);

 	dout("  snap_id 0x%016llx order = %u, snap_size = %llu\n",
@@ -3939,11 +3940,10 @@ static char *rbd_dev_v2_snap_info(struct
rbd_device *rbd_dev, u32 which,
 		u64 *snap_size, u64 *snap_features)
 {
 	u64 snap_id;
-	u8 order;
 	int ret;

 	snap_id = rbd_dev->header.snapc->snaps[which];
-	ret = _rbd_dev_v2_snap_size(rbd_dev, snap_id, &order, snap_size);
+	ret = _rbd_dev_v2_snap_size(rbd_dev, snap_id, NULL, snap_size);
 	if (ret)
 		return ERR_PTR(ret);
 	ret = _rbd_dev_v2_snap_features(rbd_dev, snap_id, snap_features);
-- 
1.7.9.5

