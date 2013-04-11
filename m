From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: update feature bits
Date: Thu, 11 Apr 2013 14:58:25 -0500
Message-ID: <516715E1.5090708@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:56391 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754624Ab3DKT60 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Apr 2013 15:58:26 -0400
Received: by mail-ie0-f175.google.com with SMTP id c12so2560019ieb.34
        for <ceph-devel@vger.kernel.org>; Thu, 11 Apr 2013 12:58:26 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There is a new rbd feature bit defined for "fancy striping." Add
it to the ones defined in the kernel client.

Change RBD_FEATURES_ALL so it represents the set of all feature
bits (rather than just the ones we support).  Define a new symbol
RBD_FEATURES_SUPPORTED to indicate the supported ones.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 11b7987..503e64f 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -73,11 +73,14 @@

 /* Feature bits */

-#define RBD_FEATURE_LAYERING      1
+#define RBD_FEATURE_LAYERING	(1<<0)
+#define RBD_FEATURE_STRIPINGV2	(1<<1)
+#define RBD_FEATURES_ALL \
+	    (RBD_FEATURE_LAYERING | RBD_FEATURE_STRIPINGV2)

 /* Features supported by this (client software) implementation. */

-#define RBD_FEATURES_ALL          (0)
+#define RBD_FEATURES_SUPPORTED	(0)

 /*
  * An RBD device name will be "rbd#", where the "rbd" comes from
@@ -2843,7 +2846,7 @@ static int _rbd_dev_v2_snap_features(struct
rbd_device *rbd_dev, u64 snap_id,
 		return ret;

 	incompat = le64_to_cpu(features_buf.incompat);
-	if (incompat & ~RBD_FEATURES_ALL)
+	if (incompat & ~RBD_FEATURES_SUPPORTED)
 		return -ENXIO;

 	*snap_features = le64_to_cpu(features_buf.features);
-- 
1.7.9.5

