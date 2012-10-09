From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/4] rbd: implement feature checks
Date: Tue, 09 Oct 2012 14:01:00 -0700
Message-ID: <5074908C.3010808@inktank.com>
References: <50748FA5.4030508@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34485 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756508Ab2JIVBH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Oct 2012 17:01:07 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so5612010pad.19
        for <ceph-devel@vger.kernel.org>; Tue, 09 Oct 2012 14:01:07 -0700 (PDT)
In-Reply-To: <50748FA5.4030508@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Version 2 images have two sets of feature bit fields.  The first
indicates features possibly used by the image.  The second indicates
features that the client *must* support in order to use the image.

When an image (or snapshot) is first examined, we need to make sure
that the local implementation supports the image's required
features.  If not, fail the probe for the image.

Signed-off-by: Alex Elder <elder@inktank.com>
---
  drivers/block/rbd.c |   16 +++++++++++++++-
  1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 23f3beb..86ab032 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -70,6 +70,14 @@
  #define RBD_IMAGE_ID_LEN_MAX	64
  #define RBD_OBJ_PREFIX_LEN_MAX	64

+/* Feature bits */
+
+#define RBD_FEATURE_LAYERING      1
+
+/* Features supported by this (client software) implementation. */
+
+#define RBD_FEATURES_ALL          (0)
+
  /*
   * An RBD device name will be "rbd#", where the "rbd" comes from
   * RBD_DRV_NAME above, and # is a unique integer identifier.
@@ -2225,6 +2233,7 @@ static int _rbd_dev_v2_snap_features(struct 
rbd_device *rbd_dev, u64 snap_id,
  		__le64 features;
  		__le64 incompat;
  	} features_buf = { 0 };
+	u64 incompat;
  	int ret;

  	ret = rbd_req_sync_exec(rbd_dev, rbd_dev->header_name,
@@ -2235,6 +2244,11 @@ static int _rbd_dev_v2_snap_features(struct 
rbd_device *rbd_dev, u64 snap_id,
  	dout("%s: rbd_req_sync_exec returned %d\n", __func__, ret);
  	if (ret < 0)
  		return ret;
+
+	incompat = le64_to_cpu(features_buf.incompat);
+	if (incompat & ~RBD_FEATURES_ALL)
+		return -ENOTSUPP;
+
  	*snap_features = le64_to_cpu(features_buf.features);

  	dout("  snap_id 0x%016llx features = 0x%016llx incompat = 0x%016llx\n",
@@ -2976,7 +2990,7 @@ static int rbd_dev_v2_probe(struct rbd_device 
*rbd_dev)
  	if (ret < 0)
  		goto out_err;

-	/* Get the features for the image */
+	/* Get the and check features for the image */

  	ret = rbd_dev_v2_features(rbd_dev);
  	if (ret < 0)
-- 
1.7.9.5

