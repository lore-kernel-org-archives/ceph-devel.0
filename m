From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 2/2] ceph: wake up writer if vmtruncate work get blocked
Date: Sun, 21 Jul 2013 20:25:26 +0800
Message-ID: <1374409526-8297-2-git-send-email-zheng.z.yan@intel.com>
References: <1374409526-8297-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:10716 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755280Ab3GUMZh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 21 Jul 2013 08:25:37 -0400
In-Reply-To: <1374409526-8297-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

To write data, the writer first acquires the i_mutex, then try getting
caps. The writer may sleep while holding the i_mutex. If the MDS revokes
Fb cap in this case, vmtruncate work can't do its job because i_mutex
is locked. We should wake up the writer and let it truncate the pages.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/inode.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 4906ada..55aaddb 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1465,7 +1465,14 @@ static void ceph_vmtruncate_work(struct work_struct *work)
 	struct inode *inode = &ci->vfs_inode;
 
 	dout("vmtruncate_work %p\n", inode);
-	mutex_lock(&inode->i_mutex);
+	if (!mutex_trylock(&inode->i_mutex)) {
+		/*
+		 * the i_mutex can be hold by a writer who is waiting for
+		 * caps. wake up waiters, they will do pending vmtruncate.
+		 */
+		wake_up_all(&ci->i_cap_wq);
+		mutex_lock(&inode->i_mutex);
+	}
 	__ceph_do_pending_vmtruncate(inode);
 	mutex_unlock(&inode->i_mutex);
 	iput(inode);
-- 
1.8.1.4

