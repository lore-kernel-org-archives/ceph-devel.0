From: Josh Durgin <josh.durgin@inktank.com>
Subject: [PATCH 1/3] rbd: fix null dereference in dout
Date: Wed, 28 Aug 2013 23:24:05 -0700
Message-ID: <1377757447-23515-2-git-send-email-josh.durgin@inktank.com>
References: <1377757447-23515-1-git-send-email-josh.durgin@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:35213 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755606Ab3H2Ggh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Aug 2013 02:36:37 -0400
In-Reply-To: <1377757447-23515-1-git-send-email-josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Josh Durgin <josh.durgin@inktank.com>

The order parameter is sometimes NULL in _rbd_dev_v2_snap_size(), but
the dout() always derefences it. Move this to another dout() protected
by a check that order is non-NULL.

Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
---
 drivers/block/rbd.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 80f787b..fef3687 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3702,12 +3702,14 @@ static int _rbd_dev_v2_snap_size(struct rbd_device *rbd_dev, u64 snap_id,
 	if (ret < sizeof (size_buf))
 		return -ERANGE;
 
-	if (order)
+	if (order) {
 		*order = size_buf.order;
+		dout("  order %u", (unsigned int)*order);
+	}
 	*snap_size = le64_to_cpu(size_buf.size);
 
-	dout("  snap_id 0x%016llx order = %u, snap_size = %llu\n",
-		(unsigned long long)snap_id, (unsigned int)*order,
+	dout("  snap_id 0x%016llx snap_size = %llu\n",
+		(unsigned long long)snap_id,
 		(unsigned long long)*snap_size);
 
 	return 0;
-- 
1.7.2.5

