From: Sage Weil <sage@newdream.net>
Subject: [PATCH 12/23] ceph: ignore lease mask
Date: Fri, 22 Jul 2011 17:02:51 -0700
Message-ID: <1311379382-9218-13-git-send-email-sage@newdream.net>
References: <1311379382-9218-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44313 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019Ab1GWAFy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jul 2011 20:05:54 -0400
In-Reply-To: <1311379382-9218-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

The lease mask is no longer used (and it changed a while back).  Instead,
use a non-zero duration to indicate that there is a lease being issued.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 fs/ceph/inode.c      |   10 ++++------
 fs/ceph/mds_client.c |   18 +++++++-----------
 fs/ceph/mds_client.h |    2 +-
 3 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index d8858e9..f51e873 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -805,14 +805,14 @@ static void update_dentry_lease(struct dentry *dentry,
 		return;
 
 	spin_lock(&dentry->d_lock);
-	dout("update_dentry_lease %p mask %d duration %lu ms ttl %lu\n",
-	     dentry, le16_to_cpu(lease->mask), duration, ttl);
+	dout("update_dentry_lease %p duration %lu ms ttl %lu\n",
+	     dentry, duration, ttl);
 
 	/* make lease_rdcache_gen match directory */
 	dir = dentry->d_parent->d_inode;
 	di->lease_shared_gen = ceph_inode(dir)->i_shared_gen;
 
-	if (lease->mask == 0)
+	if (duration == 0)
 		goto out_unlock;
 
 	if (di->lease_gen == session->s_cap_gen &&
@@ -1022,9 +1022,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req,
 
 		/* do we have a dn lease? */
 		have_lease = have_dir_cap ||
-			(le16_to_cpu(rinfo->dlease->mask) &
-			 CEPH_LOCK_DN);
-
+			le32_to_cpu(rinfo->dlease->duration_ms);
 		if (!have_lease)
 			dout("fill_trace  no dentry lease or dir cap\n");
 
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 0c1d917..3b1e743 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2714,7 +2714,6 @@ static void handle_lease(struct ceph_mds_client *mdsc,
 	struct ceph_mds_lease *h = msg->front.iov_base;
 	u32 seq;
 	struct ceph_vino vino;
-	int mask;
 	struct qstr dname;
 	int release = 0;
 
@@ -2725,7 +2724,6 @@ static void handle_lease(struct ceph_mds_client *mdsc,
 		goto bad;
 	vino.ino = le64_to_cpu(h->ino);
 	vino.snap = CEPH_NOSNAP;
-	mask = le16_to_cpu(h->mask);
 	seq = le32_to_cpu(h->seq);
 	dname.name = (void *)h + sizeof(*h) + sizeof(u32);
 	dname.len = msg->front.iov_len - sizeof(*h) - sizeof(u32);
@@ -2737,8 +2735,8 @@ static void handle_lease(struct ceph_mds_client *mdsc,
 
 	/* lookup inode */
 	inode = ceph_find_inode(sb, vino);
-	dout("handle_lease %s, mask %d, ino %llx %p %.*s\n",
-	     ceph_lease_op_name(h->action), mask, vino.ino, inode,
+	dout("handle_lease %s, ino %llx %p %.*s\n",
+	     ceph_lease_op_name(h->action), vino.ino, inode,
 	     dname.len, dname.name);
 	if (inode == NULL) {
 		dout("handle_lease no inode %llx\n", vino.ino);
@@ -2828,7 +2826,6 @@ void ceph_mdsc_lease_send_msg(struct ceph_mds_session *session,
 		return;
 	lease = msg->front.iov_base;
 	lease->action = action;
-	lease->mask = cpu_to_le16(1);
 	lease->ino = cpu_to_le64(ceph_vino(inode).ino);
 	lease->first = lease->last = cpu_to_le64(ceph_vino(inode).snap);
 	lease->seq = cpu_to_le32(seq);
@@ -2850,7 +2847,7 @@ void ceph_mdsc_lease_send_msg(struct ceph_mds_session *session,
  * Pass @inode always, @dentry is optional.
  */
 void ceph_mdsc_lease_release(struct ceph_mds_client *mdsc, struct inode *inode,
-			     struct dentry *dentry, int mask)
+			     struct dentry *dentry)
 {
 	struct ceph_dentry_info *di;
 	struct ceph_mds_session *session;
@@ -2858,7 +2855,6 @@ void ceph_mdsc_lease_release(struct ceph_mds_client *mdsc, struct inode *inode,
 
 	BUG_ON(inode == NULL);
 	BUG_ON(dentry == NULL);
-	BUG_ON(mask == 0);
 
 	/* is dentry lease valid? */
 	spin_lock(&dentry->d_lock);
@@ -2868,8 +2864,8 @@ void ceph_mdsc_lease_release(struct ceph_mds_client *mdsc, struct inode *inode,
 	    di->lease_gen != di->lease_session->s_cap_gen ||
 	    !time_before(jiffies, dentry->d_time)) {
 		dout("lease_release inode %p dentry %p -- "
-		     "no lease on %d\n",
-		     inode, dentry, mask);
+		     "no lease\n",
+		     inode, dentry);
 		spin_unlock(&dentry->d_lock);
 		return;
 	}
@@ -2880,8 +2876,8 @@ void ceph_mdsc_lease_release(struct ceph_mds_client *mdsc, struct inode *inode,
 	__ceph_mdsc_drop_dentry_lease(dentry);
 	spin_unlock(&dentry->d_lock);
 
-	dout("lease_release inode %p dentry %p mask %d to mds%d\n",
-	     inode, dentry, mask, session->s_mds);
+	dout("lease_release inode %p dentry %p to mds%d\n",
+	     inode, dentry, session->s_mds);
 	ceph_mdsc_lease_send_msg(session, inode, dentry,
 				 CEPH_MDS_LEASE_RELEASE, seq);
 	ceph_put_mds_session(session);
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 7d8a0d6..8a40f06 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -333,7 +333,7 @@ extern void ceph_mdsc_sync(struct ceph_mds_client *mdsc);
 
 extern void ceph_mdsc_lease_release(struct ceph_mds_client *mdsc,
 				    struct inode *inode,
-				    struct dentry *dn, int mask);
+				    struct dentry *dn);
 
 extern void ceph_invalidate_dir_request(struct ceph_mds_request *req);
 
-- 
1.7.0

