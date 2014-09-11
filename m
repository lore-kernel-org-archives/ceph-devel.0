From: roy.qing.li@gmail.com
Subject: [PATCH] libceph: fix a memory leak in handle_watch_notify
Date: Thu, 11 Sep 2014 08:20:21 +0800
Message-ID: <1410394821-13054-1-git-send-email-roy.qing.li@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:64947 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642AbaIKAUV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Sep 2014 20:20:21 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so7509525pab.1
        for <ceph-devel@vger.kernel.org>; Wed, 10 Sep 2014 17:20:21 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com, ceph-devel@vger.kernel.org

From: Li RongQing <roy.qing.li@gmail.com> 

event_work should be freed when adding it to queue failed

Signed-off-by: Li RongQing <roy.qing.li@gmail.com>
---
 net/ceph/osd_client.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 30f6faf..1e1b4f1 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -2323,6 +2323,7 @@ static void handle_watch_notify(struct ceph_osd_client *osdc,
 		event_work->opcode = opcode;
 		if (!queue_work(osdc->notify_wq, &event_work->work)) {
 			dout("WARNING: failed to queue notify event work\n");
+			kfree(event_work);
 			goto done_err;
 		}
 	}
-- 
1.7.10.4

