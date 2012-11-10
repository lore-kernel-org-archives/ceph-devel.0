From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/2] rbd: fix reference leak in rbd_do_op()
Date: Fri, 09 Nov 2012 21:06:32 -0600
Message-ID: <509DC4B8.5020306@inktank.com>
References: <509DC473.805@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:36984 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036Ab2KJDGa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Nov 2012 22:06:30 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so6883768iea.19
        for <ceph-devel@vger.kernel.org>; Fri, 09 Nov 2012 19:06:30 -0800 (PST)
In-Reply-To: <509DC473.805@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This commit introduced a bug:
    4634246d rbd: consolidate rbd_do_op() calls

When a read request is being issued, the snapshot context provided
isn't needed.  But that snap context pointer was acquired in
rbd_rq_fn() and it carries with it a reference to that structure.
So before discarding it, the reference needs to be dropped.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 835153e..b86f5e5 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1333,6 +1333,7 @@ static int rbd_do_op(struct request *rq,
 	} else {
 		opcode = CEPH_OSD_OP_READ;
 		flags = CEPH_OSD_FLAG_READ;
+		ceph_put_snap_context(snapc);
 		snapc = NULL;
 		snapid = rbd_dev->spec->snap_id;
 		payload_len = 0;
-- 
1.7.9.5

