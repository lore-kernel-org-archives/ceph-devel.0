From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/7] rbd: adjust image object request ref counting
Date: Mon, 15 Apr 2013 22:38:15 -0500
Message-ID: <516CC7A7.5060907@inktank.com>
References: <516CC6E4.6070307@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f176.google.com ([209.85.210.176]:36930 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935355Ab3DPDiR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Apr 2013 23:38:17 -0400
Received: by mail-ia0-f176.google.com with SMTP id i9so47341iad.7
        for <ceph-devel@vger.kernel.org>; Mon, 15 Apr 2013 20:38:17 -0700 (PDT)
In-Reply-To: <516CC6E4.6070307@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

An extra reference is taken when an object request is added as one
of the requests making up an image object.  A reference is dropped
again when the image's object requests get submitted.

The original reference for the object request will remain throughout
this period, so we don't need to add and then take away an extra
one.

This can be interpreted as the image request inheriting the original
object request's reference.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 8e8b876..81751cd 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1167,7 +1167,7 @@ static inline void rbd_img_obj_request_add(struct
rbd_img_request *img_request,
 {
 	rbd_assert(obj_request->img_request == NULL);

-	rbd_obj_request_get(obj_request);
+	/* Image request now owns object's original reference */
 	obj_request->img_request = img_request;
 	obj_request->which = img_request->obj_request_count;
 	rbd_assert(!obj_request_img_data_test(obj_request));
@@ -1815,12 +1815,6 @@ static int rbd_img_request_submit(struct
rbd_img_request *img_request)
 		ret = rbd_obj_request_submit(osdc, obj_request);
 		if (ret)
 			return ret;
-		/*
-		 * The image request has its own reference to each
-		 * of its object requests, so we can safely drop the
-		 * initial one here.
-		 */
-		rbd_obj_request_put(obj_request);
 	}

 	return 0;
-- 
1.7.9.5

