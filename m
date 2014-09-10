From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH] ceph: trim unused inodes before reconnecting to recovering MDS
Date: Wed, 10 Sep 2014 17:32:49 +0800
Message-ID: <1410341569-1729-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:20703 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320AbaIJJdD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 10 Sep 2014 05:33:03 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s8A9X2jV026255
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Wed, 10 Sep 2014 05:33:02 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zyan@redhat.com>

So the recovering MDS does not need to fetch these ununsed inodes during
cache rejoin. This may reduce MDS recovery time.

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 fs/ceph/mds_client.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index bad07c0..f751fea 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2695,16 +2695,6 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 	session->s_state = CEPH_MDS_SESSION_RECONNECTING;
 	session->s_seq = 0;
 
-	ceph_con_close(&session->s_con);
-	ceph_con_open(&session->s_con,
-		      CEPH_ENTITY_TYPE_MDS, mds,
-		      ceph_mdsmap_get_addr(mdsc->mdsmap, mds));
-
-	/* replay unsafe requests */
-	replay_unsafe_requests(mdsc, session);
-
-	down_read(&mdsc->snap_rwsem);
-
 	dout("session %p state %s\n", session,
 	     session_state_name(session->s_state));
 
@@ -2723,6 +2713,19 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 	discard_cap_releases(mdsc, session);
 	spin_unlock(&session->s_cap_lock);
 
+	/* trim unused caps to reduce MDS's cache rejoin time */
+	shrink_dcache_parent(mdsc->fsc->sb->s_root);
+
+	ceph_con_close(&session->s_con);
+	ceph_con_open(&session->s_con,
+		      CEPH_ENTITY_TYPE_MDS, mds,
+		      ceph_mdsmap_get_addr(mdsc->mdsmap, mds));
+
+	/* replay unsafe requests */
+	replay_unsafe_requests(mdsc, session);
+
+	down_read(&mdsc->snap_rwsem);
+
 	/* traverse this session's caps */
 	s_nr_caps = session->s_nr_caps;
 	err = ceph_pagelist_encode_32(pagelist, s_nr_caps);
-- 
1.9.3

