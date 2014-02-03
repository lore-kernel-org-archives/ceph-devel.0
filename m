From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 1/4] libceph: fix error handling in ceph_osdc_init()
Date: Mon,  3 Feb 2014 15:47:05 +0200
Message-ID: <1391435228-27874-2-git-send-email-ilya.dryomov@inktank.com>
References: <1391435228-27874-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:63856 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbaBCNrR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Feb 2014 08:47:17 -0500
Received: by mail-wg0-f50.google.com with SMTP id l18so11643064wgh.17
        for <ceph-devel@vger.kernel.org>; Mon, 03 Feb 2014 05:47:13 -0800 (PST)
Received: from localhost ([109.110.66.110])
        by mx.google.com with ESMTPSA id gd5sm26013308wic.0.2014.02.03.05.47.12
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 03 Feb 2014 05:47:12 -0800 (PST)
In-Reply-To: <1391435228-27874-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

msgpool_op_reply message pool isn't destroyed if workqueue construction
fails.  Fix it.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/osd_client.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 010ff3bd58ad..166d4c7ba065 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -2504,9 +2504,12 @@ int ceph_osdc_init(struct ceph_osd_client *osdc, struct ceph_client *client)
 	err = -ENOMEM;
 	osdc->notify_wq = create_singlethread_workqueue("ceph-watch-notify");
 	if (!osdc->notify_wq)
-		goto out_msgpool;
+		goto out_msgpool_reply;
+
 	return 0;
 
+out_msgpool_reply:
+	ceph_msgpool_destroy(&osdc->msgpool_op_reply);
 out_msgpool:
 	ceph_msgpool_destroy(&osdc->msgpool_op);
 out_mempool:
-- 
1.7.10.4

