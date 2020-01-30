From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] rbd: remove barriers from img_request_layered_{set,clear,test}()
Date: Thu, 30 Jan 2020 14:31:02 +0100
Message-ID: <20200130133102.13745-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41137 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgA3Na5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jan 2020 08:30:57 -0500
Received: by mail-wr1-f65.google.com with SMTP id c9so4035086wrw.8
        for <ceph-devel@vger.kernel.org>; Thu, 30 Jan 2020 05:30:57 -0800 (PST)
Received: from kwango.redhat.com ([213.175.37.12])
        by smtp.gmail.com with ESMTPSA id g2sm7254835wrw.76.2020.01.30.05.30.55
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 05:30:55 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

IMG_REQ_LAYERED is set in rbd_img_request_create(), and tested and
cleared in rbd_img_request_destroy() when the image request is about to
be destroyed.  The barriers are unnecessary.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index f21f9bc8d74a..4e494d5600cc 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1371,18 +1371,15 @@ static void rbd_osd_submit(struct ceph_osd_request *osd_req)
 static void img_request_layered_set(struct rbd_img_request *img_request)
 {
 	set_bit(IMG_REQ_LAYERED, &img_request->flags);
-	smp_mb();
 }
 
 static void img_request_layered_clear(struct rbd_img_request *img_request)
 {
 	clear_bit(IMG_REQ_LAYERED, &img_request->flags);
-	smp_mb();
 }
 
 static bool img_request_layered_test(struct rbd_img_request *img_request)
 {
-	smp_mb();
 	return test_bit(IMG_REQ_LAYERED, &img_request->flags) != 0;
 }
 
-- 
2.19.2
