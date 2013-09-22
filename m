From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 2/3] ceph: set caps count after composing cap reconnect message
Date: Sun, 22 Sep 2013 12:46:51 +0800
Message-ID: <1379825212-10438-2-git-send-email-zheng.z.yan@intel.com>
References: <1379825212-10438-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53405 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752306Ab3IVErS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 22 Sep 2013 00:47:18 -0400
In-Reply-To: <1379825212-10438-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

It's possible that some caps get released while composing the cap
reconnect message.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/mds_client.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 8f8f5c0..6b4ed35 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -43,6 +43,7 @@
  */
 
 struct ceph_reconnect_state {
+	int nr_caps;
 	struct ceph_pagelist *pagelist;
 	bool flock;
 };
@@ -2549,6 +2550,8 @@ encode_again:
 	} else {
 		err = ceph_pagelist_append(pagelist, &rec, reclen);
 	}
+
+	recon_state->nr_caps++;
 out_free:
 	kfree(path);
 out_dput:
@@ -2576,6 +2579,7 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 	struct rb_node *p;
 	int mds = session->s_mds;
 	int err = -ENOMEM;
+	int s_nr_caps;
 	struct ceph_pagelist *pagelist;
 	struct ceph_reconnect_state recon_state;
 
@@ -2611,10 +2615,12 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 	discard_cap_releases(mdsc, session);
 
 	/* traverse this session's caps */
-	err = ceph_pagelist_encode_32(pagelist, session->s_nr_caps);
+	s_nr_caps = session->s_nr_caps;
+	err = ceph_pagelist_encode_32(pagelist, s_nr_caps);
 	if (err)
 		goto fail;
 
+	recon_state.nr_caps = 0;
 	recon_state.pagelist = pagelist;
 	recon_state.flock = session->s_con.peer_features & CEPH_FEATURE_FLOCK;
 	err = iterate_session_caps(session, encode_caps_cb, &recon_state);
@@ -2643,11 +2649,18 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 
 	if (recon_state.flock)
 		reply->hdr.version = cpu_to_le16(2);
-	if (pagelist->length) {
-		/* set up outbound data if we have any */
-		reply->hdr.data_len = cpu_to_le32(pagelist->length);
-		ceph_msg_data_add_pagelist(reply, pagelist);
-	}
+
+	/* raced with cap release? */
+	if (s_nr_caps != recon_state.nr_caps) {
+		struct page *page = list_first_entry(&pagelist->head,
+						     struct page, lru);
+		__le32 *addr = kmap_atomic(page);
+		*addr = cpu_to_le32(recon_state.nr_caps);
+		kunmap_atomic(addr);
+	}
+		
+	reply->hdr.data_len = cpu_to_le32(pagelist->length);
+	ceph_msg_data_add_pagelist(reply, pagelist);
 	ceph_con_send(&session->s_con, reply);
 
 	mutex_unlock(&session->s_mutex);
-- 
1.8.1.4

