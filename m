From: xiubli@redhat.com
Subject: [PATCH v5 1/5] ceph: add check_session_state helper and make it global
Date: Tue, 30 Jun 2020 03:52:15 -0400
Message-ID: <1593503539-1209-2-git-send-email-xiubli@redhat.com>
References: <1593503539-1209-1-git-send-email-xiubli@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35825 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731323AbgF3Hwr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:52:47 -0400
In-Reply-To: <1593503539-1209-1-git-send-email-xiubli@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org
Cc: idryomov@gmail.com, zyan@redhat.com, pdonnell@redhat.com, vshankar@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

And remove the unsed mdsc parameter to simplify the code.

URL: https://tracker.ceph.com/issues/43215
Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/ceph/mds_client.c | 47 +++++++++++++++++++++++++++--------------------
 fs/ceph/mds_client.h |  3 +++
 2 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index a504971..58c54d4 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1785,8 +1785,7 @@ static void renewed_caps(struct ceph_mds_client *mdsc,
 /*
  * send a session close request
  */
-static int request_close_session(struct ceph_mds_client *mdsc,
-				 struct ceph_mds_session *session)
+static int request_close_session(struct ceph_mds_session *session)
 {
 	struct ceph_msg *msg;
 
@@ -1809,7 +1808,7 @@ static int __close_session(struct ceph_mds_client *mdsc,
 	if (session->s_state >= CEPH_MDS_SESSION_CLOSING)
 		return 0;
 	session->s_state = CEPH_MDS_SESSION_CLOSING;
-	return request_close_session(mdsc, session);
+	return request_close_session(session);
 }
 
 static bool drop_negative_children(struct dentry *dentry)
@@ -4263,6 +4262,29 @@ static void maybe_recover_session(struct ceph_mds_client *mdsc)
 	ceph_force_reconnect(fsc->sb);
 }
 
+bool check_session_state(struct ceph_mds_session *s)
+{
+	if (s->s_state == CEPH_MDS_SESSION_CLOSING) {
+		dout("resending session close request for mds%d\n",
+				s->s_mds);
+		request_close_session(s);
+		return false;
+	}
+	if (s->s_ttl && time_after(jiffies, s->s_ttl)) {
+		if (s->s_state == CEPH_MDS_SESSION_OPEN) {
+			s->s_state = CEPH_MDS_SESSION_HUNG;
+			pr_info("mds%d hung\n", s->s_mds);
+		}
+	}
+	if (s->s_state == CEPH_MDS_SESSION_NEW ||
+	    s->s_state == CEPH_MDS_SESSION_RESTARTING ||
+	    s->s_state == CEPH_MDS_SESSION_REJECTED)
+		/* this mds is failed or recovering, just wait */
+		return false;
+
+	return true;
+}
+
 /*
  * delayed work -- periodically trim expired leases, renew caps with mds
  */
@@ -4294,23 +4316,8 @@ static void delayed_work(struct work_struct *work)
 		struct ceph_mds_session *s = __ceph_lookup_mds_session(mdsc, i);
 		if (!s)
 			continue;
-		if (s->s_state == CEPH_MDS_SESSION_CLOSING) {
-			dout("resending session close request for mds%d\n",
-			     s->s_mds);
-			request_close_session(mdsc, s);
-			ceph_put_mds_session(s);
-			continue;
-		}
-		if (s->s_ttl && time_after(jiffies, s->s_ttl)) {
-			if (s->s_state == CEPH_MDS_SESSION_OPEN) {
-				s->s_state = CEPH_MDS_SESSION_HUNG;
-				pr_info("mds%d hung\n", s->s_mds);
-			}
-		}
-		if (s->s_state == CEPH_MDS_SESSION_NEW ||
-		    s->s_state == CEPH_MDS_SESSION_RESTARTING ||
-		    s->s_state == CEPH_MDS_SESSION_REJECTED) {
-			/* this mds is failed or recovering, just wait */
+
+		if (!check_session_state(s)) {
 			ceph_put_mds_session(s);
 			continue;
 		}
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 5e0c407..6147ff0 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -18,6 +18,7 @@
 #include <linux/ceph/auth.h>
 
 #include "metric.h"
+#include "super.h"
 
 /* The first 8 bits are reserved for old ceph releases */
 enum ceph_feature_type {
@@ -476,6 +477,8 @@ struct ceph_mds_client {
 
 extern const char *ceph_mds_op_name(int op);
 
+extern bool check_session_state(struct ceph_mds_session *s);
+
 extern struct ceph_mds_session *
 __ceph_lookup_mds_session(struct ceph_mds_client *, int mds);
 
-- 
1.8.3.1
