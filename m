From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v8 5/7] ceph: handle epoch barriers in cap messages
Date: Mon, 17 Apr 2017 12:42:56 -0400
Message-ID: <20170417164258.31527-6-jlayton@redhat.com>
References: <20170417164258.31527-1-jlayton@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45800 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754699AbdDQQnH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 17 Apr 2017 12:43:07 -0400
In-Reply-To: <20170417164258.31527-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: idryomov@gmail.com, zyan@redhat.com, sage@redhat.com
Cc: jspray@redhat.com, ceph-devel@vger.kernel.org

Have the client store and update the osdc epoch_barrier when a cap
message comes in with one.

When sending cap messages, send the epoch barrier as well. This allows
clients to inform servers that their released caps may not be used until
a particular OSD map epoch.

Reviewed-by: "Yan, Zheng” <zyan@redhat.com>
Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/caps.c       | 21 ++++++++++++++++-----
 fs/ceph/mds_client.c | 20 ++++++++++++++++++++
 fs/ceph/mds_client.h |  7 +++++--
 3 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 60185434162a..a3ebb632294e 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1015,6 +1015,7 @@ static int send_cap_msg(struct cap_msg_args *arg)
 	void *p;
 	size_t extra_len;
 	struct timespec zerotime = {0};
+	struct ceph_osd_client *osdc = &arg->session->s_mdsc->fsc->client->osdc;
 
 	dout("send_cap_msg %s %llx %llx caps %s wanted %s dirty %s"
 	     " seq %u/%u tid %llu/%llu mseq %u follows %lld size %llu/%llu"
@@ -1076,8 +1077,12 @@ static int send_cap_msg(struct cap_msg_args *arg)
 	ceph_encode_64(&p, arg->inline_data ? 0 : CEPH_INLINE_NONE);
 	/* inline data size */
 	ceph_encode_32(&p, 0);
-	/* osd_epoch_barrier (version 5) */
-	ceph_encode_32(&p, 0);
+	/*
+	 * osd_epoch_barrier (version 5)
+	 * The epoch_barrier is protected osdc->lock, so READ_ONCE here in
+	 * case it was recently changed
+	 */
+	ceph_encode_32(&p, READ_ONCE(osdc->epoch_barrier));
 	/* oldest_flush_tid (version 6) */
 	ceph_encode_64(&p, arg->oldest_flush_tid);
 
@@ -3633,13 +3638,19 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 		p += inline_len;
 	}
 
+	if (le16_to_cpu(msg->hdr.version) >= 5) {
+		struct ceph_osd_client	*osdc = &mdsc->fsc->client->osdc;
+		u32			epoch_barrier;
+
+		ceph_decode_32_safe(&p, end, epoch_barrier, bad);
+		ceph_osdc_update_epoch_barrier(osdc, epoch_barrier);
+	}
+
 	if (le16_to_cpu(msg->hdr.version) >= 8) {
 		u64 flush_tid;
 		u32 caller_uid, caller_gid;
-		u32 osd_epoch_barrier;
 		u32 pool_ns_len;
-		/* version >= 5 */
-		ceph_decode_32_safe(&p, end, osd_epoch_barrier, bad);
+
 		/* version >= 6 */
 		ceph_decode_64_safe(&p, end, flush_tid, bad);
 		/* version >= 7 */
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 8cc4d4e8b077..f7bfc22eb39c 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1552,9 +1552,15 @@ void ceph_send_cap_releases(struct ceph_mds_client *mdsc,
 	struct ceph_msg *msg = NULL;
 	struct ceph_mds_cap_release *head;
 	struct ceph_mds_cap_item *item;
+	struct ceph_osd_client *osdc = &mdsc->fsc->client->osdc;
 	struct ceph_cap *cap;
 	LIST_HEAD(tmp_list);
 	int num_cap_releases;
+	__le32	barrier, *cap_barrier;
+
+	down_read(&osdc->lock);
+	barrier = cpu_to_le32(osdc->epoch_barrier);
+	up_read(&osdc->lock);
 
 	spin_lock(&session->s_cap_lock);
 again:
@@ -1572,7 +1578,11 @@ void ceph_send_cap_releases(struct ceph_mds_client *mdsc,
 			head = msg->front.iov_base;
 			head->num = cpu_to_le32(0);
 			msg->front.iov_len = sizeof(*head);
+
+			msg->hdr.version = cpu_to_le16(2);
+			msg->hdr.compat_version = cpu_to_le16(1);
 		}
+
 		cap = list_first_entry(&tmp_list, struct ceph_cap,
 					session_caps);
 		list_del(&cap->session_caps);
@@ -1590,6 +1600,11 @@ void ceph_send_cap_releases(struct ceph_mds_client *mdsc,
 		ceph_put_cap(mdsc, cap);
 
 		if (le32_to_cpu(head->num) == CEPH_CAPS_PER_RELEASE) {
+			// Append cap_barrier field
+			cap_barrier = msg->front.iov_base + msg->front.iov_len;
+			*cap_barrier = barrier;
+			msg->front.iov_len += sizeof(*cap_barrier);
+
 			msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
 			dout("send_cap_releases mds%d %p\n", session->s_mds, msg);
 			ceph_con_send(&session->s_con, msg);
@@ -1605,6 +1620,11 @@ void ceph_send_cap_releases(struct ceph_mds_client *mdsc,
 	spin_unlock(&session->s_cap_lock);
 
 	if (msg) {
+		// Append cap_barrier field
+		cap_barrier = msg->front.iov_base + msg->front.iov_len;
+		*cap_barrier = barrier;
+		msg->front.iov_len += sizeof(*cap_barrier);
+
 		msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
 		dout("send_cap_releases mds%d %p\n", session->s_mds, msg);
 		ceph_con_send(&session->s_con, msg);
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 3e67dd2169fa..db57ae98ed34 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -106,10 +106,13 @@ struct ceph_mds_reply_info_parsed {
 
 /*
  * cap releases are batched and sent to the MDS en masse.
+ *
+ * Account for per-message overhead of mds_cap_release header
+ * and __le32 for osd epoch barrier trailing field.
  */
-#define CEPH_CAPS_PER_RELEASE ((PAGE_SIZE -			\
+#define CEPH_CAPS_PER_RELEASE ((PAGE_SIZE - sizeof(u32) -		\
 				sizeof(struct ceph_mds_cap_release)) /	\
-			       sizeof(struct ceph_mds_cap_item))
+			        sizeof(struct ceph_mds_cap_item))
 
 
 /*
-- 
2.9.3

