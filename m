From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH v3 2/2] ceph: quota: fix quota subdir mounts
Date: Thu, 21 Mar 2019 10:20:10 +0000
Message-ID: <20190321102010.26958-3-lhenriques@suse.com>
References: <20190321102010.26958-1-lhenriques@suse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190321102010.26958-1-lhenriques@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Luis Henriques <lhenriques@suse.com>, Hendrik Peyerl <hpeyerl@plusline.net>
List-Id: ceph-devel.vger.kernel.org

The CephFS kernel client does not enforce quotas set in a directory that
isn't visible from the mount point.  For example, given the path
'/dir1/dir2', if quotas are set in 'dir1' and the filesystem is mounted with

  mount -t ceph <server>:<port>:/dir1/ /mnt

then the client won't be able to access 'dir1' inode, even if 'dir2' belongs
to a quota realm that points to it.

This patch fixes this issue by simply doing an MDS LOOKUPINO operation for
unknown inodes.  Any inode reference obtained this way will be added to a
list in ceph_mds_client, and will only be released when the filesystem is
umounted.

Link: https://tracker.ceph.com/issues/38482
Reported-by: Hendrik Peyerl <hpeyerl@plusline.net>
Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 fs/ceph/mds_client.c |  19 ++++++
 fs/ceph/mds_client.h |  18 +++++
 fs/ceph/quota.c      | 158 ++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 185 insertions(+), 10 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 21c33ed048ed..0d49000f4daa 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4077,6 +4077,8 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
 	mdsc->max_sessions = 0;
 	mdsc->stopping = 0;
 	atomic64_set(&mdsc->quotarealms_count, 0);
+	mdsc->quotarealms_inodes = RB_ROOT;
+	mutex_init(&mdsc->quotarealms_inodes_mutex);
 	mdsc->last_snap_seq = 0;
 	init_rwsem(&mdsc->snap_rwsem);
 	mdsc->snap_realms = RB_ROOT;
@@ -4156,6 +4158,9 @@ static void wait_requests(struct ceph_mds_client *mdsc)
  */
 void ceph_mdsc_pre_umount(struct ceph_mds_client *mdsc)
 {
+	struct ceph_quotarealm_inode *qri;
+	struct rb_node *node;
+
 	dout("pre_umount\n");
 	mdsc->stopping = 1;
 
@@ -4168,6 +4173,20 @@ void ceph_mdsc_pre_umount(struct ceph_mds_client *mdsc)
 	 * their inode/dcache refs
 	 */
 	ceph_msgr_flush();
+	/*
+	 * It should now be safe to clean quotarealms_inode tree without holding
+	 * mdsc->quotarealms_inodes_mutex...
+	 */
+	mutex_lock(&mdsc->quotarealms_inodes_mutex);
+	while (!RB_EMPTY_ROOT(&mdsc->quotarealms_inodes)) {
+		node = rb_first(&mdsc->quotarealms_inodes);
+		qri = rb_entry(node, struct ceph_quotarealm_inode, node);
+		rb_erase(node, &mdsc->quotarealms_inodes);
+		if (qri->ci)
+			iput(&qri->ci->vfs_inode);
+		kfree(qri);
+	}
+	mutex_unlock(&mdsc->quotarealms_inodes_mutex);
 }
 
 /*
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 50385a481fdb..9cfa90b4a6d9 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -325,6 +325,18 @@ struct ceph_snapid_map {
 	unsigned long last_used;
 };
 
+/*
+ * node for list of quotarealm inodes that are not visible from the filesystem
+ * mountpoint, but required to handle, e.g. quotas.
+ */
+struct ceph_quotarealm_inode {
+	struct rb_node node;
+	struct ceph_inode_info *ci;
+	struct mutex mutex;
+	u64 ino;
+	unsigned long timeout; /* last time a lookup failed for this inode */
+};
+
 /*
  * mds client state
  */
