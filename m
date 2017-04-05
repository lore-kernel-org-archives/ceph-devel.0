From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 4/5] ceph: close stopped mds' session
Date: Wed,  5 Apr 2017 09:30:18 +0800
Message-ID: <20170405013019.5032-4-zyan@redhat.com>
References: <20170405013019.5032-1-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46788 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755021AbdDEBar (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 4 Apr 2017 21:30:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C2CE67709
        for <ceph-devel@vger.kernel.org>; Wed,  5 Apr 2017 01:30:45 +0000 (UTC)
In-Reply-To: <20170405013019.5032-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jlayton@redhat.com, "Yan, Zheng" <zyan@redhat.com>

If a mds has stopped, close its session and clean up its session
requests/caps. The process is similar to handling SESSION_CLOSE
initiated by mds.

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/mds_client.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index bf765a8..5584c98 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3156,6 +3156,22 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 				__unregister_session(mdsc, s);
 				__wake_requests(mdsc, &s->s_waiting);
 				ceph_put_mds_session(s);
+			} else if (i >= newmap->m_num_mds) {
+				/* force close session for stopped mds */
+				get_session(s);
+				__unregister_session(mdsc, s);
+				__wake_requests(mdsc, &s->s_waiting);
+				kick_requests(mdsc, i);
+				mutex_unlock(&mdsc->mutex);
+
+				mutex_lock(&s->s_mutex);
+				cleanup_session_requests(mdsc, s);
+				remove_session_caps(s);
+				mutex_unlock(&s->s_mutex);
+
+				ceph_put_mds_session(s);
+
+				mutex_lock(&mdsc->mutex);
 			} else {
 				/* just close it */
 				mutex_unlock(&mdsc->mutex);
-- 
2.9.3

