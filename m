From: Alex Elder <elder@inktank.com>
Subject: [PATCH 09/11] rbd: drop needless test in rbd_rq_fn()
Date: Fri, 24 Aug 2012 11:35:42 -0500
Message-ID: <5037AD5E.5050501@inktank.com>
References: <5037AB20.4000103@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49774 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964839Ab2HXQfr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Aug 2012 12:35:47 -0400
Received: by ialo24 with SMTP id o24so3740650ial.19
        for <ceph-devel@vger.kernel.org>; Fri, 24 Aug 2012 09:35:47 -0700 (PDT)
In-Reply-To: <5037AB20.4000103@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There's a test for null rq pointer inside the while loop in
rbd_rq_fn() that's not needed.  That same test already occurred
in the immediatly preceding loop condition test.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index bb8dad7..fad4ecb 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1462,10 +1462,6 @@ static void rbd_rq_fn(struct request_queue *q)
 		struct rbd_req_coll *coll;
 		struct ceph_snap_context *snapc;

-		/* peek at request from block layer */
-		if (!rq)
-			break;
-
 		dout("fetched request\n");

 		/* filter out block requests we don't understand */
-- 
1.7.9.5

