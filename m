From: Himangi Saraogi <himangi774@gmail.com>
Subject: [PATCH] rbd: Use kmem_cache_free
Date: Tue, 22 Jul 2014 23:41:30 +0530
Message-ID: <20140722181130.GA3278@himangi-Dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:42761 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbaGVSLk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jul 2014 14:11:40 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>, Sage Weil <sage@inktank.com>, Alex Elder <elder@kernel.org>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Julia Lawall <julia.lawall@lip6.fr>

Free memory allocated using kmem_cache_zalloc using kmem_cache_free
rather than kfree.

The Coccinelle semantic patch that makes this change is as follows:

// <smpl>
@@
expression x,E,c;
@@

 x = \(kmem_cache_alloc\|kmem_cache_zalloc\|kmem_cache_alloc_node\)(c,...)
 ... when != x = E
     when != &x
?-kfree(x)
+kmem_cache_free(c,x)
// </smpl>

Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
 drivers/block/rbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b2c98c1..8381c54 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1158,7 +1158,7 @@ static const char *rbd_segment_name(struct rbd_device *rbd_dev, u64 offset)
 	if (ret < 0 || ret > CEPH_MAX_OID_NAME_LEN) {
 		pr_err("error formatting segment name for #%llu (%d)\n",
 			segment, ret);
-		kfree(name);
+		kmem_cache_free(rbd_segment_name_cache, name);
 		name = NULL;
 	}
 
-- 
1.9.1

