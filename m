From: Alex Elder <elder@inktank.com>
Subject: [PATCH 02/11] rbd: record aggregate image transfer count
Date: Thu, 11 Apr 2013 21:17:15 -0500
Message-ID: <51676EAB.1030804@inktank.com>
References: <51676E0F.2010504@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f170.google.com ([209.85.210.170]:41590 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974Ab3DLCRR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Apr 2013 22:17:17 -0400
Received: by mail-ia0-f170.google.com with SMTP id j38so2008477iad.1
        for <ceph-devel@vger.kernel.org>; Thu, 11 Apr 2013 19:17:16 -0700 (PDT)
In-Reply-To: <51676E0F.2010504@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Compute the total number of bytes transferred for an image
request--the sum across each of the request's object requests.
To avoid contention do it only when all object requests are
complete, in rbd_img_request_complete().

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 69eab66..e8374ae 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -214,6 +214,7 @@ struct rbd_img_request {
 	spinlock_t		completion_lock;/* protects next_completion */
 	u32			next_completion;
 	rbd_img_callback_t	callback;
+	u64			xferred;/* aggregate bytes transferred */
 	int			result;	/* first nonzero obj_request result */

 	u32			obj_request_count;
@@ -1148,7 +1149,24 @@ static int rbd_obj_request_submit(struct
ceph_osd_client *osdc,

 static void rbd_img_request_complete(struct rbd_img_request *img_request)
 {
+
 	dout("%s: img %p\n", __func__, img_request);
+
+	/*
+	 * If no error occurred, compute the aggregate transfer
+	 * count for the image request.  We could instead use
+	 * atomic64_cmpxchg() to update it as each object request
+	 * completes; not clear which way is better off hand.
+	 */
+	if (!img_request->result) {
+		struct rbd_obj_request *obj_request;
+		u64 xferred = 0;
+
+		for_each_obj_request(img_request, obj_request)
+			xferred += obj_request->xferred;
+		img_request->xferred = xferred;
+	}
+
 	if (img_request->callback)
 		img_request->callback(img_request);
 	else
-- 
1.7.9.5

