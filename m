From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH] rbd: don't treat CEPH_OSD_OP_DELETE as extent op
Date: Mon, 24 Nov 2014 12:59:50 +0300
Message-ID: <1416823190-10246-1-git-send-email-idryomov@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:41543 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115AbaKXKAC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Nov 2014 05:00:02 -0500
Received: by mail-la0-f45.google.com with SMTP id gq15so7306763lab.32
        for <ceph-devel@vger.kernel.org>; Mon, 24 Nov 2014 02:00:00 -0800 (PST)
Received: from localhost ([109.110.66.84])
        by mx.google.com with ESMTPSA id vr7sm3425856lbb.21.2014.11.24.01.59.58
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 24 Nov 2014 01:59:59 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

CEPH_OSD_OP_DELETE is not an extent op, stop treating it as such.  This
sneaked in with discard patches - it's one of the three osd ops (the
other two are CEPH_OSD_OP_TRUNCATE and CEPH_OSD_OP_ZERO) that discard
is implemented with.

Signed-off-by: Ilya Dryomov <idryomov@redhat.com>
---
 drivers/block/rbd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 27b71a0b72d0..1df0802bf6cb 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2370,8 +2370,12 @@ static void rbd_img_obj_request_fill(struct rbd_obj_request *obj_request,
 		opcode = CEPH_OSD_OP_READ;
 	}
 
-	osd_req_op_extent_init(osd_request, num_ops, opcode, offset, length,
-				0, 0);
+	if (opcode == CEPH_OSD_OP_DELETE)
+		osd_req_op_init(osd_request, num_ops, opcode);
+	else
+		osd_req_op_extent_init(osd_request, num_ops, opcode,
+				       offset, length, 0, 0);
+
 	if (obj_request->type == OBJ_REQUEST_BIO)
 		osd_req_op_extent_osd_data_bio(osd_request, num_ops,
 					obj_request->bio_list, length);
-- 
2.1.1

