From: Alex Elder <elder@inktank.com>
Subject: [PATCH 5/5] rbd: set up devices only for mapped images
Date: Mon, 29 Apr 2013 13:01:11 -0500
Message-ID: <517EB567.60303@inktank.com>
References: <517EB4F0.1070607@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f43.google.com ([209.85.128.43]:37336 "EHLO
	mail-qe0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758327Ab3D2SBN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Apr 2013 14:01:13 -0400
Received: by mail-qe0-f43.google.com with SMTP id 1so562970qec.30
        for <ceph-devel@vger.kernel.org>; Mon, 29 Apr 2013 11:01:13 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id z2sm35808091qad.4.2013.04.29.11.01.12
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 29 Apr 2013 11:01:12 -0700 (PDT)
In-Reply-To: <517EB4F0.1070607@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Stop setting up Linux devices during the image probe operation.
Instead, set up the devices as a separate step after the image
probe, in rbd_add().

A consequence of this is that only mapped images get devices
assigned to them, which is pretty sweet.

This resolves:
    http://tracker.ceph.com/issues/4774

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index ff850e9..8b680ad 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4880,14 +4880,9 @@ static int rbd_dev_image_probe(struct rbd_device
*rbd_dev)
 		goto err_out_snaps;

 	ret = rbd_dev_probe_parent(rbd_dev);
-	if (ret)
-		goto err_out_snaps;
-
-	ret = rbd_dev_device_setup(rbd_dev);
 	if (!ret)
 		return 0;

-	rbd_dev_remove_parent(rbd_dev);
 err_out_snaps:
 	rbd_remove_all_snaps(rbd_dev);
 err_out_probe:
@@ -4966,9 +4961,12 @@ static ssize_t rbd_add(struct bus_type *bus,
 	if (rc < 0)
 		goto err_out_rbd_dev;

-	return count;
+	rc = rbd_dev_device_setup(rbd_dev);
+	if (!rc)
+		return count;
+
+	rbd_dev_image_release(rbd_dev);
 err_out_rbd_dev:
-	kfree(rbd_dev->header_name);
 	rbd_dev_destroy(rbd_dev);
 err_out_client:
 	rbd_put_client(rbdc);
@@ -5031,7 +5029,6 @@ static void rbd_dev_remove_parent(struct
rbd_device *rbd_dev)
 			second = third;
 		}
 		rbd_assert(second);
-		rbd_bus_del_dev(second);
 		rbd_dev_image_release(second);
 		first->parent = NULL;
 		first->parent_overlap = 0;
-- 
1.7.9.5

