From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] rbd: endian bug in rbd_req_cb()
Date: Fri, 4 May 2012 20:39:55 +0300
Message-ID: <20120504173954.GA18827@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:34742 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab2EDRkH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 May 2012 13:40:07 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@hq.newdream.net>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, kernel-janitors@vger.kernel.org

Sparse complains about this because:
drivers/block/rbd.c:996:20: warning: cast to restricted __le32
drivers/block/rbd.c:996:20: warning: cast from restricted __le16

These are set in osd_req_encode_op() and they are le16.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index c1f7701..64d3d6f 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -993,7 +993,7 @@ static void rbd_req_cb(struct ceph_osd_request *req, struct ceph_msg *msg)
 	op = (void *)(replyhead + 1);
 	rc = le32_to_cpu(replyhead->result);
 	bytes = le64_to_cpu(op->extent.length);
-	read_op = (le32_to_cpu(op->op) == CEPH_OSD_OP_READ);
+	read_op = (le16_to_cpu(op->op) == CEPH_OSD_OP_READ);
 
 	dout("rbd_req_cb bytes=%lld readop=%d rc=%d\n", bytes, read_op, rc);
 
