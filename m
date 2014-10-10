From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 1/3] libceph: ceph-msgr workqueue needs a resque worker
Date: Fri, 10 Oct 2014 22:27:04 +0400
Message-ID: <1412965626-11165-2-git-send-email-idryomov@redhat.com>
References: <1412965626-11165-1-git-send-email-idryomov@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:50417 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765AbaJJS1S (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Oct 2014 14:27:18 -0400
Received: by mail-la0-f49.google.com with SMTP id q1so3778645lam.22
        for <ceph-devel@vger.kernel.org>; Fri, 10 Oct 2014 11:27:17 -0700 (PDT)
In-Reply-To: <1412965626-11165-1-git-send-email-idryomov@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Micha Krause <micha@krausam.de>

Commit f363e45fd118 ("net/ceph: make ceph_msgr_wq non-reentrant")
effectively removed WQ_MEM_RECLAIM flag from ceph_msgr_wq.  This is
wrong - libceph is very much a memory reclaim path, so restore it.

Cc: stable@vger.kernel.org # needs backporting for < 3.12
Signed-off-by: Ilya Dryomov <idryomov@redhat.com>
Tested-by: Micha Krause <micha@krausam.de>
---
 net/ceph/messenger.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 9764c771cfb1..559c9f619c20 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -292,7 +292,11 @@ int ceph_msgr_init(void)
 	if (ceph_msgr_slab_init())
 		return -ENOMEM;
 
-	ceph_msgr_wq = alloc_workqueue("ceph-msgr", 0, 0);
+	/*
+	 * The number of active work items is limited by the number of
+	 * connections, so leave @max_active at default.
+	 */
+	ceph_msgr_wq = alloc_workqueue("ceph-msgr", WQ_MEM_RECLAIM, 0);
 	if (ceph_msgr_wq)
 		return 0;
 
-- 
1.7.10.4

