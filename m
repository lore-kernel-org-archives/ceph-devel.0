From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 3/5] ceph: fix potential use-after-free
Date: Wed,  5 Apr 2017 09:30:17 +0800
Message-ID: <20170405013019.5032-3-zyan@redhat.com>
References: <20170405013019.5032-1-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34750 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755079AbdDEBak (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 4 Apr 2017 21:30:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 75A7480460
        for <ceph-devel@vger.kernel.org>; Wed,  5 Apr 2017 01:30:40 +0000 (UTC)
In-Reply-To: <20170405013019.5032-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jlayton@redhat.com, "Yan, Zheng" <zyan@redhat.com>

__unregister_session() free the session if it drops the last
reference. We should grab an extra reference if we want to use
session after __unregister_session().

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/mds_client.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 163f0d3..bf765a8 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2658,8 +2658,10 @@ static void handle_session(struct ceph_mds_session *session,
 	seq = le64_to_cpu(h->seq);
 
 	mutex_lock(&mdsc->mutex);
-	if (op == CEPH_SESSION_CLOSE)
+	if (op == CEPH_SESSION_CLOSE) {
+		get_session(session);
 		__unregister_session(mdsc, session);
+	}
 	/* FIXME: this ttl calculation is generous */
 	session->s_ttl = jiffies + HZ*mdsc->mdsmap->m_session_autoclose;
 	mutex_unlock(&mdsc->mutex);
@@ -2748,6 +2750,8 @@ static void handle_session(struct ceph_mds_session *session,
 			kick_requests(mdsc, mds);
 		mutex_unlock(&mdsc->mutex);
 	}
+	if (op == CEPH_SESSION_CLOSE)
+		ceph_put_mds_session(session);
 	return;
 
 bad:
@@ -3148,8 +3152,10 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 			if (s->s_state == CEPH_MDS_SESSION_OPENING) {
 				/* the session never opened, just close it
 				 * out now */
-				__wake_requests(mdsc, &s->s_waiting);
+				get_session(s);
 				__unregister_session(mdsc, s);
+				__wake_requests(mdsc, &s->s_waiting);
+				ceph_put_mds_session(s);
 			} else {
 				/* just close it */
 				mutex_unlock(&mdsc->mutex);
-- 
2.9.3

