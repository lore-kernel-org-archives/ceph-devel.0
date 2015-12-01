From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] rbd: don't put snap_context twice in rbd_queue_workfn()
Date: Tue,  1 Dec 2015 21:04:29 +0100
Message-ID: <1449000269-27732-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:33325 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754908AbbLAUEv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Dec 2015 15:04:51 -0500
Received: by wmec201 with SMTP id c201so222721427wme.0
        for <ceph-devel@vger.kernel.org>; Tue, 01 Dec 2015 12:04:50 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Josh Durgin <jdurgin@redhat.com>

Commit 4e752f0ab0e8 ("rbd: access snapshot context and mapping size
safely") moved ceph_get_snap_context() out of rbd_img_request_create()
and into rbd_queue_workfn(), adding a ceph_put_snap_context() to the
error path in rbd_queue_workfn().  However, rbd_img_request_create()
consumes a ref on snapc, so calling ceph_put_snap_context() after
a successful rbd_img_request_create() leads to an extra put.  Fix it.

Cc: stable@vger.kernel.org # 3.18+
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 24a757e97d56..4a876785b68c 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3442,6 +3442,7 @@ static void rbd_queue_workfn(struct work_struct *work)
 		goto err_rq;
 	}
 	img_request->rq = rq;
+	snapc = NULL; /* img_request consumes a ref */
 
 	if (op_type == OBJ_OP_DISCARD)
 		result = rbd_img_request_fill(img_request, OBJ_REQUEST_NODATA,
-- 
2.4.3

