From: mchristi@redhat.com
Subject: [PATCH 07/18] rbd: add num ops calculator helper
Date: Wed, 29 Jul 2015 04:23:44 -0500
Message-ID: <1438161835-27960-7-git-send-email-mchristi@redhat.com>
References: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49887 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752515AbbG2JYB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Jul 2015 05:24:01 -0400
In-Reply-To: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, target-devel@vger.kernel.org

From: Mike Christie <michaelc@cs.wisc.edu>

The next patches add new commands that have different
number of ops, so this adds a helper.

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
---
 drivers/block/rbd.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 8d0b30a..425c3d8 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -813,6 +813,16 @@ static int parse_rbd_opts_token(char *c, void *private)
 	return 0;
 }
 
+static int obj_num_ops(enum obj_operation_type op_type)
+{
+	switch (op_type) {
+	case OBJ_OP_WRITE:
+		return 2;
+	default:
+		return 1;
+	}
+}
+
 static char* obj_op_name(enum obj_operation_type op_type)
 {
 	switch (op_type) {
@@ -1987,7 +1997,7 @@ static struct ceph_osd_request *rbd_osd_req_create(
 		snapc = img_request->snapc;
 	}
 
-	rbd_assert(num_ops == 1 || ((op_type == OBJ_OP_WRITE) && num_ops == 2));
+	rbd_assert(num_ops == 1 || obj_num_ops(op_type) == num_ops);
 
 	/* Allocate and initialize the request, for the num_ops ops */
 
@@ -2589,8 +2599,7 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
 		}
 
 		osd_req = rbd_osd_req_create(rbd_dev, op_type,
-					(op_type == OBJ_OP_WRITE) ? 2 : 1,
-					obj_request);
+					     obj_num_ops(op_type), obj_request);
 		if (!osd_req)
 			goto out_unwind;
 
-- 
1.8.3.1

