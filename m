From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 1/4] ceph: create a new session lock to avoid lock inversion
Date: Fri, 13 Jan 2012 11:50:00 -0800
Message-ID: <1326484200.3334.28.camel@doink>
Reply-To: elder@dreamhost.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:38995 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753317Ab2AMTuB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Jan 2012 14:50:01 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id E6982C066
	for <ceph-devel@vger.kernel.org>; Fri, 13 Jan 2012 11:50:08 -0800 (PST)
Received: from [192.168.107.250] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id D68DFC062
	for <ceph-devel@vger.kernel.org>; Fri, 13 Jan 2012 11:50:08 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Lockdep was reporting a possible circular lock dependency in
dentry_lease_is_valid().  That function needs to sample the
session's s_cap_gen and and s_cap_ttl fields coherently, but needs
to do so while holding a dentry lock.  The s_cap_lock field was
being used to protect the two fields, but that can't be taken while
holding a lock on a dentry within the session.

In most cases, the s_cap_gen and s_cap_ttl fields only get operated
on separately.  But in three cases they need to be updated together.
Implement a new lock to protect the spots updating both fields
atomically is required.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
 fs/ceph/caps.c       |    4 ++--
 fs/ceph/dir.c        |   14 +++-----------
 fs/ceph/mds_client.c |    8 +++++---
 fs/ceph/mds_client.h |    7 +++++--
 4 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 8b53193..90d789d 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -641,10 +641,10 @@ static int __cap_is_valid(struct ceph_cap *cap)
 	unsigned long ttl;
 	u32 gen;
 
-	spin_lock(&cap->session->s_cap_lock);
+	spin_lock(&cap->session->s_gen_ttl_lock);
 	gen = cap->session->s_cap_gen;
 	ttl = cap->session->s_cap_ttl;
-	spin_unlock(&cap->session->s_cap_lock);
+	spin_unlock(&cap->session->s_gen_ttl_lock);
 
 	if (cap->cap_gen < gen || time_after_eq(jiffies, ttl)) {
 		dout("__cap_is_valid %p cap %p issued %s "
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index ab2b035..a1a0693 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -971,24 +971,16 @@ static int dentry_lease_is_valid(struct dentry
*dentry)
 	struct inode *dir = NULL;
 	u32 seq = 0;
 
-retry:
 	spin_lock(&dentry->d_lock);
 	di = ceph_dentry(dentry);
 	if (di->lease_session) {
 		s = di->lease_session;
 		ceph_get_mds_session(s);
-		spin_unlock(&dentry->d_lock);
-		spin_lock(&s->s_cap_lock);
-		spin_lock(&dentry->d_lock);
-		if (di->lease_session != s) {
-			spin_unlock(&s->s_cap_lock);
-			spin_unlock(&dentry->d_lock);
-			ceph_put_mds_session(s);
-			goto retry;
-		}
+
+		spin_lock(&s->s_gen_ttl_lock);
 		gen = s->s_cap_gen;
 		ttl = s->s_cap_ttl;
-		spin_unlock(&s->s_cap_lock);
+		spin_unlock(&s->s_gen_ttl_lock);
 
 		if (di->lease_gen == gen &&
 		    time_before(jiffies, dentry->d_time) &&
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 23ab6a3..2b0e274 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -398,9 +398,11 @@ static struct ceph_mds_session
*register_session(struct ceph_mds_client *mdsc,
 	s->s_con.peer_name.type = CEPH_ENTITY_TYPE_MDS;
 	s->s_con.peer_name.num = cpu_to_le64(mds);
 
-	spin_lock_init(&s->s_cap_lock);
+	spin_lock_init(&s->s_gen_ttl_lock);
 	s->s_cap_gen = 0;
 	s->s_cap_ttl = 0;
+
+	spin_lock_init(&s->s_cap_lock);
 	s->s_renew_requested = 0;
 	s->s_renew_seq = 0;
 	INIT_LIST_HEAD(&s->s_caps);
@@ -2326,10 +2328,10 @@ static void handle_session(struct
ceph_mds_session *session,
 	case CEPH_SESSION_STALE:
 		pr_info("mds%d caps went stale, renewing\n",
 			session->s_mds);
-		spin_lock(&session->s_cap_lock);
+		spin_lock(&session->s_gen_ttl_lock);
 		session->s_cap_gen++;
 		session->s_cap_ttl = 0;
-		spin_unlock(&session->s_cap_lock);
+		spin_unlock(&session->s_gen_ttl_lock);
 		send_renew_caps(mdsc, session);
 		break;
 
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index a50ca0e..8c7c04e 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -117,10 +117,13 @@ struct ceph_mds_session {
 	void             *s_authorizer_buf, *s_authorizer_reply_buf;
 	size_t            s_authorizer_buf_len, s_authorizer_reply_buf_len;
 
-	/* protected by s_cap_lock */
-	spinlock_t        s_cap_lock;
+	/* protected by s_gen_ttl_lock */
+	spinlock_t        s_gen_ttl_lock;
 	u32               s_cap_gen;  /* inc each time we get mds stale msg */
 	unsigned long     s_cap_ttl;  /* when session caps expire */
+
+	/* protected by s_cap_lock */
+	spinlock_t        s_cap_lock;
 	struct list_head  s_caps;     /* all caps issued by this session */
 	int               s_nr_caps, s_trim_caps;
 	int               s_num_cap_releases;
-- 
1.7.5.4



