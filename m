From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH 5/5] ceph: add flags parameter to send_cap_msg
Date: Thu, 10 Nov 2016 07:52:14 -0500
Message-ID: <1478782334-20667-6-git-send-email-jlayton@redhat.com>
References: <1478782334-20667-1-git-send-email-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40412 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932830AbcKJMwT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 10 Nov 2016 07:52:19 -0500
In-Reply-To: <1478782334-20667-1-git-send-email-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: idryomov@gmail.com, zyan@redhat.com, sage@redhat.com
Cc: ceph-devel@vger.kernel.org

Add a flags parameter to send_cap_msg, so we can request expedited
service from the MDS when we know we'll be waiting on the result.

Set that flag in the case of try_flush_caps. The callers of that
function generally wait synchronously on the result, so it's beneficial
to ask the server to expedite it.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/caps.c               | 25 +++++++++++++++----------
 include/linux/ceph/ceph_fs.h |  3 +++
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index c4886b1a9470..98818b107857 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -996,6 +996,7 @@ struct cap_msg_args {
 	struct timespec		atime, mtime, ctime;
 	int			op, caps, wanted, dirty;
 	u32			seq, issue_seq, mseq, time_warp_seq;
+	u32			flags;
 	kuid_t			uid;
 	kgid_t			gid;
 	umode_t			mode;
@@ -1104,7 +1105,7 @@ static int send_cap_msg(struct cap_msg_args *arg)
 	ceph_encode_64(&p, 0);
 
 	/* Advisory flags (version 10) */
-	ceph_encode_32(&p, 0);
+	ceph_encode_32(&p, arg->flags);
 
 	ceph_con_send(&arg->session->s_con, msg);
 	return 0;
@@ -1145,8 +1146,8 @@ void ceph_queue_caps_release(struct inode *inode)
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
@@ -1235,6 +1236,9 @@ static int __send_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
 	arg.mode = inode->i_mode;
 
 	arg.inline_data = ci->i_inline_version != CEPH_INLINE_NONE;
+	arg.flags = 0;
+	if (sync)
+		arg.flags |= CEPH_CLIENT_CAPS_SYNC;
 
 	spin_unlock(&ci->i_ceph_lock);
 
@@ -1288,6 +1292,7 @@ static inline int __send_flush_snap(struct inode *inode,
 	arg.mode = capsnap->mode;
 
 	arg.inline_data = capsnap->inline_data;
+	arg.flags = 0;
 
 	return send_cap_msg(&arg);
 }
@@ -1912,9 +1917,9 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags,
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
 
@@ -1978,9 +1983,9 @@ static int try_flush_caps(struct inode *inode, u64 *ptid)
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
@@ -2173,7 +2178,7 @@ static void __kick_flushing_caps(struct ceph_mds_client *mdsc,
 			     inode, cap, cf->tid, ceph_cap_string(cf->caps));
 			ci->i_ceph_flags |= CEPH_I_NODELAY;
 			ret = __send_cap(mdsc, cap, CEPH_CAP_OP_FLUSH,
-					  __ceph_caps_used(ci),
+					  false, __ceph_caps_used(ci),
 					  __ceph_caps_wanted(ci),
 					  cap->issued | cap->implemented,
 					  cf->caps, cf->tid, oldest_flush_tid);
diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index f96de8de4fa7..f4b2ee18f38c 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -653,6 +653,9 @@ enum {
 
 extern const char *ceph_cap_op_name(int op);
 
+/* flags field in client cap messages (version >= 10) */
+#define CEPH_CLIENT_CAPS_SYNC	(0x1)
+
 /*
  * caps message, used for capability callbacks, acks, requests, etc.
  */
-- 
2.7.4

