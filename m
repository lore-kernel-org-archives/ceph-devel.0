From: Sage Weil <sage@newdream.net>
Subject: [PATCH 1/5] ceph: fix msgr_init error path
Date: Mon, 20 Dec 2010 11:15:27 -0800
Message-ID: <1292872531-18396-2-git-send-email-sage@newdream.net>
References: <1292872531-18396-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41941 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932628Ab0LTTPe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Dec 2010 14:15:34 -0500
In-Reply-To: <1292872531-18396-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

create_workqueue() returns NULL on failure.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 net/ceph/messenger.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 1c7a2ec..b6ff4a1 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -97,11 +97,9 @@ struct workqueue_struct *ceph_msgr_wq;
 int ceph_msgr_init(void)
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
-- 
1.6.6.1

