From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 22/32] ceph: fsc->*_wq's aren't used in memory reclaim path
Date: Mon,  3 Jan 2011 14:49:45 +0100
Message-ID: <1294062595-30097-23-git-send-email-tj@kernel.org>
References: <1294062595-30097-1-git-send-email-tj@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1294062595-30097-1-git-send-email-tj@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

fsc->*_wq's aren't depended upon during memory reclaim.  Convert to
alloc_workqueue() w/o WQ_MEM_RECLAIM.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org
---
Only compile tested.  Please feel free to take it into the subsystem
tree or simply ack - I'll route it through the wq tree.

Thanks.

 fs/ceph/super.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 08b460a..1f6436e 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -443,13 +443,17 @@ struct ceph_fs_client *create_fs_client(struct ceph_mount_options *fsopt,
 		goto fail_client;
 
 	err = -ENOMEM;
-	fsc->wb_wq = create_workqueue("ceph-writeback");
+	/*
+	 * The number of concurrent works can be high but they don't need
+	 * to be processed in parallel, limit concurrency.
+	 */
+	fsc->wb_wq = alloc_workqueue("ceph-writeback", 0, 1);
 	if (fsc->wb_wq == NULL)
 		goto fail_bdi;
-	fsc->pg_inv_wq = create_singlethread_workqueue("ceph-pg-invalid");
+	fsc->pg_inv_wq = alloc_workqueue("ceph-pg-invalid", 0, 1);
 	if (fsc->pg_inv_wq == NULL)
 		goto fail_wb_wq;
-	fsc->trunc_wq = create_singlethread_workqueue("ceph-trunc");
+	fsc->trunc_wq = alloc_workqueue("ceph-trunc", 0, 1);
 	if (fsc->trunc_wq == NULL)
 		goto fail_pg_inv_wq;
 
-- 
1.7.1
