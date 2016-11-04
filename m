From: Jeff Layton <jlayton@redhat.com>
Subject: [RFC PATCH 05/10] ceph: handle btime and change_attr updates in cap messages
Date: Fri,  4 Nov 2016 07:34:28 -0400
Message-ID: <1478259273-3471-6-git-send-email-jlayton@redhat.com>
References: <1478259273-3471-1-git-send-email-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52718 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761517AbcKDLej (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 4 Nov 2016 07:34:39 -0400
In-Reply-To: <1478259273-3471-1-git-send-email-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, zyan@redhat.com, sage@redhat.com

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/caps.c  | 31 ++++++++++++++++++++++++-------
 fs/ceph/snap.c  |  3 +++
 fs/ceph/super.h |  3 +++
 3 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 2a5caee2fb17..dcf1eff06f85 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2798,7 +2798,8 @@ static void handle_cap_grant(struct ceph_mds_client *mdsc,
 			     void *inline_data, u32 inline_len,
 			     struct ceph_buffer *xattr_buf,
 			     struct ceph_mds_session *session,
-			     struct ceph_cap *cap, int issued)
+			     struct ceph_cap *cap, int issued,
+			     struct timespec *btime, u64 change_attr)
 	__releases(ci->i_ceph_lock)
 	__releases(mdsc->snap_rwsem)
 {
@@ -2864,11 +2865,14 @@ static void handle_cap_grant(struct ceph_mds_client *mdsc,
 
 	__check_cap_issue(ci, cap, newcaps);
 
+	inode->i_version = max(change_attr, inode->i_version);
+
 	if ((newcaps & CEPH_CAP_AUTH_SHARED) &&
 	    (issued & CEPH_CAP_AUTH_EXCL) == 0) {
 		inode->i_mode = le32_to_cpu(grant->mode);
 		inode->i_uid = make_kuid(&init_user_ns, le32_to_cpu(grant->uid));
 		inode->i_gid = make_kgid(&init_user_ns, le32_to_cpu(grant->gid));
+		ci->i_btime = *btime;
 		dout("%p mode 0%o uid.gid %d.%d\n", inode, inode->i_mode,
 		     from_kuid(&init_user_ns, inode->i_uid),
 		     from_kgid(&init_user_ns, inode->i_gid));
@@ -3480,6 +3484,9 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	void *snaptrace;
 	size_t snaptrace_len;
 	void *p, *end;
+	u16 hdr_version;
+	struct timespec btime = {};
+	u64 change_attr = 0;
 
 	dout("handle_caps from mds%d\n", mds);
 
@@ -3499,7 +3506,8 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	snaptrace_len = le32_to_cpu(h->snap_trace_len);
 	p = snaptrace + snaptrace_len;
 
-	if (le16_to_cpu(msg->hdr.version) >= 2) {
+	hdr_version = le16_to_cpu(msg->hdr.version);
+	if (hdr_version >= 2) {
 		u32 flock_len;
 		ceph_decode_32_safe(&p, end, flock_len, bad);
 		if (p + flock_len > end)
@@ -3507,7 +3515,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 		p += flock_len;
 	}
 
-	if (le16_to_cpu(msg->hdr.version) >= 3) {
+	if (hdr_version >= 3) {
 		if (op == CEPH_CAP_OP_IMPORT) {
 			if (p + sizeof(*peer) > end)
 				goto bad;
@@ -3519,7 +3527,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 		}
 	}
 
-	if (le16_to_cpu(msg->hdr.version) >= 4) {
+	if (hdr_version >= 4) {
 		ceph_decode_64_safe(&p, end, inline_version, bad);
 		ceph_decode_32_safe(&p, end, inline_len, bad);
 		if (p + inline_len > end)
@@ -3528,7 +3536,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 		p += inline_len;
 	}
 
-	if (le16_to_cpu(msg->hdr.version) >= 8) {
+	if (hdr_version >= 8) {
 		u64 flush_tid;
 		u32 caller_uid, caller_gid;
 		u32 osd_epoch_barrier;
@@ -3549,6 +3557,13 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 		}
 	}
 
+	if (hdr_version >= 9) {
+		ceph_decode_need(&p, end, sizeof(struct ceph_timespec), bad);
+		ceph_decode_timespec(&btime, p);
+		p += sizeof(struct ceph_timespec);
+		ceph_decode_64_safe(&p, end, change_attr, bad);
+	}
+
 	/* lookup ino */
 	inode = ceph_find_inode(sb, vino);
 	ci = ceph_inode(inode);
@@ -3604,7 +3619,8 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 				  &cap, &issued);
 		handle_cap_grant(mdsc, inode, h, &pool_ns,
 				 inline_version, inline_data, inline_len,
-				 msg->middle, session, cap, issued);
+				 msg->middle, session, cap, issued, &btime,
+				 change_attr);
 		if (realm)
 			ceph_put_snap_realm(mdsc, realm);
 		goto done_unlocked;
@@ -3628,7 +3644,8 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 		issued |= __ceph_caps_dirty(ci);
 		handle_cap_grant(mdsc, inode, h, &pool_ns,
 				 inline_version, inline_data, inline_len,
-				 msg->middle, session, cap, issued);
+				 msg->middle, session, cap, issued, &btime,
+				 change_attr);
 		goto done_unlocked;
 
 	case CEPH_CAP_OP_FLUSH_ACK:
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 9ff5219d849e..5cfdab5d366b 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -529,6 +529,9 @@ void ceph_queue_cap_snap(struct ceph_inode_info *ci)
 	capsnap->mode = inode->i_mode;
 	capsnap->uid = inode->i_uid;
 	capsnap->gid = inode->i_gid;
+	capsnap->btime = ci->i_btime;
+
+	capsnap->change_attr = inode->i_version;
 
 	if (dirty & CEPH_CAP_XATTR_EXCL) {
 		__ceph_build_xattrs_blob(ci);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 244fd8dbff31..c264d823bc58 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -173,10 +173,13 @@ struct ceph_cap_snap {
 	umode_t mode;
 	kuid_t uid;
 	kgid_t gid;
+	struct timespec btime;
 
 	struct ceph_buffer *xattr_blob;
 	u64 xattr_version;
 
+	u64 change_attr;
+
 	u64 size;
 	struct timespec mtime, atime, ctime;
 	u64 time_warp_seq;
-- 
2.7.4

