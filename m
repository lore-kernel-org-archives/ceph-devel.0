From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] rbd: fix double free on rbd_dev->header_name
Date: Mon, 31 Aug 2015 15:47:28 +0300
Message-ID: <1441025248-50599-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:34761 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668AbbHaMrq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Aug 2015 08:47:46 -0400
Received: by widfa3 with SMTP id fa3so23882317wid.1
        for <ceph-devel@vger.kernel.org>; Mon, 31 Aug 2015 05:47:45 -0700 (PDT)
Received: from orange.local.localdomain ([109.110.67.18])
        by smtp.gmail.com with ESMTPSA id w8sm17928143wiy.10.2015.08.31.05.47.43
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2015 05:47:44 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

If rbd_dev_image_probe() in rbd_dev_probe_parent() fails, header_name
is freed twice: once in rbd_dev_probe_parent() and then in its caller
rbd_dev_image_probe() (rbd_dev_image_probe() is called recursively to
handle parent images).

rbd_dev_probe_parent() is responsible for probing the parent, so it
shoudn't mock with clone's fields.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index bc67a93aa4f4..324bf35ec4dd 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5201,7 +5201,6 @@ static int rbd_dev_probe_parent(struct rbd_device *rbd_dev)
 out_err:
 	if (parent) {
 		rbd_dev_unparent(rbd_dev);
-		kfree(rbd_dev->header_name);
 		rbd_dev_destroy(parent);
 	} else {
 		rbd_put_client(rbdc);
-- 
1.9.3

