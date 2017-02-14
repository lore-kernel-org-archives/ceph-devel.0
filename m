From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 09/15] rbd: introduce rbd_init_layout()
Date: Tue, 14 Feb 2017 21:11:58 +0100
Message-ID: <1487103124-2974-10-git-send-email-idryomov@gmail.com>
References: <1487103124-2974-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33458 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754829AbdBNUMo (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Feb 2017 15:12:44 -0500
Received: by mail-qk0-f193.google.com with SMTP id 11so20554627qkl.0
        for <ceph-devel@vger.kernel.org>; Tue, 14 Feb 2017 12:12:44 -0800 (PST)
In-Reply-To: <1487103124-2974-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@ieee.org>

Rather than initializing layout fields with some made up values in
__rbd_dev_create(), move the initialization into rbd_init_layout() and
call it after the header is actually populated.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index f2f52b7db33d..aac1d3259738 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -978,6 +978,21 @@ static u32 rbd_obj_bytes(struct rbd_image_header *header)
 	return 1U << header->obj_order;
 }
 
+static void rbd_init_layout(struct rbd_device *rbd_dev)
+{
+	if (rbd_dev->header.stripe_unit == 0 ||
+	    rbd_dev->header.stripe_count == 0) {
+		rbd_dev->header.stripe_unit = rbd_obj_bytes(&rbd_dev->header);
+		rbd_dev->header.stripe_count = 1;
+	}
+
+	rbd_dev->layout.stripe_unit = rbd_dev->header.stripe_unit;
+	rbd_dev->layout.stripe_count = rbd_dev->header.stripe_count;
+	rbd_dev->layout.object_size = rbd_obj_bytes(&rbd_dev->header);
+	rbd_dev->layout.pool_id = rbd_dev->spec->pool_id;
+	RCU_INIT_POINTER(rbd_dev->layout.pool_ns, NULL);
+}
+
 /*
  * Fill an rbd image header with information from the given format 1
  * on-disk header.
@@ -1053,6 +1068,7 @@ static int rbd_header_from_disk(struct rbd_device *rbd_dev,
 	if (first_time) {
 		header->object_prefix = object_prefix;
 		header->obj_order = ondisk->options.order;
+		rbd_init_layout(rbd_dev);
 	} else {
 		ceph_put_snap_context(header->snapc);
 		kfree(header->snap_names);
@@ -4804,12 +4820,6 @@ static struct rbd_device *__rbd_dev_create(struct rbd_client *rbdc,
 	rbd_dev->rbd_client = rbdc;
 	rbd_dev->spec = spec;
 
-	rbd_dev->layout.stripe_unit = 1 << RBD_MAX_OBJ_ORDER;
-	rbd_dev->layout.stripe_count = 1;
-	rbd_dev->layout.object_size = 1 << RBD_MAX_OBJ_ORDER;
-	rbd_dev->layout.pool_id = spec->pool_id;
-	RCU_INIT_POINTER(rbd_dev->layout.pool_ns, NULL);
-
 	return rbd_dev;
 }
 
@@ -5848,12 +5858,13 @@ static int rbd_dev_v2_header_onetime(struct rbd_device *rbd_dev)
 			goto out_err;
 	}
 
+	rbd_init_layout(rbd_dev);
 	return 0;
+
 out_err:
 	rbd_dev->header.features = 0;
 	kfree(rbd_dev->header.object_prefix);
 	rbd_dev->header.object_prefix = NULL;
-
 	return ret;
 }
 
-- 
2.4.3

