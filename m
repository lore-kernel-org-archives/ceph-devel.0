From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 5/6] rbd: num_ops parameter for rbd_osd_req_create()
Date: Fri, 21 Feb 2014 20:55:45 +0200
Message-ID: <1393008946-7931-6-git-send-email-ilya.dryomov@inktank.com>
References: <1393008946-7931-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:46504 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755848AbaBUS4G (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Feb 2014 13:56:06 -0500
Received: by mail-ee0-f41.google.com with SMTP id e49so1817179eek.0
        for <ceph-devel@vger.kernel.org>; Fri, 21 Feb 2014 10:56:05 -0800 (PST)
Received: from localhost ([109.110.66.27])
        by mx.google.com with ESMTPSA id v6sm29561793eef.2.2014.02.21.10.56.03
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 21 Feb 2014 10:56:04 -0800 (PST)
In-Reply-To: <1393008946-7931-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In preparation for prefixing rbd writes with an allocation hint
introduce a num_ops parameter for rbd_osd_req_create().  The rationale
is that not every write request is a write op that needs to be prefixed
(e.g. watch op), so the num_ops logic needs to be in the callers.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 drivers/block/rbd.c |   28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 48a889866824..6cf001ef00bc 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1718,6 +1718,7 @@ static void rbd_osd_req_format_write(struct rbd_obj_request *obj_request)
 static struct ceph_osd_request *rbd_osd_req_create(
 					struct rbd_device *rbd_dev,
 					bool write_request,
+					unsigned int num_ops,
 					struct rbd_obj_request *obj_request)
 {
 	struct ceph_snap_context *snapc = NULL;
@@ -1733,10 +1734,13 @@ static struct ceph_osd_request *rbd_osd_req_create(
 			snapc = img_request->snapc;
 	}
 
-	/* Allocate and initialize the request, for the single op */
+	rbd_assert(num_ops == 1);
+
+	/* Allocate and initialize the request, for the num_ops ops */
 
 	osdc = &rbd_dev->rbd_client->client->osdc;
-	osd_req = ceph_osdc_alloc_request(osdc, snapc, 1, false, GFP_ATOMIC);
+	osd_req = ceph_osdc_alloc_request(osdc, snapc, num_ops, false,
+					  GFP_ATOMIC);
 	if (!osd_req)
 		return NULL;	/* ENOMEM */
 
@@ -2220,8 +2224,8 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
 			pages += page_count;
 		}
 
-		osd_req = rbd_osd_req_create(rbd_dev, write_request,
-						obj_request);
+		osd_req = rbd_osd_req_create(rbd_dev, write_request, 1,
+					     obj_request);
 		if (!osd_req)
 			goto out_partial;
 		obj_request->osd_req = osd_req;
@@ -2604,8 +2608,8 @@ static int rbd_img_obj_exists_submit(struct rbd_obj_request *obj_request)
 
 	rbd_assert(obj_request->img_request);
 	rbd_dev = obj_request->img_request->rbd_dev;
-	stat_request->osd_req = rbd_osd_req_create(rbd_dev, false,
-						stat_request);
+	stat_request->osd_req = rbd_osd_req_create(rbd_dev, false, 1,
+						   stat_request);
 	if (!stat_request->osd_req)
 		goto out;
 	stat_request->callback = rbd_img_obj_exists_callback;
@@ -2808,7 +2812,8 @@ static int rbd_obj_notify_ack_sync(struct rbd_device *rbd_dev, u64 notify_id)
 		return -ENOMEM;
 
 	ret = -ENOMEM;
-	obj_request->osd_req = rbd_osd_req_create(rbd_dev, false, obj_request);
+	obj_request->osd_req = rbd_osd_req_create(rbd_dev, false, 1,
+						  obj_request);
 	if (!obj_request->osd_req)
 		goto out;
 
@@ -2871,7 +2876,8 @@ static int __rbd_dev_header_watch_sync(struct rbd_device *rbd_dev, bool start)
 	if (!obj_request)
 		goto out_cancel;
 
-	obj_request->osd_req = rbd_osd_req_create(rbd_dev, true, obj_request);
+	obj_request->osd_req = rbd_osd_req_create(rbd_dev, true, 1,
+						  obj_request);
 	if (!obj_request->osd_req)
 		goto out_cancel;
 
@@ -2979,7 +2985,8 @@ static int rbd_obj_method_sync(struct rbd_device *rbd_dev,
 	obj_request->pages = pages;
 	obj_request->page_count = page_count;
 
-	obj_request->osd_req = rbd_osd_req_create(rbd_dev, false, obj_request);
+	obj_request->osd_req = rbd_osd_req_create(rbd_dev, false, 1,
+						  obj_request);
 	if (!obj_request->osd_req)
 		goto out;
 
@@ -3212,7 +3219,8 @@ static int rbd_obj_read_sync(struct rbd_device *rbd_dev,
 	obj_request->pages = pages;
 	obj_request->page_count = page_count;
 
-	obj_request->osd_req = rbd_osd_req_create(rbd_dev, false, obj_request);
+	obj_request->osd_req = rbd_osd_req_create(rbd_dev, false, 1,
+						  obj_request);
 	if (!obj_request->osd_req)
 		goto out;
 
-- 
1.7.10.4

