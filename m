From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/5] rbd: define rbd_dev_unparent()
Date: Sat, 11 May 2013 12:44:12 -0500
Message-ID: <518E836C.9010404@inktank.com>
References: <518E831E.6000206@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:57468 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754227Ab3EKRoN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 11 May 2013 13:44:13 -0400
Received: by mail-ie0-f179.google.com with SMTP id c13so10146110ieb.10
        for <ceph-devel@vger.kernel.org>; Sat, 11 May 2013 10:44:13 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id kc10sm5817132igb.0.2013.05.11.10.44.12
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 11 May 2013 10:44:12 -0700 (PDT)
In-Reply-To: <518E831E.6000206@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Define rbd_dev_unparent() to encapsulate cleaning up parent data
structures from a layered rbd image.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index ac3f4e7..607c536 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1835,6 +1835,17 @@ static void rbd_obj_request_destroy(struct kref
*kref)
 	kmem_cache_free(rbd_obj_request_cache, obj_request);
 }

+/* It's OK to call this for a device with no parent */
+
+static void rbd_spec_put(struct rbd_spec *spec);
+static void rbd_dev_unparent(struct rbd_device *rbd_dev)
+{
+	rbd_dev_remove_parent(rbd_dev);
+	rbd_spec_put(rbd_dev->parent_spec);
+	rbd_dev->parent_spec = NULL;
+	rbd_dev->parent_overlap = 0;
+}
+
 /*
  * Caller is responsible for filling in the list of object requests
  * that comprises the image request, and the Linux request pointer
@@ -4062,9 +4073,7 @@ out_err:
 	rbd_dev->mapping.size = 0;
 	rbd_dev->header.image_size = 0;
 	rbd_dev->header.obj_order = 0;
-	rbd_dev->parent_overlap = 0;
-	rbd_spec_put(rbd_dev->parent_spec);
-	rbd_dev->parent_spec = NULL;
+	rbd_dev_unparent(rbd_dev);
 	rbd_dev->header.stripe_count = 0;
 	rbd_dev->header.stripe_unit = 0;
 	rbd_dev->header.features = 0;
@@ -4492,10 +4501,7 @@ static void rbd_dev_unprobe(struct rbd_device
*rbd_dev)
 {
 	struct rbd_image_header	*header;

-	rbd_dev_remove_parent(rbd_dev);
-	rbd_spec_put(rbd_dev->parent_spec);
-	rbd_dev->parent_spec = NULL;
-	rbd_dev->parent_overlap = 0;
+	rbd_dev_unparent(rbd_dev);

 	/* Free dynamic fields from the header, then zero it out */

@@ -4571,7 +4577,7 @@ static int rbd_dev_probe_parent(struct rbd_device
*rbd_dev)
 	return 0;
 out_err:
 	if (parent) {
-		rbd_spec_put(rbd_dev->parent_spec);
+		rbd_dev_unparent(rbd_dev);
 		kfree(rbd_dev->header_name);
 		rbd_dev_destroy(parent);
 	} else {
-- 
1.7.9.5

