From: Jeff Layton <jlayton@redhat.com>
Subject: [RFC PATCH 06/10] ceph: define new argument structure for send_cap_msg
Date: Fri,  4 Nov 2016 07:34:29 -0400
Message-ID: <1478259273-3471-7-git-send-email-jlayton@redhat.com>
References: <1478259273-3471-1-git-send-email-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45776 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761180AbcKDLej (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 4 Nov 2016 07:34:39 -0400
In-Reply-To: <1478259273-3471-1-git-send-email-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, zyan@redhat.com, sage@redhat.com

When we get to this many arguments, it's hard to work with positional
parameters. send_cap_msg is already at 25 arguments, with more needed.

Define a new args structure and pass a pointer to it to send_cap_msg.
Eventually it might make sense to embed one of these inside
ceph_cap_snap instead of tracking individual fields.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/caps.c | 225 ++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 126 insertions(+), 99 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index dcf1eff06f85..6e99866b1946 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -987,22 +987,27 @@ void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
 		__cap_delay_cancel(mdsc, ci);
 }
 
+struct cap_msg_args {
+	struct ceph_mds_session	*session;
+	u64			ino, cid, follows;
+	u64			flush_tid, oldest_flush_tid, size, max_size;
+	u64			xattr_version;
+	struct ceph_buffer	*xattr_buf;
+	struct timespec		atime, mtime, ctime;
+	int			op, caps, wanted, dirty;
+	u32			seq, issue_seq, mseq, time_warp_seq;
+	kuid_t			uid;
+	kgid_t			gid;
+	umode_t			mode;
+	bool			inline_data;
+};
+
 /*
  * Build and send a cap message to the given MDS.
  *
  * Caller should be holding s_mutex.
  */
