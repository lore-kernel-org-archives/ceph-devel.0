From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: fix type of snap_id in rbd_dev_v2_snap_info()
Date: Fri, 11 Jan 2013 21:17:06 -0600
Message-ID: <50F0D5B2.2090904@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:48721 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755388Ab3ALDRJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Jan 2013 22:17:09 -0500
Received: by mail-ie0-f181.google.com with SMTP id 16so3180150iea.12
        for <ceph-devel@vger.kernel.org>; Fri, 11 Jan 2013 19:17:09 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

The type of the snap_id local variable is defined with the
wrong byte order.  Fix that.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 02002b1..47443eb 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2800,7 +2800,7 @@ out:
 static char *rbd_dev_v2_snap_info(struct rbd_device *rbd_dev, u32 which,
 		u64 *snap_size, u64 *snap_features)
 {
-	__le64 snap_id;
+	u64 snap_id;
 	u8 order;
 	int ret;

-- 
1.7.9.5

