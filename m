From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/5] rbd: fix an incorrect assertion condition
Date: Wed, 08 May 2013 17:07:42 -0500
Message-ID: <518ACCAE.4050600@inktank.com>
References: <518ACC55.7090100@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:43125 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774Ab3EHWHo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 May 2013 18:07:44 -0400
Received: by mail-ob0-f170.google.com with SMTP id er7so895960obc.1
        for <ceph-devel@vger.kernel.org>; Wed, 08 May 2013 15:07:43 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id nt17sm242494obb.13.2013.05.08.15.07.42
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 08 May 2013 15:07:42 -0700 (PDT)
In-Reply-To: <518ACC55.7090100@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In rbd_img_obj_parent_read_full_callback() there is an assertion
intended to verify the size of the image request for a full parent
read was the size of the original request's target object.  But
assertion was looking at the parent image order rather than the
original one, and these values can differ.

Fix that.

This resolves:
    http://tracker.ceph.com/issues/4938

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 0d874a5..15ac2a5 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2186,13 +2186,13 @@ rbd_img_obj_parent_read_full_callback(struct
rbd_img_request *img_request)
 	result = img_request->result;
 	obj_size = img_request->length;
 	xferred = img_request->xferred;
+	rbd_img_request_put(img_request);

-	rbd_dev = img_request->rbd_dev;
+	rbd_assert(orig_request->img_request);
+	rbd_dev = orig_request->img_request->rbd_dev;
 	rbd_assert(rbd_dev);
 	rbd_assert(obj_size == (u64)1 << rbd_dev->header.obj_order);

-	rbd_img_request_put(img_request);
-
 	if (result)
 		goto out_err;

-- 
1.7.9.5