-static int send_cap_msg(struct ceph_mds_session *session,
-			u64 ino, u64 cid, int op,
-			int caps, int wanted, int dirty,
-			u32 seq, u64 flush_tid, u64 oldest_flush_tid,
-			u32 issue_seq, u32 mseq, u64 size, u64 max_size,
-			struct timespec *mtime, struct timespec *atime,
-			struct timespec *ctime, u32 time_warp_seq,
-			kuid_t uid, kgid_t gid, umode_t mode,
-			u64 xattr_version,
-			struct ceph_buffer *xattrs_buf,
-			u64 follows, bool inline_data)
+static int send_cap_msg(struct cap_msg_args *arg)
 {
 	struct ceph_mds_caps *fc;
 	struct ceph_msg *msg;
@@ -1011,12 +1016,13 @@ static int send_cap_msg(struct ceph_mds_session *session,
 
 	dout("send_cap_msg %s %llx %llx caps %s wanted %s dirty %s"
 	     " seq %u/%u tid %llu/%llu mseq %u follows %lld size %llu/%llu"
-	     " xattr_ver %llu xattr_len %d\n", ceph_cap_op_name(op),
-	     cid, ino, ceph_cap_string(caps), ceph_cap_string(wanted),
-	     ceph_cap_string(dirty),
-	     seq, issue_seq, flush_tid, oldest_flush_tid,
-	     mseq, follows, size, max_size,
-	     xattr_version, xattrs_buf ? (int)xattrs_buf->vec.iov_len : 0);
+	     " xattr_ver %llu xattr_len %d\n", ceph_cap_op_name(arg->op),
+	     arg->cid, arg->ino, ceph_cap_string(arg->caps),
+	     ceph_cap_string(arg->wanted), ceph_cap_string(arg->dirty),
+	     arg->seq, arg->issue_seq, arg->flush_tid, arg->oldest_flush_tid,
+	     arg->mseq, arg->follows, arg->size, arg->max_size,
+	     arg->xattr_version,
+	     arg->xattr_buf ? (int)arg->xattr_buf->vec.iov_len : 0);
 
 	/* flock buffer size + inline version + inline data size +
 	 * osd_epoch_barrier + oldest_flush_tid */
@@ -1027,56 +1033,53 @@ static int send_cap_msg(struct ceph_mds_session *session,
 		return -ENOMEM;
 
 	msg->hdr.version = cpu_to_le16(6);
-	msg->hdr.tid = cpu_to_le64(flush_tid);
+	msg->hdr.tid = cpu_to_le64(arg->flush_tid);
 
 	fc = msg->front.iov_base;
 	memset(fc, 0, sizeof(*fc));
 
-	fc->cap_id = cpu_to_le64(cid);
-	fc->op = cpu_to_le32(op);
-	fc->seq = cpu_to_le32(seq);
-	fc->issue_seq = cpu_to_le32(issue_seq);
-	fc->migrate_seq = cpu_to_le32(mseq);
-	fc->caps = cpu_to_le32(caps);
-	fc->wanted = cpu_to_le32(wanted);
-	fc->dirty = cpu_to_le32(dirty);
-	fc->ino = cpu_to_le64(ino);
-	fc->snap_follows = cpu_to_le64(follows);
-
-	fc->size = cpu_to_le64(size);
-	fc->max_size = cpu_to_le64(max_size);
-	if (mtime)
-		ceph_encode_timespec(&fc->mtime, mtime);
-	if (atime)
-		ceph_encode_timespec(&fc->atime, atime);
-	if (ctime)
-		ceph_encode_timespec(&fc->ctime, ctime);
-	fc->time_warp_seq = cpu_to_le32(time_warp_seq);
-
-	fc->uid = cpu_to_le32(from_kuid(&init_user_ns, uid));
-	fc->gid = cpu_to_le32(from_kgid(&init_user_ns, gid));
-	fc->mode = cpu_to_le32(mode);
-
-	fc->xattr_version = cpu_to_le64(xattr_version);
-	if (xattrs_buf) {
-		msg->middle = ceph_buffer_get(xattrs_buf);
-		fc->xattr_len = cpu_to_le32(xattrs_buf->vec.iov_len);
-		msg->hdr.middle_len = cpu_to_le32(xattrs_buf->vec.iov_len);
+	fc->cap_id = cpu_to_le64(arg->cid);
+	fc->op = cpu_to_le32(arg->op);
+	fc->seq = cpu_to_le32(arg->seq);
+	fc->issue_seq = cpu_to_le32(arg->issue_seq);
+	fc->migrate_seq = cpu_to_le32(arg->mseq);
+	fc->caps = cpu_to_le32(arg->caps);
+	fc->wanted = cpu_to_le32(arg->wanted);
+	fc->dirty = cpu_to_le32(arg->dirty);
+	fc->ino = cpu_to_le64(arg->ino);
+	fc->snap_follows = cpu_to_le64(arg->follows);
+
+	fc->size = cpu_to_le64(arg->size);
+	fc->max_size = cpu_to_le64(arg->max_size);
+	ceph_encode_timespec(&fc->mtime, &arg->mtime);
+	ceph_encode_timespec(&fc->atime, &arg->atime);
+	ceph_encode_timespec(&fc->ctime, &arg->ctime);
+	fc->time_warp_seq = cpu_to_le32(arg->time_warp_seq);
+
+	fc->uid = cpu_to_le32(from_kuid(&init_user_ns, arg->uid));
+	fc->gid = cpu_to_le32(from_kgid(&init_user_ns, arg->gid));
+	fc->mode = cpu_to_le32(arg->mode);
+
+	fc->xattr_version = cpu_to_le64(arg->xattr_version);
+	if (arg->xattr_buf) {
+		msg->middle = ceph_buffer_get(arg->xattr_buf);
+		fc->xattr_len = cpu_to_le32(arg->xattr_buf->vec.iov_len);
+		msg->hdr.middle_len = cpu_to_le32(arg->xattr_buf->vec.iov_len);
 	}
 
 	p = fc + 1;
 	/* flock buffer size */
 	ceph_encode_32(&p, 0);
 	/* inline version */
-	ceph_encode_64(&p, inline_data ? 0 : CEPH_INLINE_NONE);
+	ceph_encode_64(&p, arg->inline_data ? 0 : CEPH_INLINE_NONE);
 	/* inline data size */
 	ceph_encode_32(&p, 0);
 	/* osd_epoch_barrier */
 	ceph_encode_32(&p, 0);
 	/* oldest_flush_tid */
-	ceph_encode_64(&p, oldest_flush_tid);
+	ceph_encode_64(&p, arg->oldest_flush_tid);
 
-	ceph_con_send(&session->s_con, msg);
+	ceph_con_send(&arg->session->s_con, msg);
 	return 0;
 }
 
@@ -1121,21 +1124,11 @@ static int __send_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
 {
 	struct ceph_inode_info *ci = cap->ci;
 	struct inode *inode = &ci->vfs_inode;
-	u64 cap_id = cap->cap_id;
-	int held, revoking, dropping, keep;
-	u64 follows, size, max_size;
-	u32 seq, issue_seq, mseq, time_warp_seq;
-	struct timespec mtime, atime, ctime;
+	struct cap_msg_args arg;
+	int held, revoking, dropping;
 	int wake = 0;
-	umode_t mode;
-	kuid_t uid;
-	kgid_t gid;
-	struct ceph_mds_session *session;
-	u64 xattr_version = 0;
-	struct ceph_buffer *xattr_blob = NULL;
 	int delayed = 0;
 	int ret;
-	bool inline_data;
 
 	held = cap->issued | cap->implemented;
 	revoking = cap->implemented & ~cap->issued;
@@ -1148,7 +1141,7 @@ static int __send_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
 	     ceph_cap_string(revoking));
 	BUG_ON((retain & CEPH_CAP_PIN) == 0);
 
-	session = cap->session;
+	arg.session = cap->session;
 
 	/* don't release wanted unless we've waited a bit. */
 	if ((ci->i_ceph_flags & CEPH_I_NODELAY) == 0 &&
@@ -1177,40 +1170,48 @@ static int __send_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
 	cap->implemented &= cap->issued | used;
 	cap->mds_wanted = want;
 
-	follows = flushing ? ci->i_head_snapc->seq : 0;
-
-	keep = cap->implemented;
-	seq = cap->seq;
-	issue_seq = cap->issue_seq;
-	mseq = cap->mseq;
-	size = inode->i_size;
-	ci->i_reported_size = size;
-	max_size = ci->i_wanted_max_size;
-	ci->i_requested_max_size = max_size;
-	mtime = inode->i_mtime;
-	atime = inode->i_atime;
-	ctime = inode->i_ctime;
-	time_warp_seq = ci->i_time_warp_seq;
-	uid = inode->i_uid;
-	gid = inode->i_gid;
-	mode = inode->i_mode;
+	arg.ino = ceph_vino(inode).ino;
+	arg.cid = cap->cap_id;
+	arg.follows = flushing ? ci->i_head_snapc->seq : 0;
+	arg.flush_tid = flush_tid;
+	arg.oldest_flush_tid = oldest_flush_tid;
+
+	arg.size = inode->i_size;
+	ci->i_reported_size = arg.size;
+	arg.max_size = ci->i_wanted_max_size;
+	ci->i_requested_max_size = arg.max_size;
 
 	if (flushing & CEPH_CAP_XATTR_EXCL) {
 		__ceph_build_xattrs_blob(ci);
-		xattr_blob = ci->i_xattrs.blob;
-		xattr_version = ci->i_xattrs.version;
+		arg.xattr_version = ci->i_xattrs.version;
+		arg.xattr_buf = ci->i_xattrs.blob;
+	} else {
+		arg.xattr_buf = NULL;
 	}
 
-	inline_data = ci->i_inline_version != CEPH_INLINE_NONE;
+	arg.mtime = inode->i_mtime;
+	arg.atime = inode->i_atime;
+	arg.ctime = inode->i_ctime;
+
+	arg.op = op;
+	arg.caps = cap->implemented;
+	arg.wanted = want;
+	arg.dirty = flushing;
+
+	arg.seq = cap->seq;
+	arg.issue_seq = cap->issue_seq;
+	arg.mseq = cap->mseq;
+	arg.time_warp_seq = ci->i_time_warp_seq;
+
+	arg.uid = inode->i_uid;
+	arg.gid = inode->i_gid;
+	arg.mode = inode->i_mode;
+
+	arg.inline_data = ci->i_inline_version != CEPH_INLINE_NONE;
 
 	spin_unlock(&ci->i_ceph_lock);
 
-	ret = send_cap_msg(session, ceph_vino(inode).ino, cap_id,
-		op, keep, want, flushing, seq,
-		flush_tid, oldest_flush_tid, issue_seq, mseq,
-		size, max_size, &mtime, &atime, &ctime, time_warp_seq,
-		uid, gid, mode, xattr_version, xattr_blob,
-		follows, inline_data);
+	ret = send_cap_msg(&arg);
 	if (ret < 0) {
 		dout("error sending cap msg, must requeue %p\n", inode);
 		delayed = 1;
@@ -1227,15 +1228,41 @@ static inline int __send_flush_snap(struct inode *inode,
 				    struct ceph_cap_snap *capsnap,
 				    u32 mseq, u64 oldest_flush_tid)
 {
-	return send_cap_msg(session, ceph_vino(inode).ino, 0,
-			CEPH_CAP_OP_FLUSHSNAP, capsnap->issued, 0,
-			capsnap->dirty, 0, capsnap->cap_flush.tid,
-			oldest_flush_tid, 0, mseq, capsnap->size, 0,
-			&capsnap->mtime, &capsnap->atime,
-			&capsnap->ctime, capsnap->time_warp_seq,
-			capsnap->uid, capsnap->gid, capsnap->mode,
-			capsnap->xattr_version, capsnap->xattr_blob,
-			capsnap->follows, capsnap->inline_data);
+	struct cap_msg_args	arg;
+
+	arg.session = session;
+	arg.ino = ceph_vino(inode).ino;
+	arg.cid = 0;
+	arg.follows = capsnap->follows;
+	arg.flush_tid = capsnap->cap_flush.tid;
+	arg.oldest_flush_tid = oldest_flush_tid;
+
+	arg.size = capsnap->size;
+	arg.max_size = 0;
+	arg.xattr_version = capsnap->xattr_version;
+	arg.xattr_buf = capsnap->xattr_blob;
+
+	arg.atime = capsnap->atime;
+	arg.mtime = capsnap->mtime;
+	arg.ctime = capsnap->ctime;
+
+	arg.op = CEPH_CAP_OP_FLUSHSNAP;
+	arg.caps = capsnap->issued;
+	arg.wanted = 0;
+	arg.dirty = capsnap->dirty;
+
+	arg.seq = 0;
+	arg.issue_seq = 0;
+	arg.mseq = mseq;
+	arg.time_warp_seq = capsnap->time_warp_seq;
+
+	arg.uid = capsnap->uid;
+	arg.gid = capsnap->gid;
+	arg.mode = capsnap->mode;
+
+	arg.inline_data = capsnap->inline_data;
+
+	return send_cap_msg(&arg);
 }
 
 /*
-- 
2.7.4

