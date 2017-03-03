From: Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH 1/2] fs, ceph: convert ceph_mds_session.s_ref from atomic_t to refcount_t
Date: Fri,  3 Mar 2017 11:15:06 +0200
Message-ID: <1488532507-27863-2-git-send-email-elena.reshetova@intel.com>
References: <1488532507-27863-1-git-send-email-elena.reshetova@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:37069 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751356AbdCCJR3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 3 Mar 2017 04:17:29 -0500
In-Reply-To: <1488532507-27863-1-git-send-email-elena.reshetova@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: ceph-devel@vger.kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org, zyan@redhat.com, sage@redhat.com, idryomov@gmail.com, Elena Reshetova <elena.reshetova@intel.com>, Hans Liljestrand <ishkamiel@gmail.com>, Kees Cook <keescook@chromium.org>, David Windsor <dwindsor@gmail.com>

refcount_t type and corresponding API should be
used instead of atomic_t when the variable is used as
a reference counter. This allows to avoid accidental
refcounter overflows that might lead to use-after-free
situations.

Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Hans Liljestrand <ishkamiel@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 fs/ceph/mds_client.c | 18 +++++++++---------
 fs/ceph/mds_client.h |  5 +++--
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index c681762..0744905 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -378,9 +378,9 @@ const char *ceph_session_state_name(int s)
 
 static struct ceph_mds_session *get_session(struct ceph_mds_session *s)
 {
-	if (atomic_inc_not_zero(&s->s_ref)) {
+	if (refcount_inc_not_zero(&s->s_ref)) {
 		dout("mdsc get_session %p %d -> %d\n", s,
-		     atomic_read(&s->s_ref)-1, atomic_read(&s->s_ref));
+		     refcount_read(&s->s_ref)-1, refcount_read(&s->s_ref));
 		return s;
 	} else {
 		dout("mdsc get_session %p 0 -- FAIL", s);
@@ -391,8 +391,8 @@ static struct ceph_mds_session *get_session(struct ceph_mds_session *s)
 void ceph_put_mds_session(struct ceph_mds_session *s)
 {
 	dout("mdsc put_session %p %d -> %d\n", s,
-	     atomic_read(&s->s_ref), atomic_read(&s->s_ref)-1);
-	if (atomic_dec_and_test(&s->s_ref)) {
+	     refcount_read(&s->s_ref), refcount_read(&s->s_ref)-1);
+	if (refcount_dec_and_test(&s->s_ref)) {
 		if (s->s_auth.authorizer)
 			ceph_auth_destroy_authorizer(s->s_auth.authorizer);
 		kfree(s);
@@ -411,7 +411,7 @@ struct ceph_mds_session *__ceph_lookup_mds_session(struct ceph_mds_client *mdsc,
 		return NULL;
 	session = mdsc->sessions[mds];
 	dout("lookup_mds_session %p %d\n", session,
-	     atomic_read(&session->s_ref));
+	     refcount_read(&session->s_ref));
 	get_session(session);
 	return session;
 }
@@ -466,7 +466,7 @@ static struct ceph_mds_session *register_session(struct ceph_mds_client *mdsc,
 	INIT_LIST_HEAD(&s->s_caps);
 	s->s_nr_caps = 0;
 	s->s_trim_caps = 0;
-	atomic_set(&s->s_ref, 1);
+	refcount_set(&s->s_ref, 1);
 	INIT_LIST_HEAD(&s->s_waiting);
 	INIT_LIST_HEAD(&s->s_unsafe);
 	s->s_num_cap_releases = 0;
@@ -494,7 +494,7 @@ static struct ceph_mds_session *register_session(struct ceph_mds_client *mdsc,
 	}
 	mdsc->sessions[mds] = s;
 	atomic_inc(&mdsc->num_sessions);
-	atomic_inc(&s->s_ref);  /* one ref to sessions[], one to caller */
+	refcount_inc(&s->s_ref);  /* one ref to sessions[], one to caller */
 
 	ceph_con_open(&s->s_con, CEPH_ENTITY_TYPE_MDS, mds,
 		      ceph_mdsmap_get_addr(mdsc->mdsmap, mds));
@@ -3881,7 +3881,7 @@ static struct ceph_connection *con_get(struct ceph_connection *con)
 	struct ceph_mds_session *s = con->private;
 
 	if (get_session(s)) {
-		dout("mdsc con_get %p ok (%d)\n", s, atomic_read(&s->s_ref));
+		dout("mdsc con_get %p ok (%d)\n", s, refcount_read(&s->s_ref));
 		return con;
 	}
 	dout("mdsc con_get %p FAIL\n", s);
@@ -3892,7 +3892,7 @@ static void con_put(struct ceph_connection *con)
 {
 	struct ceph_mds_session *s = con->private;
 
-	dout("mdsc con_put %p (%d)\n", s, atomic_read(&s->s_ref) - 1);
+	dout("mdsc con_put %p (%d)\n", s, refcount_read(&s->s_ref) - 1);
 	ceph_put_mds_session(s);
 }
 
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index ac0475a..bbebcd5 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -7,6 +7,7 @@
 #include <linux/mutex.h>
 #include <linux/rbtree.h>
 #include <linux/spinlock.h>
+#include <linux/refcount.h>
 
 #include <linux/ceph/types.h>
 #include <linux/ceph/messenger.h>
@@ -156,7 +157,7 @@ struct ceph_mds_session {
 	unsigned long     s_renew_requested; /* last time we sent a renew req */
 	u64               s_renew_seq;
 
-	atomic_t          s_ref;
+	refcount_t          s_ref;
 	struct list_head  s_waiting;  /* waiting requests */
 	struct list_head  s_unsafe;   /* unsafe requests */
 };
@@ -373,7 +374,7 @@ __ceph_lookup_mds_session(struct ceph_mds_client *, int mds);
 static inline struct ceph_mds_session *
 ceph_get_mds_session(struct ceph_mds_session *s)
 {
-	atomic_inc(&s->s_ref);
+	refcount_inc(&s->s_ref);
 	return s;
 }
 
-- 
2.7.4

