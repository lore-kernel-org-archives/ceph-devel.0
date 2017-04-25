From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 2/9] rbd: move rbd_unregister_watch() call into rbd_dev_image_release()
Date: Tue, 25 Apr 2017 11:33:38 +0200
Message-ID: <1493112825-16403-3-git-send-email-idryomov@gmail.com>
References: <1493112825-16403-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36476 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1428697AbdDYJeO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Apr 2017 05:34:14 -0400
Received: by mail-qt0-f194.google.com with SMTP id t52so24174166qtb.3
        for <ceph-devel@vger.kernel.org>; Tue, 25 Apr 2017 02:34:14 -0700 (PDT)
Received: from orange.brq.redhat.com. (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id w6sm7461396qta.50.2017.04.25.02.34.12
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 02:34:13 -0700 (PDT)
In-Reply-To: <1493112825-16403-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

rbd_dev->disk tear down vs rbd_watch_cb() race shouldn't be a problem
anymore thanks to EXISTS and REMOVING checks in rbd_dev_update_size().
A similar race could occur on "rbd map", see commit 811c66887746
("rbd: fix rbd map vs notify races").

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 2effa3e8f96c..a21587732749 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5964,6 +5964,8 @@ static int rbd_dev_header_name(struct rbd_device *rbd_dev)
 static void rbd_dev_image_release(struct rbd_device *rbd_dev)
 {
 	rbd_dev_unprobe(rbd_dev);
+	if (rbd_dev->opts)
+		rbd_unregister_watch(rbd_dev);
 	rbd_dev->image_format = 0;
 	kfree(rbd_dev->spec->image_id);
 	rbd_dev->spec->image_id = NULL;
@@ -6126,15 +6128,8 @@ static ssize_t do_rbd_add(struct bus_type *bus,
 	rbd_dev->mapping.read_only = read_only;
 
 	rc = rbd_dev_device_setup(rbd_dev);
-	if (rc) {
-		/*
-		 * rbd_unregister_watch() can't be moved into
-		 * rbd_dev_image_release() without refactoring, see
-		 * commit 1f3ef78861ac.
-		 */
-		rbd_unregister_watch(rbd_dev);
+	if (rc)
 		goto err_out_image_probe;
-	}
 
 	rc = count;
 out:
@@ -6275,14 +6270,7 @@ static ssize_t do_rbd_remove(struct bus_type *bus,
 	if (__rbd_is_lock_owner(rbd_dev))
 		rbd_unlock(rbd_dev);
 	up_write(&rbd_dev->lock_rwsem);
-	rbd_unregister_watch(rbd_dev);
 
-	/*
-	 * Don't free anything from rbd_dev->disk until after all
-	 * notifies are completely processed. Otherwise
-	 * rbd_bus_del_dev() will race with rbd_watch_cb(), resulting
-	 * in a potential use after free of rbd_dev->disk or rbd_dev.
-	 */
 	rbd_dev_device_release(rbd_dev);
 	rbd_dev_image_release(rbd_dev);
 	rbd_dev_destroy(rbd_dev);
-- 
2.4.3

