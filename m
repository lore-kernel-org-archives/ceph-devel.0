From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 3/4] ceph: make session->s_cap_gen atomic
Date: Fri, 13 Jan 2012 11:50:07 -0800
Message-ID: <1326484207.3334.30.camel@doink>
Reply-To: elder@dreamhost.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:39009 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758971Ab2AMTuH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Jan 2012 14:50:07 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 1A317C067
	for <ceph-devel@vger.kernel.org>; Fri, 13 Jan 2012 11:50:15 -0800 (PST)
Received: from [192.168.107.250] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 0FCF7C062
	for <ceph-devel@vger.kernel.org>; Fri, 13 Jan 2012 11:50:15 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The ceph_mds_session s_cap_gen field can be accessed concurrently
and is used for synchronization.  Change it to be an atomic_t to
make the desired atomicity explicit.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
 fs/ceph/caps.c       |    6 +++---
 fs/ceph/dir.c        |    2 +-
 fs/ceph/inode.c      |    4 ++--
 fs/ceph/mds_client.c |    8 ++++----
 fs/ceph/mds_client.h |    2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 90d789d..fd240e3 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -622,7 +622,7 @@ retry:
 	cap->seq = seq;
 	cap->issue_seq = seq;
 	cap->mseq = mseq;
-	cap->cap_gen = session->s_cap_gen;
+	cap->cap_gen = atomic_read(&session->s_cap_gen);
 
 	if (fmode >= 0)
 		__ceph_get_fmode(ci, fmode);
@@ -642,7 +642,7 @@ static int __cap_is_valid(struct ceph_cap *cap)
 	u32 gen;
 
 	spin_lock(&cap->session->s_gen_ttl_lock);
-	gen = cap->session->s_cap_gen;
+	gen = atomic_read(&cap->session->s_cap_gen);
 	ttl = cap->session->s_cap_ttl;
 	spin_unlock(&cap->session->s_gen_ttl_lock);
 
@@ -2347,7 +2347,7 @@ static void handle_cap_grant(struct inode *inode,
struct ceph_mds_caps *grant,
 	issued = __ceph_caps_issued(ci, &implemented);
 	issued |= implemented | __ceph_caps_dirty(ci);
 
-	cap->cap_gen = session->s_cap_gen;
+	cap->cap_gen = atomic_read(&session->s_cap_gen);
 
 	__check_cap_issue(ci, cap, newcaps);
 
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index a1a0693..da9427d 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -978,7 +978,7 @@ static int dentry_lease_is_valid(struct dentry
*dentry)
 		ceph_get_mds_session(s);
 
 		spin_lock(&s->s_gen_ttl_lock);
-		gen = s->s_cap_gen;
+		gen = atomic_read(&s->s_cap_gen);
 		ttl = s->s_cap_ttl;
 		spin_unlock(&s->s_gen_ttl_lock);
 
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index f556e76..23bee03 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -820,7 +820,7 @@ static void update_dentry_lease(struct dentry
*dentry,
 	if (duration == 0)
 		goto out_unlock;
 
-	if (di->lease_gen == session->s_cap_gen &&
+	if (di->lease_gen == atomic_read(&session->s_cap_gen) &&
 	    time_before(ttl, dentry->d_time))
 		goto out_unlock;  /* we already have a newer lease. */
 
@@ -831,7 +831,7 @@ static void update_dentry_lease(struct dentry
*dentry,
 
 	if (!di->lease_session)
 		di->lease_session = ceph_get_mds_session(session);
-	di->lease_gen = session->s_cap_gen;
+	di->lease_gen = atomic_read(&session->s_cap_gen);
 	di->lease_seq = le32_to_cpu(lease->seq);
 	di->lease_renew_after = half_ttl;
 	di->lease_renew_from = 0;
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index bd147fa..cd567c3 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -399,7 +399,7 @@ static struct ceph_mds_session
*register_session(struct ceph_mds_client *mdsc,
 	s->s_con.peer_name.num = cpu_to_le64(mds);
 
 	spin_lock_init(&s->s_gen_ttl_lock);
-	s->s_cap_gen = 0;
+	atomic_set(&s->s_cap_gen, 0);
 	s->s_cap_ttl = jiffies - 1;
 
 	spin_lock_init(&s->s_cap_lock);
@@ -2328,7 +2328,7 @@ static void handle_session(struct ceph_mds_session
*session,
 		pr_info("mds%d caps went stale, renewing\n",
 			session->s_mds);
 		spin_lock(&session->s_gen_ttl_lock);
-		session->s_cap_gen++;
+		atomic_inc(&session->s_cap_gen);
 		session->s_cap_ttl = jiffies - 1;
 		spin_unlock(&session->s_gen_ttl_lock);
 		send_renew_caps(mdsc, session);
@@ -2783,7 +2783,7 @@ static void handle_lease(struct ceph_mds_client
*mdsc,
 
 	case CEPH_MDS_LEASE_RENEW:
 		if (di->lease_session == session &&
-		    di->lease_gen == session->s_cap_gen &&
+		    di->lease_gen == atomic_read(&session->s_cap_gen) &&
 		    di->lease_renew_from &&
 		    di->lease_renew_after == 0) {
 			unsigned long duration =
@@ -2874,7 +2874,7 @@ void ceph_mdsc_lease_release(struct
ceph_mds_client *mdsc, struct inode *inode,
 	di = ceph_dentry(dentry);
 	if (!di || !di->lease_session ||
 	    di->lease_session->s_mds < 0 ||
-	    di->lease_gen != di->lease_session->s_cap_gen ||
+	    di->lease_gen != atomic_read(&di->lease_session->s_cap_gen) ||
 	    !time_before(jiffies, dentry->d_time)) {
 		dout("lease_release inode %p dentry %p -- "
 		     "no lease\n",
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 8c7c04e..20ca17e 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -119,7 +119,7 @@ struct ceph_mds_session {
 
 	/* protected by s_gen_ttl_lock */
 	spinlock_t        s_gen_ttl_lock;
-	u32               s_cap_gen;  /* inc each time we get mds stale msg */
+	atomic_t          s_cap_gen;  /* inc each time we get mds stale msg */
 	unsigned long     s_cap_ttl;  /* when session caps expire */
 
 	/* protected by s_cap_lock */
-- 
1.7.5.4



