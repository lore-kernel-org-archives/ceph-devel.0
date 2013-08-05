From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 3/3] ceph: rework trim caps code
Date: Mon,  5 Aug 2013 14:10:30 +0800
Message-ID: <1375683030-28305-10-git-send-email-zheng.z.yan@intel.com>
References: <1375683030-28305-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:63899 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754703Ab3HEGKn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 5 Aug 2013 02:10:43 -0400
In-Reply-To: <1375683030-28305-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

The trim caps code that handles SESSION_RECALL_STATE message has
two issues. First, it uses d_prune_aliases() to prune dentries.
This confuses our 'dir complete' check, because d_prune_aliases()
unhashes dentries before calling our d_prune() callback. Second,
it only prune dentries, inodes with zero reference are still in
the icache unless there is memory pressure.

The fix is adding d_delete() and drop_inode() VFS callback. VFS
calls our d_delete()/drop_inode() callback when a dentry/inode's
last reference is dropped. If true is returned, VFS drop the
dentry/inode from the cache. When handling SESSION_RECALL_STATE
message, we mark inode with CEPH_I_TRIMCAPS flag. Our callbacks
check the flag and session->s_trim_caps to decide if VFS should
drop a dentry/inode. To trim an inode, we just need to reference
dentries associated with the inode, then release them.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c       | 30 ++++++++++++++++++++++++++++++
 fs/ceph/dir.c        | 12 ++++++++++++
 fs/ceph/inode.c      | 11 +++++++++++
 fs/ceph/mds_client.c | 37 ++++++++++++++++++++++++++++++-------
 fs/ceph/mds_client.h |  4 ++--
 fs/ceph/super.c      |  1 +
 fs/ceph/super.h      |  3 +++
 7 files changed, 89 insertions(+), 9 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 49590a0..332dc8d 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -882,6 +882,36 @@ int __ceph_caps_mds_wanted(struct ceph_inode_info *ci)
 }
 
 /*
+ * Used by ceph_d_delete()/ceph_drop_inode(). check if we should drop
+ * the inode.
+ */
+int ceph_trim_caps(struct ceph_inode_info *ci, int drop_inode)
+{
+	struct ceph_cap *cap;
+	struct rb_node *p;
+	int ret = 0;
+
+	if (!spin_trylock(&ci->i_ceph_lock))
+		return 0;
+
+	if (ci->i_ceph_flags & CEPH_I_TRIMCAPS) {
+		for (p = rb_first(&ci->i_caps); p; p = rb_next(p)) {
+			cap = rb_entry(p, struct ceph_cap, ci_node);
+			if (atomic_read(&cap->session->s_trim_caps) <= 0)
+				continue;
+			if (drop_inode)
+				atomic_dec(&cap->session->s_trim_caps);
+			ret = 1;
+		}
+		if (!ret)
+			ci->i_ceph_flags &= ~CEPH_I_TRIMCAPS;
+	}
+
+	spin_unlock(&ci->i_ceph_lock);
+	return ret;
+}
+
+/*
  * called under i_ceph_lock
  */
 static int __ceph_is_any_caps(struct ceph_inode_info *ci)
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 0e4da4a..9741f34 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1043,6 +1043,17 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
 	return valid;
 }
 
+static int ceph_d_delete(const struct dentry *dentry)
+{
+	if (dentry->d_inode) {
+		struct ceph_inode_info *ci = ceph_inode(dentry->d_inode);
+		/* need trim caps? */
+		if (ci->i_ceph_flags & CEPH_I_TRIMCAPS)
+			return ceph_trim_caps(ci, false);
+	}
+	return 0;
+}
+
 /*
  * Release our ceph_dentry_info.
  */
@@ -1300,6 +1311,7 @@ const struct inode_operations ceph_dir_iops = {
 
 const struct dentry_operations ceph_dentry_ops = {
 	.d_revalidate = ceph_d_revalidate,
+	.d_delete = ceph_d_delete,
 	.d_release = ceph_d_release,
 	.d_prune = ceph_d_prune,
 };
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 01e4db1..371590a 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -431,6 +431,17 @@ void ceph_destroy_inode(struct inode *inode)
 	call_rcu(&inode->i_rcu, ceph_i_callback);
 }
 
+int ceph_drop_inode(struct inode *inode)
+{
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	int ret = generic_drop_inode(inode);
+
+	/* need trim caps? */
+	if (!ret && (ci->i_ceph_flags & CEPH_I_TRIMCAPS))
+		ret = ceph_trim_caps(ci, true);
+
+	return ret ;
+}
 
 /*
  * Helpers to fill in size, ctime, mtime, and atime.  We have to be
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 2a42b5f..7c2b8d6 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -435,7 +435,7 @@ static struct ceph_mds_session *register_session(struct ceph_mds_client *mdsc,
 	s->s_renew_seq = 0;
 	INIT_LIST_HEAD(&s->s_caps);
 	s->s_nr_caps = 0;
-	s->s_trim_caps = 0;
+	atomic_set(&s->s_trim_caps, 0);
 	atomic_set(&s->s_ref, 1);
 	INIT_LIST_HEAD(&s->s_waiting);
 	INIT_LIST_HEAD(&s->s_unsafe);
@@ -1207,9 +1207,10 @@ static int trim_caps_cb(struct inode *inode, struct ceph_cap *cap, void *arg)
 {
 	struct ceph_mds_session *session = arg;
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct dentry *dentry;
 	int used, oissued, mine;
 
-	if (session->s_trim_caps <= 0)
+	if (atomic_read(&session->s_trim_caps) <= 0)
 		return -1;
 
 	spin_lock(&ci->i_ceph_lock);
@@ -1225,16 +1226,39 @@ static int trim_caps_cb(struct inode *inode, struct ceph_cap *cap, void *arg)
 	if ((used & ~oissued) & mine)
 		goto out;   /* we need these caps */
 
