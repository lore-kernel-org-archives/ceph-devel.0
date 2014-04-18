From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 2/6] ceph: update inode fields according to issued caps
Date: Fri, 18 Apr 2014 22:48:38 +0800
Message-ID: <1397832522-9557-2-git-send-email-zheng.z.yan@intel.com>
References: <1397832522-9557-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:42749 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753846AbaDROtN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 18 Apr 2014 10:49:13 -0400
In-Reply-To: <1397832522-9557-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

Cap message and request reply from non-auth MDS may carry stale
information (corresponding locks are in LOCK states) even they
have the newest inode version. So client should update inode fields
according to issued caps.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c               | 58 ++++++++++++++++++++----------------
 fs/ceph/inode.c              | 70 ++++++++++++++++++++++++--------------------
 include/linux/ceph/ceph_fs.h |  2 ++
 3 files changed, 73 insertions(+), 57 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index de39a03..5f6d24e 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2476,7 +2476,8 @@ static void handle_cap_grant(struct inode *inode, struct ceph_mds_caps *grant,
 
 	__check_cap_issue(ci, cap, newcaps);
 
-	if ((issued & CEPH_CAP_AUTH_EXCL) == 0) {
+	if ((newcaps & CEPH_CAP_AUTH_SHARED) &&
+	    (issued & CEPH_CAP_AUTH_EXCL) == 0) {
 		inode->i_mode = le32_to_cpu(grant->mode);
 		inode->i_uid = make_kuid(&init_user_ns, le32_to_cpu(grant->uid));
 		inode->i_gid = make_kgid(&init_user_ns, le32_to_cpu(grant->gid));
@@ -2485,7 +2486,8 @@ static void handle_cap_grant(struct inode *inode, struct ceph_mds_caps *grant,
 		     from_kgid(&init_user_ns, inode->i_gid));
 	}
 
-	if ((issued & CEPH_CAP_LINK_EXCL) == 0) {
+	if ((newcaps & CEPH_CAP_AUTH_SHARED) &&
+	    (issued & CEPH_CAP_LINK_EXCL) == 0) {
 		set_nlink(inode, le32_to_cpu(grant->nlink));
 		if (inode->i_nlink == 0 &&
 		    (newcaps & (CEPH_CAP_LINK_SHARED | CEPH_CAP_LINK_EXCL)))
@@ -2512,31 +2514,35 @@ static void handle_cap_grant(struct inode *inode, struct ceph_mds_caps *grant,
 	if ((issued & CEPH_CAP_FILE_CACHE) && ci->i_rdcache_gen > 1)
 		queue_revalidate = 1;
 
-	/* size/ctime/mtime/atime? */
-	queue_trunc = ceph_fill_file_size(inode, issued,
-					  le32_to_cpu(grant->truncate_seq),
-					  le64_to_cpu(grant->truncate_size),
-					  size);
-	ceph_decode_timespec(&mtime, &grant->mtime);
-	ceph_decode_timespec(&atime, &grant->atime);
-	ceph_decode_timespec(&ctime, &grant->ctime);
-	ceph_fill_file_time(inode, issued,
-			    le32_to_cpu(grant->time_warp_seq), &ctime, &mtime,
-			    &atime);
-
-
-	/* file layout may have changed */
-	ci->i_layout = grant->layout;
-
-	/* max size increase? */
-	if (ci->i_auth_cap == cap && max_size != ci->i_max_size) {
-		dout("max_size %lld -> %llu\n", ci->i_max_size, max_size);
-		ci->i_max_size = max_size;
-		if (max_size >= ci->i_wanted_max_size) {
-			ci->i_wanted_max_size = 0;  /* reset */
-			ci->i_requested_max_size = 0;
+	if (newcaps & CEPH_CAP_ANY_RD) {
+		/* ctime/mtime/atime? */
+		ceph_decode_timespec(&mtime, &grant->mtime);
+		ceph_decode_timespec(&atime, &grant->atime);
+		ceph_decode_timespec(&ctime, &grant->ctime);
+		ceph_fill_file_time(inode, issued,
+				    le32_to_cpu(grant->time_warp_seq),
+				    &ctime, &mtime, &atime);
+	}
+
+	if (newcaps & (CEPH_CAP_ANY_FILE_RD | CEPH_CAP_ANY_FILE_WR)) {
+		/* file layout may have changed */
+		ci->i_layout = grant->layout;
+		/* size/truncate_seq? */
+		queue_trunc = ceph_fill_file_size(inode, issued,
+					le32_to_cpu(grant->truncate_seq),
+					le64_to_cpu(grant->truncate_size),
+					size);
+		/* max size increase? */
+		if (ci->i_auth_cap == cap && max_size != ci->i_max_size) {
+			dout("max_size %lld -> %llu\n",
+			     ci->i_max_size, max_size);
+			ci->i_max_size = max_size;
+			if (max_size >= ci->i_wanted_max_size) {
+				ci->i_wanted_max_size = 0;  /* reset */
+				ci->i_requested_max_size = 0;
+			}
+			wake = 1;
 		}
-		wake = 1;
 	}
 
 	/* check cap bits */
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 233c6f9..f9e7399 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -585,14 +585,15 @@ static int fill_inode(struct inode *inode,
 	struct ceph_mds_reply_inode *info = iinfo->in;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	int i;
-	int issued = 0, implemented;
+	int issued = 0, implemented, new_issued;
 	struct timespec mtime, atime, ctime;
 	u32 nsplits;
 	struct ceph_inode_frag *frag;
 	struct rb_node *rb_node;
 	struct ceph_buffer *xattr_blob = NULL;
 	int err = 0;
-	int queue_trunc = 0;
+	bool queue_trunc = false;
+	bool new_version = false;
 
 	dout("fill_inode %p ino %llx.%llx v %llu had %llu\n",
 	     inode, ceph_vinop(inode), le64_to_cpu(info->version),
@@ -623,19 +624,23 @@ static int fill_inode(struct inode *inode,
 	 *   3    2     skip
 	 *   3    3     update
 	 */
-	if (le64_to_cpu(info->version) > 0 &&
-	    (ci->i_version & ~1) >= le64_to_cpu(info->version))
-		goto no_change;
-	
+	if (ci->i_version == 0 ||
+	    ((info->cap.flags & CEPH_CAP_FLAG_AUTH) &&
+	     le64_to_cpu(info->version) > (ci->i_version & ~1)))
+		new_version = true;
+
 	issued = __ceph_caps_issued(ci, &implemented);
 	issued |= implemented | __ceph_caps_dirty(ci);
+	new_issued = ~issued & le32_to_cpu(info->cap.caps);
 
 	/* update inode */
 	ci->i_version = le64_to_cpu(info->version);
 	inode->i_version++;
 	inode->i_rdev = le32_to_cpu(info->rdev);
+	inode->i_blkbits = fls(le32_to_cpu(info->layout.fl_stripe_unit)) - 1;
 
-	if ((issued & CEPH_CAP_AUTH_EXCL) == 0) {
+	if ((new_version || (new_issued & CEPH_CAP_AUTH_SHARED)) &&
+	    (issued & CEPH_CAP_AUTH_EXCL) == 0) {
 		inode->i_mode = le32_to_cpu(info->mode);
 		inode->i_uid = make_kuid(&init_user_ns, le32_to_cpu(info->uid));
 		inode->i_gid = make_kgid(&init_user_ns, le32_to_cpu(info->gid));
@@ -644,23 +649,35 @@ static int fill_inode(struct inode *inode,
 		     from_kgid(&init_user_ns, inode->i_gid));
 	}
 
-	if ((issued & CEPH_CAP_LINK_EXCL) == 0)
+	if ((new_version || (new_issued & CEPH_CAP_LINK_SHARED)) &&
+	    (issued & CEPH_CAP_LINK_EXCL) == 0)
 		set_nlink(inode, le32_to_cpu(info->nlink));
 
-	/* be careful with mtime, atime, size */
-	ceph_decode_timespec(&atime, &info->atime);
-	ceph_decode_timespec(&mtime, &info->mtime);
-	ceph_decode_timespec(&ctime, &info->ctime);
-	queue_trunc = ceph_fill_file_size(inode, issued,
-					  le32_to_cpu(info->truncate_seq),
-					  le64_to_cpu(info->truncate_size),
-					  le64_to_cpu(info->size));
-	ceph_fill_file_time(inode, issued,
-			    le32_to_cpu(info->time_warp_seq),
-			    &ctime, &mtime, &atime);
-
-	ci->i_layout = info->layout;
-	inode->i_blkbits = fls(le32_to_cpu(info->layout.fl_stripe_unit)) - 1;
+	if (new_version || (new_issued & CEPH_CAP_ANY_RD)) {
+		/* be careful with mtime, atime, size */
+		ceph_decode_timespec(&atime, &info->atime);
+		ceph_decode_timespec(&mtime, &info->mtime);
+		ceph_decode_timespec(&ctime, &info->ctime);
+		ceph_fill_file_time(inode, issued,
+				le32_to_cpu(info->time_warp_seq),
+				&ctime, &mtime, &atime);
+	}
+
+	if (new_version ||
+	    (new_issued & (CEPH_CAP_ANY_FILE_RD | CEPH_CAP_ANY_FILE_WR))) {
+		ci->i_layout = info->layout;
+		queue_trunc = ceph_fill_file_size(inode, issued,
+					le32_to_cpu(info->truncate_seq),
+					le64_to_cpu(info->truncate_size),
+					le64_to_cpu(info->size));
+		/* only update max_size on auth cap */
+		if ((info->cap.flags & CEPH_CAP_FLAG_AUTH) &&
+		    ci->i_max_size != le64_to_cpu(info->max_size)) {
+			dout("max_size %lld -> %llu\n", ci->i_max_size,
+					le64_to_cpu(info->max_size));
+			ci->i_max_size = le64_to_cpu(info->max_size);
+		}
+	}
 
 	/* xattrs */
 	/* note that if i_xattrs.len <= 4, i_xattrs.data will still be NULL. */
@@ -745,15 +762,6 @@ static int fill_inode(struct inode *inode,
 		dout(" marking %p complete (empty)\n", inode);
 		__ceph_dir_set_complete(ci, atomic_read(&ci->i_release_count));
 	}
-no_change:
-	/* only update max_size on auth cap */
-	if ((info->cap.flags & CEPH_CAP_FLAG_AUTH) &&
-	    ci->i_max_size != le64_to_cpu(info->max_size)) {
-		dout("max_size %lld -> %llu\n", ci->i_max_size,
-		     le64_to_cpu(info->max_size));
-		ci->i_max_size = le64_to_cpu(info->max_size);
-	}
-
 	spin_unlock(&ci->i_ceph_lock);
 
 	/* queue truncate if we saw i_size decrease */
diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index 5f6db18..3c97d5e 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -625,6 +625,8 @@ int ceph_flags_to_mode(int flags);
 			   CEPH_CAP_LINK_EXCL |		\
 			   CEPH_CAP_XATTR_EXCL |	\
 			   CEPH_CAP_FILE_EXCL)
+#define CEPH_CAP_ANY_FILE_RD (CEPH_CAP_FILE_RD | CEPH_CAP_FILE_CACHE | \
+			      CEPH_CAP_FILE_SHARED)
 #define CEPH_CAP_ANY_FILE_WR (CEPH_CAP_FILE_WR | CEPH_CAP_FILE_BUFFER |	\
 			      CEPH_CAP_FILE_EXCL)
 #define CEPH_CAP_ANY_WR   (CEPH_CAP_ANY_EXCL | CEPH_CAP_ANY_FILE_WR)
-- 
1.9.0

