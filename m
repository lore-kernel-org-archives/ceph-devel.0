From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/6] rbd: encapsulate removing parent devices
Date: Sat, 27 Apr 2013 07:36:47 -0500
Message-ID: <517BC65F.90300@inktank.com>
References: <517BC608.5030008@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f170.google.com ([209.85.210.170]:35089 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440Ab3D0Mgs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 27 Apr 2013 08:36:48 -0400
Received: by mail-ia0-f170.google.com with SMTP id k20so1360143iak.1
        for <ceph-devel@vger.kernel.org>; Sat, 27 Apr 2013 05:36:48 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id d4sm7770553igc.3.2013.04.27.05.36.47
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 05:36:47 -0700 (PDT)
In-Reply-To: <517BC608.5030008@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Encapsulate the code that removes an rbd device's parent images into
a new function, rbd_dev_remove_parent().

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   46 +++++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 88cd5f4..fa703db 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -427,8 +427,9 @@ void rbd_warn(struct rbd_device *rbd_dev, const char
*fmt, ...)
 #  define rbd_assert(expr)	((void) 0)
 #endif /* !RBD_DEBUG */

-static void rbd_img_parent_read(struct rbd_obj_request *obj_request);
 static int rbd_img_obj_request_submit(struct rbd_obj_request *obj_request);
+static void rbd_img_parent_read(struct rbd_obj_request *obj_request);
+static void rbd_dev_remove_parent(struct rbd_device *rbd_dev);

 static int rbd_dev_refresh(struct rbd_device *rbd_dev, u64 *hver);
 static int rbd_dev_v2_refresh(struct rbd_device *rbd_dev, u64 *hver);
@@ -4987,6 +4988,29 @@ static void __rbd_remove(struct rbd_device *rbd_dev)
 	rbd_bus_del_dev(rbd_dev);
 }

+static void rbd_dev_remove_parent(struct rbd_device *rbd_dev)
+{
+	while (rbd_dev->parent_spec) {
+		struct rbd_device *first = rbd_dev;
+		struct rbd_device *second = first->parent;
+		struct rbd_device *third;
+
+		/*
+		 * Follow to the parent with no grandparent and
+		 * remove it.
+		 */
+		while (second && (third = second->parent)) {
+			first = second;
+			second = third;
+		}
+		__rbd_remove(second);
+		rbd_spec_put(first->parent_spec);
+		first->parent_spec = NULL;
+		first->parent_overlap = 0;
+		first->parent = NULL;
+	}
+}
+
 static ssize_t rbd_remove(struct bus_type *bus,
 			  const char *buf,
 			  size_t count)
@@ -5022,25 +5046,9 @@ static ssize_t rbd_remove(struct bus_type *bus,
 	if (ret < 0)
 		goto done;

-	while (rbd_dev->parent_spec) {
-		struct rbd_device *first = rbd_dev;
-		struct rbd_device *second = first->parent;
-		struct rbd_device *third;
+	if (rbd_dev->parent)
+		rbd_dev_remove_parent(rbd_dev);

-		/*
-		 * Follow to the parent with no grandparent and
-		 * remove it.
-		 */
-		while (second && (third = second->parent)) {
-			first = second;
-			second = third;
-		}
-		__rbd_remove(second);
-		rbd_spec_put(first->parent_spec);
-		first->parent_spec = NULL;
-		first->parent_overlap = 0;
-		first->parent = NULL;
-	}
 	__rbd_remove(rbd_dev);

 done:
-- 
1.7.9.5

