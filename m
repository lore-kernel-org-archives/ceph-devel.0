From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH] rbd: fix ida/idr memory leak
Date: Wed,  4 Jun 2014 20:38:37 +0400
Message-ID: <1401899917-11254-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:35272 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbaFDQil (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jun 2014 12:38:41 -0400
Received: by mail-la0-f47.google.com with SMTP id pn19so4577190lab.34
        for <ceph-devel@vger.kernel.org>; Wed, 04 Jun 2014 09:38:40 -0700 (PDT)
Received: from localhost ([109.110.66.45])
        by mx.google.com with ESMTPSA id vq4sm2973240lbb.14.2014.06.04.09.38.38
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 04 Jun 2014 09:38:39 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

ida_destroy() needs to be called on module exit to release ida caches.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 drivers/block/rbd.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 94747afc2e78..ecdd4aee173c 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5464,6 +5464,7 @@ err_out_slab:
 
 static void __exit rbd_exit(void)
 {
+	ida_destroy(&rbd_dev_id_ida);
 	rbd_sysfs_cleanup();
 	if (single_major)
 		unregister_blkdev(rbd_major, RBD_DRV_NAME);
-- 
1.7.10.4

