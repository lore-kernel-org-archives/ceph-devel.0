From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 6/6] ceph: don't acquire i_mutex ceph_vmtruncate_work
Date: Fri,  4 Jan 2013 19:34:21 +0800
Message-ID: <1357299261-20591-7-git-send-email-zheng.z.yan@intel.com>
References: <1357299261-20591-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:48663 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754555Ab3ADLeh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 06:34:37 -0500
In-Reply-To: <1357299261-20591-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

In commit 22cddde104, ceph_get_caps() was moved into ceph_write_begin().
So ceph_get_caps() can be called while i_mutex is locked. If there is
pending vmtruncate, ceph_get_caps() will wait for it to complete, but
ceph_vmtruncate_work() is blocked by the locked i_mutex.

There are several places that call __ceph_do_pending_vmtruncate()
without holding the i_mutex, I think it's OK to not acquire the i_mutex
in ceph_vmtruncate_work()

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/inode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 81613bc..c895c7f 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1420,7 +1420,7 @@ out:
 
 
 /*
- * called by trunc_wq; take i_mutex ourselves
+ * called by trunc_wq;
  *
  * We also truncate in a separate thread as well.
  */
@@ -1431,9 +1431,7 @@ static void ceph_vmtruncate_work(struct work_struct *work)
 	struct inode *inode = &ci->vfs_inode;
 
 	dout("vmtruncate_work %p\n", inode);
-	mutex_lock(&inode->i_mutex);
 	__ceph_do_pending_vmtruncate(inode);
-	mutex_unlock(&inode->i_mutex);
 	iput(inode);
 }
 
-- 
1.7.11.7

