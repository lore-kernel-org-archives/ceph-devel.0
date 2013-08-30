From: Josh Durgin <josh.durgin@inktank.com>
Subject: [PATCH v2 3/3] rbd: make rbd_obj_notify_ack() synchronous
Date: Thu, 29 Aug 2013 17:57:08 -0700
Message-ID: <1377824228-14632-3-git-send-email-josh.durgin@inktank.com>
References: <1377824228-14632-1-git-send-email-josh.durgin@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:39835 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395Ab3H3BJl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Aug 2013 21:09:41 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id A9A2626391
	for <ceph-devel@vger.kernel.org>; Thu, 29 Aug 2013 18:13:35 -0700 (PDT)
Received: from vit.ops.newdream.net (unknown [38.122.20.226])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id A2A1226389
	for <ceph-devel@vger.kernel.org>; Thu, 29 Aug 2013 18:13:35 -0700 (PDT)
In-Reply-To: <1377824228-14632-1-git-send-email-josh.durgin@inktank.com>
In-Reply-To: <1377757447-23515-4-git-send-email-josh.durgin@inktank.com>
References: <1377757447-23515-4-git-send-email-josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The only user is rbd_watch_cb(). If this is asynchronous, there is no
tracking of when it completes, so it may still be in progress when the
osd_client is shut down.  This results in a BUG() since the osd client
assumes no requests are in flight when it stops. Since all notifies
are flushed now, waiting for the notify ack to complete before
returning from the watch callback ensures there are no notify acks in
flight during shutdown.

Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
---
 drivers/block/rbd.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 2223617..0e83a10 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2826,13 +2826,15 @@ static int rbd_obj_notify_ack(struct rbd_device *rbd_dev, u64 notify_id)
 	obj_request->osd_req = rbd_osd_req_create(rbd_dev, false, obj_request);
 	if (!obj_request->osd_req)
 		goto out;
-	obj_request->callback = rbd_obj_request_put;
 
 	osd_req_op_watch_init(obj_request->osd_req, 0, CEPH_OSD_OP_NOTIFY_ACK,
 					notify_id, 0, 0);
 	rbd_osd_req_format_read(obj_request);
 
 	ret = rbd_obj_request_submit(osdc, obj_request);
+	if (ret)
+		goto out;
+	ret = rbd_obj_request_wait(obj_request);
 out:
 	if (ret)
 		rbd_obj_request_put(obj_request);
-- 
1.7.2.5

