From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 1/7] rbd: rbd_device::dev_id is an int, format it as such
Date: Mon, 16 Dec 2013 19:16:27 +0200
Message-ID: <1387214193-18489-2-git-send-email-ilya.dryomov@inktank.com>
References: <1387214193-18489-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f49.google.com ([74.125.83.49]:49287 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143Ab3LPRRW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Dec 2013 12:17:22 -0500
Received: by mail-ee0-f49.google.com with SMTP id c41so2364936eek.36
        for <ceph-devel@vger.kernel.org>; Mon, 16 Dec 2013 09:17:21 -0800 (PST)
In-Reply-To: <1387214193-18489-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ilya.dryomov@inktank.com

rbd_device::dev_id is an int, format it as such.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
Reviewed-by: Alex Elder <elder@linaro.org>
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
---
 drivers/block/rbd.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index cb1db2979d3d..60536e446d69 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4385,8 +4385,7 @@ static void rbd_dev_id_get(struct rbd_device *rbd_dev)
 	spin_lock(&rbd_dev_list_lock);
 	list_add_tail(&rbd_dev->node, &rbd_dev_list);
 	spin_unlock(&rbd_dev_list_lock);
-	dout("rbd_dev %p given dev id %llu\n", rbd_dev,
-		(unsigned long long) rbd_dev->dev_id);
+	dout("rbd_dev %p given dev id %d\n", rbd_dev, rbd_dev->dev_id);
 }
 
 /*
@@ -4401,8 +4400,7 @@ static void rbd_dev_id_put(struct rbd_device *rbd_dev)
 
 	rbd_assert(rbd_id > 0);
 
-	dout("rbd_dev %p released dev id %llu\n", rbd_dev,
-		(unsigned long long) rbd_dev->dev_id);
+	dout("rbd_dev %p released dev id %d\n", rbd_dev, rbd_dev->dev_id);
 	spin_lock(&rbd_dev_list_lock);
 	list_del_init(&rbd_dev->node);
 
-- 
1.7.10.4

