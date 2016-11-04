From: Jeff Layton <jlayton@redhat.com>
Subject: [RFC PATCH 09/10] ceph: plumb "sync" parameter into __send_cap
Date: Fri,  4 Nov 2016 07:34:32 -0400
Message-ID: <1478259273-3471-10-git-send-email-jlayton@redhat.com>
References: <1478259273-3471-1-git-send-email-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44936 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761693AbcKDLem (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 4 Nov 2016 07:34:42 -0400
In-Reply-To: <1478259273-3471-1-git-send-email-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, zyan@redhat.com, sage@redhat.com

We set that to false, except in the case of try_flush_caps. The callers
of that function generally wait synchronously on the result, so it's
beneficial to ask the server to expedite it.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/caps.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index e92c6ce53af6..7f6aa1e42f5a 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1131,8 +1131,8 @@ void ceph_queue_caps_release(struct inode *inode)
  * caller should hold snap_rwsem (read), s_mutex.
  */
 static int __send_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
-		      int op, int used, int want, int retain, int flushing,
-		      u64 flush_tid, u64 oldest_flush_tid)
+		      int op, bool sync, int used, int want, int retain,
+		      int flushing, u64 flush_tid, u64 oldest_flush_tid)
 	__releases(cap->ci->i_ceph_lock)
 {
 	struct ceph_inode_info *ci = cap->ci;
@@ -1223,7 +1223,7 @@ static int __send_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
 	arg.mode = inode->i_mode;
 
 	arg.inline_data = ci->i_inline_version != CEPH_INLINE_NONE;
-	arg.sync = false;
+	arg.sync = sync;
 
 	spin_unlock(&ci->i_ceph_lock);
 
@@ -1904,9 +1904,9 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags,
 		sent++;
 
 		/* __send_cap drops i_ceph_lock */
-		delayed += __send_cap(mdsc, cap, CEPH_CAP_OP_UPDATE, cap_used,
-				      want, retain, flushing,
-				      flush_tid, oldest_flush_tid);
+		delayed += __send_cap(mdsc, cap, CEPH_CAP_OP_UPDATE, false,
+				cap_used, want, retain, flushing,
+				flush_tid, oldest_flush_tid);
 		goto retry; /* retake i_ceph_lock and restart our cap scan. */
 	}
 
@@ -1970,9 +1970,9 @@ static int try_flush_caps(struct inode *inode, u64 *ptid)
 						&flush_tid, &oldest_flush_tid);
 
 		/* __send_cap drops i_ceph_lock */
-		delayed = __send_cap(mdsc, cap, CEPH_CAP_OP_FLUSH, used, want,
-				     (cap->issued | cap->implemented),
-				     flushing, flush_tid, oldest_flush_tid);
+		delayed = __send_cap(mdsc, cap, CEPH_CAP_OP_FLUSH, true,
+				used, want, (cap->issued | cap->implemented),
+				flushing, flush_tid, oldest_flush_tid);
 
 		if (delayed) {
 			spin_lock(&ci->i_ceph_lock);
@@ -2165,7 +2165,7 @@ static void __kick_flushing_caps(struct ceph_mds_client *mdsc,
 			     inode, cap, cf->tid, ceph_cap_string(cf->caps));
 			ci->i_ceph_flags |= CEPH_I_NODELAY;
 			ret = __send_cap(mdsc, cap, CEPH_CAP_OP_FLUSH,
-					  __ceph_caps_used(ci),
+					  false, __ceph_caps_used(ci),
 					  __ceph_caps_wanted(ci),
 					  cap->issued | cap->implemented,
 					  cf->caps, cf->tid, oldest_flush_tid);
-- 
2.7.4

