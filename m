From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/6] rbd: simplify __rbd_remove_all_snaps()
Date: Thu, 26 Jul 2012 13:44:47 -0500
Message-ID: <5011901F.2020704@inktank.com>
References: <50118F33.7080502@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34666 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941Ab2GZSow (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Jul 2012 14:44:52 -0400
Received: by yhmm54 with SMTP id m54so2323144yhm.19
        for <ceph-devel@vger.kernel.org>; Thu, 26 Jul 2012 11:44:51 -0700 (PDT)
In-Reply-To: <50118F33.7080502@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This just replaces a while loop with list_for_each_entry_safe()
in __rbd_remove_all_snaps().

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b9895fe..74e6a33 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1692,11 +1692,10 @@ bad:
 static void __rbd_remove_all_snaps(struct rbd_device *rbd_dev)
 {
 	struct rbd_snap *snap;
+	struct rbd_snap *next;

-	while (!list_empty(&rbd_dev->snaps)) {
-		snap = list_first_entry(&rbd_dev->snaps, struct rbd_snap, node);
+	list_for_each_entry_safe(snap, next, &rbd_dev->snaps, node)
 		__rbd_remove_snap_dev(rbd_dev, snap);
-	}
 }

 /*
-- 
1.7.9.5

