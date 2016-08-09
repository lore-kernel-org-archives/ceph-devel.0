From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] rbd: nuke the 32-bit pool id check
Date: Tue,  9 Aug 2016 16:42:17 +0200
Message-ID: <1470753737-5729-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33686 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbcHIOmb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Aug 2016 10:42:31 -0400
Received: by mail-yw0-f195.google.com with SMTP id z8so599082ywa.0
        for <ceph-devel@vger.kernel.org>; Tue, 09 Aug 2016 07:42:30 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@linaro.org>

ceph_file_layout::pool_id is now s64.  rbd_add_get_pool_id() and
ceph_pg_poolid_by_name() both return an int, so it's bogus anyway.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 07668a6f0607..6c6519f6492a 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5337,15 +5337,6 @@ static ssize_t do_rbd_add(struct bus_type *bus,
 	}
 	spec->pool_id = (u64)rc;
 
-	/* The ceph file layout needs to fit pool id in 32 bits */
-
-	if (spec->pool_id > (u64)U32_MAX) {
-		rbd_warn(NULL, "pool id too large (%llu > %u)",
-				(unsigned long long)spec->pool_id, U32_MAX);
-		rc = -EIO;
-		goto err_out_client;
-	}
-
 	rbd_dev = rbd_dev_create(rbdc, spec, rbd_opts);
 	if (!rbd_dev) {
 		rc = -ENOMEM;
-- 
2.4.3

