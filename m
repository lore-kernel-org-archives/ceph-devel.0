From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v6 5/7] ceph: handle epoch barriers in cap messages
Date: Thu, 30 Mar 2017 14:07:05 -0400
Message-ID: <20170330180707.11137-5-jlayton@redhat.com>
References: <20170330180546.11021-1-jlayton@redhat.com>
 <20170330180707.11137-1-jlayton@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41402 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933150AbdC3SHO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 30 Mar 2017 14:07:14 -0400
In-Reply-To: <20170330180707.11137-1-jlayton@redhat.com>
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
 fs/ceph/caps.c       | 17 +++++++++++++----
 fs/ceph/mds_client.c | 20 ++++++++++++++++++++
 fs/ceph/mds_client.h |  7 +++++--
 3 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 60185434162a..f2df84a8f460 100644
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
 
@@ -3633,13 +3636,19 @@ void ceph_handle_caps(struct ceph_mds_session *session,
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
index b16f1cf552a8..820bf0fb7745 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1551,9 +1551,15 @@ void ceph_send_cap_releases(struct ceph_mds_client *mdsc,
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
@@ -1571,7 +1577,11 @@ void ceph_send_cap_releases(struct ceph_mds_client *mdsc,
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
@@ -1589,6 +1599,11 @@ void ceph_send_cap_releases(struct ceph_mds_client *mdsc,
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
@@ -1604,6 +1619,11 @@ void ceph_send_cap_releases(struct ceph_mds_client *mdsc,
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
index bbebcd55d79e..54166758093f 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -105,10 +105,13 @@ struct ceph_mds_reply_info_parsed {
 
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

