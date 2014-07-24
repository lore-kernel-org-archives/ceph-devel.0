From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 2/8] rbd: introduce rbd_dev_header_info()
Date: Thu, 24 Jul 2014 12:42:43 +0400
Message-ID: <1406191369-6746-3-git-send-email-ilya.dryomov@inktank.com>
References: <1406191369-6746-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:43031 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934448AbaGXIm7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jul 2014 04:42:59 -0400
Received: by mail-lb0-f175.google.com with SMTP id 10so1976460lbg.20
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jul 2014 01:42:58 -0700 (PDT)
Received: from localhost ([109.110.66.237])
        by mx.google.com with ESMTPSA id tv3sm9593277lbb.49.2014.07.24.01.42.56
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 24 Jul 2014 01:42:57 -0700 (PDT)
In-Reply-To: <1406191369-6746-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

A wrapper around rbd_dev_v{1,2}_header_info() to reduce duplication.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 drivers/block/rbd.c |   24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 7847fbb949ff..0d3be608f16f 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -514,7 +514,7 @@ static void rbd_dev_remove_parent(struct rbd_device *rbd_dev);
 
 static int rbd_dev_refresh(struct rbd_device *rbd_dev);
 static int rbd_dev_v2_header_onetime(struct rbd_device *rbd_dev);
-static int rbd_dev_v2_header_info(struct rbd_device *rbd_dev);
+static int rbd_dev_header_info(struct rbd_device *rbd_dev);
 static const char *rbd_dev_v2_snap_name(struct rbd_device *rbd_dev,
 					u64 snap_id);
 static int _rbd_dev_v2_snap_size(struct rbd_device *rbd_dev, u64 snap_id,
@@ -3506,13 +3506,10 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev)
 	u64 mapping_size;
 	int ret;
 
-	rbd_assert(rbd_image_format_valid(rbd_dev->image_format));
 	down_write(&rbd_dev->header_rwsem);
 	mapping_size = rbd_dev->mapping.size;
-	if (rbd_dev->image_format == 1)
-		ret = rbd_dev_v1_header_info(rbd_dev);
-	else
-		ret = rbd_dev_v2_header_info(rbd_dev);
+
+	ret = rbd_dev_header_info(rbd_dev);
 
 	/* If it's a mapped snapshot, validate its EXISTS flag */
 
@@ -4501,6 +4498,16 @@ static int rbd_dev_v2_header_info(struct rbd_device *rbd_dev)
 	return ret;
 }
 
+static int rbd_dev_header_info(struct rbd_device *rbd_dev)
+{
+	rbd_assert(rbd_image_format_valid(rbd_dev->image_format));
+
+	if (rbd_dev->image_format == 1)
+		return rbd_dev_v1_header_info(rbd_dev);
+
+	return rbd_dev_v2_header_info(rbd_dev);
+}
+
 static int rbd_bus_add_dev(struct rbd_device *rbd_dev)
 {
 	struct device *dev;
@@ -5149,10 +5156,7 @@ static int rbd_dev_image_probe(struct rbd_device *rbd_dev, bool mapping)
 			goto out_header_name;
 	}
 
-	if (rbd_dev->image_format == 1)
-		ret = rbd_dev_v1_header_info(rbd_dev);
-	else
-		ret = rbd_dev_v2_header_info(rbd_dev);
+	ret = rbd_dev_header_info(rbd_dev);
 	if (ret)
 		goto err_out_watch;
 
-- 
1.7.10.4

