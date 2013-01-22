From: Alex Elder <elder@inktank.com>
Subject: [PATCH 10/12] rbd: send notify ack asynchronously
Date: Tue, 22 Jan 2013 16:30:59 -0600
Message-ID: <50FF1323.20208@inktank.com>
References: <50FF11EA.3000808@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:55168 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190Ab3AVWbD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 17:31:03 -0500
Received: by mail-ie0-f172.google.com with SMTP id c13so12674414ieb.3
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 14:31:02 -0800 (PST)
In-Reply-To: <50FF11EA.3000808@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

When we receive notification of a change to an rbd image's header
object we need to refresh our information about the image (its
size and snapshot context).  Once we have refreshed our rbd image
we need to acknowledge the notification.

This acknowledgement was previously done synchronously, but there's
really no need to wait for it to complete.

Change it so the caller doesn't wait for the notify acknowledgement
request to complete.  And change the name to reflect it's no longer
synchronous.

This resolves:
    http://tracker.newdream.net/issues/3877

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index a6ca5db..e66695a 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1775,7 +1775,7 @@ static int rbd_image_request_submit(struct
rbd_image_request *image_request)
 	return ret;
 }

-static int rbd_obj_notify_ack_sync(struct rbd_device *rbd_dev,
+static int rbd_obj_notify_ack(struct rbd_device *rbd_dev,
 				   u64 ver, u64 notify_id)
 {
 	struct rbd_obj_request *obj_request;
@@ -1799,11 +1799,11 @@ static int rbd_obj_notify_ack_sync(struct
rbd_device *rbd_dev,
 		goto out_err;

 	osdc = &rbd_dev->rbd_client->client->osdc;
+	obj_request->callback = rbd_obj_request_put;
 	ret = rbd_obj_request_submit(osdc, obj_request);
-	if (!ret)
-		ret = rbd_obj_request_wait(obj_request);
 out_err:
-	rbd_obj_request_put(obj_request);
+	if (ret)
+		rbd_obj_request_put(obj_request);

 	return ret;
 }
@@ -1825,7 +1825,7 @@ static void rbd_watch_cb(u64 ver, u64 notify_id,
u8 opcode, void *data)
 		rbd_warn(rbd_dev, "got notification but failed to "
 			   " update snaps: %d\n", rc);

-	rbd_obj_notify_ack_sync(rbd_dev, hver, notify_id);
+	rbd_obj_notify_ack(rbd_dev, hver, notify_id);
 }

 /*
-- 
1.7.9.5

