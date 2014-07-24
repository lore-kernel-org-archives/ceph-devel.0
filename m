From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 5/8] rbd: harden rbd_dev_refresh() caller
Date: Thu, 24 Jul 2014 12:42:46 +0400
Message-ID: <1406191369-6746-6-git-send-email-ilya.dryomov@inktank.com>
References: <1406191369-6746-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:47204 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934456AbaGXInI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jul 2014 04:43:08 -0400
Received: by mail-lb0-f175.google.com with SMTP id 10so1976579lbg.20
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jul 2014 01:43:07 -0700 (PDT)
Received: from localhost ([109.110.66.237])
        by mx.google.com with ESMTPSA id 2sm3881312lav.14.2014.07.24.01.43.05
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 24 Jul 2014 01:43:06 -0700 (PDT)
In-Reply-To: <1406191369-6746-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Recently discovered watch/notify problems showed that we really can't
ignore errors in anything refresh related.  Alas, currently there is
not much we can do in response to those errors, except print warnings.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 drivers/block/rbd.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 23df1773ef77..5dd6f5057ef4 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2963,11 +2963,20 @@ static void rbd_watch_cb(u64 ver, u64 notify_id, u8 opcode, void *data)
 	dout("%s: \"%s\" notify_id %llu opcode %u\n", __func__,
 		rbd_dev->header_name, (unsigned long long)notify_id,
 		(unsigned int)opcode);
+
+	/*
+	 * Until adequate refresh error handling is in place, there is
+	 * not much we can do here, except warn.
+	 *
+	 * See http://tracker.ceph.com/issues/5040
+	 */
 	ret = rbd_dev_refresh(rbd_dev);
 	if (ret)
-		rbd_warn(rbd_dev, "header refresh error (%d)\n", ret);
+		rbd_warn(rbd_dev, "refresh failed: %d\n", ret);
 
-	rbd_obj_notify_ack_sync(rbd_dev, notify_id);
+	ret = rbd_obj_notify_ack_sync(rbd_dev, notify_id);
+	if (ret)
+		rbd_warn(rbd_dev, "notify_ack ret %d\n", ret);
 }
 
 /*
@@ -3724,9 +3733,9 @@ static ssize_t rbd_image_refresh(struct device *dev,
 
 	ret = rbd_dev_refresh(rbd_dev);
 	if (ret)
-		rbd_warn(rbd_dev, ": manual header refresh error (%d)\n", ret);
+		return ret;
 
-	return ret < 0 ? ret : size;
+	return size;
 }
 
 static DEVICE_ATTR(size, S_IRUGO, rbd_size_show, NULL);
-- 
1.7.10.4