@@ -344,6 +356,12 @@ struct ceph_mds_client {
 	int                     stopping;      /* true if shutting down */
 
 	atomic64_t		quotarealms_count; /* # realms with quota */
+	/*
+	 * We keep a list of inodes we don't see in the mountpoint but that we
+	 * need to track quota realms.
+	 */
+	struct rb_root		quotarealms_inodes;
+	struct mutex		quotarealms_inodes_mutex;
 
 	/*
 	 * snap_rwsem will cover cap linkage into snaprealms, and
diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
index 9455d3aef0c3..6cdd83a2bbd6 100644
--- a/fs/ceph/quota.c
+++ b/fs/ceph/quota.c
@@ -22,7 +22,16 @@ void ceph_adjust_quota_realms_count(struct inode *inode, bool inc)
 static inline bool ceph_has_realms_with_quotas(struct inode *inode)
 {
 	struct ceph_mds_client *mdsc = ceph_inode_to_client(inode)->mdsc;
-	return atomic64_read(&mdsc->quotarealms_count) > 0;
+	struct super_block *sb = mdsc->fsc->sb;
+
+	if (atomic64_read(&mdsc->quotarealms_count) > 0)
+		return true;
+	/* if root is the real CephFS root, we don't have quota realms */
+	if (sb->s_root->d_inode &&
+	    (sb->s_root->d_inode->i_ino == CEPH_INO_ROOT))
+		return false;
+	/* otherwise, we can't know for sure */
+	return true;
 }
 
 void ceph_handle_quota(struct ceph_mds_client *mdsc,
@@ -68,6 +77,89 @@ void ceph_handle_quota(struct ceph_mds_client *mdsc,
 	iput(inode);
 }
 
+struct ceph_quotarealm_inode *ceph_find_quotarealm_inode(
+	struct ceph_mds_client *mdsc, u64 ino)
+{
+	struct ceph_quotarealm_inode *qri = NULL;
+	struct rb_node **node, *parent = NULL;
+
+	mutex_lock(&mdsc->quotarealms_inodes_mutex);
+	node = &(mdsc->quotarealms_inodes.rb_node);
+	while (*node) {
+		parent = *node;
+		qri = container_of(*node, struct ceph_quotarealm_inode, node);
+
+		if (ino < qri->ino)
+			node = &((*node)->rb_left);
+		else if (ino > qri->ino)
+			node = &((*node)->rb_right);
+		else
+			break;
+	}
+	if (!qri || (qri->ino != ino)) {
+		/* Not found, create a new one and insert it */
+		qri = kmalloc(sizeof(*qri), GFP_KERNEL);
+		if (qri) {
+			qri->ino = ino;
+			qri->ci = NULL;
+			qri->timeout = 0;
+			mutex_init(&qri->mutex);
+			rb_link_node(&qri->node, parent, node);
+			rb_insert_color(&qri->node, &mdsc->quotarealms_inodes);
+		} else
+			pr_warn("Failed to alloc quotarealms_inode\n");
+	}
+	mutex_unlock(&mdsc->quotarealms_inodes_mutex);
+
+	return qri;
+}
+
+/*
+ * This function will try to lookup a realm inode which isn't visible in the
+ * filesystem mountpoint.  A list of these kind of inodes (not visible) is
+ * maintained in the mdsc and freed only when the filesystem is umounted.
+ *
+ * Note that these inodes are kept in this list even if the lookup fails, which
+ * allows to prevent useless lookup requests.
+ */
+static struct inode *lookup_quotarealm_inode(struct ceph_mds_client *mdsc,
+					     struct super_block *sb,
+					     struct ceph_snap_realm *realm)
+{
+	struct ceph_quotarealm_inode *qri;
+	struct inode *in;
+
+	qri = ceph_find_quotarealm_inode(mdsc, realm->ino);
+	if (!qri)
+		return NULL;
+
+	mutex_lock(&qri->mutex);
+	if (qri->ci) {
+		/* A request has already returned the inode */
+		mutex_unlock(&qri->mutex);
+		return &qri->ci->vfs_inode;
+	}
+	/* Check if this inode lookup has failed recently */
+	if ((qri->timeout) &&
+	    (time_before_eq(jiffies, qri->timeout +
+			    msecs_to_jiffies(60 * 1000)))) { /* XXX */
+		mutex_unlock(&qri->mutex);
+		return NULL;
+	}
+	in = ceph_lookup_inode(sb, realm->ino);
+	if (IS_ERR(in)) {
+		pr_warn("Can't lookup inode %llx (err: %ld)\n",
+			realm->ino, PTR_ERR(in));
+		qri->timeout = jiffies;
+	} else {
+		qri->ci = ceph_inode(in);
+		qri->timeout = 0;
+	}
+	mutex_unlock(&qri->mutex);
+
+	return in;
+}
+
 /*
  * This function walks through the snaprealm for an inode and returns the
  * ceph_snap_realm for the first snaprealm that has quotas set (either max_files
@@ -76,9 +168,15 @@ void ceph_handle_quota(struct ceph_mds_client *mdsc,
  *
  * Note that the caller is responsible for calling ceph_put_snap_realm() on the
  * returned realm.
+ *
+ * Callers of this function need to hold mdsc->snap_rwsem.  However, if there's
+ * a need to do an inode lookup, this rwsem will be temporarily dropped.  Hence
+ * the 'retry' argument: if rwsem needs to be dropped and 'retry' is 'false'
+ * this function will return -EAGAIN; otherwise, the snaprealms walk-through
+ * will be restarted.
  */
 static struct ceph_snap_realm *get_quota_realm(struct ceph_mds_client *mdsc,
-					       struct inode *inode)
+					       struct inode *inode, bool retry)
 {
 	struct ceph_inode_info *ci = NULL;
 	struct ceph_snap_realm *realm, *next;
@@ -88,6 +186,7 @@ static struct ceph_snap_realm *get_quota_realm(struct ceph_mds_client *mdsc,
 	if (ceph_snap(inode) != CEPH_NOSNAP)
 		return NULL;
 
+restart:
 	realm = ceph_inode(inode)->i_snap_realm;
 	if (realm)
 		ceph_get_snap_realm(mdsc, realm);
@@ -95,11 +194,25 @@ static struct ceph_snap_realm *get_quota_realm(struct ceph_mds_client *mdsc,
 		pr_err_ratelimited("get_quota_realm: ino (%llx.%llx) "
 				   "null i_snap_realm\n", ceph_vinop(inode));
 	while (realm) {
+		bool has_inode;
+
 		spin_lock(&realm->inodes_with_caps_lock);
-		in = realm->inode ? igrab(realm->inode) : NULL;
+		has_inode = realm->inode;
+		in = has_inode ? igrab(realm->inode) : NULL;
 		spin_unlock(&realm->inodes_with_caps_lock);
-		if (!in)
+		if (has_inode && !in)
 			break;
+		if (!in) {
+			up_read(&mdsc->snap_rwsem);
+			in = lookup_quotarealm_inode(mdsc, inode->i_sb, realm);
+			down_read(&mdsc->snap_rwsem);
+			if (IS_ERR_OR_NULL(in))
+				break;
+			ceph_put_snap_realm(mdsc, realm);
+			if (!retry)
+				return ERR_PTR(-EAGAIN);
+			goto restart;
+		}
 
 		ci = ceph_inode(in);
 		has_quota = __ceph_has_any_quota(ci);
@@ -125,9 +238,22 @@ bool ceph_quota_is_same_realm(struct inode *old, struct inode *new)
 	struct ceph_snap_realm *old_realm, *new_realm;
 	bool is_same;
 
+restart:
+	/*
+	 * We need to lookup 2 quota realms atomically, i.e. with snap_rwsem.
+	 * However, get_quota_realm may drop it temporarily.  By setting the
+	 * 'retry' parameter to 'false', we'll get -EAGAIN if the rwsem was
+	 * dropped and we can then restart the whole operation.
+	 */
 	down_read(&mdsc->snap_rwsem);
-	old_realm = get_quota_realm(mdsc, old);
-	new_realm = get_quota_realm(mdsc, new);
+	old_realm = get_quota_realm(mdsc, old, true);
+	new_realm = get_quota_realm(mdsc, new, false);
+	if (PTR_ERR(new_realm) == -EAGAIN) {
+		up_read(&mdsc->snap_rwsem);
+		if (old_realm)
+			ceph_put_snap_realm(mdsc, old_realm);
+		goto restart;
+	}
 	is_same = (old_realm == new_realm);
 	up_read(&mdsc->snap_rwsem);
 
@@ -166,6 +292,7 @@ static bool check_quota_exceeded(struct inode *inode, enum quota_check_op op,
 		return false;
 
 	down_read(&mdsc->snap_rwsem);
+restart:
 	realm = ceph_inode(inode)->i_snap_realm;
 	if (realm)
 		ceph_get_snap_realm(mdsc, realm);
@@ -173,12 +300,23 @@ static bool check_quota_exceeded(struct inode *inode, enum quota_check_op op,
 		pr_err_ratelimited("check_quota_exceeded: ino (%llx.%llx) "
 				   "null i_snap_realm\n", ceph_vinop(inode));
 	while (realm) {
+		bool has_inode;
+
 		spin_lock(&realm->inodes_with_caps_lock);
-		in = realm->inode ? igrab(realm->inode) : NULL;
+		has_inode = realm->inode;
+		in = has_inode ? igrab(realm->inode) : NULL;
 		spin_unlock(&realm->inodes_with_caps_lock);
-		if (!in)
+		if (has_inode && !in)
 			break;
-
+		if (!in) {
+			up_read(&mdsc->snap_rwsem);
+			in = lookup_quotarealm_inode(mdsc, inode->i_sb, realm);
+			down_read(&mdsc->snap_rwsem);
+			if (IS_ERR_OR_NULL(in))
+				break;
+			ceph_put_snap_realm(mdsc, realm);
+			goto restart;
+		}
 		ci = ceph_inode(in);
 		spin_lock(&ci->i_ceph_lock);
 		if (op == QUOTA_CHECK_MAX_FILES_OP) {
@@ -314,7 +452,7 @@ bool ceph_quota_update_statfs(struct ceph_fs_client *fsc, struct kstatfs *buf)
 	bool is_updated = false;
 
 	down_read(&mdsc->snap_rwsem);
-	realm = get_quota_realm(mdsc, d_inode(fsc->sb->s_root));
+	realm = get_quota_realm(mdsc, d_inode(fsc->sb->s_root), true);
 	up_read(&mdsc->snap_rwsem);
 	if (!realm)
 		return false;