-	session->s_trim_caps--;
 	if (oissued) {
 		/* we aren't the only cap.. just remove us */
 		__queue_cap_release(session, ceph_ino(inode), cap->cap_id,
 				    cap->mseq, cap->issue_seq);
 		__ceph_remove_cap(cap);
+		atomic_dec(&session->s_trim_caps);
 	} else {
 		/* try to drop referring dentries */
+		ci->i_ceph_flags |= CEPH_I_TRIMCAPS;
 		spin_unlock(&ci->i_ceph_lock);
-		d_prune_aliases(inode);
+		/*
+		 * can't use d_prune_aliases(), because it unhashes dentries
+		 * before calling ceph_d_prune().
+		 */
+restart:
+		spin_lock(&inode->i_lock);
+		hlist_for_each_entry(dentry, &inode->i_dentry, d_alias) {
+			spin_lock(&dentry->d_lock);
+			if (!dentry->d_count) {
+				dget_dlock(dentry);
+				spin_unlock(&dentry->d_lock);
+				spin_unlock(&inode->i_lock);
+				/*
+				 * our d_delete callback returns true when
+				 * CEPH_I_TRIMCAPS is set. This makes VFS
+				 * drop the dentry.
+				 */
+				dput(dentry);
+				goto restart;
+			}
+			spin_unlock(&dentry->d_lock);
+		}
+		spin_unlock(&inode->i_lock);
 		dout("trim_caps_cb %p cap %p  pruned, count now %d\n",
 		     inode, cap, atomic_read(&inode->i_count));
 		return 0;
@@ -1257,12 +1281,11 @@ static int trim_caps(struct ceph_mds_client *mdsc,
 	dout("trim_caps mds%d start: %d / %d, trim %d\n",
 	     session->s_mds, session->s_nr_caps, max_caps, trim_caps);
 	if (trim_caps > 0) {
-		session->s_trim_caps = trim_caps;
+		atomic_set(&session->s_trim_caps, trim_caps);
 		iterate_session_caps(session, trim_caps_cb, session);
 		dout("trim_caps mds%d done: %d / %d, trimmed %d\n",
 		     session->s_mds, session->s_nr_caps, max_caps,
-			trim_caps - session->s_trim_caps);
-		session->s_trim_caps = 0;
+		     trim_caps - atomic_read(&session->s_trim_caps));
 	}
 	return 0;
 }
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index c2a19fb..d0e6566 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -130,8 +130,8 @@ struct ceph_mds_session {
 	/* protected by s_cap_lock */
 	spinlock_t        s_cap_lock;
 	struct list_head  s_caps;     /* all caps issued by this session */
-	int               s_nr_caps, s_trim_caps;
-	int               s_num_cap_releases;
+	int               s_nr_caps, s_num_cap_releases;
+	atomic_t	  s_trim_caps;
 	struct list_head  s_cap_releases; /* waiting cap_release messages */
 	struct list_head  s_cap_releases_done; /* ready to send */
 	struct ceph_cap  *s_cap_iterator;
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 6627b26..bcf26bf 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -655,6 +655,7 @@ static const struct super_operations ceph_super_ops = {
 	.alloc_inode	= ceph_alloc_inode,
 	.destroy_inode	= ceph_destroy_inode,
 	.write_inode    = ceph_write_inode,
+	.drop_inode     = ceph_drop_inode,
 	.sync_fs        = ceph_sync_fs,
 	.put_super	= ceph_put_super,
 	.show_options   = ceph_show_options,
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index e81c0b6..b87691a 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -421,6 +421,7 @@ static inline struct inode *ceph_find_inode(struct super_block *sb,
 /*
  * Ceph inode.
  */
+#define CEPH_I_TRIMCAPS  1  /* trim caps when possible */
 #define CEPH_I_NODELAY   4  /* do not delay cap release */
 #define CEPH_I_FLUSH     8  /* do not delay flush of dirty metadata */
 #define CEPH_I_NOFLUSH  16  /* do not flush dirty caps */
@@ -487,6 +488,7 @@ extern int __ceph_caps_issued(struct ceph_inode_info *ci, int *implemented);
 extern int __ceph_caps_issued_mask(struct ceph_inode_info *ci, int mask, int t);
 extern int __ceph_caps_issued_other(struct ceph_inode_info *ci,
 				    struct ceph_cap *cap);
+extern int ceph_trim_caps(struct ceph_inode_info *ci, int drop_inode);
 
 static inline int ceph_caps_issued(struct ceph_inode_info *ci)
 {
@@ -675,6 +677,7 @@ extern const struct inode_operations ceph_file_iops;
 
 extern struct inode *ceph_alloc_inode(struct super_block *sb);
 extern void ceph_destroy_inode(struct inode *inode);
+extern int ceph_drop_inode(struct inode *inode);
 
 extern struct inode *ceph_get_inode(struct super_block *sb,
 				    struct ceph_vino vino);
-- 
1.8.1.4

