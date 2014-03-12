From: Guangliang Zhao <lucienchao@gmail.com>
Subject: [PATCH 1/3] rbd: skip the copyup when an entire object writing
Date: Wed, 12 Mar 2014 12:24:43 +0800
Message-ID: <1394598285-17225-2-git-send-email-lucienchao@gmail.com>
References: <1394598285-17225-1-git-send-email-lucienchao@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:60070 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbaCLEZB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Mar 2014 00:25:01 -0400
Received: by mail-pa0-f48.google.com with SMTP id hz1so526863pad.21
        for <ceph-devel@vger.kernel.org>; Tue, 11 Mar 2014 21:25:00 -0700 (PDT)
In-Reply-To: <1394598285-17225-1-git-send-email-lucienchao@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com

It need to copyup the parent's content when layered writing,
but an entire object write would overwrite it, so skip it.

Signed-off-by: Guangliang Zhao <lucienchao@gmail.com>
---
 drivers/block/rbd.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b365e0d..965b9b9 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2629,12 +2629,14 @@ static int rbd_img_obj_request_submit(struct rbd_obj_request *obj_request)
 	struct rbd_img_request *img_request;
 	struct rbd_device *rbd_dev;
 	bool known;
+	u64 obj_size;
 
 	rbd_assert(obj_request_img_data_test(obj_request));
 
 	img_request = obj_request->img_request;
 	rbd_assert(img_request);
 	rbd_dev = img_request->rbd_dev;
+	obj_size = (u64) 1 << rbd_dev->header.obj_order;
 
 	/*
 	 * Only writes to layered images need special handling.
@@ -2644,11 +2646,15 @@ static int rbd_img_obj_request_submit(struct rbd_obj_request *obj_request)
 	 * simple object requests.  Finally, if the target object is
 	 * known to already exist, its parent data has already been
 	 * copied, so a write to the object can also be handled as a
-	 * simple object request.
+	 * simple object request. Another type: if the obj_request
+	 * aligns with the boundary and equals to the size of an object,
+	 * it doesn't need copyup, because the obj_request will overwrite
+	 * it finally.
 	 */
 	if (!img_request_write_test(img_request) ||
 		!img_request_layered_test(img_request) ||
 		rbd_dev->parent_overlap <= obj_request->img_offset ||
+		((!obj_request->offset) && (obj_request->length == obj_size)) ||
 		((known = obj_request_known_test(obj_request)) &&
 			obj_request_exists_test(obj_request))) {
 
-- 
1.7.9.5

