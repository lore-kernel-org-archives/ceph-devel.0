From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] ceph: queue vmtruncate if necessary when handing cap grant/revoke
Date: Fri, 11 Apr 2014 10:45:32 +0800
Message-ID: <1397184332-6840-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:50677 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754132AbaDKCpg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 10 Apr 2014 22:45:36 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

cap grant/revoke message from non-auth MDS can update inode's size
and truncate_seq/truncate_size. (the message arrives before auth
MDS's cap trunc message)

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 2e5e648..9946ce3 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2418,11 +2418,12 @@ static void handle_cap_grant(struct inode *inode, struct ceph_mds_caps *grant,
 	u64 max_size = le64_to_cpu(grant->max_size);
 	struct timespec mtime, atime, ctime;
 	int check_caps = 0;
-	int wake = 0;
-	int writeback = 0;
-	int queue_invalidate = 0;
-	int deleted_inode = 0;
-	int queue_revalidate = 0;
+	bool wake = 0;
+	bool writeback = 0;
+	bool queue_trunc = 0;
+	bool queue_invalidate = 0;
+	bool queue_revalidate = 0;
+	bool deleted_inode = 0;
 
 	dout("handle_cap_grant inode %p cap %p mds%d seq %d %s\n",
 	     inode, cap, mds, seq, ceph_cap_string(newcaps));
@@ -2512,9 +2513,10 @@ static void handle_cap_grant(struct inode *inode, struct ceph_mds_caps *grant,
 		queue_revalidate = 1;
 
 	/* size/ctime/mtime/atime? */
-	ceph_fill_file_size(inode, issued,
-			    le32_to_cpu(grant->truncate_seq),
-			    le64_to_cpu(grant->truncate_size), size);
+	queue_trunc = ceph_fill_file_size(inode, issued,
+					  le32_to_cpu(grant->truncate_seq),
+					  le64_to_cpu(grant->truncate_size),
+					  size);
 	ceph_decode_timespec(&mtime, &grant->mtime);
 	ceph_decode_timespec(&atime, &grant->atime);
 	ceph_decode_timespec(&ctime, &grant->ctime);
@@ -2595,6 +2597,12 @@ static void handle_cap_grant(struct inode *inode, struct ceph_mds_caps *grant,
 
 	spin_unlock(&ci->i_ceph_lock);
 
+	if (queue_trunc) {
+		ceph_queue_vmtruncate(inode);
+		ceph_queue_revalidate(inode);
+	} else if (queue_revalidate)
+		ceph_queue_revalidate(inode);
+
 	if (writeback)
 		/*
 		 * queue inode for writeback: we can't actually call
@@ -2606,8 +2614,6 @@ static void handle_cap_grant(struct inode *inode, struct ceph_mds_caps *grant,
 		ceph_queue_invalidate(inode);
 	if (deleted_inode)
 		invalidate_aliases(inode);
-	if (queue_revalidate)
-		ceph_queue_revalidate(inode);
 	if (wake)
 		wake_up_all(&ci->i_cap_wq);
 
-- 
1.9.0

