From: John Spray <john.spray@redhat.com>
Subject: [PATCH 6/7] ceph: handle new osdmap barrier field in CLIENTCAPS
Date: Tue,  4 Nov 2014 14:34:28 +0000
Message-ID: <1415111669-26246-7-git-send-email-john.spray@redhat.com>
References: <1415111669-26246-1-git-send-email-john.spray@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:54692 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754026AbaKDOfR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Nov 2014 09:35:17 -0500
Received: by mail-wg0-f50.google.com with SMTP id z12so13525694wgg.23
        for <ceph-devel@vger.kernel.org>; Tue, 04 Nov 2014 06:35:16 -0800 (PST)
In-Reply-To: <1415111669-26246-1-git-send-email-john.spray@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: John Spray <john.spray@redhat.com>

In the latest version of this message, the barrier
field is added as an instruction to clients that
they may not use the attached capabilities until
they have a particular OSD map epoch.

Signed-off-by: John Spray <john.spray@redhat.com>
---
 fs/ceph/caps.c       | 110 +++++++++++++++++++++++++++++++++++++++++++++++--
 fs/ceph/mds_client.c | 114 +++++++++++++++++++++++++++++++++++++++++++--------
 fs/ceph/mds_client.h |   9 ++++
 fs/ceph/super.h      |   3 +-
 4 files changed, 214 insertions(+), 22 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index eb1bf1f..99e3fdd 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -979,6 +979,8 @@ static int send_cap_msg(struct ceph_mds_session *session,
 {
 	struct ceph_mds_caps *fc;
 	struct ceph_msg *msg;
+	int msg_len;
+	__le32 *epoch_barrier;
 
 	dout("send_cap_msg %s %llx %llx caps %s wanted %s dirty %s"
 	     " seq %u/%u mseq %u follows %lld size %llu/%llu"
@@ -988,15 +990,31 @@ static int send_cap_msg(struct ceph_mds_session *session,
 	     seq, issue_seq, mseq, follows, size, max_size,
 	     xattr_version, xattrs_buf ? (int)xattrs_buf->vec.iov_len : 0);
 
-	msg = ceph_msg_new(CEPH_MSG_CLIENT_CAPS, sizeof(*fc), GFP_NOFS, false);
+	/*
+	 * MSG_CLIENT_CAPS version 5 size calculation:
+		sizeof(ceph_mds_caps) for caps field
+		0 bytes for snapbl field (headerless)
+		4 bytes for flockbl field len=0
+		0 bytes for peer field (op not in import|export)
+		8 bytes for inline_version
+		4 bytes for inline_data len=0
+		4 bytes for epoch barrier
+	*/
+	msg_len = sizeof(*fc) + 4 + 8 + 4 + 4;
+
+	msg = ceph_msg_new(CEPH_MSG_CLIENT_CAPS, msg_len, GFP_NOFS, false);
 	if (!msg)
 		return -ENOMEM;
+	memset(msg->front.iov_base, 0, msg_len);
+
+	epoch_barrier = msg->front.iov_base + sizeof(*fc) + 4 + 8 + 4;
+	*epoch_barrier = cpu_to_le32(session->s_mdsc->cap_epoch_barrier);
 
+	msg->hdr.version = cpu_to_le16(5);
+	msg->hdr.compat_version = cpu_to_le16(1);
 	msg->hdr.tid = cpu_to_le64(flush_tid);
 
 	fc = msg->front.iov_base;
-	memset(fc, 0, sizeof(*fc));
-
 	fc->cap_id = cpu_to_le64(cid);
 	fc->op = cpu_to_le32(op);
 	fc->seq = cpu_to_le32(seq);
@@ -2973,14 +2991,39 @@ retry:
 	*target_cap = cap;
 }
 
+
+
+/**
+ * Delay handling a cap message until a given OSD epoch
+ *
+ * Call with session mutex held
+ * Call with OSD map_sem held for read
+ */
+static void delay_message(struct ceph_mds_session *session, struct ceph_msg *msg, u32 epoch)
+{
+    struct ceph_delayed_message *dm;
+
+    ceph_msg_get(msg);
+
+    dm = kmalloc(sizeof(*dm), GFP_NOFS);
+    memset(dm, 0, sizeof(*dm));
+    dm->dm_epoch = epoch;
+    dm->dm_msg = msg;
+
+    list_add(&dm->dm_item, &session->s_delayed_msgs);
+}
+
 /*
  * Handle a caps message from the MDS.
  *
  * Identify the appropriate session, inode, and call the right handler
  * based on the cap op.
+ *
+ * skip_epoch_check: skip checking epoch_barrier (avoid taking mdsc and osdc locks)
  */
 void ceph_handle_caps(struct ceph_mds_session *session,
-		      struct ceph_msg *msg)
+		      struct ceph_msg *msg,
+		      bool skip_epoch_check)
 {
 	struct ceph_mds_client *mdsc = session->s_mdsc;
 	struct super_block *sb = mdsc->fsc->sb;
@@ -3001,6 +3044,9 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	void *flock;
 	void *end;
 	u32 flock_len;
+	u64 inline_version;
+	u32 inline_len;
+	u32 epoch_barrier = 0;
 
 	dout("handle_caps from mds%d\n", mds);
 
@@ -3045,6 +3091,62 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 		}
 	}
 
