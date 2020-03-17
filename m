From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 3/3] rbd: don't test rbd_dev->opts in rbd_dev_image_release()
Date: Tue, 17 Mar 2020 13:04:22 +0100
Message-ID: <20200317120422.3406-4-idryomov@gmail.com>
References: <20200317120422.3406-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43041 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgCQMFC (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Mar 2020 08:05:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id b2so19062412wrj.10
        for <ceph-devel@vger.kernel.org>; Tue, 17 Mar 2020 05:05:01 -0700 (PDT)
Received: from kwango.local (ip-94-112-129-237.net.upcbroadband.cz. [94.112.129.237])
        by smtp.gmail.com with ESMTPSA id p8sm4416706wrw.19.2020.03.17.05.04.56
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 05:04:57 -0700 (PDT)
In-Reply-To: <20200317120422.3406-1-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

rbd_dev->opts is used to distinguish between the image that is being
mapped and a parent.  However, because we no longer establish watch for
read-only mappings, this test is imprecise and results in unnecessary
rbd_unregister_watch() calls.

Make it consistent with need_watch in rbd_dev_image_probe().

Fixes: b9ef2b8858a0 ("rbd: don't establish watch for read-only mappings")
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index e590dc484c18..f44ce9ccadd6 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -6898,7 +6898,7 @@ static void rbd_print_dne(struct rbd_device *rbd_dev, bool is_snap)
 
 static void rbd_dev_image_release(struct rbd_device *rbd_dev)
 {
-	if (rbd_dev->opts)
+	if (!rbd_is_ro(rbd_dev))
 		rbd_unregister_watch(rbd_dev);
 
 	rbd_dev_unprobe(rbd_dev);
-- 
2.19.2
