From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 01/12] ceph: handle cap export race in try_flush_caps()
Date: Fri,  6 Dec 2013 16:46:32 +0800
Message-ID: <1386319603-2610-2-git-send-email-zheng.z.yan@intel.com>
References: <1386319603-2610-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23345 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757143Ab3LFIqt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 6 Dec 2013 03:46:49 -0500
In-Reply-To: <1386319603-2610-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

auth cap may change after releasing the i_ceph_lock

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 3c0a4bd..b1b7304 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1735,13 +1735,12 @@ ack:
 /*
  * Try to flush dirty caps back to the auth mds.
  */
-static int try_flush_caps(struct inode *inode, struct ceph_mds_session *session,
-			  unsigned *flush_tid)
+static int try_flush_caps(struct inode *inode, unsigned *flush_tid)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	int unlock_session = session ? 0 : 1;
 	int flushing = 0;
+	struct ceph_mds_session *session = NULL;
 
 retry:
 	spin_lock(&ci->i_ceph_lock);
@@ -1755,13 +1754,14 @@ retry:
 		int want = __ceph_caps_wanted(ci);
 		int delayed;
 
-		if (!session) {
+		if (!session || session != cap->session) {
 			spin_unlock(&ci->i_ceph_lock);
+			if (session)
+				mutex_unlock(&session->s_mutex);
 			session = cap->session;
 			mutex_lock(&session->s_mutex);
 			goto retry;
 		}
-		BUG_ON(session != cap->session);
 		if (cap->session->s_state < CEPH_MDS_SESSION_OPEN)
 			goto out;
 
@@ -1780,7 +1780,7 @@ retry:
 out:
 	spin_unlock(&ci->i_ceph_lock);
 out_unlocked:
-	if (session && unlock_session)
+	if (session)
 		mutex_unlock(&session->s_mutex);
 	return flushing;
 }
@@ -1865,7 +1865,7 @@ int ceph_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 		return ret;
 	mutex_lock(&inode->i_mutex);
 
-	dirty = try_flush_caps(inode, NULL, &flush_tid);
+	dirty = try_flush_caps(inode, &flush_tid);
 	dout("fsync dirty caps are %s\n", ceph_cap_string(dirty));
 
 	/*
@@ -1900,7 +1900,7 @@ int ceph_write_inode(struct inode *inode, struct writeback_control *wbc)
 
 	dout("write_inode %p wait=%d\n", inode, wait);
 	if (wait) {
-		dirty = try_flush_caps(inode, NULL, &flush_tid);
+		dirty = try_flush_caps(inode, &flush_tid);
 		if (dirty)
 			err = wait_event_interruptible(ci->i_cap_wq,
 				       caps_are_flushed(inode, flush_tid));
-- 
1.8.1.4

