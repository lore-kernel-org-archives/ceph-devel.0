From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v1 5/7] ceph: update CAPRELEASE message format
Date: Fri, 20 Jan 2017 10:17:36 -0500
Message-ID: <20170120151738.9584-6-jlayton@redhat.com>
References: <20170120151738.9584-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751276AbdATPRm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 20 Jan 2017 10:17:42 -0500
In-Reply-To: <20170120151738.9584-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jspray@redhat.com, idryomov@gmail.com, zyan@redhat.com, sage@redhat.com

Version 2 includes the new osd epoch barrier field. This allows clients
to inform servers that their released caps may not be used until a
particular OSD map epoch.

[ jlayton: bring up to v4.10-rc3 ]

Signed-off-by: John Spray <john.spray@redhat.com>
Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/mds_client.c | 15 +++++++++++++++
 fs/ceph/mds_client.h |  7 +++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 7055b499c08b..28c83454e9f6 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1620,6 +1620,7 @@ void ceph_send_cap_releases(struct ceph_mds_client *mdsc,
 	struct ceph_cap *cap;
 	LIST_HEAD(tmp_list);
 	int num_cap_releases;
+	__le32	*cap_barrier;
 
 	spin_lock(&session->s_cap_lock);
 again:
@@ -1637,7 +1638,11 @@ void ceph_send_cap_releases(struct ceph_mds_client *mdsc,
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
@@ -1655,6 +1660,11 @@ void ceph_send_cap_releases(struct ceph_mds_client *mdsc,
 		ceph_put_cap(mdsc, cap);
 
 		if (le32_to_cpu(head->num) == CEPH_CAPS_PER_RELEASE) {
+			// Append cap_barrier field
+			cap_barrier = msg->front.iov_base + msg->front.iov_len;
+			*cap_barrier = cpu_to_le32(mdsc->cap_epoch_barrier);
+			msg->front.iov_len += sizeof(*cap_barrier);
+
 			msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
 			dout("send_cap_releases mds%d %p\n", session->s_mds, msg);
 			ceph_con_send(&session->s_con, msg);
@@ -1670,6 +1680,11 @@ void ceph_send_cap_releases(struct ceph_mds_client *mdsc,
 	spin_unlock(&session->s_cap_lock);
 
 	if (msg) {
+		// Append cap_barrier field
+		cap_barrier = msg->front.iov_base + msg->front.iov_len;
+		*cap_barrier = cpu_to_le32(mdsc->cap_epoch_barrier);
+		msg->front.iov_len += sizeof(*cap_barrier);
+
 		msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
 		dout("send_cap_releases mds%d %p\n", session->s_mds, msg);
 		ceph_con_send(&session->s_con, msg);
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index eb8144ab4995..5da41326a0fd 100644
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

