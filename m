From: Josh Durgin <josh.durgin@inktank.com>
Subject: [PATCH v2 2/3] rbd: complete notifies before cleaning up osd_client and rbd_dev
Date: Thu, 29 Aug 2013 17:57:07 -0700
Message-ID: <1377824228-14632-2-git-send-email-josh.durgin@inktank.com>
References: <1377824228-14632-1-git-send-email-josh.durgin@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:39832 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395Ab3H3BJk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Aug 2013 21:09:40 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 671C026391
	for <ceph-devel@vger.kernel.org>; Thu, 29 Aug 2013 18:13:34 -0700 (PDT)
Received: from vit.ops.newdream.net (unknown [38.122.20.226])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 602E826389
	for <ceph-devel@vger.kernel.org>; Thu, 29 Aug 2013 18:13:34 -0700 (PDT)
In-Reply-To: <1377824228-14632-1-git-send-email-josh.durgin@inktank.com>
In-Reply-To: <1377757447-23515-4-git-send-email-josh.durgin@inktank.com>
References: <1377757447-23515-4-git-send-email-josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

To ensure rbd_dev is not used after it's released, flush all pending
notify callbacks before calling rbd_dev_image_release(). No new
notifies can be added to the queue at this point because the watch has
already be unregistered with the osd_client.

Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
---
 drivers/block/rbd.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 8ab3362b..2223617 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5190,6 +5190,13 @@ static ssize_t rbd_remove(struct bus_type *bus,
 	ret = rbd_dev_header_watch_sync(rbd_dev, false);
 	if (ret)
 		rbd_warn(rbd_dev, "failed to cancel watch event (%d)\n", ret);
+
+	/*
+	 * flush remaining watch callbacks - these must be complete
+	 * before the osd_client is shutdown
+	 */
+	dout("%s: flushing notifies", __func__);
+	ceph_osdc_flush_notifies(&rbd_dev->rbd_client->client->osdc);
 	rbd_dev_image_release(rbd_dev);
 	module_put(THIS_MODULE);
 
-- 
1.7.2.5

