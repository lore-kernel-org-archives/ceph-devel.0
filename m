From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] rbd: remove duplicate calls to rbd_dev_mapping_clear()
Date: Fri, 23 Oct 2015 20:41:04 +0200
Message-ID: <1445625664-30873-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33331 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbbJWRBd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Oct 2015 13:01:33 -0400
Received: by wijp11 with SMTP id p11so86238759wij.0
        for <ceph-devel@vger.kernel.org>; Fri, 23 Oct 2015 10:01:32 -0700 (PDT)
Received: from orange.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id nf15sm3582397wic.22.2015.10.23.10.01.31
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Oct 2015 10:01:31 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Commit d1cf5788450e ("rbd: set mapping info earlier") defined
rbd_dev_mapping_clear(), but, just a few days after, commit
f35a4dee14c3 ("rbd: set the mapping size and features later") moved
rbd_dev_mapping_set() calls and added another rbd_dev_mapping_clear()
call instead of moving the old one.  Around the same time, another
duplicate was introduced in rbd_dev_device_release() - kill both.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index cf087c5a6aa5..f8f4beb72b84 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5251,8 +5251,6 @@ err_out_blkdev:
 		unregister_blkdev(rbd_dev->major, rbd_dev->name);
 err_out_id:
 	rbd_dev_id_put(rbd_dev);
-	rbd_dev_mapping_clear(rbd_dev);
-
 	return ret;
 }
 
@@ -5507,7 +5505,6 @@ static void rbd_dev_device_release(struct rbd_device *rbd_dev)
 	if (!single_major)
 		unregister_blkdev(rbd_dev->major, rbd_dev->name);
 	rbd_dev_id_put(rbd_dev);
-	rbd_dev_mapping_clear(rbd_dev);
 }
 
 static void rbd_dev_remove_parent(struct rbd_device *rbd_dev)
-- 
2.4.3

