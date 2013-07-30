From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 8/9] ceph: WQ_NON_REENTRANT is meaningless and going away
Date: Tue, 30 Jul 2013 08:40:27 -0400
Message-ID: <1375188028-11910-9-git-send-email-tj@kernel.org>
References: <1375188028-11910-1-git-send-email-tj@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1375188028-11910-1-git-send-email-tj@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, laijs@cn.fujitsu.com
Cc: shli@kernel.org, Tejun Heo <tj@kernel.org>, Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hello,

Please route this through the subsystem tree.  As written in the
description, this shouldn't make any functional difference and just
prepares for the removal of WQ_NON_REENTRANT which is already noop.

Thanks.

------ 8< -------
dbf2576e37 ("workqueue: make all workqueues non-reentrant") made
WQ_NON_REENTRANT no-op and the flag is going away.  Remove its usages.

This patch doesn't introduce any behavior changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org
---
 net/ceph/messenger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index eb0a46a..dd9b585 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -290,7 +290,7 @@ int ceph_msgr_init(void)
 	if (ceph_msgr_slab_init())
 		return -ENOMEM;
 
-	ceph_msgr_wq = alloc_workqueue("ceph-msgr", WQ_NON_REENTRANT, 0);
+	ceph_msgr_wq = alloc_workqueue("ceph-msgr", 0, 0);
 	if (ceph_msgr_wq)
 		return 0;
 
-- 
1.8.3.1
