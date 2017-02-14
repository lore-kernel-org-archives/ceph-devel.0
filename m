From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 02/15] rbd: kill rbd_image_header::{crypt_type,comp_type}
Date: Tue, 14 Feb 2017 21:11:51 +0100
Message-ID: <1487103124-2974-3-git-send-email-idryomov@gmail.com>
References: <1487103124-2974-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36133 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754730AbdBNUMc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Feb 2017 15:12:32 -0500
Received: by mail-qk0-f195.google.com with SMTP id p22so12928996qka.3
        for <ceph-devel@vger.kernel.org>; Tue, 14 Feb 2017 12:12:31 -0800 (PST)
In-Reply-To: <1487103124-2974-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@ieee.org>

Image format 1 is deprecated and format 2 doesn't have these.  Also,
__rbd_dev_create() takes care of zeroing (or otherwise initializing)
format 2 specific fields.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c       | 9 ---------
 drivers/block/rbd_types.h | 3 ---
 2 files changed, 12 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 76e538c3378e..a6ad714c85ac 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -144,8 +144,6 @@ struct rbd_image_header {
 	/* These six fields never change for a given rbd image */
 	char *object_prefix;
 	__u8 obj_order;
-	__u8 crypt_type;
-	__u8 comp_type;
 	u64 stripe_unit;
 	u64 stripe_count;
 	u64 features;		/* Might be changeable someday? */
@@ -1047,12 +1045,6 @@ static int rbd_header_from_disk(struct rbd_device *rbd_dev,
 	if (first_time) {
 		header->object_prefix = object_prefix;
 		header->obj_order = ondisk->options.order;
-		header->crypt_type = ondisk->options.crypt_type;
-		header->comp_type = ondisk->options.comp_type;
-		/* The rest aren't used for format 1 images */
-		header->stripe_unit = 0;
-		header->stripe_count = 0;
-		header->features = 0;
 	} else {
 		ceph_put_snap_context(header->snapc);
 		kfree(header->snap_names);
@@ -5938,7 +5930,6 @@ static int rbd_dev_v2_header_onetime(struct rbd_device *rbd_dev)
 		if (ret < 0)
 			goto out_err;
 	}
-	/* No support for crypto and compression type format 2 images */
 
 	return 0;
 out_err:
diff --git a/drivers/block/rbd_types.h b/drivers/block/rbd_types.h
index 94f367db27b0..be9c76d292f5 100644
--- a/drivers/block/rbd_types.h
+++ b/drivers/block/rbd_types.h
@@ -57,9 +57,6 @@ enum rbd_notify_op {
 #define RBD_MIN_OBJ_ORDER       16
 #define RBD_MAX_OBJ_ORDER       30
 
-#define RBD_COMP_NONE		0
-#define RBD_CRYPT_NONE		0
-
 #define RBD_HEADER_TEXT		"<<< Rados Block Device Image >>>\n"
 #define RBD_HEADER_SIGNATURE	"RBD"
 #define RBD_HEADER_VERSION	"001.005"
-- 
2.4.3

