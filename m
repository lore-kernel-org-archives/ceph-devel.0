From: Alex Elder <elder@inktank.com>
Subject: [PATCH 01/11] rbd: record overall image request result
Date: Thu, 11 Apr 2013 21:17:03 -0500
Message-ID: <51676E9F.3030607@inktank.com>
References: <51676E0F.2010504@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f179.google.com ([209.85.210.179]:38326 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab3DLCRF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Apr 2013 22:17:05 -0400
Received: by mail-ia0-f179.google.com with SMTP id l25so1979009iad.38
        for <ceph-devel@vger.kernel.org>; Thu, 11 Apr 2013 19:17:03 -0700 (PDT)
In-Reply-To: <51676E0F.2010504@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

If any image object request produces a non-zero result, preserve
that as the result of the overall image request.  If multiple
objects have non-zero results, save only the first one.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 503e64f..69eab66 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -214,6 +214,7 @@ struct rbd_img_request {
 	spinlock_t		completion_lock;/* protects next_completion */
 	u32			next_completion;
 	rbd_img_callback_t	callback;
+	int			result;	/* first nonzero obj_request result */

 	u32			obj_request_count;
 	struct list_head	obj_requests;	/* rbd_obj_request structs */
@@ -1488,6 +1489,7 @@ static struct rbd_img_request *rbd_img_request_create(
 	spin_lock_init(&img_request->completion_lock);
 	img_request->next_completion = 0;
 	img_request->callback = NULL;
+	img_request->result = 0;
 	img_request->obj_request_count = 0;
 	INIT_LIST_HEAD(&img_request->obj_requests);
 	kref_init(&img_request->kref);
@@ -1552,13 +1554,16 @@ static void rbd_img_obj_callback(struct
rbd_obj_request *obj_request)
 		if (!obj_request_done_test(obj_request))
 			break;

-		rbd_assert(obj_request->xferred <= (u64) UINT_MAX);
-		xferred = (unsigned int) obj_request->xferred;
-		result = (int) obj_request->result;
-		if (result)
+		rbd_assert(obj_request->xferred <= (u64)UINT_MAX);
+		xferred = (unsigned int)obj_request->xferred;
+		result = obj_request->result;
+		if (result) {
 			rbd_warn(NULL, "obj_request %s result %d xferred %u\n",
 				img_request->write_request ? "write" : "read",
 				result, xferred);
+			if (!img_request->result)
+				img_request->result = result;
+		}

 		more = blk_end_request(img_request->rq, result, xferred);
 		which++;
-- 
1.7.9.5

