From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 04/12] ceph: parse inline data in MClientReply and MClientCaps
Date: Mon, 17 Nov 2014 15:56:58 +0800
Message-ID: <1416211026-11524-5-git-send-email-zyan@redhat.com>
References: <1416211026-11524-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48788 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751085AbaKQH5s (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 17 Nov 2014 02:57:48 -0500
In-Reply-To: <1416211026-11524-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: liwang@ubuntukylin.com, "Yan, Zheng" <zyan@redhat.com>

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 fs/ceph/caps.c       | 34 +++++++++++++++++++++++-----------
 fs/ceph/mds_client.c | 10 ++++++++++
 fs/ceph/mds_client.h |  3 +++
 3 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index eb1bf1f..b88ae60 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2383,6 +2383,8 @@ static void invalidate_aliases(struct inode *inode)
 static void handle_cap_grant(struct ceph_mds_client *mdsc,
 			     struct inode *inode, struct ceph_mds_caps *grant,
 			     void *snaptrace, int snaptrace_len,
+			     u64 inline_version,
+			     void *inline_data, int inline_len,
 			     struct ceph_buffer *xattr_buf,
 			     struct ceph_mds_session *session,
 			     struct ceph_cap *cap, int issued)
@@ -2996,11 +2998,12 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	u64 cap_id;
 	u64 size, max_size;
 	u64 tid;
+	u64 inline_version = 0;
+	void *inline_data = NULL;
+	u32  inline_len = 0;
 	void *snaptrace;
 	size_t snaptrace_len;
-	void *flock;
-	void *end;
-	u32 flock_len;
+	void *p, *end;
 
 	dout("handle_caps from mds%d\n", mds);
 
@@ -3021,30 +3024,37 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 
 	snaptrace = h + 1;
 	snaptrace_len = le32_to_cpu(h->snap_trace_len);
+	p = snaptrace + snaptrace_len;
 
 	if (le16_to_cpu(msg->hdr.version) >= 2) {
-		void *p = snaptrace + snaptrace_len;
+		u32 flock_len;
 		ceph_decode_32_safe(&p, end, flock_len, bad);
 		if (p + flock_len > end)
 			goto bad;
-		flock = p;
-	} else {
-		flock = NULL;
-		flock_len = 0;
+		p += flock_len;
 	}
 
 	if (le16_to_cpu(msg->hdr.version) >= 3) {
 		if (op == CEPH_CAP_OP_IMPORT) {
-			void *p = flock + flock_len;
 			if (p + sizeof(*peer) > end)
 				goto bad;
 			peer = p;
+			p += sizeof(*peer);
 		} else if (op == CEPH_CAP_OP_EXPORT) {
 			/* recorded in unused fields */
 			peer = (void *)&h->size;
 		}
 	}
 
+	if (le16_to_cpu(msg->hdr.version) >= 4) {
+		ceph_decode_64_safe(&p, end, inline_version, bad);
+		ceph_decode_32_safe(&p, end, inline_len, bad);
+		if (p + inline_len > end)
+			goto bad;
+		inline_data = p;
+		p += inline_len;
+	}
+
 	/* lookup ino */
 	inode = ceph_find_inode(sb, vino);
 	ci = ceph_inode(inode);
@@ -3085,6 +3095,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 		handle_cap_import(mdsc, inode, h, peer, session,
 				  &cap, &issued);
 		handle_cap_grant(mdsc, inode, h,  snaptrace, snaptrace_len,
+				 inline_version, inline_data, inline_len,
 				 msg->middle, session, cap, issued);
 		goto done_unlocked;
 	}
@@ -3105,8 +3116,9 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	case CEPH_CAP_OP_GRANT:
 		__ceph_caps_issued(ci, &issued);
 		issued |= __ceph_caps_dirty(ci);
-		handle_cap_grant(mdsc, inode, h, NULL, 0, msg->middle,
-				 session, cap, issued);
+		handle_cap_grant(mdsc, inode, h, NULL, 0,
+				 inline_version, inline_data, inline_len,
+				 msg->middle, session, cap, issued);
 		goto done_unlocked;
 
 	case CEPH_CAP_OP_FLUSH_ACK:
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 387a489..d2171f4 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -89,6 +89,16 @@ static int parse_reply_info_in(void **p, void *end,
 	ceph_decode_need(p, end, info->xattr_len, bad);
 	info->xattr_data = *p;
 	*p += info->xattr_len;
+
+	if (features & CEPH_FEATURE_MDS_INLINE_DATA) {
+		ceph_decode_64_safe(p, end, info->inline_version, bad);
+		ceph_decode_32_safe(p, end, info->inline_len, bad);
+		ceph_decode_need(p, end, info->inline_len, bad);
+		info->inline_data = *p;
+		*p += info->inline_len;
+	} else
+		info->inline_version = CEPH_INLINE_NONE;
+
 	return 0;
 bad:
 	return err;
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 230bda7..01f5e4c 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -41,6 +41,9 @@ struct ceph_mds_reply_info_in {
 	char *symlink;
 	u32 xattr_len;
 	char *xattr_data;
+	u64 inline_version;
+	u32 inline_len;
+	char *inline_data;
 };
 
 /*
-- 
1.9.3

