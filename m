From: Guanjun He <heguanbo@gmail.com>
Subject: [PATCH] net/ceph/osd_client.c add sem to osdmap destroy
Date: Fri, 15 Jun 2012 16:32:00 +0800
Message-ID: <1339749120-7007-1-git-send-email-gjhe@suse.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56351 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754544Ab2FOIci (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Jun 2012 04:32:38 -0400
Received: by pbbrp8 with SMTP id rp8so4973129pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 15 Jun 2012 01:32:38 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Guanjun He <heguanbo@gmail.com>, Guanjun He <gjhe@suse.com>

From: Guanjun He <heguanbo@gmail.com>

	I think the osdmap destroy code shoule be protected by map_sem.
If I was wrong, please correct me, thanks!

Signed-off-by: Guanjun He <gjhe@suse.com>
---
 net/ceph/osd_client.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 1ffebed..718b100 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1872,11 +1872,13 @@ void ceph_osdc_stop(struct ceph_osd_client *osdc)
 	destroy_workqueue(osdc->notify_wq);
 	cancel_delayed_work_sync(&osdc->timeout_work);
 	cancel_delayed_work_sync(&osdc->osds_timeout_work);
+	down_write(&osdc->map_sem);
 	if (osdc->osdmap) {
 		ceph_osdmap_destroy(osdc->osdmap);
 		osdc->osdmap = NULL;
 	}
 	remove_all_osds(osdc);
+	up_write(&osdc->map_sem);
 	mempool_destroy(osdc->req_mempool);
 	ceph_msgpool_destroy(&osdc->msgpool_op);
 	ceph_msgpool_destroy(&osdc->msgpool_op_reply);
-- 
1.7.3.4

