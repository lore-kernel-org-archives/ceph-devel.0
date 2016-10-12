From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] rbd: don't retry watch reregistration if header object is gone
Date: Wed, 12 Oct 2016 16:04:48 +0200
Message-ID: <1476281088-30667-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35957 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755122AbcJLOE6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Oct 2016 10:04:58 -0400
Received: by mail-qk0-f195.google.com with SMTP id z190so3660679qkc.3
        for <ceph-devel@vger.kernel.org>; Wed, 12 Oct 2016 07:04:58 -0700 (PDT)
Received: from localhost.localdomain.com (ip-78-102-108-116.net.upcbroadband.cz. [78.102.108.116])
        by smtp.gmail.com with ESMTPSA id za1sm9118726wjb.8.2016.10.12.07.04.56
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Oct 2016 07:04:56 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

If the header object gets deleted (perhaps along with the entire pool),
there is no point in attempting to reregister the watch.  Treat this
the same as blacklisting: fail all pending and new I/Os requiring the
lock.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index fbc025a87261..2acb3f04c37b 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3944,7 +3944,7 @@ static void rbd_reregister_watch(struct work_struct *work)
 	ret = __rbd_register_watch(rbd_dev);
 	if (ret) {
 		rbd_warn(rbd_dev, "failed to reregister watch: %d", ret);
-		if (ret == -EBLACKLISTED) {
+		if (ret == -EBLACKLISTED || ret == -ENOENT) {
 			set_bit(RBD_DEV_FLAG_BLACKLISTED, &rbd_dev->flags);
 			need_to_wake = true;
 		} else {
-- 
2.4.3

