From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] rbd: return -ENOMEM instead of pool id if rbd_dev_create() fails
Date: Mon, 19 Oct 2015 20:05:44 +0200
Message-ID: <1445277944-57934-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35302 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbbJSQZu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Oct 2015 12:25:50 -0400
Received: by wicll6 with SMTP id ll6so13720350wic.0
        for <ceph-devel@vger.kernel.org>; Mon, 19 Oct 2015 09:25:49 -0700 (PDT)
Received: from orange.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id pb4sm41105455wjb.8.2015.10.19.09.25.48
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Oct 2015 09:25:48 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Returning pool id (i.e. >= 0) from a sysfs ->store() callback makes
userspace think it needs to retry the write.  Fix it - it's a leftover
from the times when the equivalent of rbd_dev_create() was the first
action in rbd_add().

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 07f666f4ca18..df795deffe77 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5394,7 +5394,7 @@ static ssize_t do_rbd_add(struct bus_type *bus,
 	struct rbd_spec *spec = NULL;
 	struct rbd_client *rbdc;
 	bool read_only;
-	int rc = -ENOMEM;
+	int rc;
 
 	if (!try_module_get(THIS_MODULE))
 		return -ENODEV;
@@ -5429,8 +5429,10 @@ static ssize_t do_rbd_add(struct bus_type *bus,
 	}
 
 	rbd_dev = rbd_dev_create(rbdc, spec, rbd_opts);
-	if (!rbd_dev)
+	if (!rbd_dev) {
+		rc = -ENOMEM;
 		goto err_out_client;
+	}
 	rbdc = NULL;		/* rbd_dev now owns this */
 	spec = NULL;		/* rbd_dev now owns this */
 	rbd_opts = NULL;	/* rbd_dev now owns this */
-- 
2.4.3

