From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] rbd: don't mess with a page vector in rbd_notify_op_lock()
Date: Tue, 17 Mar 2020 15:48:47 +0100
Message-ID: <20200317144847.10913-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46503 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgCQOsn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Mar 2020 10:48:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id w16so9638318wrv.13
        for <ceph-devel@vger.kernel.org>; Tue, 17 Mar 2020 07:48:42 -0700 (PDT)
Received: from kwango.redhat.com (ip-94-112-129-237.net.upcbroadband.cz. [94.112.129.237])
        by smtp.gmail.com with ESMTPSA id i21sm4300348wmb.23.2020.03.17.07.48.39
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 07:48:40 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

rbd_notify_op_lock() isn't interested in a notify reply.  Instead of
accepting that page vector just to free it, have watch-notify code take
care of it.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index f44ce9ccadd6..acafdae16be2 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3754,11 +3754,7 @@ static int __rbd_notify_op_lock(struct rbd_device *rbd_dev,
 static void rbd_notify_op_lock(struct rbd_device *rbd_dev,
 			       enum rbd_notify_op notify_op)
 {
-	struct page **reply_pages;
-	size_t reply_len;
-
-	__rbd_notify_op_lock(rbd_dev, notify_op, &reply_pages, &reply_len);
-	ceph_release_page_vector(reply_pages, calc_pages_for(0, reply_len));
+	__rbd_notify_op_lock(rbd_dev, notify_op, NULL, NULL);
 }
 
 static void rbd_notify_acquired_lock(struct work_struct *work)
-- 
2.19.2
