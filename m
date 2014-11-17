From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 11/12] ceph: flush inline version
Date: Mon, 17 Nov 2014 15:57:05 +0800
Message-ID: <1416211026-11524-12-git-send-email-zyan@redhat.com>
References: <1416211026-11524-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52704 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751072AbaKQH6S (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 17 Nov 2014 02:58:18 -0500
In-Reply-To: <1416211026-11524-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: liwang@ubuntukylin.com, "Yan, Zheng" <zyan@redhat.com>

After converting inline data to normal data, client need to flush
the new i_inline_version (CEPH_INLINE_NONE) to MDS. This commit makes
cap messages (sent to MDS) contain inline_version and inline_data.
Client always converts inline data to normal data before data write,
so the inline data length part is always zero.

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 fs/ceph/caps.c  | 24 ++++++++++++++++++++----
 fs/ceph/snap.c  |  2 ++
 fs/ceph/super.h |  1 +
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 3bc0908..77c4068 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -975,10 +975,12 @@ static int send_cap_msg(struct ceph_mds_session *session,
 			kuid_t uid, kgid_t gid, umode_t mode,
 			u64 xattr_version,
 			struct ceph_buffer *xattrs_buf,
-			u64 follows)
+			u64 follows, bool inline_data)
 {
 	struct ceph_mds_caps *fc;
 	struct ceph_msg *msg;
+	void *p;
+	size_t extra_len;
 
 	dout("send_cap_msg %s %llx %llx caps %s wanted %s dirty %s"
 	     " seq %u/%u mseq %u follows %lld size %llu/%llu"
@@ -988,7 +990,10 @@ static int send_cap_msg(struct ceph_mds_session *session,
 	     seq, issue_seq, mseq, follows, size, max_size,
 	     xattr_version, xattrs_buf ? (int)xattrs_buf->vec.iov_len : 0);
 
-	msg = ceph_msg_new(CEPH_MSG_CLIENT_CAPS, sizeof(*fc), GFP_NOFS, false);
+	/* flock buffer size + inline version + inline data size */
+	extra_len = 4 + 8 + 4;
+	msg = ceph_msg_new(CEPH_MSG_CLIENT_CAPS, sizeof(*fc) + extra_len,
+			   GFP_NOFS, false);
 	if (!msg)
 		return -ENOMEM;
 
@@ -1020,6 +1025,14 @@ static int send_cap_msg(struct ceph_mds_session *session,
 	fc->gid = cpu_to_le32(from_kgid(&init_user_ns, gid));
 	fc->mode = cpu_to_le32(mode);
 
+	p = fc + 1;
+	/* flock buffer size */
+	ceph_encode_32(&p, 0);
+	/* inline version */
+	ceph_encode_64(&p, inline_data ? 0 : CEPH_INLINE_NONE);
+	/* inline data size */
+	ceph_encode_32(&p, 0);
+
 	fc->xattr_version = cpu_to_le64(xattr_version);
 	if (xattrs_buf) {
 		msg->middle = ceph_buffer_get(xattrs_buf);
@@ -1126,6 +1139,7 @@ static int __send_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
 	u64 flush_tid = 0;
 	int i;
 	int ret;
+	bool inline_data;
 
 	held = cap->issued | cap->implemented;
 	revoking = cap->implemented & ~cap->issued;
@@ -1209,13 +1223,15 @@ static int __send_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
 		xattr_version = ci->i_xattrs.version;
 	}
 
+	inline_data = ci->i_inline_version != CEPH_INLINE_NONE;
+
 	spin_unlock(&ci->i_ceph_lock);
 
 	ret = send_cap_msg(session, ceph_vino(inode).ino, cap_id,
 		op, keep, want, flushing, seq, flush_tid, issue_seq, mseq,
 		size, max_size, &mtime, &atime, time_warp_seq,
 		uid, gid, mode, xattr_version, xattr_blob,
-		follows);
+		follows, inline_data);
 	if (ret < 0) {
 		dout("error sending cap msg, must requeue %p\n", inode);
 		delayed = 1;
@@ -1336,7 +1352,7 @@ retry:
 			     capsnap->time_warp_seq,
 			     capsnap->uid, capsnap->gid, capsnap->mode,
 			     capsnap->xattr_version, capsnap->xattr_blob,
-			     capsnap->follows);
+			     capsnap->follows, capsnap->inline_data);
 
 		next_follows = capsnap->follows + 1;
 		ceph_put_cap_snap(capsnap);
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 24b454a..28571cf 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -515,6 +515,8 @@ void ceph_queue_cap_snap(struct ceph_inode_info *ci)
 			capsnap->xattr_version = 0;
 		}
 
+		capsnap->inline_data = ci->i_inline_version != CEPH_INLINE_NONE;
+
 		/* dirty page count moved from _head to this cap_snap;
 		   all subsequent writes page dirties occur _after_ this
 		   snapshot. */
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 02de104..33885ad 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -161,6 +161,7 @@ struct ceph_cap_snap {
 	u64 time_warp_seq;
 	int writing;   /* a sync write is still in progress */
 	int dirty_pages;     /* dirty pages awaiting writeback */
+	bool inline_data;
 };
 
 static inline void ceph_put_cap_snap(struct ceph_cap_snap *capsnap)
-- 
1.9.3

