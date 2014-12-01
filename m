From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/1] block-rbd: Delete a check before ceph_put_snap_context()
Date: Mon, 01 Dec 2014 11:23:51 +0100
Message-ID: <547C41B7.1060604@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net> <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6> <530A086E.8010901@users.sourceforge.net> <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6> <530A72AA.3000601@users.sourceforge.net> <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6> <530B5FB6.6010207@users.sourceforge.net> <alpine.DEB.2.10.1402241710370.2074@hadrien> <530C5E18.1020800@users.sourceforge.net> <alpine.DEB.2.10.1402251014170.2080@hadrien> <530CD2C4.4050903@users.sourceforge.net> <alpine.DEB.2.10.1402251840450.7035@hadrien> <530CF8FF.8080600@users.sourceforge.net> <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6> <530DD06F.4090703@users.sourceforge.net> <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6> <5317A59D.4@users.so
 urceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5317A59D.4@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Elder <elder@kernel.org>, Sage Weil <sage@inktank.com>, Yehuda Sadeh <yehuda@inktank.com>, Ceph <ceph-devel@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: ceph-devel.vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 1 Dec 2014 11:18:21 +0100

The ceph_put_snap_context() function tests whether its argument is NULL
and then returns immediately. Thus the test around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 27b71a0..3c34ab5 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3405,8 +3405,7 @@ err_rq:
 	if (result)
 		rbd_warn(rbd_dev, "%s %llx at %llx result %d",
 			 obj_op_name(op_type), length, offset, result);
-	if (snapc)
-		ceph_put_snap_context(snapc);
+	ceph_put_snap_context(snapc);
 	blk_end_request_all(rq, result);
 }
 
-- 
2.1.3
