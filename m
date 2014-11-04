From: John Spray <john.spray@redhat.com>
Subject: [PATCH 5/7] ceph: update CAPRELEASE message format
Date: Tue,  4 Nov 2014 14:34:27 +0000
Message-ID: <1415111669-26246-6-git-send-email-john.spray@redhat.com>
References: <1415111669-26246-1-git-send-email-john.spray@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:34704 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153AbaKDOfR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Nov 2014 09:35:17 -0500
Received: by mail-wg0-f47.google.com with SMTP id a1so13679421wgh.20
        for <ceph-devel@vger.kernel.org>; Tue, 04 Nov 2014 06:35:15 -0800 (PST)
In-Reply-To: <1415111669-26246-1-git-send-email-john.spray@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: John Spray <john.spray@redhat.com>

Version 2 includes the new osd epoch barrier
field.

This allows clients to inform servers that their
released caps may not be used until a particular
OSD map epoch.

Signed-off-by: John Spray <john.spray@redhat.com>
---
 fs/ceph/mds_client.c | 13 +++++++++++++
 fs/ceph/mds_client.h |  8 ++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index dce7977..3f5bc23 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1508,12 +1508,25 @@ void ceph_send_cap_releases(struct ceph_mds_client *mdsc,
 			    struct ceph_mds_session *session)
 {
 	struct ceph_msg *msg;
+	u32             *cap_barrier;
 
 	dout("send_cap_releases mds%d\n", session->s_mds);
 	spin_lock(&session->s_cap_lock);
 	while (!list_empty(&session->s_cap_releases_done)) {
 		msg = list_first_entry(&session->s_cap_releases_done,
 				 struct ceph_msg, list_head);
+
+		BUG_ON(msg->front.iov_len + sizeof(*cap_barrier) > \
+		       PAGE_CACHE_SIZE);
+
+		// Append cap_barrier field
+		cap_barrier = msg->front.iov_base + msg->front.iov_len;
+		*cap_barrier = cpu_to_le32(mdsc->cap_epoch_barrier);
+		msg->front.iov_len += sizeof(*cap_barrier);
+
+		msg->hdr.version = cpu_to_le16(2);
+		msg->hdr.compat_version = cpu_to_le16(1);
+
 		list_del_init(&msg->list_head);
 		spin_unlock(&session->s_cap_lock);
 		msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 7b40568..b9412a8 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -92,10 +92,14 @@ struct ceph_mds_reply_info_parsed {
 
 /*
  * cap releases are batched and sent to the MDS en masse.
+ *
+ * Account for per-message overhead of mds_cap_release header
+ * and u32 for osd epoch barrier trailing field.
  */
 #define CEPH_CAPS_PER_RELEASE ((PAGE_CACHE_SIZE -			\
-				sizeof(struct ceph_mds_cap_release)) /	\
-			       sizeof(struct ceph_mds_cap_item))
+				sizeof(struct ceph_mds_cap_release) -   \
+				sizeof(u32)) /	\
+			        sizeof(struct ceph_mds_cap_item))
 
 
 /*
-- 
1.9.3