+	if (le16_to_cpu(msg->hdr.version) >= 5) {
+		void *p = flock + flock_len;
+
+		// Skip peer if applicable
+		if (op == CEPH_CAP_OP_IMPORT) {
+			p += sizeof(struct ceph_mds_cap_peer);
+		}
+
+		// We don't use this, but decode it to advance p
+		ceph_decode_64_safe(&p, end, inline_version, bad);
+
+		// Read 4 bytes for length of inline_data
+		ceph_decode_32_safe(&p, end, inline_len, bad);
+
+		// Skip length of inline_data
+		if (inline_len != 0) {
+			p += inline_len;
+		}
+
+		// Read epoch_barrier field
+		ceph_decode_32_safe(&p, end, epoch_barrier, bad);
+	}
+
+	dout("handle_caps v=%d barrier=%d skip=%d\n",
+		le16_to_cpu(msg->hdr.version),
+		epoch_barrier,
+		skip_epoch_check);
+
+	if (epoch_barrier && !skip_epoch_check) {
+		struct ceph_osd_client *osdc = &mdsc->fsc->client->osdc;
+		// We are required to wait until we have this OSD map epoch
+		// before using the capability.
+		mutex_lock(&mdsc->mutex);
+		if (epoch_barrier > mdsc->cap_epoch_barrier) {
+			mdsc->cap_epoch_barrier = epoch_barrier;
+		}
+		mutex_unlock(&mdsc->mutex);
+
+		down_read(&osdc->map_sem);
+		if (osdc->osdmap->epoch < epoch_barrier) {
+			dout("handle_caps delaying message until OSD epoch %d\n", epoch_barrier);
+			mutex_lock(&session->s_mutex);
+			delay_message(session, msg, epoch_barrier);
+			mutex_unlock(&session->s_mutex);
+
+			// Kick OSD client to get the latest map
+			ceph_monc_request_next_osdmap(&osdc->client->monc);
+
+			up_read(&osdc->map_sem);
+			return;
+		} else {
+			dout("handle_caps barrier %d already satisfied (%d)\n", epoch_barrier, osdc->osdmap->epoch);
+			up_read(&osdc->map_sem);
+		}
+	}
+
 	/* lookup ino */
 	inode = ceph_find_inode(sb, vino);
 	ci = ceph_inode(inode);
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 3f5bc23..5022c71 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -332,6 +332,94 @@ static void destroy_reply_info(struct ceph_mds_reply_info_parsed *info)
 }
 
 
+/**
+ * Unlink and delete a ceph_delayed message
+ */
+static void discard_delayed(
+		struct ceph_mds_session *session,
+		struct ceph_delayed_message *dm)
+{
+	dout("discard_delayed: putting msg %p\n", dm->dm_msg);
+	ceph_msg_put(dm->dm_msg);
+	list_del(&dm->dm_item);
+	kfree(dm);
+}
+
+
+/**
+ * For all messages waiting for <= this epoch,
+ * dispatch
+ */
+static void replay_delayed(
+		struct ceph_mds_session *session,
+		struct ceph_delayed_message *dm)
+{
+	dout("replay_delayed: releasing delayed msg %p\n", dm->dm_msg);
+	ceph_handle_caps(session, dm->dm_msg, true);
+	discard_delayed(session, dm);
+}
+
+
+/**
+ * Find any delayed messages that are ready to be replayed,
+ * and move them to replay_list
+ */
+static void find_ready_delayed(
+		struct ceph_mds_session *session,
+		struct ceph_delayed_message *dm,
+		struct list_head *replay_list,
+		u32 epoch)
+{
+	if (dm->dm_epoch <= epoch) {
+		dout("find_ready_delayed: delayed msg %p ready (%d vs %d)\n", dm->dm_msg, dm->dm_epoch, epoch);
+		list_del(&dm->dm_item);
+		list_add(&dm->dm_item, replay_list);
+	}
+}
+
+
+/**
+ * Call this with map_sem held for read
+ */
+static void handle_osd_map(struct ceph_osd_client *osdc, void *p)
+{
+	struct ceph_mds_client *mdsc = (struct ceph_mds_client*)p;
+	u32 cancelled_epoch = 0;
+	int mds_id;
+
+	if (osdc->osdmap->flags & CEPH_OSDMAP_FULL) {
+		cancelled_epoch = ceph_osdc_cancel_writes(osdc, -ENOSPC);
+		if (cancelled_epoch) {
+			mdsc->cap_epoch_barrier = max(cancelled_epoch + 1,
+						      mdsc->cap_epoch_barrier);
+		}
+	}
+
+	dout("handle_osd_map: epoch=%d\n", osdc->osdmap->epoch);
+
+	// Release any cap messages waiting for this epoch
+	for (mds_id = 0; mds_id < mdsc->max_sessions; ++mds_id) {
+		struct ceph_mds_session *session = mdsc->sessions[mds_id];
+		if (session != NULL) {
+			struct ceph_delayed_message *dm = NULL;
+			struct ceph_delayed_message *dm_next = NULL;
+			struct list_head replay_msgs;
+			INIT_LIST_HEAD(&replay_msgs);
+
+			dout("find_ready_delayed... (s=%p)\n", session);
+			mutex_lock(&session->s_mutex);
+			list_for_each_entry_safe(dm, dm_next, &session->s_delayed_msgs, dm_item)
+				find_ready_delayed(session, dm, &replay_msgs, osdc->osdmap->epoch);
+			mutex_unlock(&session->s_mutex);
+
+			dout("replay_delayed... (s=%p)\n", session);
+			list_for_each_entry_safe(dm, dm_next, &replay_msgs, dm_item)
+				replay_delayed(session, dm);
+		}
+	}
+}
+
+
 /*
  * sessions
  */
