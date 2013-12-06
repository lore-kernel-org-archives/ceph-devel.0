From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 10/12] ceph: add open export target session helper
Date: Fri,  6 Dec 2013 16:46:41 +0800
Message-ID: <1386319603-2610-11-git-send-email-zheng.z.yan@intel.com>
References: <1386319603-2610-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23374 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757217Ab3LFIq4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 6 Dec 2013 03:46:56 -0500
In-Reply-To: <1386319603-2610-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/mds_client.c | 51 ++++++++++++++++++++++++++++++++++++---------------
 fs/ceph/mds_client.h |  2 ++
 2 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index a8dd8b0..dcf356e 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -847,35 +847,56 @@ static int __open_session(struct ceph_mds_client *mdsc,
  *
  * called under mdsc->mutex
  */
+static struct ceph_mds_session *
+__open_export_target_session(struct ceph_mds_client *mdsc, int target)
+{
+	struct ceph_mds_session *session;
+
+	session = __ceph_lookup_mds_session(mdsc, target);
+	if (!session) {
+		session = register_session(mdsc, target);
+		if (IS_ERR(session))
+			return session;
+	}
+	if (session->s_state == CEPH_MDS_SESSION_NEW ||
+	    session->s_state == CEPH_MDS_SESSION_CLOSING)
+		__open_session(mdsc, session);
+
+	return session;
+}
+
+struct ceph_mds_session *
+ceph_mdsc_open_export_target_session(struct ceph_mds_client *mdsc, int target)
+{
+	struct ceph_mds_session *session;
+
+	dout("open_export_target_session to mds%d\n", target);
+
+	mutex_lock(&mdsc->mutex);
+	session = __open_export_target_session(mdsc, target);
+	mutex_unlock(&mdsc->mutex);
+
+	return session;
+}
+
 static void __open_export_target_sessions(struct ceph_mds_client *mdsc,
 					  struct ceph_mds_session *session)
 {
 	struct ceph_mds_info *mi;
 	struct ceph_mds_session *ts;
 	int i, mds = session->s_mds;
-	int target;
 
 	if (mds >= mdsc->mdsmap->m_max_mds)
 		return;
+
 	mi = &mdsc->mdsmap->m_info[mds];
 	dout("open_export_target_sessions for mds%d (%d targets)\n",
 	     session->s_mds, mi->num_export_targets);
 
 	for (i = 0; i < mi->num_export_targets; i++) {
-		target = mi->export_targets[i];
-		ts = __ceph_lookup_mds_session(mdsc, target);
-		if (!ts) {
-			ts = register_session(mdsc, target);
-			if (IS_ERR(ts))
-				return;
-		}
-		if (session->s_state == CEPH_MDS_SESSION_NEW ||
-		    session->s_state == CEPH_MDS_SESSION_CLOSING)
-			__open_session(mdsc, session);
-		else
-			dout(" mds%d target mds%d %p is %s\n", session->s_mds,
-			     i, ts, session_state_name(ts->s_state));
-		ceph_put_mds_session(ts);
+		ts = __open_export_target_session(mdsc, mi->export_targets[i]);
+		if (!IS_ERR(ts))
+			ceph_put_mds_session(ts);
 	}
 }
 
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 4c053d0..6828891 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -383,6 +383,8 @@ extern void ceph_mdsc_lease_send_msg(struct ceph_mds_session *session,
 extern void ceph_mdsc_handle_map(struct ceph_mds_client *mdsc,
 				 struct ceph_msg *msg);
 
+extern struct ceph_mds_session *
+ceph_mdsc_open_export_target_session(struct ceph_mds_client *mdsc, int target);
 extern void ceph_mdsc_open_export_target_sessions(struct ceph_mds_client *mdsc,
 					  struct ceph_mds_session *session);
 
-- 
1.8.1.4

