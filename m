From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/4] rbd: unregister linger in watch sync routine
Date: Sat, 26 Jan 2013 14:40:41 -0600
Message-ID: <51043F49.2020904@inktank.com>
References: <51043EF2.4070305@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f181.google.com ([209.85.210.181]:34874 "EHLO
	mail-ia0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754120Ab3AZUkm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 26 Jan 2013 15:40:42 -0500
Received: by mail-ia0-f181.google.com with SMTP id k25so2430467iah.12
        for <ceph-devel@vger.kernel.org>; Sat, 26 Jan 2013 12:40:42 -0800 (PST)
In-Reply-To: <51043EF2.4070305@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Move the code that unregisters an rbd device's lingering header
object watch request into rbd_dev_header_watch_sync(), so it
occurs in the same function that originally sets up that request.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 47e5798..363a813 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1730,6 +1730,10 @@ static int rbd_dev_header_watch_sync(struct
rbd_device *rbd_dev, int start)
 	if (start) {
 		rbd_dev->watch_request = obj_request->osd_req;
 		ceph_osdc_set_request_linger(osdc, rbd_dev->watch_request);
+	} else {
+		ceph_osdc_unregister_linger_request(osdc,
+						rbd_dev->watch_request);
+		rbd_dev->watch_request = NULL;
 	}
 	ret = rbd_obj_request_submit(osdc, obj_request);
 	if (ret)
@@ -4040,12 +4044,6 @@ static void rbd_dev_release(struct device *dev)
 {
 	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);

-	if (rbd_dev->watch_request) {
-		struct ceph_client *client = rbd_dev->rbd_client->client;
-
-		ceph_osdc_unregister_linger_request(&client->osdc,
-						    rbd_dev->watch_request);
-	}
 	if (rbd_dev->watch_event)
 		rbd_dev_header_watch_sync(rbd_dev, 0);

-- 
1.7.9.5

