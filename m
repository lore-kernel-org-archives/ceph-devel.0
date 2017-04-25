From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 1/9] rbd: move rbd_dev_destroy() call out of rbd_dev_image_release()
Date: Tue, 25 Apr 2017 11:33:37 +0200
Message-ID: <1493112825-16403-2-git-send-email-idryomov@gmail.com>
References: <1493112825-16403-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35642 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1428696AbdDYJeN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Apr 2017 05:34:13 -0400
Received: by mail-qt0-f193.google.com with SMTP id o36so24161393qtb.2
        for <ceph-devel@vger.kernel.org>; Tue, 25 Apr 2017 02:34:13 -0700 (PDT)
Received: from orange.brq.redhat.com. (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id w6sm7461396qta.50.2017.04.25.02.34.11
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 02:34:12 -0700 (PDT)
In-Reply-To: <1493112825-16403-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

... to simplify error handling in do_rbd_add().

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 2fb0a7a76d8e..2effa3e8f96c 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5967,8 +5967,6 @@ static void rbd_dev_image_release(struct rbd_device *rbd_dev)
 	rbd_dev->image_format = 0;
 	kfree(rbd_dev->spec->image_id);
 	rbd_dev->spec->image_id = NULL;
-
-	rbd_dev_destroy(rbd_dev);
 }
 
 /*
@@ -6135,8 +6133,7 @@ static ssize_t do_rbd_add(struct bus_type *bus,
 		 * commit 1f3ef78861ac.
 		 */
 		rbd_unregister_watch(rbd_dev);
-		rbd_dev_image_release(rbd_dev);
-		goto out;
+		goto err_out_image_probe;
 	}
 
 	rc = count;
@@ -6144,6 +6141,8 @@ static ssize_t do_rbd_add(struct bus_type *bus,
 	module_put(THIS_MODULE);
 	return rc;
 
+err_out_image_probe:
+	rbd_dev_image_release(rbd_dev);
 err_out_rbd_dev:
 	rbd_dev_destroy(rbd_dev);
 err_out_client:
@@ -6203,6 +6202,7 @@ static void rbd_dev_remove_parent(struct rbd_device *rbd_dev)
 		}
 		rbd_assert(second);
 		rbd_dev_image_release(second);
+		rbd_dev_destroy(second);
 		first->parent = NULL;
 		first->parent_overlap = 0;
 
@@ -6285,7 +6285,7 @@ static ssize_t do_rbd_remove(struct bus_type *bus,
 	 */
 	rbd_dev_device_release(rbd_dev);
 	rbd_dev_image_release(rbd_dev);
-
+	rbd_dev_destroy(rbd_dev);
 	return count;
 }
 
-- 
2.4.3

