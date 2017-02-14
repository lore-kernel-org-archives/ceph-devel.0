From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 03/15] rbd: initialize rbd_dev->header_oloc early
Date: Tue, 14 Feb 2017 21:11:52 +0100
Message-ID: <1487103124-2974-4-git-send-email-idryomov@gmail.com>
References: <1487103124-2974-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34850 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754915AbdBNUMd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Feb 2017 15:12:33 -0500
Received: by mail-qk0-f194.google.com with SMTP id u25so20603163qki.2
        for <ceph-devel@vger.kernel.org>; Tue, 14 Feb 2017 12:12:33 -0800 (PST)
In-Reply-To: <1487103124-2974-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@ieee.org>

No reason to delay it until image_id is known.  This will be required
by some rbd_obj_method_sync() callers, after rbd_obj_method_sync() is
changed to take oloc.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index a6ad714c85ac..24e8116d3431 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4863,7 +4863,7 @@ static struct rbd_device *__rbd_dev_create(struct rbd_client *rbdc,
 	init_rwsem(&rbd_dev->header_rwsem);
 
 	ceph_oid_init(&rbd_dev->header_oid);
-	ceph_oloc_init(&rbd_dev->header_oloc);
+	rbd_dev->header_oloc.pool = spec->pool_id;
 
 	mutex_init(&rbd_dev->watch_mutex);
 	rbd_dev->watch_state = RBD_WATCH_STATE_UNREGISTERED;
@@ -6062,8 +6062,6 @@ static int rbd_dev_header_name(struct rbd_device *rbd_dev)
 	/* Record the header object name for this rbd image. */
 
 	rbd_assert(rbd_image_format_valid(rbd_dev->image_format));
-
-	rbd_dev->header_oloc.pool = rbd_dev->layout.pool_id;
 	if (rbd_dev->image_format == 1)
 		ret = ceph_oid_aprintf(&rbd_dev->header_oid, GFP_KERNEL, "%s%s",
 				       spec->image_name, RBD_SUFFIX);
-- 
2.4.3

