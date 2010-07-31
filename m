From: Dan Carpenter <error27@gmail.com>
Subject: [patch] ceph: create_workqueue() doesn't return ERR_PTR
Date: Sat, 31 Jul 2010 22:26:31 +0200
Message-ID: <20100731202631.GH26313@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42306 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391Ab0GaU0z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 31 Jul 2010 16:26:55 -0400
Received: by wwj40 with SMTP id 40so2640630wwj.1
        for <ceph-devel@vger.kernel.org>; Sat, 31 Jul 2010 13:26:53 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Yehuda Sadeh <yehuda@hq.newdream.net>, ceph-devel@vger.kernel.org, kernel-janitors@vger.kernel.org

create_workqueue() returns a NULL pointer on errors.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/fs/ceph/messenger.c b/fs/ceph/messenger.c
index 15167b2..d959dba 100644
--- a/fs/ceph/messenger.c
+++ b/fs/ceph/messenger.c
@@ -94,11 +94,9 @@ struct workqueue_struct *ceph_msgr_wq;
 int __init ceph_msgr_init(void)
 {
 	ceph_msgr_wq = create_workqueue("ceph-msgr");
-	if (IS_ERR(ceph_msgr_wq)) {
-		int ret = PTR_ERR(ceph_msgr_wq);
-		pr_err("msgr_init failed to create workqueue: %d\n", ret);
-		ceph_msgr_wq = NULL;
-		return ret;
+	if (!ceph_msgr_wq) {
+		pr_err("msgr_init failed to create workqueue\n");
+		return -ENOMEM;
 	}
 	return 0;
 }
