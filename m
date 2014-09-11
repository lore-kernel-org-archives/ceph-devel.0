From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 1/2] ceph: protect kick_requests() with mdsc->mutex
Date: Thu, 11 Sep 2014 15:22:35 +0800
Message-ID: <1410420156-3289-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58947 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751148AbaIKHWx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 11 Sep 2014 03:22:53 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <ukernel@gmail.com>, "Yan, Zheng" <zyan@redhat.com>

From: "Yan, Zheng" <ukernel@gmail.com>

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 fs/ceph/mds_client.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index f751fea..267ba44 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2471,9 +2471,8 @@ static void handle_session(struct ceph_mds_session *session,
 		if (session->s_state == CEPH_MDS_SESSION_RECONNECTING)
 			pr_info("mds%d reconnect denied\n", session->s_mds);
 		remove_session_caps(session);
-		wake = 1; /* for good measure */
+		wake = 2; /* for good measure */
 		wake_up_all(&mdsc->session_close_wq);
-		kick_requests(mdsc, mds);
 		break;
 
 	case CEPH_SESSION_STALE:
@@ -2503,6 +2502,8 @@ static void handle_session(struct ceph_mds_session *session,
 	if (wake) {
 		mutex_lock(&mdsc->mutex);
 		__wake_requests(mdsc, &session->s_waiting);
+		if (wake == 2)
+			kick_requests(mdsc, mds);
 		mutex_unlock(&mdsc->mutex);
 	}
 	return;
-- 
1.9.3

