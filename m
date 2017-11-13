From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] rbd: default to single-major device number scheme
Date: Mon, 13 Nov 2017 11:50:17 +0100
Message-ID: <1510570217-14811-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:47981 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752418AbdKMKun (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Nov 2017 05:50:43 -0500
Received: by mail-wr0-f193.google.com with SMTP id k61so14007340wrc.4
        for <ceph-devel@vger.kernel.org>; Mon, 13 Nov 2017 02:50:42 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sweil@redhat.com>

It's been 3.5 years, let's turn it on by default.  Support in rbd(8)
utility goes back to pre-firefly, "rbd map" has been loading the module
with single_major=Y ever since.  However, if the module is already
loaded (whether by hand or at boot time), we end up with single_major=N.
Also, some people don't install rbd(8) and use the sysfs interface
directly.

(With single-major=N, a major number is consumed for every mapping,
imposing a limit of ~240 rbd images per host.  single-major=Y allows
mapping thousands of rbd images on a single machine.)

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 57275298d9fc..f40050c97bb3 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -449,12 +449,11 @@ static DEFINE_IDA(rbd_dev_id_ida);
 static struct workqueue_struct *rbd_wq;
 
 /*
- * Default to false for now, as single-major requires >= 0.75 version of
- * userspace rbd utility.
+ * single-major requires >= 0.75 version of userspace rbd utility.
  */
-static bool single_major = false;
+static bool single_major = true;
 module_param(single_major, bool, S_IRUGO);
-MODULE_PARM_DESC(single_major, "Use a single major number for all rbd devices (default: false)");
+MODULE_PARM_DESC(single_major, "Use a single major number for all rbd devices (default: true)");
 
 static int rbd_img_request_submit(struct rbd_img_request *img_request);
 
-- 
2.4.3

