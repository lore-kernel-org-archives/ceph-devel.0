From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 4/4] ceph: make session->s_cap_ttl atomic
Date: Fri, 13 Jan 2012 11:50:09 -0800
Message-ID: <1326484209.3334.31.camel@doink>
Reply-To: elder@dreamhost.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:39033 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753405Ab2AMTuK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Jan 2012 14:50:10 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 0CB08C077
	for <ceph-devel@vger.kernel.org>; Fri, 13 Jan 2012 11:50:18 -0800 (PST)
Received: from [192.168.107.250] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id BF96BC071
	for <ceph-devel@vger.kernel.org>; Fri, 13 Jan 2012 11:50:17 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The ceph_mds_session s_cap_ttl field is 64 bits that can be accessed
concurrently and is used for synchronization.  Change it to be an
atomic64_t to make guarantee it is operated on atomicly.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
 fs/ceph/caps.c       |    2 +-
 fs/ceph/dir.c        |    2 +-
 fs/ceph/mds_client.c |   25 +++++++++++++++----------
 fs/ceph/mds_client.h |    2 +-
 4 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index fd240e3..9b87e48 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -643,7 +643,7 @@ static int __cap_is_valid(struct ceph_cap *cap)
 
 	spin_lock(&cap->session->s_gen_ttl_lock);
 	gen = atomic_read(&cap->session->s_cap_gen);
-	ttl = cap->session->s_cap_ttl;
+	ttl = atomic64_read(&cap->session->s_cap_ttl);
 	spin_unlock(&cap->session->s_gen_ttl_lock);
 
 	if (cap->cap_gen < gen || time_after_eq(jiffies, ttl)) {
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index da9427d..a182907 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -979,7 +979,7 @@ static int dentry_lease_is_valid(struct dentry
*dentry)
 
 		spin_lock(&s->s_gen_ttl_lock);
 		gen = atomic_read(&s->s_cap_gen);
-		ttl = s->s_cap_ttl;
+		ttl = atomic64_read(&s->s_cap_ttl);
 		spin_unlock(&s->s_gen_ttl_lock);
 
 		if (di->lease_gen == gen &&
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index cd567c3..a1ecd1a 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -400,7 +400,7 @@ static struct ceph_mds_session
*register_session(struct ceph_mds_client *mdsc,
 
 	spin_lock_init(&s->s_gen_ttl_lock);
 	atomic_set(&s->s_cap_gen, 0);
-	s->s_cap_ttl = jiffies - 1;
+	atomic64_set(&s->s_cap_ttl, jiffies - 1);
 
 	spin_lock_init(&s->s_cap_lock);
 	s->s_renew_requested = 0;
@@ -1044,9 +1044,11 @@ static int send_renew_caps(struct ceph_mds_client
*mdsc,
 {
 	struct ceph_msg *msg;
 	int state;
+	unsigned long cap_ttl;
 
-	if (time_after_eq(jiffies, session->s_cap_ttl) &&
-	    time_after_eq(session->s_cap_ttl, session->s_renew_requested))
+	cap_ttl = atomic64_read(&session->s_cap_ttl);
+	if (time_after_eq(jiffies, cap_ttl) &&
+	    time_after_eq(cap_ttl, session->s_renew_requested))
 		pr_info("mds%d caps stale\n", session->s_mds);
 	session->s_renew_requested = jiffies;
 
@@ -1079,15 +1081,18 @@ static void renewed_caps(struct ceph_mds_client
*mdsc,
 {
 	int was_stale;
 	int wake = 0;
+	unsigned long cap_ttl;
 
 	spin_lock(&session->s_cap_lock);
-	was_stale = is_renew && time_after_eq(jiffies, session->s_cap_ttl);
+	cap_ttl = atomic64_read(&session->s_cap_ttl);
+	was_stale = is_renew && time_after_eq(jiffies, cap_ttl);
 
-	session->s_cap_ttl = session->s_renew_requested +
-		mdsc->mdsmap->m_session_timeout*HZ;
+	cap_ttl = session->s_renew_requested +
+			mdsc->mdsmap->m_session_timeout*HZ;
+	atomic64_set(&session->s_cap_ttl, cap_ttl);
 
 	if (was_stale) {
-		if (time_before(jiffies, session->s_cap_ttl)) {
+		if (time_before(jiffies, cap_ttl)) {
 			pr_info("mds%d caps renewed\n", session->s_mds);
 			wake = 1;
 		} else {
@@ -1095,8 +1100,8 @@ static void renewed_caps(struct ceph_mds_client
*mdsc,
 		}
 	}
 	dout("renewed_caps mds%d ttl now %lu, was %s, now %s\n",
-	     session->s_mds, session->s_cap_ttl, was_stale ? "stale" :
"fresh",
-	     time_before(jiffies, session->s_cap_ttl) ? "stale" : "fresh");
+	     session->s_mds, cap_ttl, was_stale ? "stale" : "fresh",
+	     time_before(jiffies, cap_ttl) ? "stale" : "fresh");
 	spin_unlock(&session->s_cap_lock);
 
 	if (wake)
@@ -2329,7 +2334,7 @@ static void handle_session(struct ceph_mds_session
*session,
 			session->s_mds);
 		spin_lock(&session->s_gen_ttl_lock);
 		atomic_inc(&session->s_cap_gen);
-		session->s_cap_ttl = jiffies - 1;
+		atomic64_set(&session->s_cap_ttl, jiffies - 1);
 		spin_unlock(&session->s_gen_ttl_lock);
 		send_renew_caps(mdsc, session);
 		break;
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 20ca17e..f3c32fb 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -120,7 +120,7 @@ struct ceph_mds_session {
 	/* protected by s_gen_ttl_lock */
 	spinlock_t        s_gen_ttl_lock;
 	atomic_t          s_cap_gen;  /* inc each time we get mds stale msg */
-	unsigned long     s_cap_ttl;  /* when session caps expire */
+	atomic64_t        s_cap_ttl;  /* when session caps expire */
 
 	/* protected by s_cap_lock */
 	spinlock_t        s_cap_lock;
-- 
1.7.5.4



