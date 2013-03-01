From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 2/7] ceph: queue cap release when trimming cap
Date: Fri,  1 Mar 2013 14:46:19 +0800
Message-ID: <1362120384-5188-3-git-send-email-zheng.z.yan@intel.com>
References: <1362120384-5188-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58983 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752071Ab3CAGqa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 1 Mar 2013 01:46:30 -0500
In-Reply-To: <1362120384-5188-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

So the client will later send cap release message to MDS

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c       | 6 +++---
 fs/ceph/mds_client.c | 2 ++
 fs/ceph/super.h      | 2 ++
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 1e1e020..5d5c32b 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -997,9 +997,9 @@ static int send_cap_msg(struct ceph_mds_session *session,
 	return 0;
 }
 
-static void __queue_cap_release(struct ceph_mds_session *session,
-				u64 ino, u64 cap_id, u32 migrate_seq,
-				u32 issue_seq)
+void __queue_cap_release(struct ceph_mds_session *session,
+			 u64 ino, u64 cap_id, u32 migrate_seq,
+			 u32 issue_seq)
 {
 	struct ceph_msg *msg;
 	struct ceph_mds_cap_release *head;
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 608ffcf..ccc68b0 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1197,6 +1197,8 @@ static int trim_caps_cb(struct inode *inode, struct ceph_cap *cap, void *arg)
 	session->s_trim_caps--;
 	if (oissued) {
 		/* we aren't the only cap.. just remove us */
+		__queue_cap_release(session, ceph_ino(inode), cap->cap_id,
+				    cap->mseq, cap->issue_seq);
 		__ceph_remove_cap(cap);
 	} else {
 		/* try to drop referring dentries */
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 604526a..4353ebc 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -755,6 +755,8 @@ static inline void ceph_remove_cap(struct ceph_cap *cap)
 extern void ceph_put_cap(struct ceph_mds_client *mdsc,
 			 struct ceph_cap *cap);
 
+extern void __queue_cap_release(struct ceph_mds_session *session, u64 ino,
+				u64 cap_id, u32 migrate_seq, u32 issue_seq);
 extern void ceph_queue_caps_release(struct inode *inode);
 extern int ceph_write_inode(struct inode *inode, struct writeback_control *wbc);
 extern int ceph_fsync(struct file *file, loff_t start, loff_t end,
-- 
1.7.11.7

