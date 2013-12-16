From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 3/7] rbd: refactor rbd_init() a bit
Date: Mon, 16 Dec 2013 19:16:29 +0200
Message-ID: <1387214193-18489-4-git-send-email-ilya.dryomov@inktank.com>
References: <1387214193-18489-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f50.google.com ([74.125.83.50]:39139 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754583Ab3LPRR0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Dec 2013 12:17:26 -0500
Received: by mail-ee0-f50.google.com with SMTP id c41so2356223eek.23
        for <ceph-devel@vger.kernel.org>; Mon, 16 Dec 2013 09:17:25 -0800 (PST)
In-Reply-To: <1387214193-18489-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ilya.dryomov@inktank.com

Refactor rbd_init() a bit to make it more clear what's going on.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
Reviewed-by: Alex Elder <elder@linaro.org>
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
---
 drivers/block/rbd.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index d743900ca780..8b78a08483a6 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5292,18 +5292,22 @@ static int __init rbd_init(void)
 
 	if (!libceph_compatible(NULL)) {
 		rbd_warn(NULL, "libceph incompatibility (quitting)");
-
 		return -EINVAL;
 	}
+
 	rc = rbd_slab_init();
 	if (rc)
 		return rc;
+
 	rc = rbd_sysfs_init();
 	if (rc)
-		rbd_slab_exit();
-	else
-		pr_info("loaded\n");
+		goto err_out_slab;
 
+	pr_info("loaded\n");
+	return 0;
+
+err_out_slab:
+	rbd_slab_exit();
 	return rc;
 }
 
-- 
1.7.10.4

