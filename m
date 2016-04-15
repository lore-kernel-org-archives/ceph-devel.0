From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] rbd: report unsupported features to syslog
Date: Fri, 15 Apr 2016 21:25:45 +0200
Message-ID: <1460748345-3717-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33843 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932138AbcDOT0O (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Apr 2016 15:26:14 -0400
Received: by mail-qk0-f182.google.com with SMTP id r184so41272820qkc.1
        for <ceph-devel@vger.kernel.org>; Fri, 15 Apr 2016 12:26:14 -0700 (PDT)
Received: from dhcp-1-141.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n124sm14282526qhc.37.2016.04.15.12.26.12
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Apr 2016 12:26:12 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

... instead of just returning an error.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 9f1eb00b5e64..78aca585e7e5 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4184,7 +4184,7 @@ static int _rbd_dev_v2_snap_features(struct rbd_device *rbd_dev, u64 snap_id,
 		__le64 features;
 		__le64 incompat;
 	} __attribute__ ((packed)) features_buf = { 0 };
-	u64 incompat;
+	u64 unsup;
 	int ret;
 
 	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_name,
@@ -4197,9 +4197,12 @@ static int _rbd_dev_v2_snap_features(struct rbd_device *rbd_dev, u64 snap_id,
 	if (ret < sizeof (features_buf))
 		return -ERANGE;
 
-	incompat = le64_to_cpu(features_buf.incompat);
-	if (incompat & ~RBD_FEATURES_SUPPORTED)
+	unsup = le64_to_cpu(features_buf.incompat) & ~RBD_FEATURES_SUPPORTED;
+	if (unsup) {
+		rbd_warn(rbd_dev, "image uses unsupported features: 0x%llx",
+			 unsup);
 		return -ENXIO;
+	}
 
 	*snap_features = le64_to_cpu(features_buf.features);
 
-- 
2.4.3

