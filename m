From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v3 5/5] ceph: handle epoch barriers in cap messages
Date: Tue,  7 Feb 2017 07:28:28 -0500
Message-ID: <20170207122828.5550-6-jlayton@redhat.com>
References: <20170207122828.5550-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753857AbdBGM2d (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 7 Feb 2017 07:28:33 -0500
In-Reply-To: <20170207122828.5550-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com, jspray@redhat.com

Have the client store and update the osdc epoch_barrier when a cap
message comes in with one. This allows clients to inform servers that
their released caps may not be used until a particular OSD map epoch.

Signed-off-by: John Spray <john.spray@redhat.com>
Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/caps.c       | 17 +++++++++++++----
 fs/ceph/mds_client.c | 20 ++++++++++++++++++++
 fs/ceph/mds_client.h |  7 +++++--
 3 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 3c2dfd72e5b2..d91d3f32a5b6 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1015,6 +1015,7 @@ static int send_cap_msg(struct cap_msg_args *arg)
 	void *p;
 	size_t extra_len;
 	struct timespec zerotime = {0};
+	struct ceph_osd_client *osdc = &arg->session->s_mdsc->fsc->client->osdc;
 
 	dout("send_cap_msg %s %llx %llx caps %s wanted %s dirty %s"
 	     " seq %u/%u tid %llu/%llu mseq %u follows %lld size %llu/%llu"
@@ -1077,7 +1078,9 @@ static int send_cap_msg(struct cap_msg_args *arg)
 	/* inline data size */
 	ceph_encode_32(&p, 0);
 	/* osd_epoch_barrier (version 5) */
-	ceph_encode_32(&p, 0);
+	down_read(&osdc->lock);
+	ceph_encode_32(&p, osdc->epoch_barrier);
+	up_read(&osdc->lock);
 	/* oldest_flush_tid (version 6) */
 	ceph_encode_64(&p, arg->oldest_flush_tid);
 
@@ -3635,13 +3638,19 @@ void ceph_handle_caps(struct ceph_mds_session *session,
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
index fcf1e5313c16..9125ec83a9f4 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1562,9 +1562,15 @@ void ceph_send_cap_releases(struct ceph_mds_client *mdsc,
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
@@ -1582,7 +1588,11 @@ void ceph_send_cap_releases(struct ceph_mds_client *mdsc,
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
@@ -1600,6 +1610,11 @@ void ceph_send_cap_releases(struct ceph_mds_client *mdsc,
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
@@ -1615,6 +1630,11 @@ void ceph_send_cap_releases(struct ceph_mds_client *mdsc,
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
index ac0475a2daa7..517684c7c5f0 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -104,10 +104,13 @@ struct ceph_mds_reply_info_parsed {
 
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

