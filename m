From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: fix image request leak on parent read
Date: Thu, 02 May 2013 06:51:08 -0500
Message-ID: <5182532C.80400@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f179.google.com ([209.85.210.179]:64454 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756090Ab3EBLvK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 May 2013 07:51:10 -0400
Received: by mail-ia0-f179.google.com with SMTP id g4so391569iae.10
        for <ceph-devel@vger.kernel.org>; Thu, 02 May 2013 04:51:09 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id xc3sm16865248igb.10.2013.05.02.04.51.08
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 02 May 2013 04:51:08 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

When a read for a layered image object finds the target object
doesn't exist, a read image request for the parent image is created
and submitted.  When that completes, the callback routine was
not releasing that parent image request.  Fix that.

The slab allocation stuff just added has greatly simplified the
search for the source of this memory leak.

This resolves:
    http://tracker.ceph.com/issues/4803

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 8d9aeef..d669f71 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2547,6 +2547,7 @@ static void rbd_img_parent_read_callback(struct
rbd_img_request *img_request)
 		obj_request->xferred = img_request->xferred;
 	}
 out:
+	rbd_img_request_put(img_request);
 	rbd_img_obj_request_read_callback(obj_request);
 	rbd_obj_request_complete(obj_request);
 }
-- 
1.7.9.5

