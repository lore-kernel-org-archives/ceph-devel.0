From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: barriers are hard
Date: Fri, 22 Feb 2013 11:17:20 -0600
Message-ID: <5127A820.6070505@inktank.com>
References: <5127A7C1.3070609@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f179.google.com ([209.85.210.179]:64258 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758313Ab3BVRRX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Feb 2013 12:17:23 -0500
Received: by mail-ia0-f179.google.com with SMTP id x24so737631iak.10
        for <ceph-devel@vger.kernel.org>; Fri, 22 Feb 2013 09:17:22 -0800 (PST)
In-Reply-To: <5127A7C1.3070609@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Let's go shopping!

I'm afraid this may not have gotten it right:
    07741308  rbd: add barriers near done flag operations

The smp_wmb() should have been done *before* setting the done flag,
to ensure all other data was valid before marking the object request
done.

Switch to use atomic_inc_return() here to set the done flag, which
allows us to verify we don't mark something done more than once.
Doing this also implies general barriers before and after the call.

And although a read memory barrier might have been sufficient before
reading the done flag, convert this to a full memory barrier just
to put this issue to bed.

This resolves:
    http://tracker.ceph.com/issues/4238

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 3cc003b..bd6078b 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1226,13 +1226,22 @@ static void obj_request_done_init(struct
rbd_obj_request *obj_request)

 static void obj_request_done_set(struct rbd_obj_request *obj_request)
 {
-	atomic_set(&obj_request->done, 1);
-	smp_wmb();
+	int done;
+
+	done = atomic_inc_return(&obj_request->done);
+	if (done > 1) {
+		struct rbd_img_request *img_request = obj_request->img_request;
+		struct rbd_device *rbd_dev;
+
+		rbd_dev = img_request ? img_request->rbd_dev : NULL;
+		rbd_warn(rbd_dev, "obj_request %p was already done\n",
+			obj_request);
+	}
 }

 static bool obj_request_done_test(struct rbd_obj_request *obj_request)
 {
-	smp_rmb();
+	smp_mb();
 	return atomic_read(&obj_request->done) != 0;
 }

-- 
1.7.9.5

