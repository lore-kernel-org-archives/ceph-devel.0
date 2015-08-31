From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] rbd: plug rbd_dev->header.object_prefix memory leak
Date: Mon, 31 Aug 2015 20:02:38 +0300
Message-ID: <1441040558-8977-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:32815 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753340AbbHaRCx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Aug 2015 13:02:53 -0400
Received: by wicmc4 with SMTP id mc4so6578736wic.0
        for <ceph-devel@vger.kernel.org>; Mon, 31 Aug 2015 10:02:51 -0700 (PDT)
Received: from orange.local.localdomain ([109.110.66.71])
        by smtp.gmail.com with ESMTPSA id lz10sm23031893wjb.48.2015.08.31.10.02.50
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2015 10:02:51 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Need to free object_prefix when rbd_dev_v2_snap_context() fails, but
only if this is the first time we are reading in the header.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 324bf35ec4dd..69d03aa46d0d 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4720,7 +4720,10 @@ static int rbd_dev_v2_header_info(struct rbd_device *rbd_dev)
 	}
 
 	ret = rbd_dev_v2_snap_context(rbd_dev);
-	dout("rbd_dev_v2_snap_context returned %d\n", ret);
+	if (ret && first_time) {
+		kfree(rbd_dev->header.object_prefix);
+		rbd_dev->header.object_prefix = NULL;
+	}
 
 	return ret;
 }
-- 
1.9.3

