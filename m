From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 2/7] rbd: tweak "loaded" message and module description
Date: Mon, 16 Dec 2013 19:16:28 +0200
Message-ID: <1387214193-18489-3-git-send-email-ilya.dryomov@inktank.com>
References: <1387214193-18489-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f45.google.com ([74.125.83.45]:51570 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754583Ab3LPRRY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Dec 2013 12:17:24 -0500
Received: by mail-ee0-f45.google.com with SMTP id d49so2335694eek.18
        for <ceph-devel@vger.kernel.org>; Mon, 16 Dec 2013 09:17:23 -0800 (PST)
In-Reply-To: <1387214193-18489-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ilya.dryomov@inktank.com

Tweak "loaded" message, so that it looks like

[   30.184235] rbd: loaded

instead of

[   38.056564] rbd: loaded rbd (rados block device)

Also move (and slightly tweak) MODULE_DESCRIPTION so that all authors
are next to each other in modinfo output.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
Reviewed-by: Alex Elder <elder@linaro.org>
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
---
 drivers/block/rbd.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 60536e446d69..d743900ca780 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -89,7 +89,6 @@ static int atomic_dec_return_safe(atomic_t *v)
 }
 
 #define RBD_DRV_NAME "rbd"
-#define RBD_DRV_NAME_LONG "rbd (rados block device)"
 
 #define RBD_MINORS_PER_MAJOR	256		/* max minors per blkdev */
 
@@ -5303,7 +5302,7 @@ static int __init rbd_init(void)
 	if (rc)
 		rbd_slab_exit();
 	else
-		pr_info("loaded " RBD_DRV_NAME_LONG "\n");
+		pr_info("loaded\n");
 
 	return rc;
 }
@@ -5320,9 +5319,8 @@ module_exit(rbd_exit);
 MODULE_AUTHOR("Alex Elder <elder@inktank.com>");
 MODULE_AUTHOR("Sage Weil <sage@newdream.net>");
 MODULE_AUTHOR("Yehuda Sadeh <yehuda@hq.newdream.net>");
-MODULE_DESCRIPTION("rados block device");
-
 /* following authorship retained from original osdblk.c */
 MODULE_AUTHOR("Jeff Garzik <jeff@garzik.org>");
 
+MODULE_DESCRIPTION("RADOS Block Device (RBD) driver");
 MODULE_LICENSE("GPL");
-- 
1.7.10.4