@@ -451,6 +539,7 @@ static struct ceph_mds_session *register_session(struct ceph_mds_client *mdsc,
 	INIT_LIST_HEAD(&s->s_cap_releases_done);
 	INIT_LIST_HEAD(&s->s_cap_flushing);
 	INIT_LIST_HEAD(&s->s_cap_snaps_flushing);
+	INIT_LIST_HEAD(&s->s_delayed_msgs);
 
 	dout("register_session mds%d\n", mds);
 	if (mds >= mdsc->max_sessions) {
@@ -488,10 +577,17 @@ fail_realloc:
 static void __unregister_session(struct ceph_mds_client *mdsc,
 			       struct ceph_mds_session *s)
 {
+	struct ceph_delayed_message *dm;
+	struct ceph_delayed_message *dm_next;
+
 	dout("__unregister_session mds%d %p\n", s->s_mds, s);
 	BUG_ON(mdsc->sessions[s->s_mds] != s);
 	mdsc->sessions[s->s_mds] = NULL;
 	ceph_con_close(&s->s_con);
+
+	list_for_each_entry_safe(dm, dm_next, &s->s_delayed_msgs, dm_item)
+		discard_delayed(s, dm);
+
 	ceph_put_mds_session(s);
 }
 
@@ -3278,22 +3374,6 @@ static void delayed_work(struct work_struct *work)
 	schedule_delayed(mdsc);
 }
 
-/**
- * Call this with map_sem held for read
- */
-static void handle_osd_map(struct ceph_osd_client *osdc, void *p)
-{
-	struct ceph_mds_client *mdsc = (struct ceph_mds_client*)p;
-	u32 cancelled_epoch = 0;
-
-	if (osdc->osdmap->flags & CEPH_OSDMAP_FULL) {
-		cancelled_epoch = ceph_osdc_cancel_writes(osdc, -ENOSPC);
-		if (cancelled_epoch) {
-			mdsc->cap_epoch_barrier = max(cancelled_epoch + 1,
-						      mdsc->cap_epoch_barrier);
-		}
-	}
-}
 
 int ceph_mdsc_init(struct ceph_fs_client *fsc)
 
@@ -3683,7 +3763,7 @@ static void dispatch(struct ceph_connection *con, struct ceph_msg *msg)
 		handle_forward(mdsc, s, msg);
 		break;
 	case CEPH_MSG_CLIENT_CAPS:
-		ceph_handle_caps(s, msg);
+		ceph_handle_caps(s, msg, false);
 		break;
 	case CEPH_MSG_CLIENT_SNAP:
 		ceph_handle_snap(mdsc, s, msg);
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index b9412a8..e389358 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -151,6 +151,15 @@ struct ceph_mds_session {
 	atomic_t          s_ref;
 	struct list_head  s_waiting;  /* waiting requests */
 	struct list_head  s_unsafe;   /* unsafe requests */
+
+    struct list_head  s_delayed_msgs;  /* OSD epoch waiters */
+};
+
+struct ceph_delayed_message
+{
+    struct ceph_msg  *dm_msg;
+    u32               dm_epoch;
+	struct list_head  dm_item;
 };
 
 /*
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index aca2287..c6aab54 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -814,7 +814,8 @@ static inline void ceph_forget_all_cached_acls(struct inode *inode)
 /* caps.c */
 extern const char *ceph_cap_string(int c);
 extern void ceph_handle_caps(struct ceph_mds_session *session,
-			     struct ceph_msg *msg);
+			     struct ceph_msg *msg,
+			     bool skip_epoch_check);
 extern struct ceph_cap *ceph_get_cap(struct ceph_mds_client *mdsc,
 				     struct ceph_cap_reservation *ctx);
 extern void ceph_add_cap(struct inode *inode,
-- 
1.9.3

