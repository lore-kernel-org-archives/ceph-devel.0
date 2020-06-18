From: xiubli@redhat.com
Subject: [PATCH v2 1/5] ceph: add check_session_state helper and make it global
Date: Thu, 18 Jun 2020 07:59:55 -0400
Message-ID: <1592481599-7851-2-git-send-email-xiubli@redhat.com>
References: <1592481599-7851-1-git-send-email-xiubli@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50163 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728103AbgFRMBF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Jun 2020 08:01:05 -0400
In-Reply-To: <1592481599-7851-1-git-send-email-xiubli@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org, idryomov@gmail.com
Cc: zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

This will be used by followed sending metrics patches.

URL: https://tracker.ceph.com/issues/43215
Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/ceph/mds_client.c | 43 ++++++++++++++++++++++++++-----------------
 fs/ceph/mds_client.h |  4 ++++
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index a504971..608fb5c 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4263,6 +4263,30 @@ static void maybe_recover_session(struct ceph_mds_client *mdsc)
 	ceph_force_reconnect(fsc->sb);
 }
 
+bool check_session_state(struct ceph_mds_client *mdsc,
+			 struct ceph_mds_session *s)
+{
+	if (s->s_state == CEPH_MDS_SESSION_CLOSING) {
+		dout("resending session close request for mds%d\n",
+				s->s_mds);
+		request_close_session(mdsc, s);
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
@@ -4294,23 +4318,8 @@ static void delayed_work(struct work_struct *work)
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
+		if (!check_session_state(mdsc, s)) {
 			ceph_put_mds_session(s);
 			continue;
 		}
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 5e0c407..bcb3892 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -18,6 +18,7 @@
 #include <linux/ceph/auth.h>
 
 #include "metric.h"
+#include "super.h"
 
 /* The first 8 bits are reserved for old ceph releases */
 enum ceph_feature_type {
@@ -476,6 +477,9 @@ struct ceph_mds_client {
 
 extern const char *ceph_mds_op_name(int op);
 
+extern bool check_session_state(struct ceph_mds_client *mdsc,
+				struct ceph_mds_session *s);
+
 extern struct ceph_mds_session *
 __ceph_lookup_mds_session(struct ceph_mds_client *, int mds);
 
-- 
1.8.3.1
