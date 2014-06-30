From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH] rbd: do not leak image_id in rbd_dev_v2_parent_info()
Date: Mon, 30 Jun 2014 13:45:56 +0400
Message-ID: <1404121556-4854-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:37163 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753906AbaF3JqB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jun 2014 05:46:01 -0400
Received: by mail-la0-f43.google.com with SMTP id e16so4715857lan.30
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jun 2014 02:45:59 -0700 (PDT)
Received: from localhost ([109.110.67.36])
        by mx.google.com with ESMTPSA id q8sm22938658lbr.28.2014.06.30.02.45.58
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 30 Jun 2014 02:45:58 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

image_id is leaked if the parent happens to have been recorded already.
Fix it.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 drivers/block/rbd.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index d99aa81774f8..adedb393b374 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4072,6 +4072,8 @@ static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev)
 		parent_spec->snap_id = snap_id;
 		rbd_dev->parent_spec = parent_spec;
 		parent_spec = NULL;	/* rbd_dev now owns this */
+	} else {
+		kfree(image_id);
 	}
 
 	/*
-- 
1.7.10.4

