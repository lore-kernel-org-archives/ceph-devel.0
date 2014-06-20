From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 3/4] rbd: rbd_obj_request_wait() should cancel the request if interrupted
Date: Fri, 20 Jun 2014 13:09:42 +0400
Message-ID: <1403255383-5729-4-git-send-email-ilya.dryomov@inktank.com>
References: <1403255383-5729-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:61123 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965860AbaFTJJz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jun 2014 05:09:55 -0400
Received: by mail-lb0-f172.google.com with SMTP id c11so2183312lbj.31
        for <ceph-devel@vger.kernel.org>; Fri, 20 Jun 2014 02:09:54 -0700 (PDT)
Received: from localhost ([109.110.66.173])
        by mx.google.com with ESMTPSA id ob4sm6144013lbc.30.2014.06.20.02.09.52
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 20 Jun 2014 02:09:53 -0700 (PDT)
In-Reply-To: <1403255383-5729-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

rbd_obj_request_wait() should cancel the underlying OSD request if
interrupted.  Otherwise libceph will hold onto it indefinitely, causing
assert failures or leaking the original object request.

Fixes: http://tracker.ceph.com/issues/6628

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 drivers/block/rbd.c |   20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b2c98c1bc037..1701595648ce 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1558,13 +1558,25 @@ static void rbd_img_request_complete(struct rbd_img_request *img_request)
 		rbd_img_request_put(img_request);
 }
 
-/* Caller is responsible for rbd_obj_request_destroy(obj_request) */
-
+/*
+ * Wait for an object request to complete.  If interrupted, cancel the
+ * underlying osd request.
+ */
 static int rbd_obj_request_wait(struct rbd_obj_request *obj_request)
 {
-	dout("%s: obj %p\n", __func__, obj_request);
+	int ret;
+
+	dout("%s obj %p\n", __func__, obj_request);
 
-	return wait_for_completion_interruptible(&obj_request->completion);
+	ret = wait_for_completion_interruptible(&obj_request->completion);
+	if (ret < 0) {
+		dout("%s obj %p interrupted\n", __func__, obj_request);
+		ceph_osdc_cancel_request(obj_request->osd_req);
+		return ret;
+	}
+
+	dout("%s obj %p done\n", __func__, obj_request);
+	return 0;
 }
 
 /*
-- 
1.7.10.4

